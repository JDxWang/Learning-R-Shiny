# Overview

I am learning to write R shiny visualisation apps in this project.

It also involves some basic HTML scraping with the package `rvest`.

You can find the current version here: https://jdxwang.shinyapps.io/ozbargain_tags/

Do note that currently it's using a basic for-loop to go through about 200 deals and takes a moment to load.

# Description

OzBargain is an Australian website that allows users to post "deals" (i.e. discounts, promotions, sales, etc.) from other websites or stores.

Each deal will have one or more associated tags. E.g. A deal of discounted laptops will have the tag "Computing".

The app in its current state will retrieve the first 10 pages of newest deals and present a pie chart of the frequency of each tag.

# End Goal

I am looking to add the following features:

1. Allow the user to choose the number of pages of deals to load.
2. Have an interactive chart where the user can see the top deal (the deal with most user likes) of each tag.
3. The user can see all deals under each tag via external links to OzBargain.
4. Tables that list popular deals (OzBargain have this feature but the threshold for "popular" is rather high)

# Side project

Potentially I can write a notification bot that searches user input keywords and notifies them if a matching deal has been posted via a messeging platform of their choice.
