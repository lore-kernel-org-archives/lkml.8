Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0FAC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EDA20757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SolCn0fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbgDCFlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40975 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so2277259pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nyJuVOklujI4A49EJDPNPQtSElNbDG1xztw7fx5/L0w=;
        b=SolCn0fPtVKG94TUn967D1cdwZ+1KsnaZTsRiLJc3EUAhhsU+0804Olcuozs6XCJ8Z
         gy7pGciH7bS4citbJ+CR0eCwRrQDWEQq7MH5k86YjzoQAT0Vm0YPLWv8aL7WwfcEMqCJ
         dD5OKXc2o806KTUIuprWuLi7vSREg8x+aAOlBLlV11eBIPBVG1Gqq5mCCpgOWRCMBLD7
         jCjCZBB23oYGO4zq6t2MIAGv47ZkFZ10YYOuTleSGE1E/hpC28eJtHSfpRtcE/Hk2nZ+
         FhNpBWMQxxHPxE9833Kod5vwsurxCXj9DLG38Igd3KbH7IHr5hiyE/MogrGnQiDIIdCr
         hBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nyJuVOklujI4A49EJDPNPQtSElNbDG1xztw7fx5/L0w=;
        b=VvBklfiPzoe4nfdpfdn+8peajfV1XnDFKhpCAaF4zNkyCvDezE5b3fhJ7rwvg9abJ4
         AjkG/Il6S73tLNTRYgYaEgkixxdtbFIjjfoXkqdOYu4+4HhGgnH0hpslKQBgtgSQT2Yr
         U6Q3wDSK0ftu5q27NDIpfGSlr/AjRDE2LU3efEBku6hFYdpE10jIuWbFE6u1fNPM0GPI
         T/y0X5rDuth+gVEZhUvS4aqbHUbCbwG7C7YgVJ1GTp9K6FRfBQRBXbWuHc6b1mdj12Ii
         hlcbq721soRxk/8YaZZ43ZGL1Ed2uFDqltJ7xsHfEiKnL+bI70gCm3K2M8XngjELNkM8
         5oXg==
X-Gm-Message-State: AGi0PuZ/yXrgXk4rYBKzaNKrkTZdTdfdbj5E3q1N1G/ijZKTVaTPS1PZ
        GvE+YwVOhvqnkGLq1TERyL4=
X-Google-Smtp-Source: APiQypLeFgZuu2gBMNYSNiGfUB+95gGX5/XYQ9tX3CnoIz2hQJ3qf8dKGX3GstL/kuQrAgn6TEZ96g==
X-Received: by 2002:a17:90b:2351:: with SMTP id ms17mr8006157pjb.163.1585892476165;
        Thu, 02 Apr 2020 22:41:16 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:15 -0700 (PDT)
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
Subject: [PATCH v5 03/10] mm/workingset: extend the workingset detection for anon LRU
Date:   Fri,  3 Apr 2020 14:40:41 +0900
Message-Id: <1585892447-32059-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In the following patch, workingset detection will be applied to
anonymous LRU. To prepare it, this patch adds some code to
distinguish/handle the both LRUs.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h | 14 +++++++++-----
 mm/memcontrol.c        | 12 ++++++++----
 mm/vmscan.c            | 15 ++++++++++-----
 mm/vmstat.c            |  6 ++++--
 mm/workingset.c        | 33 ++++++++++++++++++++-------------
 5 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f687..57fcb89 100644
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
+	/* Evictions & activations on the inactive list, anon=0, file=1 */
+	atomic_long_t			inactive_age[2];
 	/* Refaults at the time of last reclaim cycle */
-	unsigned long			refaults;
+	unsigned long			refaults[2];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7ddf91c..dda278a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1444,10 +1444,14 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
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
index 9853035..7196ccc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2705,7 +2705,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2716,8 +2719,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2994,8 +2997,10 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
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
index 474186b..59415e0 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/memcontrol.h>
+#include <linux/mm_inline.h>
 #include <linux/writeback.h>
 #include <linux/shmem_fs.h>
 #include <linux/pagemap.h>
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
+				bool file)
 {
 	/*
 	 * Reclaiming a cgroup means reclaiming all its children in a
@@ -230,7 +232,7 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		atomic_long_inc(&lruvec->inactive_age);
+		atomic_long_inc(&lruvec->inactive_age[file]);
 	} while (memcg && (memcg = parent_mem_cgroup(memcg)));
 }
 
@@ -245,6 +247,7 @@ static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat)
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 {
 	struct pglist_data *pgdat = page_pgdat(page);
+	bool file = page_is_file_cache(page);
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	int memcgid;
@@ -254,12 +257,12 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
-	advance_inactive_age(page_memcg(page), pgdat);
+	advance_inactive_age(page_memcg(page), pgdat, file);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
-	eviction = atomic_long_read(&lruvec->inactive_age);
+	eviction = atomic_long_read(&lruvec->inactive_age[file]);
 	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }
 
@@ -274,15 +277,16 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
  */
 void workingset_refault(struct page *page, void *shadow)
 {
+	bool file = page_is_file_cache(page);
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
 	struct pglist_data *pgdat;
-	unsigned long active_file;
 	struct mem_cgroup *memcg;
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	unsigned long refault;
+	unsigned long active;
 	bool workingset;
 	int memcgid;
 
@@ -308,9 +312,11 @@ void workingset_refault(struct page *page, void *shadow)
 	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		goto out;
+
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
-	refault = atomic_long_read(&eviction_lruvec->inactive_age);
-	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	refault = atomic_long_read(&eviction_lruvec->inactive_age[file]);
+	active = lruvec_page_state(eviction_lruvec,
+				page_lru_base_type(page) + LRU_ACTIVE);
 
 	/*
 	 * Calculate the refault distance
@@ -341,19 +347,19 @@ void workingset_refault(struct page *page, void *shadow)
 	memcg = page_memcg(page);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
+	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
 
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
+	advance_inactive_age(memcg, pgdat, file);
+	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
 
 	/* Page was active prior to eviction */
 	if (workingset) {
@@ -370,6 +376,7 @@ void workingset_refault(struct page *page, void *shadow)
  */
 void workingset_activation(struct page *page)
 {
+	bool file = page_is_file_cache(page);
 	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
@@ -383,7 +390,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	advance_inactive_age(memcg, page_pgdat(page));
+	advance_inactive_age(memcg, page_pgdat(page), file);
 out:
 	rcu_read_unlock();
 }
-- 
2.7.4

