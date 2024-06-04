# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

![SmallBookstoreLogicalDataModel](https://github.com/cyberqubit/sql/assets/134016654/57254703-ed0d-4580-9611-09fb272b84ed)


## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![ExpandedSmallBookstoreLogicalDataModel](https://github.com/cyberqubit/sql/assets/134016654/da42a524-7533-4b29-863e-c2e16581fce0)


## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...

Two architectures for the CustomerAddress table:

Architecture 1 (Overwrites changes):
CustomerID (Primary Key, Foreign Key)
AddressLine1
AddressLine2
City
State
ZipCode

This is a Type 1 Slowly Changing Dimension (SCD) where changes overwrite existing data.


Architecture 2 (Retains changes):
AddressID (Primary Key)
CustomerID (Foreign Key)
AddressLine1
AddressLine2
City
State
ZipCode
StartDate
EndDate

This is a Type 2 Slowly Changing Dimension (SCD) where each change creates a new record, retaining address history.


Privacy Implications

Overwriting address changes keeps data minimal but loses history. Retaining address history provides a complete picture but stores more personal data. Bookstores should implement data retention policies and access controls. The right balance allows bookstores to leverage customer data while prioritizing privacy.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...

Two differences between the AdventureWorks schema and the small bookstore ERD:

Complexity: The AdventureWorks schema is more complex, with many tables and relationships reflecting a comprehensive enterprise system. The small bookstore ERD is simpler, focusing on core functions for a small bookstore.

Normalization: AdventureWorks has higher normalization with specific tables for different business aspects, like product categories and detailed sales transactions. The small bookstore ERD has fewer normalization layers.

Potential Changes:
Add more normalization to reduce redundancy, such as separate tables for address components (e.g., city, state).
Include additional tables for book categories or genres to expand functionality and align more closely with comprehensive schemas like AdventureWorks.
This enhanced model ensures efficiency and scalability while maintaining simplicity for a smaller operation.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [x] Create a branch called `model-design`.
- [x] Ensure that the repository is public.
- [x] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [x] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
