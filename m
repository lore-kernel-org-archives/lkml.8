Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E25520829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgHNGj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:39:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgHNGj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:39:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4CFFADF0;
        Fri, 14 Aug 2020 06:39:48 +0000 (UTC)
Date:   Fri, 14 Aug 2020 08:39:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
Message-ID: <20200814063924.GX9477@dhcp22.suse.cz>
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <20200813114105.GI9477@dhcp22.suse.cz>
 <9ca76893-dfe8-9a46-f2ec-6b3c663e848e@codeaurora.org>
 <20200813163054.GR9477@dhcp22.suse.cz>
 <099b1a12-7fcd-f665-3f9d-e20d4e1396d3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099b1a12-7fcd-f665-3f9d-e20d4e1396d3@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 22:57:32, Charan Teja Kalla wrote:
> Thanks Michal.
> 
> On 8/13/2020 10:00 PM, Michal Hocko wrote:
> > On Thu 13-08-20 21:51:29, Charan Teja Kalla wrote:
> >> Thanks Michal for comments.
> >>
> >> On 8/13/2020 5:11 PM, Michal Hocko wrote:
> >>> On Tue 11-08-20 18:28:23, Charan Teja Reddy wrote:
> >>> [...]
> >>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>> index e4896e6..839039f 100644
> >>>> --- a/mm/page_alloc.c
> >>>> +++ b/mm/page_alloc.c
> >>>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >>>>  	struct page *page, *tmp;
> >>>>  	LIST_HEAD(head);
> >>>>  
> >>>> +	/*
> >>>> +	 * Ensure proper count is passed which otherwise would stuck in the
> >>>> +	 * below while (list_empty(list)) loop.
> >>>> +	 */
> >>>> +	count = min(pcp->count, count);
> >>>>  	while (count) {
> >>>>  		struct list_head *list;
> >>>
> >>>
> >>> How does this prevent the race actually?
> >>
> >> This doesn't prevent the race. This only fixes the core hung(as this is
> >> called with spin_lock_irq()) caused by the race condition. This core
> >> hung is because of incorrect count value is passed to the
> >> free_pcppages_bulk() function.
> > 
> > Let me ask differently. What does enforce that the count and lists do
> > not get out of sync in the loop. 
> 
> count value is updated whenever an order-0 page is being added to the
> pcp lists through free_unref_page_commit(), which is being called with
> both interrupts, premption disabled.
> static void free_unref_page_commit(struct page *page, {
> 	....
> 	list_add(&page->lru, &pcp->lists[migratetype]);
> 	pcp->count++
> }
> 
> As these are pcp lists, they only gets touched by another process when
> this process is context switched, which happens only after enabling
> premption or interrupts. So, as long as process is operating on these
> pcp lists in free_unref_page_commit function, the count and lists are
> always synced.
> 
> However, the problem here is not that the count and lists are being out
> of sync. They do always in sync, as explained above. It is with the
> asking free_pcppages_bulk() to free the pages more than what is present
> in the pcp lists which is ending up in while(list_empty()).

You are right. I managed to confuse myself. The thing is that the batch
count is out of sync.

> > Your changelog says that the fix is to
> > use the proper value without any specifics.
> > 
> Will change this to: Ensure the count value passed is not greater than
> the pcp lists count. Any better you suggest?

Yes, this makes it more clear.

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
