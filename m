Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C493F20772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgHKGyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgHKGyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8E87AC98;
        Tue, 11 Aug 2020 06:55:08 +0000 (UTC)
Date:   Tue, 11 Aug 2020 08:54:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200811065406.GC4793@dhcp22.suse.cz>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811015148.GA10792@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-08-20 09:51:48, Baoquan He wrote:
> On 08/10/20 at 05:19pm, Mike Kravetz wrote:
> > On 8/9/20 7:17 PM, Baoquan He wrote:
> > > On 08/07/20 at 05:12pm, Wei Yang wrote:
> > >> Let's always increase surplus_huge_pages and so that free_huge_page
> > >> could decrease it at free time.
> > >>
> > >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> > >> ---
> > >>  mm/hugetlb.c | 14 ++++++--------
> > >>  1 file changed, 6 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >> index 1f2010c9dd8d..a0eb81e0e4c5 100644
> > >> --- a/mm/hugetlb.c
> > >> +++ b/mm/hugetlb.c
> > >> @@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> > >>  		return NULL;
> > >>  
> > >>  	spin_lock(&hugetlb_lock);
> > >> +
> > >> +	h->surplus_huge_pages++;
> > >> +	h->surplus_huge_pages_node[page_to_nid(page)]++;
> > >> +
> > >>  	/*
> > >>  	 * We could have raced with the pool size change.
> > >>  	 * Double check that and simply deallocate the new page
> > >> -	 * if we would end up overcommiting the surpluses. Abuse
> > >> -	 * temporary page to workaround the nasty free_huge_page
> > >> -	 * codeflow
> > >> +	 * if we would end up overcommiting the surpluses.
> > >>  	 */
> > >> -	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> > >> -		SetPageHugeTemporary(page);
> > > 
> > > Hmm, the temporary page way is taken intentionally in
> > > commit 9980d744a0428 ("mm, hugetlb: get rid of surplus page accounting tricks").
> > > From code, this is done inside hugetlb_lock holding, and the code flow
> > > is straightforward, should be safe. Adding Michal to CC.

But the lock is not held during the migration, right?

> > I remember when the temporary page code was added for page migration.
> > The use of temporary page here was added at about the same time.  Temporary
> > page does have one advantage in that it will not CAUSE surplus count to
> > exceed overcommit.  This patch could cause surplus to exceed overcommit
> > for a very short period of time.  However, do note that for this to happen
> > the code needs to race with a pool resize which itself could cause surplus
> > to exceed overcommit.

Correct.

> > IMO both approaches are valid.
> > - Advantage of temporary page is that it can not cause surplus to exceed
> >   overcommit.  Disadvantage is as mentioned in the comment 'abuse of temporary
> >   page'.
> > - Advantage of this patch is that it uses existing counters.  Disadvantage
> >   is that it can momentarily cause surplus to exceed overcommit.

Do I remember correctly that this can cause an allocation failure due to
overcommit check? In other words it would be user space visible thing?

> Yeah, since it's all done inside hugetlb_lock, should be OK even
> though it may cause surplus to exceed overcommit.
> > 
> > Unless someone has a strong opinion, I prefer the changes in this patch.
> 
> Agree, I also prefer the code change in this patch, to remove the
> unnecessary confusion about the temporary page.

I have managed to forgot all the juicy details since I have made that
change. All that remains is that the surplus pages accounting was quite
tricky and back then I didn't figure out a simpler method that would
achieve the consistent look at those counters. As mentioned above I
suspect this could lead to pre-mature allocation failures while the
migration is ongoing. Sure quite unlikely to happen and the race window
is likely very small. Maybe this is even acceptable but I would strongly
recommend to have all this thinking documented in the changelog.
-- 
Michal Hocko
SUSE Labs
