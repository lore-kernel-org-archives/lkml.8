Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C9F208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb4lZsRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFPGRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:17:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED534C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so9010915pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hqMANitN0kUFB/IRxGY8ZRFApTCGoFdmq5BwOFMOaLs=;
        b=Mb4lZsRWkTmqMsXWkrMNjmzrYZcX9UMtu0KuJeG5nVHKe4QsPnG55m0RcrQtcwfZWU
         D3SmJvgtYQAu4VKEmP6DfBhvBc10s7iG0a74xM5thSzGZHn7VcgsWRyhRfqfg+W2h67A
         qDEGjKIvrxvXOjoMzVEYuwrLhU3+Pl+ASQJjlWlMOIywDj7GU5LJRa5BSN0a1cM7iTML
         g4HTicPY9sBZKuVnRGCG3spK4tYQ8kD4sGVrUr/Im04H9IEwqtrfSmyZYodeMFGcYBKo
         m7gSd5oq5gcQ4QrexmtGliUbZXk0r/gplA84gNrYgUlABL/ViiVgkz2TF5FBn+4yf+ci
         AdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hqMANitN0kUFB/IRxGY8ZRFApTCGoFdmq5BwOFMOaLs=;
        b=avZD7FSM53gXlrO8fekEs9+y0b1kHTY4egstogGLBJ2+H7ANINTYqKVprtFN/fdnPe
         Tk+cC4BcV1zM+TqvxM1bff1dQjTCpPn9ghN9ZFvdNdJzINC/ihqgHpEZR1WdvqF8qUsm
         KMQjqz7wHncAocH9v0YnjT1Xkw1MrMHHs51igOgP+3q7x62PBGYTPu3buRMZ/PZy5gp4
         xkvY2X7lw0J6U51ydorqMLTHN+mKIJ2OqrN56udx3ljjaG1tu6CheJq2uaq2Q0Lz6ZqM
         zTPsESUhyh1pDmta1wbXKjWx1xlWJmZcHFBuk2ZXsDaQiuP22ckDf8/AY3qHv+UfJGqA
         YKCg==
X-Gm-Message-State: AOAM531reR9rIuREsj4wwqZNgDa+CPAWqKgjGcDonkjDK/PSu4XG3L4R
        9Ra6nQMVOomeU7+hEH8tdfg=
X-Google-Smtp-Source: ABdhPJwwsiwcTfrETSIs749SU9rF5IziCc1Dtt0AtkHOeIBaeqssue3aqzfH+N2X70V35YKJ45QEOA==
X-Received: by 2002:a62:191:: with SMTP id 139mr775072pfb.94.1592288226174;
        Mon, 15 Jun 2020 23:17:06 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 207sm15449267pfw.190.2020.06.15.23.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 23:17:05 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH for v5.8 1/3] mm: workingset: age nonresident information alongside anonymous pages
Date:   Tue, 16 Jun 2020 15:16:42 +0900
Message-Id: <1592288204-27734-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

After ("mm: workingset: let cache workingset challenge anon fix"), we
compare refault distances to active_file + anon. But age of the
non-resident information is only driven by the file LRU. As a result,
we may overestimate the recency of any incoming refaults and activate
them too eagerly, causing unnecessary LRU churn in certain situations.

Make anon aging drive nonresident age as well to address that.

Reported-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h |  4 ++--
 include/linux/swap.h   |  1 +
 mm/vmscan.c            |  3 +++
 mm/workingset.c        | 46 +++++++++++++++++++++++++++-------------------
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c4c37fd..f6f8849 100644
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
index 4c5974b..5b3216b 100644
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
index b6d8432..749d239 100644
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
index d481ea4..50b7937 100644
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
2.7.4

