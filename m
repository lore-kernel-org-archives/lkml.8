Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D835AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2847207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="A/Gtn++X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405296AbgE1RC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405253AbgE1RCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:02:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12BEC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:02:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n141so3806602qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8uodaYI9xgQDyjiHrOwmS4DFXtk81hRNSklyUxs8WIQ=;
        b=A/Gtn++X7qCBfblaJj2AK8K0oA/vJ9/ebcHPg6aaLOx13d1x/YuWsh7BRa4Cq0fZ06
         in6KUTImz/pV4ngJ5/dQAaU/+065/NGHFArfnMr/yDt1xrDBecyuJam7GVKHeQD1r4AH
         Z3L+7cBmzBbh9e8JdpQRlmiu+/xV1LqCkW28KuyMs4uUrvveg5fGxkpPVNSMIgnFIxs1
         EbxzYXhLTBh7GQ50Qj2v9JVHmTqtiIDY9nGgJPlCIASmVDyAFqKxJvyhZk/BPyaF1w7S
         H40N2l0jA8DMD/o/urFm4s55h40zh9dNZP/pbID5oRaboL1D8axJMyuKnH7qrzs3LA2A
         Tykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8uodaYI9xgQDyjiHrOwmS4DFXtk81hRNSklyUxs8WIQ=;
        b=SOfjK6MiInyGE3xvLKev9UEFjt1y9KT/lQnGwwLEK9PX5aGfxd7iCIBHT/ygxMiFkd
         8+ia1XkcqE4n/jCBAhNEpDBAwc8YwzwgY0UokITGXGYD3XiJfGeQoRso7LoZQU7wRsKT
         5dLtuPu/fda2L7fxUfBpqO2ND5tu0YC5YqsLh1oF3lcJ3dvHEYKViob8WzEUaqVaO3d1
         /8/2EGWQg81kocRoTVP8zN00w8agZ67PK/m2S4XdSfIP8r3VmhLH0IOwbU5uBWRTUVWt
         FagLiYkKELp3d8h6rggxlwn0/EieESnKuVbydBkdKocOqR5bacgXdQVFOkw1n5767f7O
         H8kA==
X-Gm-Message-State: AOAM532Ck/mnofmpbWMBXLJdEJVWktpUT9wCUlTIH6lV4Iz6OdxuYQoK
        GvxXESlnxmF9SB6loBkXIXqblw==
X-Google-Smtp-Source: ABdhPJzAr/QNv51v6ggqgbat2LCJUNDmLskzLsxVbQey6P7fqJNKGeTgpjoSr4XuaSpNeDzzC1mlgg==
X-Received: by 2002:a37:850:: with SMTP id 77mr3738790qki.498.1590685343516;
        Thu, 28 May 2020 10:02:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id e27sm4973684qkl.47.2020.05.28.10.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:02:22 -0700 (PDT)
Date:   Thu, 28 May 2020 13:01:55 -0400
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
Message-ID: <20200528170155.GA69521@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:16:50PM +0900, Joonsoo Kim wrote:
> 2020년 5월 27일 (수) 오후 10:43, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> > > 2020년 5월 21일 (목) 오전 8:26, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > > >
> > > > We activate cache refaults with reuse distances in pages smaller than
> > > > the size of the total cache. This allows new pages with competitive
> > > > access frequencies to establish themselves, as well as challenge and
> > > > potentially displace pages on the active list that have gone cold.
> > > >
> > > > However, that assumes that active cache can only replace other active
> > > > cache in a competition for the hottest memory. This is not a great
> > > > default assumption. The page cache might be thrashing while there are
> > > > enough completely cold and unused anonymous pages sitting around that
> > > > we'd only have to write to swap once to stop all IO from the cache.
> > > >
> > > > Activate cache refaults when their reuse distance in pages is smaller
> > > > than the total userspace workingset, including anonymous pages.
> > >
> > > Hmm... I'm not sure the correctness of this change.
> > >
> > > IIUC, this patch leads to more activations in the file list and more activations
> > > here will challenge the anon list since rotation ratio for the file
> > > list will be increased.
> >
> > Yes.
> >
> > > However, this change breaks active/inactive concept of the file list.
> > > active/inactive
> > > separation is implemented by in-list refault distance. anon list size has
> > > no direct connection with refault distance of the file list so using
> > > anon list size
> > > to detect workingset for file page breaks the concept.
> >
> > This is intentional, because there IS a connection: they both take up
> > space in RAM, and they both cost IO to bring back once reclaimed.
> 
> I know that. This is the reason that I said 'no direct connection'. The anon
> list size is directly related the *possible* file list size. But,
> active/inactive
> separation in one list is firstly based on *current* list size rather than
> the possible list size. Adding anon list size to detect workingset means
> to use the possible list size and I think that it's wrong.

