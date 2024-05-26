-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */
-- Step 1: Get vendor and product details
WITH VendorProductDetails AS (
    SELECT 
        vi.vendor_id, 
        v.vendor_name, 
        vi.product_id, 
        p.product_name, 
        vi.original_price
    FROM 
        vendor_inventory vi
    JOIN 
        vendor v ON vi.vendor_id = v.vendor_id
    JOIN 
        product p ON vi.product_id = p.product_id
),

-- Step 2: Cross join vendor-product details with customers
VendorProductCustomer AS (
    SELECT 
        vpd.vendor_id, 
        vpd.vendor_name, 
        vpd.product_id, 
        vpd.product_name, 
        c.customer_id,
        vpd.original_price
    FROM 
        VendorProductDetails vpd
    CROSS JOIN 
        customer c
)

-- Step 3: Calculate the total sales per vendor-product
SELECT 
    vendor_name, 
    product_name, 
    SUM(5 * original_price) AS total_sales
FROM 
    VendorProductCustomer
GROUP BY 
    vendor_name, 
    product_name
ORDER BY 
    vendor_name, 
    product_name;



-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
-- Create the product_units table
CREATE TABLE product_units (
    product_id INT(11) NOT NULL,
    product_name VARCHAR(45) DEFAULT NULL,
    product_size VARCHAR(45) DEFAULT NULL,
    product_category_id INT(11) NOT NULL,
    product_qty_type VARCHAR(45) DEFAULT NULL,
    snapshot_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, product_category_id),
    FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);

-- Insert data into the product_units table
INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
SELECT 
    product_id, 
    product_name, 
    product_size, 
    product_category_id, 
    product_qty_type, 
    CURRENT_TIMESTAMP
FROM 
    product
WHERE 
    product_qty_type = 'unit';


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */
-- Insert a new row into the product_units table
INSERT INTO product_units (
    product_id, 
    product_name, 
    product_size, 
    product_category_id, 
    product_qty_type, 
    snapshot_timestamp
)
VALUES (
    (SELECT MAX(product_id) + 1 FROM product_units),  -- Generating a new unique product_id
    'Apple Pie', 
    'Large', 
    1,  -- valid product_category_id
    'unit', 
    CURRENT_TIMESTAMP
);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
DELETE FROM product_units
WHERE product_name = 'Apple Pie'
AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp)
    FROM product_units
    WHERE product_name = 'Apple Pie'
);


-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */
-- Update the current_quantity column based on the last quantity value from the vendor_inventory details
UPDATE product_units
SET current_quantity = COALESCE((
    SELECT vi.quantity
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    ORDER BY vi.market_date DESC
    LIMIT 1
), 0);

