Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68BC11D80
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8232024673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivk109rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBTFMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39745 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1065553plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S2zHZDo3LP52c7+VbV6b1ucnKSE63Z5uo1ns/TCVnfA=;
        b=Ivk109rcWeNTNXa3aNvqSNI5UP48c+NwZveCUpIgkahKcNOSBMuKNAbI6MjLg6qN+q
         hvi2VmFuqKZGfxxGxbAiL0iZQ2bY5hxJ+jc2QR2HZL2ZeLEgZrqdoFhtzvTSoWqBbJ7v
         KlalyyDy5I+uhEaI87OV835bMAUM0tIR+t7rGnVD5r//WIiZ4WZfj38KS4+ITxCNGCZf
         sfBpeeoJNjI6N11fhV0FtmcEJxJ9G1IWLbTR+w5zRgfnH/9nDBkvSIyzt0yhO3IJpLkW
         NjQS4qnlpCZEA+6tmFkITTkYikXz+EE9GR4FCzFmgTpWiSdMaIkS6R0iCUkKW8vvFQKL
         yOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S2zHZDo3LP52c7+VbV6b1ucnKSE63Z5uo1ns/TCVnfA=;
        b=O1YwYVAgZipNp8l0OaZi7FeVLlwO53JCB++d3ufKaRjZujb9gLrIJMg6dXF/gv7baX
         pTaShw31fGiVhn69U8Jit+C/G2Nk+6wnw8KLP0MvhX808+sFIjm1nv1XGz7Qw6nlvrPV
         pC1DHgS1ztMZK5VPC7I0Yvr2jo2aH3MrtdAtjA/2QDyero1wg7vssJHIcyoy6XXPHsa9
         xurQRNCracDb9xuH+2X0RPsWbPNMPYQ+aWvXEDlULfak608WoFoz/szbSPxL8yxsdWJh
         mFCTNuQ4dN5YBBiYqGUemsJ3HenNDLjb8Ul+uxSQzBfcDR/0JI680Hvxqp/meWMOKnNT
         Dv3A==
X-Gm-Message-State: APjAAAVdy1d3znssSoPKf/DSYe/lD1uGJLoE9DpVZAe3dezGIhDcGBAq
        S/FhO5nQrwmj7zIf4xwLkqc=
X-Google-Smtp-Source: APXvYqy31HJtm1TxpGOBLiRkaqIz1hEQW3iw4YWOYBSBd5kuR+G3VXnlW/XV+ZItJo83PHEmN0XLAg==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr1504921pjx.113.1582175532515;
        Wed, 19 Feb 2020 21:12:12 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:12 -0800 (PST)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 3/9] mm/workingset: extend the workingset detection for anon LRU