Hm so you're saying we should try to grow the page cache, but maintain
an inactive/active balance within the cache based on its current size
in case growing is not possible.

I think it would be implementable*, but I'm not quite convinced that
it's worth distinguishing. We're talking about an overcommitted
workingset and thereby an inherently unstable state that may thrash
purely based on timing differences anyway. See below.

*It would require another page flag to tell whether a refaulting cache
page has challenged the anon set once (transitioning) or repeatedly
(thrashing), as we currently use the active state for that. If we
would repurpose PG_workingset to tell the first from the second
refault, we'd need a new flag to mark a page for memstall accounting.

> > When file is refaulting, it means we need to make more space for
> > cache. That space can come from stale active file pages. But what if
> > active cache is all hot, and meanwhile there are cold anon pages that
> > we could swap out once and then serve everything from RAM?
> >
> > When file is refaulting, we should find the coldest data that is
> > taking up RAM and kick it out. It doesn't matter whether it's file or
> > anon: the goal is to free up RAM with the least amount of IO risk.
> 
> I understand your purpose and agree with it. We need to find a solution.
> To achieve your goal, my suggestion is:
> 
> - refault distance < active file, then do activation and add up IO cost
> - refault distance < active file + anon list, then add up IO cost
> 
> This doesn't break workingset detection on file list and challenge
> the anon list as the same degree as you did.

Unfortunately, it doesn't challenge the anon set. We'll stay in cache
trimming mode where the IO cost balance doesn't have any effect.

We would need to

  1. activate on distance < active file
  2. force reclaim to scan anon when distance < active file + anon
  3. record thrashing and IO cost when distance < active file + anon
     and it's the second refault of the page.

Something like this, where vmscan would scan anon when
WORKINGSET_RESTORE or WORKINGSET_EXPAND events are occuring:

diff --git a/mm/workingset.c b/mm/workingset.c
index d481ea452eeb..41dde6274fff 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -275,9 +275,9 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 void workingset_refault(struct page *page, void *shadow)
 {
 	struct mem_cgroup *eviction_memcg;
+	unsigned long active_file, anon;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
-	unsigned long workingset_size;
 	struct pglist_data *pgdat;
 	struct mem_cgroup *memcg;
 	unsigned long eviction;
@@ -330,7 +330,7 @@ void workingset_refault(struct page *page, void *shadow)
 	refault_distance = (refault - eviction) & EVICTION_MASK;
 
 	/*
-	 * The activation decision for this page is made at the level
+	 * The distance decisions for this page is made at the level
 	 * where the eviction occurred, as that is where the LRU order
 	 * during page reclaim is being determined.
 	 *
@@ -344,32 +344,52 @@ void workingset_refault(struct page *page, void *shadow)
 
 	/*
 	 * Compare the distance to the existing workingset size. We
-	 * don't activate pages that couldn't stay resident even if
-	 * all the memory was available to the page cache. Whether
-	 * cache can compete with anon or not depends on having swap.
+	 * ignore pages that couldn't stay resident even if all the
+	 * memory was available to the page cache. Whether cache can
+	 * compete with anon or not depends on having swap.
 	 */
-	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	anon = 0;
 	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
-		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_ANON);
-		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_ACTIVE_ANON);
+		anon += lruvec_page_state(eviction_lruvec, NR_INACTIVE_ANON);
+		anon += lruvec_page_state(eviction_lruvec, NR_ACTIVE_ANON);
 	}
-	if (refault_distance > workingset_size)
-		goto out;
 
-	SetPageActive(page);
-	advance_inactive_age(memcg, pgdat);
-	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	if (refault_distance > active_file + anon)
+		goto out;
 
