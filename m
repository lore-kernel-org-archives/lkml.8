Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA5C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACDC206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583620738;
	bh=jY3ApsFdVBDgkPNklxOZVGDnQe6nZKwAz6e8yhaAOIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gnbUorVvpe2lMzgN7wBqI5vN/djcIcxq+OI6izvMeeIRvCqnenKuKxvIY86H1uDIu
	 HkIYeBHrjfiaQL7gxQir6vMCsqE9dv6Ea9po1HAanmx1fXa87Pv6EhbhtabDeZEwqO
	 Fbpf+lVTRd7PDVUr30qli7TZQQfchLLO+XrD90u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCGWiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 17:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCGWiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 17:38:51 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81334206D7;
        Sat,  7 Mar 2020 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583620729;
        bh=jY3ApsFdVBDgkPNklxOZVGDnQe6nZKwAz6e8yhaAOIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8dX6WZJnnsTSKx3Pbeao90AoSS/lmqhhzJb4g/c9rM+9E79l9AWHRczZvXY+nZZC
         87Hl9r4MHSXR0zZisAypPokTMfukwXCe/fW1dYYqbL9yHwCB2eCSRcDxdXi3TnRKpx
         hmJHkcboZInDS20D74tRulzEBmLjkAhoiEeB7aJE=
Date:   Sat, 7 Mar 2020 14:38:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH]  mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-Id: <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
In-Reply-To: <20200306150102.3e77354b@imladris.surriel.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 15:01:02 -0500 Rik van Riel <riel@surriel.com> wrote:

> Posting this one for Roman so I can deal with any upstream feedback and
> create a v2 if needed, while scratching my head over the next piece of
> this puzzle :)
> 
> ---8<---
> 
> From: Roman Gushchin <guro@fb.com>
> 
> Currently a cma area is barely used by the page allocator because
> it's used only as a fallback from movable, however kswapd tries
> hard to make sure that the fallback path isn't used.
> 
> This results in a system evicting memory and pushing data into swap,
> while lots of CMA memory is still available. This happens despite the
> fact that alloc_contig_range is perfectly capable of moving any movable
> allocations out of the way of an allocation.
> 
> To effectively use the cma area let's alter the rules: if the zone
> has more free cma pages than the half of total free pages in the zone,
> use cma pageblocks first and fallback to movable blocks in the case of
> failure.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Co-developed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

fyi, the signoffs are in an unconventional order - usually the primary
author comes first.

> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  {
>  	struct page *page;
>  
> +	/*
> +	 * Balance movable allocations between regular and CMA areas by
> +	 * allocating from CMA when over half of the zone's free memory
> +	 * is in the CMA area.
> +	 */
> +	if (migratetype == MIGRATE_MOVABLE &&
> +	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> +	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> +		page = __rmqueue_cma_fallback(zone, order);
> +		if (page)
> +			return page;
> +	}
>  retry:
>  	page = __rmqueue_smallest(zone, order, migratetype);
>  	if (unlikely(!page)) {

__rmqueue() is a hot path (as much as any per-page operation can be a
hot path).  What is the impact here?