Date:   Thu, 20 Feb 2020 14:11:47 +0900
Message-Id: <1582175513-22601-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In the following patch, workingset detection will be applied to
anonymous LRU. To prepare it, this patch adds some code to
distinguish/handle the both LRUs.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h | 14 +++++++++-----
 mm/memcontrol.c        | 12 ++++++++----
 mm/vmscan.c            | 15 ++++++++++-----
 mm/vmstat.c            |  6 ++++--
 mm/workingset.c        | 35 ++++++++++++++++++++++-------------
 5 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5334ad8..b78fd8c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,8 +220,12 @@ enum node_stat_item {
 	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
 	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
 	WORKINGSET_NODES,
-	WORKINGSET_REFAULT,
-	WORKINGSET_ACTIVATE,
+	WORKINGSET_REFAULT_BASE,
+	WORKINGSET_REFAULT_ANON = WORKINGSET_REFAULT_BASE,
+	WORKINGSET_REFAULT_FILE,
+	WORKINGSET_ACTIVATE_BASE,
+	WORKINGSET_ACTIVATE_ANON = WORKINGSET_ACTIVATE_BASE,
+	WORKINGSET_ACTIVATE_FILE,
 	WORKINGSET_RESTORE,
 	WORKINGSET_NODERECLAIM,
 	NR_ANON_MAPPED,	/* Mapped anonymous pages */
@@ -304,10 +308,10 @@ enum lruvec_flags {
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
 	struct zone_reclaim_stat	reclaim_stat;
-	/* Evictions & activations on the inactive file list */
-	atomic_long_t			inactive_age;
+	/* Evictions & activations on the inactive list */
+	atomic_long_t			inactive_age[2];
 	/* Refaults at the time of last reclaim cycle */
-	unsigned long			refaults;
+	unsigned long			refaults[2];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c83cf4..8f4473d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1431,10 +1431,14 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
 		       memcg_events(memcg, PGMAJFAULT));
 
-	seq_buf_printf(&s, "workingset_refault %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_REFAULT));
-	seq_buf_printf(&s, "workingset_activate %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_ACTIVATE));
+	seq_buf_printf(&s, "workingset_refault_anon %lu\n",
+		       memcg_page_state(memcg, WORKINGSET_REFAULT_ANON));
+	seq_buf_printf(&s, "workingset_refault_file %lu\n",
+		       memcg_page_state(memcg, WORKINGSET_REFAULT_FILE));
+	seq_buf_printf(&s, "workingset_activate_anon %lu\n",
+		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
+	seq_buf_printf(&s, "workingset_activate_file %lu\n",
+		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
 	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4122a84..74c3ade 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2735,7 +2735,10 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!sc->force_deactivate) {
 		unsigned long refaults;
 
-		if (inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+		refaults = lruvec_page_state(target_lruvec,
+				WORKINGSET_ACTIVATE_ANON);
+		if (refaults != target_lruvec->refaults[0] ||
+			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
@@ -2746,8 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * rid of any stale active pages quickly.
 		 */
 		refaults = lruvec_page_state(target_lruvec,
-					     WORKINGSET_ACTIVATE);
-		if (refaults != target_lruvec->refaults ||
+				WORKINGSET_ACTIVATE_FILE);
+		if (refaults != target_lruvec->refaults[1] ||
 		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
 			sc->may_deactivate |= DEACTIVATE_FILE;
 		else
@@ -3026,8 +3029,10 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 	unsigned long refaults;
 
 	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
-	target_lruvec->refaults = refaults;
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
+	target_lruvec->refaults[0] = refaults;
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
+	target_lruvec->refaults[1] = refaults;
 }
 
 /*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d5337..3cdf8e9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1146,8 +1146,10 @@ const char * const vmstat_text[] = {
 	"nr_isolated_anon",
 	"nr_isolated_file",
 	"workingset_nodes",
-	"workingset_refault",
-	"workingset_activate",
+	"workingset_refault_anon",
+	"workingset_refault_file",
+	"workingset_activate_anon",
+	"workingset_activate_file",
 	"workingset_restore",
 	"workingset_nodereclaim",
 	"nr_anon_pages",
diff --git a/mm/workingset.c b/mm/workingset.c
index 474186b..5fb8f85 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -15,6 +15,7 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 
 /*
  *		Double CLOCK lists
@@ -156,7 +157,7 @@
  *
  *		Implementation
  *
- * For each node's file LRU lists, a counter for inactive evictions
+ * For each node's anon/file LRU lists, a counter for inactive evictions
  * and activations is maintained (node->inactive_age).
  *
  * On eviction, a snapshot of this counter (along with some bits to
@@ -213,7 +214,8 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	*workingsetp = workingset;
 }
 
-static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
+static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat,
+				int is_file)
 {
 	/*
 	 * Reclaiming a cgroup means reclaiming all its children in a
@@ -230,7 +232,7 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		atomic_long_inc(&lruvec->inactive_age);
+		atomic_long_inc(&lruvec->inactive_age[is_file]);
 	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
 }
 
@@ -248,18 +250,19 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	int memcgid;
+	int is_file = page_is_file_cache(page);
 
 	/* Page is fully exclusive and pins page->mem_cgroup */
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	advance_inactive_age(page_memcg(page), pgdat);
+	advance_inactive_age(page_memcg(page), pgdat, is_file);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
-	eviction = atomic_long_read(&lruvec->inactive_age);
+	eviction = atomic_long_read(&lruvec->inactive_age[is_file]);
 	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }
 
@@ -278,13 +281,16 @@ void workingset_refault(struct page *page, void *shadow)
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
 	struct pglist_data *pgdat;
-	unsigned long active_file;
+	unsigned long active;
 	struct mem_cgroup *memcg;
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	unsigned long refault;
 	bool workingset;
 	int memcgid;
+	int is_file = page_is_file_cache(page);
+	enum lru_list active_lru = page_lru_base_type(page) + LRU_ACTIVE;
+	enum node_stat_item workingset_stat;
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
 
@@ -309,8 +315,8 @@ void workingset_refault(struct page *page, void *shadow)
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		goto out;
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
-	refault = atomic_long_read(&eviction_lruvec->inactive_age);
-	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	refault = atomic_long_read(&eviction_lruvec->inactive_age[is_file]);
+	active = lruvec_page_state(eviction_lruvec, active_lru);
 
 	/*
 	 * Calculate the refault distance
@@ -341,19 +347,21 @@ void workingset_refault(struct page *page, void *shadow)
 	memcg = page_memcg(page);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
+	workingset_stat = WORKINGSET_REFAULT_BASE + is_file;
+	inc_lruvec_state(lruvec, workingset_stat);
 
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't act on pages that couldn't stay resident even if all
 	 * the memory was available to the page cache.
 	 */
-	if (refault_distance > active_file)
+	if (refault_distance > active)
 		goto out;
 
 	SetPageActive(page);
-	advance_inactive_age(memcg, pgdat);
-	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	advance_inactive_age(memcg, pgdat, is_file);
+	workingset_stat = WORKINGSET_ACTIVATE_BASE + is_file;
+	inc_lruvec_state(lruvec, workingset_stat);
 
 	/* Page was active prior to eviction */
 	if (workingset) {
@@ -371,6 +379,7 @@ void workingset_refault(struct page *page, void *shadow)
 void workingset_activation(struct page *page)
 {
 	struct mem_cgroup *memcg;
+	int is_file = page_is_file_cache(page);
 
 	rcu_read_lock();
 	/*
@@ -383,7 +392,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	advance_inactive_age(memcg, page_pgdat(page));
+	advance_inactive_age(memcg, page_pgdat(page), is_file);
 out:
 	rcu_read_unlock();
 }
-- 
2.7.4

