# Karibu Academy V2 Requirements

Status: Initial requirements draft  
Version 1 remains the production baseline while V2 is designed and tested.

## Purpose

Karibu Academy V2 should make restaurant training easier to complete, easier for managers to follow up, and easier for owners to understand. The product should support structured service training without replacing the manager’s role in coaching and workplace observation.

## Current V1 baseline

V1 currently provides:

- Restaurant-specific staff sign-in using a name and PIN.
- Training modules containing explanations, examples, quizzes, and completion states.
- A manager dashboard showing staff accounts, completion percentage, completed modules, module analytics, and individual staff analytics.
- Supabase-backed restaurant, staff, login, progress, and dashboard operations.
- Local browser storage for some resume and offline behavior.

V2 must preserve the existing V1 workflow unless a deliberate migration decision is made.

## Confirmed V2 goals

1. Make learner progress understandable and trustworthy.
2. Make the manager dashboard clear without requiring verbal explanation.
3. Make navigation reliable from every training screen.
4. Make the application work well on desktop and mobile screens.
5. Improve accessibility, including readable color contrast, labels, and keyboard-friendly controls.
6. Keep training content practical, specific, and easy to understand.
7. Preserve clear separation between online learning results and workplace observation.

## Proposed V2 capabilities

These are proposed capabilities for discussion, not final commitments:

### Learner experience

- Resume a module reliably after refresh, logout, or returning on another device.
- Show clear module states such as not started, in progress, completed, and needs review.
- Show what the learner has completed and what to do next.
- Provide clear back, dashboard, and home navigation on every relevant screen.
- Use plain language, practical examples, and consistent terminology.

### Manager experience

- Provide a persistent link to the manager dashboard while a manager is viewing coursework.
- Show accurate staff progress, including saved partial progress when that capability is implemented.
- Explain every dashboard metric directly in the interface.
- Allow managers to filter staff and modules.
- Show assessment results, completion dates, and recent activity where the data supports it.
- Keep workplace observation separate from online quiz completion.

### Owner and administration experience

- Provide an owner-level view of restaurant participation and training health.
- Support controlled staff and manager account administration.
- Provide exportable or shareable reports only after privacy and access rules are defined.

### Content and assessment

- Review module explanations for vague wording, unnecessary jargon, and inconsistent terms.
- Keep quiz questions aligned with the lesson content.
- Make pass criteria visible and understandable.
- Distinguish learning completion from demonstrated workplace competency.

## Technical requirements

- Maintain the current restaurant-specific data boundary.
- Keep authentication and authorization enforced by the backend, not only by browser state.
- Store progress events in a durable backend record if V2 exposes in-progress states.
- Make progress writes idempotent so refreshes and retries do not create duplicate records.
- Make dashboard metrics derive from one consistent progress model.
- Preserve useful offline or resume behavior without presenting local-only data as manager-confirmed data.
- Keep deployment compatible with the current Netlify and Supabase setup unless a migration is approved.
- Add automated checks for JavaScript syntax, key navigation paths, role access, and dashboard calculations.

## Accessibility and visual quality

- Meet a readable contrast standard for body text, labels, buttons, status pills, and helper text.
- Do not use light decorative colors for essential information on light backgrounds.
- Ensure controls have clear visible labels and focus states.
- Ensure the full primary experience fits common desktop viewports without unnecessary page scrolling.
- Keep internal content scrolling available for long lessons and reports.

## Out of scope unless approved

- A new attendance collection system.
- Replacing manager workplace observation with automated scoring.
- Automated WhatsApp notifications or daily summaries without a separate data and consent decision.
- Payroll, scheduling, point-of-sale, or restaurant operations management.
- Broad multi-tenant administration beyond the access model that is defined for V2.

## Decisions still required

1. Is V2 primarily a refinement of the current training app, or a broader platform with owner reporting and additional workflows?
2. Which roles are required: learner, manager, owner, administrator, or another role?
3. Should partial progress be visible to managers immediately, and what exactly counts as “in progress”?
4. Should a learner’s progress follow the person across devices, or remain tied to one restaurant and account?
5. What information should owners see that managers should not see?
6. What is the minimum V2 module and assessment set for launch?
7. Are certificates, attendance, WhatsApp summaries, or notifications part of V2 or later?
8. What reporting and data-retention rules apply to staff assessment and observation records?
9. What success measures will determine whether V2 is working?
10. Should V2 use the current single-page architecture, or should the application be reorganized into a more maintainable frontend structure?

## Suggested V2 delivery order

1. Confirm scope, roles, and success measures.
2. Define the durable progress model and access rules.
3. Improve learner navigation and resume behavior.
4. Rebuild the manager dashboard around the agreed progress model.
5. Review and refine module content and assessments.
6. Add owner reporting only after manager data is reliable.
7. Test accessibility, desktop layout, mobile layout, refresh, logout, and role boundaries.
8. Pilot with one restaurant before wider rollout.

