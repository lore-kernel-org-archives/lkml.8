Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070DC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82690217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 04:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAUEsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:48:18 -0500
Received: from foss.arm.com ([217.140.110.172]:38196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgAUEsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 23:48:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE70A31B;
        Mon, 20 Jan 2020 20:48:17 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A10B3F52E;
        Mon, 20 Jan 2020 20:48:16 -0800 (PST)
Subject: Re: [Patch v2 4/4] mm/page_alloc.c: extract commom part to check page
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-5-richardw.yang@linux.intel.com>
 <3987ae0f-cbfc-1066-c78f-c5c6efc570ed@arm.com>
 <20200120123621.GE18028@richard>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c4abbe4d-6777-6c06-2a47-e01585b12745@arm.com>
Date:   Tue, 21 Jan 2020 10:19:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120123621.GE18028@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/20/2020 06:06 PM, Wei Yang wrote:
> On Mon, Jan 20, 2020 at 12:13:38PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 01/20/2020 08:34 AM, Wei Yang wrote:
>>> During free and new page, we did some check on the status of page
>>> struct. There is some common part, just extract them.
>>
>> Makes sense.
>>
>>>
>>> Besides this, this patch also rename two functions to keep the name
>>> convention, since free_pages_check_bad/free_pages_check are counterparts
>>> of check_new_page_bad/check_new_page.
>>
>> This probably should be in a different patch.
>>
> 
> In v1, they are in two separate patches. While David Suggest to merge it.
> 
> I am not sure whether my understanding is correct.

Keeping code refactoring and renaming separate is always better
but its okay, will leave it upto you.

> 
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  mm/page_alloc.c | 49 ++++++++++++++++++++++++-------------------------
>>>  1 file changed, 24 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index a7b793c739fc..7f23cc836f90 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1025,36 +1025,44 @@ static inline bool page_expected_state(struct page *page,
>>>  	return true;
>>>  }
>>>  
>>> -static void free_pages_check_bad(struct page *page)
>>> +static inline int __check_page(struct page *page, int nr,
>>> +				const char **bad_reason)
>>
>> free and new page checks are in and out of the buddy allocator, hence
>> this common factored function should have a more relevant name.
> 
> Hmm... naming is really difficult. Do you have any suggestion?
> 

Probably something like bad_page_fetch_reasons() and also this helper
can be expanded to include an additional argument 'bool free' which
can test either PAGE_FLAGS_CHECK_AT_FREE or PAGE_FLAGS_CHECK_AT_PREP.
This way bad_page_fetch_reasons() is where all possible reasons are
evaluated including page->flags based and then final 'int nr' can be
returned once and for all.

bad_flags does not seem to be needed. Wondering what it adds more
in bad_page() when page->flags gets printed universally through
__dump_page(). In case it is still required, it can be derived
from 'bad_reasons' evaluated in bad_page_fetch_reasons().
