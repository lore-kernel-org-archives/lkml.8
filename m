Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C965206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587999701;
	bh=BkcoKBV7ZEs783/BIjAIUnnTYLSlaVNoyYemnX6cuXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P84FRWZl+wUuZ9m3LRTmAgLRmJiw2OjzzWYkX3AjrMvYPMvtenG8EG4jV9oFQSpot
	 0jQ/vCFuh1K0gPOcGJTXMs4i8FId/N2Bvw65XUynemOi8sWh9EPocAGjZ0nO8oVRXs
	 Vx52/GRlRRFkDRhjowzklMPj1qBQO+/b5kOqxajo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgD0PBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:01:40 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44379 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgD0PBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:01:39 -0400
Received: by mail-wr1-f49.google.com with SMTP id d17so20949982wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jErfeyJqy2ekOgktMYV3Gdiye62PCw4i+yFqIFRALNg=;
        b=RbfnzF4InzWrkRoPIQrunuIPg1qGBUfcZYLRCxCzY7+qpYc6sko05KdFsNSrn77bNu
         jteRSOeuG+t5CL1zErJzveBen8VvINpoDVRYl4LkW4QIBGTsXkHUhfgg7WHS9u4J3C2R
         SikInMa0pDgKCfkUUBhulCtPqMlRvfu8/JXHYLBt0plEYIGgYNXdASpqwEKM9f6dKxVO
         a3Z0LFT61o7Z2eS23TjrZeSG2748UyDCptjN8iUSy1ezIYxi9tv9aQipodJr9SMDb0eo
         MQ9bHUnTFP95l8B+gThQARCDScgMMLzEiykqE0r/ijWwR/oqoarXEZAgqS7V/ehSzeZk
         Ysxw==
X-Gm-Message-State: AGi0PuYljj3CajGh0/HFGOIBBS20nP8BFJhtwBKvHZ67JJdKIOMLE+W0
        skN0Ao75BNzrwUC/1sS3xYQ=
X-Google-Smtp-Source: APiQypLT6kjKf4hBKZqFJgg9CyylQTcsdBIBOYagqZJnOSd5QqpsUj8DBCzfTIPLV0YwLABkIdgj/w==
X-Received: by 2002:a5d:404a:: with SMTP id w10mr27187756wrp.397.1587999696474;
        Mon, 27 Apr 2020 08:01:36 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id j10sm16883320wmi.18.2020.04.27.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 08:01:35 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:01:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-ID: <20200427150133.GG28637@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-04-20 13:48:06, David Rientjes wrote:
> If GFP_ATOMIC allocations will start failing soon because the amount of
> free memory is substantially under per-zone min watermarks, it is better
> to oom kill a process rather than continue to reclaim.
> 
> This intends to significantly reduce the number of page allocation
> failures that are encountered when the demands of user and atomic
> allocations overwhelm the ability of reclaim to keep up.  We can see this
> with a high ingress of networking traffic where memory allocated in irq
> context can overwhelm the ability to reclaim fast enough such that user
> memory consistently loops.  In that case, we have reclaimable memory, and
> reclaiming is successful, but we've fully depleted memory reserves that
> are allowed for non-blockable allocations.
> 
> Commit 400e22499dd9 ("mm: don't warn about allocations which stall for
> too long") removed evidence of user allocations stalling because of this,
> but the situation can apply anytime we get "page allocation failures"
> where reclaim is happening but per-zone min watermarks are starved:
> 
> Node 0 Normal free:87356kB min:221984kB low:416984kB high:611984kB active_anon:123009936kB inactive_anon:67647652kB active_file:429612kB inactive_file:209980kB unevictable:112348kB writepending:260kB present:198180864kB managed:195027624kB mlocked:81756kB kernel_stack:24040kB pagetables:11460kB bounce:0kB free_pcp:940kB local_pcp:96kB free_cma:0kB
> lowmem_reserve[]: 0 0 0 0
> Node 1 Normal free:105616kB min:225568kB low:423716kB high:621864kB active_anon:122124196kB inactive_anon:74112696kB active_file:39172kB inactive_file:103696kB unevictable:204480kB writepending:180kB present:201326592kB managed:198174372kB mlocked:204480kB kernel_stack:11328kB pagetables:3680kB bounce:0kB free_pcp:1140kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0 0
> 
> Without this patch, there is no guarantee that user memory allocations
> will ever be successful when non-blockable allocations overwhelm the
> ability to get above per-zone min watermarks.

We have never had any guarantee and we will not have any after this
patch either. The fundamental problem is that direct reclaim doesn't
provide any guarantee that the reclaimed memory is going to be used for
the reclaimer. You can see the same if the memory demand is higher
than the reclaim. GFP_ATOMIC is only different in that aspect that they
are not throttled by reclaiming and consume what is availble right away
which makes the problem worse.
 
> This doesn't solve page allocation failures entirely since it's a
> preemptive measure based on watermarks that requires concurrent blockable
> allocations to trigger the oom kill.  To complete solve page allocation
> failures, it would be possible to do the same watermark check for non-
> blockable allocations and then queue a worker to asynchronously oom kill
> if it finds watermarks to be sufficiently low as well.

I do not think this is the right approach. This patch is also quite
dangerous as pointed out by Tetsuo. You are effectively allowing a
remote DoS via OOM killer. If the reclaim is making progress then the
issue seem to be more on the configuration side I believe. Have you
tried to tune watermarks resp. watermark_scale_factor? Another potential
problem might be that the kswapd is not making sufficient progress
because it is blocked on something.

> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4372,11 +4372,21 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  					ac->nodemask) {
>  		unsigned long available;
>  		unsigned long reclaimable;
> +		unsigned long free;
>  		unsigned long min_wmark = min_wmark_pages(zone);
>  		bool wmark;
>  
> +		free = zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +		/*
> +		 * If this zone is approaching the point where even order-0
> +		 * GFP_ATOMIC allocations will fail, stop considering reclaim.
> +		 */
> +		if (!__zone_watermark_ok(zone, 0, min_wmark, ac_classzone_idx(ac),
> +					 alloc_flags | ALLOC_HIGH, free))
> +			continue;
> +
>  		available = reclaimable = zone_reclaimable_pages(zone);
> -		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +		available += free;
>  
>  		/*
>  		 * Would the allocation succeed if we reclaimed all

-- 
Michal Hocko
SUSE Labs
