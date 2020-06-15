Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99723C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D652078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="R+2e4+2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgFONlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFONlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:41:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:41:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g62so12544366qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZFMuLnM203YQezXFg3C0kzgQqrrHyQPtEdC+50sNW1c=;
        b=R+2e4+2h1GzA34ec+eoZhszT0fDJmIsnx4xIGjecmjj8EqJIMs+IZY3JZuzUHHSFTp
         R2jHcwta6PPqdmKypP4F5LQBBR+K2h+64Vqe1hTJaikBd10vYFd6RNQGRbUarCiZEDCY
         CwvmPJtznhBz+RhjoyeWU0oe0xnuFY5qCtS7rcqRgzTgSoJBwm2GOjTFEbwxkcF4nXJu
         mDAdeF6KxuOTIlGl6/XsZpRm6swtu18Xv7Q8r1prSc2O4P++ogLDzwl07FQdRrXTz4yK
         /QfdlWvLsMW8EEXimwrTqyH7aMhKXCTWwFXzTmhbM33Ns7NKpc9mqPldk5sdHi6NLouc
         G/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZFMuLnM203YQezXFg3C0kzgQqrrHyQPtEdC+50sNW1c=;
        b=f/WV4Xy4ZH1yxNGBejNFiL9GYC2nwgRu74wtbYShpTi0R57AMdyq/UzkxjBVVCoTz9
         rz0x6WLlw3OHZaLKCxOLOtzNfJJmAdZ2D9SzF3eFikriUV51gmZa0AH+xf1hlX9Cmubc
         50jKaoD4MYiaWXwJHkTuwe/e4aS0Fx3w5WNIFYkI/eOfuXgpdezBN39Xu3MRn5zUA7/c
         BYvp74XtSK/4/cOZx8uZ5ug2CLah3FrTFiXjdivOgxFNTLkuic1hKkCwRLQranZWt+ge
         mU0apE1MDIcEZHrlswBPJNgtXTNfeN9yqcJttXJRk/2xsmhwxIt/tbIOGEYJNJQTBDsW
         TfLw==
X-Gm-Message-State: AOAM533uvZRH+c780yPO3R6B6izFNL/qV+e+b24CoptD39NYOcsxY4ae
        aKxjIqZl5ciVoZw/u1Sx/ye+9w==
X-Google-Smtp-Source: ABdhPJzRsJtf4+sOp67ZYDw60yhNfEbGJscECIndAo3+BXQWJo0lHDe4zFcsbT5ksVWCAzZQyvRLrA==
X-Received: by 2002:ac8:6f55:: with SMTP id n21mr15720353qtv.175.1592228502929;
        Mon, 15 Jun 2020 06:41:42 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c186sm10698558qkd.102.2020.06.15.06.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:41:42 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:41:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Message-ID: <20200615134104.GA567172@cmpxchg.org>
References: <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org>
 <20200601204424.GA212944@cmpxchg.org>
 <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz>
 <20200604150539.GA322130@cmpxchg.org>
 <CAAmzW4NVoViiGzDx_7fFi-ShhbkB8PXHHSK=Eaa3D7vfZGGFNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4NVoViiGzDx_7fFi-ShhbkB8PXHHSK=Eaa3D7vfZGGFNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:19:58PM +0900, Joonsoo Kim wrote:
> 2020년 6월 5일 (금) 오전 12:06, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > On Thu, Jun 04, 2020 at 03:35:27PM +0200, Vlastimil Babka wrote:
> > > On 6/1/20 10:44 PM, Johannes Weiner wrote:
> > > > From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00 2001
> > > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > > Date: Mon, 1 Jun 2020 14:04:09 -0400
> > > > Subject: [PATCH] mm: workingset: let cache workingset challenge anon fix
> > >
> > > Looks like the whole series is now in mainline (that was quick!) without this
> > > followup? As such it won't be squashed so perhaps the subject should be more
> > > "standalone" now, description referencing commit 34e58cac6d8f ("mm: workingset:
> > > let cache workingset challenge anon"), possibly with Fixes: tag etc...
> >
> > Yep, I'll send a stand-alone version of this. It was a bit fat to get
> > squashed last minute anyway, and I don't mind having a bit of extra
> > time to quantify the actual impact of this delta.
> 
> Hello, Johannes.
> 
> Now, a week has passed. I hope that this patch is merged as soon as possible,
> since my WIP patchset depends on this patch. How about trying to merge
> this patch now? If you don't mind, I could send it on your behalf.

I didn't realize you directly depended on it, my apologies.

Do you depend on it code-wise or do you have test case that shows a
the difference?

Here is the latest version again, you can include it in your patch
series until we get it merged. But I think we should be able to merge
it as a follow-up fix into 5.8 still.

---

From d604062a66bc88ad1a1529c9e16952dc0d7c01c6 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 29 May 2020 09:40:00 -0400
Subject: [PATCH] mm: workingset: age nonresident information alongside
 anonymous pages

After ("mm: workingset: let cache workingset challenge anon fix"), we
compare refault distances to active_file + anon. But age of the
non-resident information is only driven by the file LRU. As a result,
we may overestimate the recency of any incoming refaults and activate
them too eagerly, causing unnecessary LRU churn in certain situations.

Make anon aging drive nonresident age as well to address that.

Reported-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  4 ++--
 include/linux/swap.h   |  1 +
 mm/vmscan.c            |  3 +++
 mm/workingset.c        | 46 +++++++++++++++++++++++++-----------------
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c4c37fd12104..f6f884970511 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -257,8 +257,8 @@ struct lruvec {
 	 */
 	unsigned long			anon_cost;
 	unsigned long			file_cost;
-	/* Evictions & activations on the inactive file list */
-	atomic_long_t			inactive_age;
+	/* Non-resident age, driven by LRU movement */
+	atomic_long_t			nonresident_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
 	/* Various lruvec state flags (enum lruvec_flags) */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4c5974bb9ba9..5b3216ba39a9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -313,6 +313,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
+void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..749d239c62b2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -904,6 +904,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		__delete_from_swap_cache(page, swap);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
+		workingset_eviction(page, target_memcg);
 	} else {
 		void (*freepage)(struct page *);
 		void *shadow = NULL;
@@ -1884,6 +1885,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 				list_add(&page->lru, &pages_to_free);
 		} else {
 			nr_moved += nr_pages;
+			if (PageActive(page))
+				workingset_age_nonresident(lruvec, nr_pages);
 		}
 	}
 
diff --git a/mm/workingset.c b/mm/workingset.c
index d481ea452eeb..50b7937bab32 100644
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
@@ -382,6 +388,7 @@ void workingset_refault(struct page *page, void *shadow)
 void workingset_activation(struct page *page)
 {
 	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	/*
@@ -394,7 +401,8 @@ void workingset_activation(struct page *page)
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

