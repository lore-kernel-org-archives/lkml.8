Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595F220758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgIBR4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:56:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:56:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4685AD5C;
        Wed,  2 Sep 2020 17:56:23 +0000 (UTC)
Subject: Re: [Patch v4 5/7] mm/hugetlb: a page from buddy is not on any list
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
 <20200901014636.29737-6-richard.weiyang@linux.alibaba.com>
 <fd89ad4a-ef8d-e54e-8769-d6b15c40cc43@suse.cz>
 <6e9aebdf-a7a9-fb60-eadf-02088602cfdd@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d25835da-b9cc-45bf-e48a-6de2efcc9f97@suse.cz>
Date:   Wed, 2 Sep 2020 19:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6e9aebdf-a7a9-fb60-eadf-02088602cfdd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 7:25 PM, Mike Kravetz wrote:
> On 9/2/20 3:49 AM, Vlastimil Babka wrote:
>> On 9/1/20 3:46 AM, Wei Yang wrote:
>>> The page allocated from buddy is not on any list, so just use list_add()
>>> is enough.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> Reviewed-by: Baoquan He <bhe@redhat.com>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  mm/hugetlb.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 441b7f7c623e..c9b292e664c4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2405,7 +2405,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>>>  			h->resv_huge_pages--;
>>>  		}
>>>  		spin_lock(&hugetlb_lock);
>>> -		list_move(&page->lru, &h->hugepage_activelist);
>>> +		list_add(&page->lru, &h->hugepage_activelist);
>> 
>> Hmm, how does that list_move() actually not crash today?
>> Page has been taken from free lists, thus there was list_del() and page->lru
>> should be poisoned.
>> list_move() does __list_del_entry() which will either detect the poison with
>> CONFIG_DEBUG_LIST, or crash accessing the poison, no?
>> Am I missing something or does it mean this code is actually never executed in wild?
>> 
> 
> There is not enough context in the diff, but the hugetlb page was not taken
> from the free list.  Rather, it was just created by a call to
> alloc_buddy_huge_page_with_mpol().  As part of the allocation/creation
> prep_new_huge_page will be called which will INIT_LIST_HEAD(&page->lru).

Ah so indeed I was missing something :) Thanks. Then this is indeed a an
optimization and not a bugfix and doesn't need stable@. Sorry for the noise.
