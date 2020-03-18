Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285012072C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Y6Xi3lPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCRTSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:18:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33805 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:18:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id f3so40800936qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQvDIySSbkWyr/qHdOXKNe8wk+VRcVawYnYMz13G/Rk=;
        b=Y6Xi3lPIjhMfBXsU+ccZCb+1d5ImI8mg5uItAkja+ZSUAIFnrsoZ8GDp3Tzr1SKQYX
         OuA+xu/WTl9J65ZQZdwrRSDA7UemC+T/mw4xn0SOrhtC+glBMau9/jGY4Ybgd0ain55g
         hho2+FUaMoVK6F05B9m/gMqpB8e8XN/C3GXKbBMvtxFFVLUjuI87iOtMXyRThZ0TRK9G
         z2CKvGio9v700rDbR1I9UkxDUlMcML77YpC1YegRrnrSKi7CffVx+2EsNH+v/rteaZ6S
         m8y/x7nUSK5Hmi6yHuOLREb0Cjx/AjnFKrMcEr/pCvygxheRcv1rdyfvg9OcYc5AII0J
         15Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQvDIySSbkWyr/qHdOXKNe8wk+VRcVawYnYMz13G/Rk=;
        b=HAEaqmwQFxkdowehw3AVTNL/SldcASFcq1BbtxWCYJcZ3yyNJeq7ZhO9Nrq3dBkjh9
         0bc9iHipTMsv7X9EtQCwaeiOOHWh+Jbhdae9brPKtt3b9rE7pZodtjjlVaCJ+oScRUuF
         FndpRc+ubmL0+oIK5sEwLlqTxidJ9o6N+k6oTPzgkcUj3NbvoqbZzPrDOkmab6Gq63QQ
         etaPEZhgJ5GaPsb3/bctIw04rQQbcPzPdxE4SV8aZP+K63EplSQTF3+YFZgSlS+/gKwf
         J0KRMozJIpQbirwIoXa/SeZuTgwc8d3flE9t/n6+BxABfxpu+Q4OrW3wOw3oAlpEmyYC
         g/8w==
X-Gm-Message-State: ANhLgQ32pqPhKMpij08N+UyNPx284gM52CAGosRUGV4EcsCCdbXB+y0a
        zGP+8A31YbpFr9C70nwAFdSHKg==
X-Google-Smtp-Source: ADFU+vtaChz9+4Wa5SKV9Hu/G/FOJ16C9CSPRkw41fqyzQ5iK+MnDy+CKWqdYP5HRzeDATU0hLql2w==
X-Received: by 2002:a37:6848:: with SMTP id d69mr3602961qkc.191.1584559084627;
        Wed, 18 Mar 2020 12:18:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id c40sm5683497qtk.18.2020.03.18.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:18:03 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:18:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 5/9] mm/workingset: use the node counter if memcg is
 the root memcg
Message-ID: <20200318191802.GE154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:53PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> In the following patch, workingset detection is implemented for the
> swap cache. Swap cache's node is usually allocated by kswapd and it
> isn't charged by kmemcg since it is from the kernel thread. So the swap
> cache's shadow node is managed by the node list of the list_lru rather
> than the memcg specific one.
> 
> If counting the shadow node on the root memcg happens to reclaim the slab
> object, the shadow node count returns the number of the shadow node on
> the node list of the list_lru since root memcg has the kmem_cache_id, -1.
> 
> However, the size of pages on the LRU is calculated by using the specific
> memcg, so mismatch happens. This causes the number of shadow node not to
> be increased to the enough size and, therefore, workingset detection
> cannot work correctly. This patch fixes this bug by checking if the memcg
> is the root memcg or not. If it is the root memcg, instead of using
> the memcg-specific LRU, the system-wide LRU is used to calculate proper
> size of the shadow node so that the number of the shadow node can grow
> as expected.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/workingset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 5fb8f85..a9f474a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -468,7 +468,13 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  	 * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
>  	 */
>  #ifdef CONFIG_MEMCG
> -	if (sc->memcg) {
> +	/*
> +	 * Kernel allocation on root memcg isn't regarded as allocation of
> +	 * specific memcg. So, if sc->memcg is the root memcg, we need to
> +	 * use the count for the node rather than one for the specific
> +	 * memcg.
> +	 */
> +	if (sc->memcg && !mem_cgroup_is_root(sc->memcg)) {

This is no good, unfortunately.

It allows the root cgroup's shadows to grow way too large. Consider a
large memory system where several workloads run in containers and only
some host software runs in the root, yet that tiny root group will
grow shadow entries in proportion to the entire RAM.

IMO, we have some choices here:

1. We say the swapcache is a shared system facility and its memory is
not accounted to anyone. In that case, we should either
   1a. Reclaim them to a fixed threshold, regardless of cgroup, or
   1b. Not reclaim them at all. Or
2. We account all nodes to the groups for which they are allocated.
   Essentially like this:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..d0d0dcc357fb 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -125,6 +125,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	page_ref_add(page, nr);
 	SetPageSwapCache(page);
 
+	memalloc_use_memcg(page_memcg(page));
 	do {
 		xas_lock_irq(&xas);
 		xas_create_range(&xas);
@@ -142,6 +143,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
+	memalloc_unuse_memcg();
 
 	if (!xas_error(&xas))
 		return 0;
@@ -605,7 +607,8 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
+		xa_init_flags(&space->i_pages,
+			      XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */

(A reclaimer has PF_MEMALLOC set, so we'll bypass the limit when
recursing into charging the node.)

I'm leaning more toward 1b, actually. The shadow shrinker was written
because the combined address space of files on the filesystem can
easily be in the terabytes, and practically unbounded with sparse
files. The shadow shrinker is there to keep users from DoSing the
system with shadow entries for files.

However, the swap address space is bounded by a privileged user. And
the size is usually in the GB range. On my system, radix_tree_node is
~583 bytes, so a for a 16G swapfile, the swapcache xarray should max
out below 40M (36M worth of leaf nodes, plus some intermediate nodes).

It doesn't seem worth messing with the shrinker at all for these.
