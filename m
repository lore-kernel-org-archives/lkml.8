Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D30D207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgFIPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:13:38 -0400
Received: from outbound-smtp42.blacknight.com ([46.22.139.226]:44325 "EHLO
        outbound-smtp42.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730737AbgFIPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:13:34 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id DCA6B1AFF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:13:31 +0100 (IST)
Received: (qmail 5930 invoked from network); 9 Jun 2020 15:13:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jun 2020 15:13:31 -0000
Date:   Tue, 9 Jun 2020 16:13:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, minchan@kernel.org,
        mgorman@suse.de, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
Subject: Re: [PATCH] page_alloc: consider highatomic reserve in wmartermark
 fast
Message-ID: <20200609151330.GL3127@techsingularity.net>
References: <CGME20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0@epcas1p1.samsung.com>
 <20200609095128.8112-1-jaewon31.kim@samsung.com>
 <20200609142747.GA3346@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200609142747.GA3346@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:27:47PM +0800, Baoquan He wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 13cc653122b7..00869378d387 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3553,6 +3553,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> >  {
> >  	long free_pages = zone_page_state(z, NR_FREE_PAGES);
> >  	long cma_pages = 0;
> > +	long highatomic = 0;
> > +	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> > +
> > +	if (likely(!alloc_harder))
> > +		highatomic = z->nr_reserved_highatomic;
> >  
> >  #ifdef CONFIG_CMA
> >  	/* If allocation can't use CMA areas don't use free CMA pages */
> > @@ -3567,8 +3572,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> >  	 * the caller is !atomic then it'll uselessly search the free
> >  	 * list. That corner case is then slower but it is harmless.
> >  	 */
> > -	if (!order && (free_pages - cma_pages) > mark + z->lowmem_reserve[classzone_idx])
> > -		return true;
> > +	if (!order) {
> > +		long fast_free = free_pages - cma_pages - highatomic;
> > +
> > +		if (fast_free > mark + z->lowmem_reserve[classzone_idx])
> 
> This looks reasonable to me. However, this change may not be rebased on
> top of the latest mainline tree or mm tree. E.g in this commit 97a225e69a1f8
> ("mm/page_alloc: integrate classzone_idx and high_zoneidx"), classzone_idx
> has been changed to highest_zoneidx.
> 

That's fine, I simply wanted to illustrate where I thought the check
should go to minimise the impact to the majority of allocations.

-- 
Mel Gorman
SUSE Labs
