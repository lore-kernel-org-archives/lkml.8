Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02763C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9A82076C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751762;
	bh=TVmPcxLNQcu0xYBxBOuhbjJ9wckAGNHvziiL1WvF9tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wG7u+X6DREBL3vkUHqpUeJTDxeL9mPm5fuZ3o+zs0ad8RACGzYxhMFWXXuSQw/d+
	 gidFjBHvKlsJmmULVtsWLRienNTAL08BZ2/aWN7/APTWfajktxzViBFVVhGVcyvrux
	 cURjC+x2/Rps/z3bttQhJbzrJZIhaLiZF6PXsWns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgCUAtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:49:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33859 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCUAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:49:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so3924708pgn.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3hKa7LLOLuovj0zSAadO4DLSIWvtOsmfSVgYwWw1DQE=;
        b=kVhapPyhhlS7a3c/Kl12nm/bpaj2L3ZRzwM27chDYk8hvA47Jc1jE1RSzbk7CHaRSd
         WGdieTWZ9+/f4tVx4SPfSCvwmb6MKz9dfAKr55RcXRIKl6Okj9oYp6U+3AdJaFMsPytc
         yfs94+DUDXpQKPZ3CEuyqGuUMP8Yq8qhlhpmq65At5ETZ8Kg3KZii/WF2cTHb4RTcvLV
         6ANInkkT0rHl8jT9NKMB9TmakwCY1zGMh4YP0WDMhw+zjrOX9oFqdVXPkxe8mH92VR/B
         H4tIYjvBFW6hrNDjg41PT1ffohl7Er15It6/L1gu22YF2M27pYrapzWdt/6go2AgWplZ
         OIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3hKa7LLOLuovj0zSAadO4DLSIWvtOsmfSVgYwWw1DQE=;
        b=OS3MNjs4vuh5/Z1ZibctSwYcU4kPhELe2oIZ/Pak3JDl/2NgewwxLRtXCL4b6aMi+2
         1xeBRRoU+gO4QscASf7zL3Dx9ruvltXTKggD6nGJPOhI0mDoqZlMxI/3bHwZdPVaSMo2
         LJ2Oc9lN9T1uDx6GaM3lzSrhAMZH2yyEHC330LrpVOE6mTeRcbkT9USTHwbT+Q4cz+6C
         SLDf7iSwqxvUXMbI1Wgfn5qeFzg8HvPPr+U42aRBRredan7ErwH8AvN60VQDpJDfhibe
         Y3yit8IeGA44EkifjediVomm6wCvPZknVS/3DAliOfYYWumLz4OB8CffBM6omb2LWZGG
         0LRQ==
X-Gm-Message-State: ANhLgQ1KGN7T7h2tO3oRQXZ3XEJTPr6T9WFgSisBl6XKPa9M4vZen5NZ
        NgMczQeh6Q3z1wOGD3trfvY=
X-Google-Smtp-Source: ADFU+vsOPDWfJHSjmNrg4xTOMhPjHA6ft6fZW+KEqoqpdYD3TjSBUPV22qdD7ljU+OCQ3wnasFONrA==
X-Received: by 2002:a63:715b:: with SMTP id b27mr11280969pgn.275.1584751759638;
        Fri, 20 Mar 2020 17:49:19 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id w19sm6397870pgm.27.2020.03.20.17.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 17:49:18 -0700 (PDT)
Date:   Fri, 20 Mar 2020 17:49:16 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH]  mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200321004608.GA172976@google.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306150102.3e77354b@imladris.surriel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:01:02PM -0500, Rik van Riel wrote:
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
> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..0fb3c1719625 100644
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

Can't we move the check to caller so that only one atomic operation
per pcp refill?

rmqueue_bulk:
    spin_lock(zone->lock);
    cma_first = FREE_CMA > FREE_PAGE / 2;
    for (i, i < count; ++i) {
        __rmqueue(zone, order, migratetype, alloc_flags, cma_first);
    }

As a long term solution, I am looking forward to seeing cma zone
approach but this is also good as stop-gap solution.
Actually, in the android, vendors have used their customization to
make CMA area utilization high(i.e., CMA first and then movable)
but more restricted allocation pathes. So, I really want to see
this patch in upstream to make CMA utilization higher. A good side
about this patch is quite simple.

About the CMA allocation failure ratio, there is no good idea
to solve the issue perfectly. Even we go with cma zone approach,
it could happen. If so, I'd like to expose the symptom more
aggressively so that we could hear the pain and find the solution
actively rather than relying on luck.

Thus,
Acked-by: Minchan Kim <minchan@kernel.org>