-	/* Page was active prior to eviction */
+	/*
+	 * Page has already challenged the workingset before, and it's
+	 * refaulting again: we're not transitioning out old cache,
+	 * we're thrashing and need to grow. Record the IO to tip the
+	 * reclaim balance and mark the page for memstall detection.
+	 */
 	if (workingset) {
-		SetPageWorkingset(page);
+		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
+
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
 		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
 		spin_unlock_irq(&page_pgdat(page)->lru_lock);
-		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
+
+		SetPageThrashing(page);
+	}
+
+	SetPageWorkingset(page);
+
+	/*
+	 * Activate right away if page can compete with the existing
+	 * active set given the *current* size of the page cache.
+	 *
+	 * Otherwise, the page cache needs to grow to house this
+	 * page. Tell reclaim to rebalance against anonymous memory.
+	 */
+	if (refault_distance <= active_file) {
+		SetPageActive(page);
+		advance_inactive_age(memcg, pgdat);
+		inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	} else {
+		inc_lruvec_state(lruvec, WORKINGSET_EXPAND);
 	}
 out:
 	rcu_read_unlock();

> > Remember that the file/anon split, and the inactive/active split, are
> > there to optimize reclaim. It doesn't mean that these memory pools are
> > independent from each other.
> >
> > The file list is split in two because of use-once cache. The anon and
> > file lists are split because of different IO patterns, because we may
> > not have swap etc. But once we are out of use-once cache, have swap
> > space available, and have corrected for the different cost of IO,
> > there needs to be a relative order between all pages in the system to
> > find the optimal candidates to reclaim.
> >
> > > My suspicion is started by this counter example.
> > >
> > > Environment:
> > > anon: 500 MB (so hot) / 500 MB (so hot)
> > > file: 50 MB (hot) / 50 MB (cold)
> > >
> > > Think about the situation that there is periodical access to other file (100 MB)
> > > with low frequency (refault distance is 500 MB)
> > >
> > > Without your change, this periodical access doesn't make thrashing for cached
> > > active file page since refault distance of periodical access is larger
> > > than the size of
> > > the active file list. However, with your change, it causes thrashing
> > > on the file list.
> >
> > It doesn't cause thrashing. It causes scanning because that 100M file
> > IS thrashing: with or without my patch, that refault IO is occuring.
> 
> It could cause thrashing for your patch.
> Without the patch, current logic try to
> find most hottest file pages that are fit into the current file list
> size and protect them
> successfully. Assume that access distance of 50 MB hot file pages is 60 MB
> which is less than whole file list size but larger than inactive list
> size. Without
> your patch, 50 MB (hot) pages are not evicted at all. All these hot
> pages will be
> protected from the 100MB low access frequency pages. 100 MB low access
> frequency pages will be refaulted repeatedely but it's correct behaviour.

Hm, something doesn't quite add up. Why is the 50M hot set evicted
with my patch?

With a 60M access distance and a 100M page cache, they might get
deactivated, but then activated back to the head of the active list on
their next access. They should get scanned but not actually reclaimed.

The only way they could get reclaimed is if their access distance ends
up bigger than the file cache. But if that's the case, then the
workingset is overcommitted, and none of the pages qualify for reclaim
protection. Picking a subset to protect against the rest is arbitrary.

For example, if you started out with 50M of free space and an empty
cache and started accessing the 50M and 100M files simultaneously,
with the access distances you specified, none of them would get
activated. You would have the same behavior with or without my patch.

> However, with your patch, 50 MB (hot) file pages are deactivated due to newly
> added file pages with low access frequency. And, then, since access distance of
> 50 MB (hot) pages is larger than inactive list size, they could not
> get a second chance
> and finally could be evicted.

Ah okay, that's a different concern. We DO get two references, but we
fail to detect them properly.

First, we don't enforce the small inactive list size when there is
refault turnover like this. Deactivation is permanently allowed, which
means the lists are scanned in proportion to their size and should
converge on a 50/50 balance. The 50M pages should get referenced again
in the second half of their in-memory time and get re-activated.

It's somewhat debatable whether that's the right thing to do when
access distances are bunched up instead of uniform. Should a page
that's accessed twice with a 10M distance, and then not again for
another 80M, stay resident in a 60M cache?

It's not entirely unreasonable to say a page needs to get accessed in
each half of in-memory time to be considered still active, to ensure a
reasonable maximum distance between reference clusters.

But if this is an actual concern, shouldn't we instead improve the
accuracy of the LRU ordering? For example, if we're refaulting and
have dissolved the inactive/active separation, shouldn't
shrink_active_list() and shrink_page_list() actually rotate pages with
PG_referenced or pte references?

We ignore those references right now because we rely on second chance
to catch them; and respecting them would incur too much CPU overhead
when all we try to do is funnel one-off cache through the list.

But if we don't trust second-chance with this, and we're already
having refault IO and CPU is less of a concern, that seems like an
obvious change to make.
