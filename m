Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58EF20776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="c5d1DsFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgFAUo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:44:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:44:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so8828120qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WX6vrgdXsTGNrYeiwfYIi7rHNabcj7FuMmAuNNQlces=;
        b=c5d1DsFj0nNPRuIrAbjcGrjMZFSlE7mxt8AP1AOeqOE1SyQQ6yzOnmxsL+zkINmMgS
         QlauWET3DH37bCvNbv15tP8W1iLK0r2deoocUb+gryo3ILSa0KX0TFCcvwXMSUzxsJui
         xVIKFSwNcdWhjmR59VuLzQLmPfbLkH4kzQHS5b69OdGh2N/2K6n4P2BRqidhAztH3dzN
         DH0fq/9RhiDc4adE9DP8heGKwo0ozpYlCHqevzmCRRUvLGdi5AIeMU0coxVBOeRO7zQI
         rvgqGBBsdkNNLeOk0A9YGsMfbvxf4JTiqVJvYkQC3qtOg7lMX2DtpfJIgM/+/jFW5fjI
         GOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WX6vrgdXsTGNrYeiwfYIi7rHNabcj7FuMmAuNNQlces=;
        b=TRV/T1Vrmj/m/EbLc480CMRHQH9Wtz+BL36Ym9+el/q4XDSvMhVkRJUvW4OkgePbmP
         nEPdSGulk+hqrpz1/EWu4N8I/esSl24vWiwZEJcL2dBD562IOdsSFnpA8IJ/nFYMeS5n
         xx0xnL/eEobZaC+S2tb7tD5x8ybl74cBEhIto/g7HPo5swUHESJebBeRx7+VtADrNaLh
         sOA8KxeMIX8VkXE3b/ieCjYheDXEos0cX4fxZti3QEEvIpa5TdVy9Y1fjaTkrHZwl80S
         OWZUyEUR0F0zuW0siLaG3z5kLBsowmeCbk37VmaHPqZmQ13XOp5Gai0hvSReU8KQtRTr
         OMfQ==
X-Gm-Message-State: AOAM531iTDAoNd9J3u4hV7dgyng9fO2kn8S4sDsNf2a7kl7+4tBX441u
        QhXL4teW3Umbm0L68lxkdhpvpQ==
X-Google-Smtp-Source: ABdhPJx1byJgYP1AEleCHDYStQWli8NMJXupxh2z98H9LSqNSlzxrKuTtyufKdmMkVDN6802Cobw5Q==
X-Received: by 2002:ac8:311d:: with SMTP id g29mr24976546qtb.242.1591044295733;
        Mon, 01 Jun 2020 13:44:55 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k12sm303772qkk.58.2020.06.01.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:44:54 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:44:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Message-ID: <20200601204424.GA212944@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601155615.GA131075@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:56:17AM -0400, Johannes Weiner wrote:
> On Mon, Jun 01, 2020 at 03:14:24PM +0900, Joonsoo Kim wrote:
> > 2020년 5월 30일 (토) 오전 12:12, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > > However, your example cannot have a completely silent stable state. As
> > > we stop workingset aging, the refault distances will slowly increase
> > > again. We will always have a bit of churn, and rightfully so, because
> > > the workingset *could* go stale.
> > >
> > > That's the same situation in my cache-only example above. Anytime you
> > > have a subset of pages that by itself could fit into memory, but can't
> > > because of an established workingset, ongoing sampling is necessary.
> > >
> > > But the rate definitely needs to reduce as we detect that in-memory
> > > pages are indeed hot. Otherwise we cause more churn than is required
> > > for an appropriate rate of workingset sampling.
> > >
> > > How about the patch below? It looks correct, but I will have to re-run
> > > my tests to make sure I / we are not missing anything.
> > 
> > Much better! It may solve my concern mostly.
> 
> Okay thanks for confirming. I'll send a proper version to Andrew.

I sent the below patch through my battery of tests to make sure it
doesn't break anything fundamental, and they didn't. For the
convergence test, the overload test, and the kernel build, the
difference, if any, is in the noise, which is expected.

Andrew, absent any objections, can you please fold the below into the
original patch?

