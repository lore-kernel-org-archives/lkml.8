Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF020776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="brpTYIHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgE2PNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2PM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:12:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E4C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:12:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s1so2466721qkf.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=19Iiy82pURoLDkvZ8E/s/DKsY13AiGF9J6xUWG9jMXU=;
        b=brpTYIHUImaP0KxCTmx/GU6vH/5sEwZlBlfBs4QgCYztVtzdVWxVo3hkHhrhW5hcB6
         MBcklf6NR+N0cyD/KvLe/YgOV2xFeld7sqkdoC2OqcCmZ9wYsu5VC2tM00sp/aiJ6GET
         Io3wS6dCQKL1MzZaq9EmtgGRtuexyiQqjVBG5wqFtYXPkP9rvtGZJkmRqa4NnRT4qDMe
         0K9P2ohr13wz7ULa406n6gklGgdlCiSpqB0qhqu9Jqn5S006Ct3vJ9z0qZOUo2drThGr
         NIGoN0IcBeLs+P9cnHLAv4LenOLLzSjWz8fDTfw5y5/bUq9GjLURTIAHQDxS5Wgleub9
         hxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=19Iiy82pURoLDkvZ8E/s/DKsY13AiGF9J6xUWG9jMXU=;
        b=NVqsYQLj8hmISDH8BbysKpoDIERIO5E0QyRaQwabgKkDFyKQE/vPJz3PVhMeYrFypX
         /B7VvM1a0nw8eTGVtuBfJ656oSRjVOya48Lk/EQUrCmKTj1U/c4hjNeL87NhQ+E3QcrN
         YLVTAV1pLqAV+9RwF7YCg0SGds8hUAhuD1udI2A4yCL858DYueQF87wElSsfxlwhugLV
         ivUGmOw5gAnRDiRj7Z8w+hbf9rkoZUddkF+h3twyP9NTOxmWGBxf9L+0YJThpDriNYcG
         1QEpFxh/TOAWSgCRYtFUjBR7TPuMstpy6YgnAQo8FeC23uZuabdzowQjk9mmIc0deE+L
         rGTA==
X-Gm-Message-State: AOAM533hbOA+dLxjWtr1xXbqIAgHf0bA7GGfDxaH2K4A+GB08sPstu0V
        EZhENQryJ3OkT5crVEYGZvxIJA==
X-Google-Smtp-Source: ABdhPJyqnZVkwmPp3QAX/8JnJtXZxe9eiT72PyDVdF64UsZG6WBDXOjLS7GF+4LGTkFXUE7KNseDfw==
X-Received: by 2002:a37:6f02:: with SMTP id k2mr8185634qkc.129.1590765178089;
        Fri, 29 May 2020 08:12:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id k17sm8906278qtb.5.2020.05.29.08.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:12:57 -0700 (PDT)
Date:   Fri, 29 May 2020 11:12:28 -0400
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
Message-ID: <20200529151228.GA92892@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 03:48:00PM +0900, Joonsoo Kim wrote:
> 2020년 5월 29일 (금) 오전 2:02, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> > > 2020년 5월 27일 (수) 오후 10:43, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > > > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > *It would require another page flag to tell whether a refaulting cache
> > page has challenged the anon set once (transitioning) or repeatedly
> > (thrashing), as we currently use the active state for that. If we
> > would repurpose PG_workingset to tell the first from the second
> > refault, we'd need a new flag to mark a page for memstall accounting.
> 
> I don't understand why a new flag is needed. Whenever we found that
> challenge is needed (dist < active + anon), we need to add up IO cost.

It sounds like this was cleared up later on in the email.

