Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1890120759
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoicN+vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEVF4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:56:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A840C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:56:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 63so7420301oto.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=xuMkRmj7HE1TUvvSzA0QEvz2ex2xVPIDBfTSJuTOfeM=;
        b=DoicN+vf5RhMplKcLT6Q88DGW2yRh2mPk5cdDgjAhGMTK0/qjr+Im1t6vFCyxp6nlk
         aaCqtH6peZqvmRbNxpNCrkEdjbZ3400UA67sK79laJCnob5U9hYXowk2Sj7r9FNrh5Ak
         DCMwtt50NogFtmaDdYVDQrJytC57uIZulPFtxNwBIsTG8CEhcQfi1DrnV7qtG/gRVV6z
         42++D8/WRiQ0NmxYrY7tZJiaztrgt2Lm8Saycau9jIQE8b86ABAue2LWTPBp/z+C0i0P
         TJ9SoGBwzJd1ZMR9CKaBhF28RQtNbpjQo0V5JLPoHs+E3DXL8bH2wt0tAOcjrgfX9y55
         VBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=xuMkRmj7HE1TUvvSzA0QEvz2ex2xVPIDBfTSJuTOfeM=;
        b=jQgWDQAw58NO1Qqf27/RZRIClAUG7tEZw6r3hajtC8T4bGAne1tQTdPPUlEbNW2sJt
         KkhrGCEglWECjFxGIvzHs5a8Ai20X0XF+QdXrLqdKXciJJ/llM7Ob+y9f13IZInPHDRe
         H4EC6PxUV1fjUGv9F+BO/cYcqZvGjcPHBJW9882VqtW5toVyNcGZMHHSJnhWO63TEHt5
         Zycw7UfClNjKRlnTg+0MFLlzS0iVo38G5yDVl/XRfHDV0R3dUFo6Dgl2cdpd0vu3kVN3
         8ov+zZnFJ7cGrORsBISOZ8roCFvoey32enutBU6t3Ij4yMf5x7pfbNaPjI3grzMGEa3p
         xT9w==
X-Gm-Message-State: AOAM533zXWABDWAuUi1kL1pL692YlD6QWqPCQgAZoLHOh2zMON/ylqmv
        M2+IeDFaRe6LhR/MQLbInR3SPQ==
X-Google-Smtp-Source: ABdhPJzCalQObzgSFGb19GhNEMR5QmicKyzdXqH+w02qvkfyMP6HhEUzFPOl66qMcsTFeD0Vy+CjrA==
X-Received: by 2002:a9d:6645:: with SMTP id q5mr9424059otm.211.1590126998592;
        Thu, 21 May 2020 22:56:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y23sm2225479otk.10.2020.05.21.22.56.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 21 May 2020 22:56:37 -0700 (PDT)
Date:   Thu, 21 May 2020 22:56:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm/swap: fix livelock in __read_swap_cache_async()
Message-ID: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've only seen this livelock on one machine (repeatably, but not to
order), and not fully analyzed it - two processes seen looping around
getting -EEXIST from swapcache_prepare(), I guess a third (at lower
priority? but wanting the same cpu as one of the loopers? preemption
or cond_resched() not enough to let it back in?) set SWAP_HAS_CACHE,
then went off into direct reclaim, scheduled away, and somehow could
not get back to add the page to swap cache and let them all complete.

Restore the page allocation in __read_swap_cache_async() to before
the swapcache_prepare() call: "mm: memcontrol: charge swapin pages
on instantiation" moved it outside the loop, which indeed looks much
nicer, but exposed this weakness.  We used to allocate new_page once
and then keep it across all iterations of the loop: but I think that
just optimizes for a rare case, and complicates the flow, so go with
the new simpler structure, with allocate+free each time around (which
is more considerate use of the memory too).

Fix the comment on the looping case, which has long been inaccurate:
it's not a racing get_swap_page() that's the problem here.

Fix the add_to_swap_cache() and mem_cgroup_charge() error recovery:
not swap_free(), but put_swap_page() to undo SWAP_HAS_CACHE, as was
done before; but delete_from_swap_cache() already includes it.

And one more nit: I don't think it makes any difference in practice,
but remove the "& GFP_KERNEL" mask from the mem_cgroup_charge() call:
add_to_swap_cache() needs that, to convert gfp_mask from user and page
cache allocation (e.g. highmem) to radix node allocation (lowmem), but
we don't need or usually apply that mask when charging mem_cgroup.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Mostly fixing mm-memcontrol-charge-swapin-pages-on-instantiation.patch
but now I see that mm-memcontrol-delete-unused-lrucare-handling.patch
made a further change here (took an arg off the mem_cgroup_charge call):
as is, this patch is diffed to go on top of both of them, and better
that I get it out now for Johannes look at; but could be rediffed for
folding into blah-instantiation.patch later.

Earlier in the day I promised two patches to __read_swap_cache_async(),
but find now that I cannot quite justify the second patch: it makes a
slight adjustment in swapcache_prepare(), then removes the redundant
__swp_swapcount() && swap_slot_cache_enabled business from blah_async().

I'd still like to do that, but this patch here brings back the
alloc_page_vma() in between them, and I don't have any evidence to
reassure us that I'm not then pessimizing a readahead case by doing
unnecessary allocation and free. Leave it for some other time perhaps.

 mm/swap_state.c |   52 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

--- 5.7-rc6-mm1/mm/swap_state.c	2020-05-20 12:21:56.149694170 -0700
+++ linux/mm/swap_state.c	2020-05-21 20:17:50.188773901 -0700
@@ -392,56 +392,62 @@ struct page *__read_swap_cache_async(swp
 			return NULL;
 
 		/*
+		 * Get a new page to read into from swap.  Allocate it now,
+		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
+		 * cause any racers to loop around until we add it to cache.
+		 */
+		page = alloc_page_vma(gfp_mask, vma, addr);
+		if (!page)
+			return NULL;
+
+		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry);
 		if (!err)
 			break;
 
-		if (err == -EEXIST) {
-			/*
-			 * We might race against get_swap_page() and stumble
-			 * across a SWAP_HAS_CACHE swap_map entry whose page
-			 * has not been brought into the swapcache yet.
-			 */
-			cond_resched();
-			continue;
-		}
+		put_page(page);
+		if (err != -EEXIST)
+			return NULL;
 
-		return NULL;
+		/*
+		 * We might race against __delete_from_swap_cache(), and
+		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
+		 * has not yet been cleared.  Or race against another
+		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
+		 * in swap_map, but not yet added its page to swap cache.
+		 */
+		cond_resched();
 	}
 
 	/*
-	 * The swap entry is ours to swap in. Prepare a new page.
+	 * The swap entry is ours to swap in. Prepare the new page.
 	 */
 
-	page = alloc_page_vma(gfp_mask, vma, addr);
-	if (!page)
-		goto fail_free;
-
 	__SetPageLocked(page);
 	__SetPageSwapBacked(page);
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL)) {
+		put_swap_page(page, entry);
 		goto fail_unlock;
+	}
 
-	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL))
-		goto fail_delete;
+	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
+		delete_from_swap_cache(page);
+		goto fail_unlock;
+	}
 
-	/* Initiate read into locked page */
+	/* Caller will initiate read into locked page */
 	SetPageWorkingset(page);
 	lru_cache_add_anon(page);
 	*new_page_allocated = true;
 	return page;
 
-fail_delete:
-	delete_from_swap_cache(page);
 fail_unlock:
 	unlock_page(page);
 	put_page(page);
-fail_free:
-	swap_free(entry);
 	return NULL;
 }
 