It's a bit noisy due to the rename of inactive_age now that it's used
for anon as well (frankly, it was a misnomer from the start), and
switching the interface to take an lruvec instead of a memcg and a
pgdat, which works better for the callers (I stole parent_lruvec()
from "mm: vmscan: determine anon/file pressure balance at the reclaim
root" later in the series, so that isn't new code).

The main change is the two bits in __remove_mapping and
move_pages_to_lru, so that shadow entries are aged when anon is
reclaimed or rotated.

---

From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 1 Jun 2020 14:04:09 -0400
Subject: [PATCH] mm: workingset: let cache workingset challenge anon fix

We compare refault distances to active_file + anon. But age of the
non-resident information is only driven by the file LRU. As a result,
we may overestimate the recency of any incoming refaults and activate
them too eagerly, causing unnecessary LRU churn in certain situations.

Make anon aging drive nonresident age as well to address that.

Reported-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 13 +++++++++++
 include/linux/mmzone.h     |  4 ++--
 include/linux/swap.h       |  1 +
 mm/vmscan.c                |  3 +++
 mm/workingset.c            | 46 ++++++++++++++++++++++----------------
 5 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 32a0b4d47540..d982c80da157 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1303,6 +1303,19 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = lruvec_memcg(lruvec);
+	if (!memcg)
+		return NULL;
+	memcg = parent_mem_cgroup(memcg);
+	if (!memcg)
+		return NULL;
+	return mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c1fbda9ddd1f..7cccbb8bc2d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -262,8 +262,8 @@ enum lruvec_flags {
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
 	struct zone_reclaim_stat	reclaim_stat;
-	/* Evictions & activations on the inactive file list */
-	atomic_long_t			inactive_age;
+	/* Non-resident age, driven by LRU movement */
+	atomic_long_t			nonresident_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
 	/* Various lruvec state flags (enum lruvec_flags) */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 30fd4641890e..f0d2dca28c99 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -312,6 +312,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
+void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 43f88b1a4f14..3033f1c951cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -898,6 +898,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		__delete_from_swap_cache(page, swap);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
+		workingset_eviction(page, target_memcg);
 	} else {
 		void (*freepage)(struct page *);
 		void *shadow = NULL;
@@ -1876,6 +1877,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 				list_add(&page->lru, &pages_to_free);
 		} else {
 			nr_moved += nr_pages;
+			if (PageActive(page))
+				workingset_age_nonresident(lruvec, nr_pages);
 		}
 	}
 
diff --git a/mm/workingset.c b/mm/workingset.c
index e69865739539..98b91e623b85 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -156,8 +156,8 @@
  *
  *		Implementation
  *
- * For each node's file LRU lists, a counter for inactive evictions
- * and activations is maintained (node->inactive_age).
+ * For each node's LRU lists, a counter for inactive evictions and
+ * activations is maintained (node->nonresident_age).
  *
  * On eviction, a snapshot of this counter (along with some bits to
  * identify the node) is stored in the now empty page cache
@@ -213,7 +213,17 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	*workingsetp = workingset;
 }
 
-static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
+/**
+ * workingset_age_nonresident - age non-resident entries as LRU ages
+ * @memcg: the lruvec that was aged
+ * @nr_pages: the number of pages to count
+ *
+ * As in-memory pages are aged, non-resident pages need to be aged as
+ * well, in order for the refault distances later on to be comparable
+ * to the in-memory dimensions. This function allows reclaim and LRU
+ * operations to drive the non-resident aging along in parallel.
+ */
+void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
 {
 	/*
 	 * Reclaiming a cgroup means reclaiming all its children in a
@@ -227,11 +237,8 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
 	 * the root cgroup's, age as well.
 	 */
 	do {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		atomic_long_inc(&lruvec->inactive_age);
-	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
+		atomic_long_add(nr_pages, &lruvec->nonresident_age);
+	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
 /**
@@ -254,12 +261,11 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	advance_inactive_age(page_memcg(page), pgdat);
-
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
+	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
-	eviction = atomic_long_read(&lruvec->inactive_age);
+	eviction = atomic_long_read(&lruvec->nonresident_age);
 	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }
 
@@ -309,20 +315,20 @@ void workingset_refault(struct page *page, void *shadow)
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		goto out;
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
-	refault = atomic_long_read(&eviction_lruvec->inactive_age);
+	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
 	/*
 	 * Calculate the refault distance
 	 *
 	 * The unsigned subtraction here gives an accurate distance
-	 * across inactive_age overflows in most cases. There is a
+	 * across nonresident_age overflows in most cases. There is a
 	 * special case: usually, shadow entries have a short lifetime
 	 * and are either refaulted or reclaimed along with the inode
 	 * before they get too old.  But it is not impossible for the
-	 * inactive_age to lap a shadow entry in the field, which can
-	 * then result in a false small refault distance, leading to a
-	 * false activation should this old entry actually refault
-	 * again.  However, earlier kernels used to deactivate
+	 * nonresident_age to lap a shadow entry in the field, which
+	 * can then result in a false small refault distance, leading
+	 * to a false activation should this old entry actually
+	 * refault again.  However, earlier kernels used to deactivate
 	 * unconditionally with *every* reclaim invocation for the
 	 * longest time, so the occasional inappropriate activation
 	 * leading to pressure on the active list is not a problem.
@@ -359,7 +365,7 @@ void workingset_refault(struct page *page, void *shadow)
 		goto out;
 
 	SetPageActive(page);
-	advance_inactive_age(memcg, pgdat);
+	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
 	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
 
 	/* Page was active prior to eviction */
@@ -378,6 +384,7 @@ void workingset_refault(struct page *page, void *shadow)
 void workingset_activation(struct page *page)
 {
 	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	/*
@@ -390,7 +397,8 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	advance_inactive_age(memcg, page_pgdat(page));
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
 out:
 	rcu_read_unlock();
 }
-- 
2.26.2