> > > It could cause thrashing for your patch.
> > > Without the patch, current logic try to
> > > find most hottest file pages that are fit into the current file list
> > > size and protect them
> > > successfully. Assume that access distance of 50 MB hot file pages is 60 MB
> > > which is less than whole file list size but larger than inactive list
> > > size. Without
> > > your patch, 50 MB (hot) pages are not evicted at all. All these hot
> > > pages will be
> > > protected from the 100MB low access frequency pages. 100 MB low access
> > > frequency pages will be refaulted repeatedely but it's correct behaviour.
> >
> > Hm, something doesn't quite add up. Why is the 50M hot set evicted
> > with my patch?
> 
> Thanks for kind explanation. I read all and I found that I was confused before.
> Please let me correct the example.
> 
> Environment:
> anon: 500 MB (hot) / 500 MB (hot)
> file: 50 MB (so hot) / 50 MB (dummy)
> 
> I will call 50 MB file hot pages as F(H).
> Let's assume that periodical access to other file (500 MB) is started. That
> file consists of 5 parts and each one is 100 MB. I will call it P1, P2, ..., P5.
> 
> Problem will occur on following access pattern.
> 
> F(H) -> P1 -> F(H) -> P2 -> ... -> F(H) -> P5 -> F(H) -> P1 -> ...
> 
> With this access pattern, access distance of F(H) and Pn is:
> 
> F(H) = 150 MB
> Pn = 750 MB
> 
> Without your patch, F(H) is kept on the memory since deactivation would not
> happen. However, with your patch, deactivation happens since Pn's refault
> distance is less than 'active file + anon'. In the end, F(H) would be finally
> evicted.

Okay, this example makes sense to me.

I do think P needs to challenge the workingset - at first. P could
easily fit into memory by itself if anon and active_file were cold, so
we need to challenge them to find out that they're hot. As you can
see, if anon and F(H) were completely unused, the current behavior
would be incorrect.

The current behavior would do the same in a cache-only example:

	anon = 1G (unreclaimable)
	file = 500M (hot) / 300M (dummy)

	P = 400M

	F(H) -> P1 -> F(H) -> P2 ...

If F(H) is already active, the first P refaults would have a distance
of 100M, thereby challenging F(H). As F(H) reactivates, its size will
be reflected in the refault distances, pushing them beyond the size of
memory that is available to the cache: 600M refault distance > 500M
active cache, or 900M access distance > 800M cache space.

However, I agree with your observation about the anon age below. When
we start aging the anon set, we have to reflect that in the refault
distances. Once we know that the 1G anon pages are indeed hotter than
the pages in P, there is no reason to keep churning the workingset.

> > The only way they could get reclaimed is if their access distance ends
> > up bigger than the file cache. But if that's the case, then the
> > workingset is overcommitted, and none of the pages qualify for reclaim
> > protection. Picking a subset to protect against the rest is arbitrary.
> 
> In the fixed example, although other file (500 MB) is repeatedly accessed,
> it's not workingset. If we have unified list (file + anon), access distance of
> Pn will be larger than whole memory size. Therefore, it's not overcommitted
> workingset and this patch wrongly try to activate it. As I said before,
> without considering inactive_age for anon list, this calculation can not be
> correct.

You're right. If we don't take anon age into account, the activations
could be over-eager; however, so would counting IO cost and exerting
pressure on anon be, which means my previous patch to split these two
wouldn't fix fundamental the problem you're pointing out. We simply
have to take anon age into account for the refaults to be comparable.

Once we do that, in your example, we would see activations in the
beginning in order to challenge the combined workingset (active_file +
anon) - which is legitimate as long as we don't know it's hot. And as
the anon pages are scanned and rotated (and the challenged F(h)
reactivated), the refault distances increase accordingly to reflect
the size of the hot pages sampled, which will correctly put P's
distances beyond the size of available memory.

However, your example cannot have a completely silent stable state. As
we stop workingset aging, the refault distances will slowly increase
again. We will always have a bit of churn, and rightfully so, because
the workingset *could* go stale.

That's the same situation in my cache-only example above. Anytime you
have a subset of pages that by itself could fit into memory, but can't
because of an established workingset, ongoing sampling is necessary.

But the rate definitely needs to reduce as we detect that in-memory
pages are indeed hot. Otherwise we cause more churn than is required
for an appropriate rate of workingset sampling.

How about the patch below? It looks correct, but I will have to re-run
my tests to make sure I / we are not missing anything.

---

From b105c85bf1cebfc4d1057f7228d7484c0ee77127 Mon Sep 17 00:00:00 2001
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
index e959602140b4..39459b8a7bb8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -255,8 +255,8 @@ struct lruvec {
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
index 157e5081bf98..216df7bdaf62 100644
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
index c628f9ab886b..2fee237063e7 100644
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

