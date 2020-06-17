Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34FF208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhsRvMKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFQF0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgFQF0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so458349pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LqAOrLNplaMBqdY/rTyoQrQcxqZrPjXktX70kNlPxVs=;
        b=RhsRvMKjie6x723miQooKnqgSSbdE9r7uTdUvENQTq+FVnX42ve0e5PcTXw657lo8G
         nLywbBbWJNegPWhAcn7UZEIuw1HzUBxVtune9XA37/3FN7Xgddmtd+tGv2RP9skb1mKL
         eysC6e2IZ7YmtaHyI8nQkWaPhLKLkJZYe7drnQWbqjsdyfRzTBofndFYu26NS1NO5nrx
         U2IiVS//aXASmtjpBJPxam85oTZaBv4G5Io/dlA0G8DrHc5a3LV+TnlY1Q53UyV4Sldd
         PhrhcjXHZF6CwIfb8XHtUiAQEWLRb3oZnZkcRzrocHUYK2l85O1bYbaoMY7Xxap27gaj
         HtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LqAOrLNplaMBqdY/rTyoQrQcxqZrPjXktX70kNlPxVs=;
        b=S1FHCS64PAltP5jEbcy7ToOFxFQURUV99ionElxlSiXUE05szbSfI5Nkr0ozc+KCyX
         Xjs0nP6FRpNHU8KujcWapiyEptzyBKu2XtrQuecU43B3NL6V17FrO4EFx7Fx5VyoA/AC
         1hAej1w2wQHStxjpBQSz98fobmA9/cGTbQDOGbVtTtdFffgy28N85wK8n8mV7YKuPMC5
         +YI0CbTrP/5xByJ54NTnmlLFWlVnZbfDxmI7wxMW2cwUoE4NAD4WMR3ft+j8f+fjoYNN
         ttovSs95hw0yDfpmjh/mV3Y1o1fFLzzHbeVrIZo5Dyq0Le+ymOrx0YkZ4WSmJrMubr1o
         s5gw==
X-Gm-Message-State: AOAM532FhQGBACgA+iofRLVtStzESSgbyVr8umvJxrXHIpCBLJFGEbi9
        I2JAlwwvX9QM7CS2XBkmCfY=
X-Google-Smtp-Source: ABdhPJzKADQ5ElC8hqTHmAdFLRipScrGlc0p5LLDRIHX9sWKdEgBxG0YNVeIT/vP5g3vj9UrE8EIbw==
X-Received: by 2002:a17:90b:390e:: with SMTP id ob14mr5695642pjb.221.1592371609477;
        Tue, 16 Jun 2020 22:26:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:48 -0700 (PDT)
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
Subject: [PATCH v6 3/6] mm/workingset: extend the workingset detection for anon LRU
Date:   Wed, 17 Jun 2020 14:26:20 +0900
Message-Id: <1592371583-30672-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In the following patch, workingset detection will be applied to
anonymous LRU. To prepare it, this patch adds some code to
distinguish/handle the both LRUs.

v6: do not introduce a new nonresident_age for anon LRU since
we need to use *unified* nonresident_age to implement workingset
detection for anon LRU.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h | 16 +++++++++++-----
 mm/memcontrol.c        | 16 +++++++++++-----
 mm/vmscan.c            | 15 ++++++++++-----
 mm/vmstat.c            |  9 ++++++---
 mm/workingset.c        |  8 +++++---
 5 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f6f8849..8e9d0b9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -179,9 +179,15 @@ enum node_stat_item {
 	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
 	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
 	WORKINGSET_NODES,
-	WORKINGSET_REFAULT,
-	WORKINGSET_ACTIVATE,
-	WORKINGSET_RESTORE,
+	WORKINGSET_REFAULT_BASE,
+	WORKINGSET_REFAULT_ANON = WORKINGSET_REFAULT_BASE,
+	WORKINGSET_REFAULT_FILE,
+	WORKINGSET_ACTIVATE_BASE,
+	WORKINGSET_ACTIVATE_ANON = WORKINGSET_ACTIVATE_BASE,
+	WORKINGSET_ACTIVATE_FILE,
+	WORKINGSET_RESTORE_BASE,
+	WORKINGSET_RESTORE_ANON = WORKINGSET_RESTORE_BASE,
+	WORKINGSET_RESTORE_FILE,
 	WORKINGSET_NODERECLAIM,
 	NR_ANON_MAPPED,	/* Mapped anonymous pages */
 	NR_FILE_MAPPED,	/* pagecache pages mapped into pagetables.
@@ -259,8 +265,8 @@ struct lruvec {
 	unsigned long			file_cost;
 	/* Non-resident age, driven by LRU movement */
 	atomic_long_t			nonresident_age;
-	/* Refaults at the time of last reclaim cycle */
-	unsigned long			refaults;
+	/* Refaults at the time of last reclaim cycle, anon=0, file=1 */
+	unsigned long			refaults[2];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6a..2127dd1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1425,12 +1425,18 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
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
 	seq_buf_printf(&s, "workingset_restore %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_RESTORE));
+		       memcg_page_state(memcg, WORKINGSET_RESTORE_ANON));
+	seq_buf_printf(&s, "workingset_restore %lu\n",
+		       memcg_page_state(memcg, WORKINGSET_RESTORE_FILE));
 	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4745e88..3caa35f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2695,7 +2695,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2706,8 +2709,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2984,8 +2987,10 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
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
index 80c9b62..8843e75 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1149,9 +1149,12 @@ const char * const vmstat_text[] = {
 	"nr_isolated_anon",
 	"nr_isolated_file",
 	"workingset_nodes",
-	"workingset_refault",
-	"workingset_activate",
-	"workingset_restore",
+	"workingset_refault_anon",
+	"workingset_refault_file",
+	"workingset_activate_anon",
+	"workingset_activate_file",
+	"workingset_restore_anon",
+	"workingset_restore_file",
 	"workingset_nodereclaim",
 	"nr_anon_pages",
 	"nr_mapped",
diff --git a/mm/workingset.c b/mm/workingset.c
index fc16d97c..8395e60 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/memcontrol.h>
+#include <linux/mm_inline.h>
 #include <linux/writeback.h>
 #include <linux/shmem_fs.h>
 #include <linux/pagemap.h>
@@ -280,6 +281,7 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
  */
 void workingset_refault(struct page *page, void *shadow)
 {
+	bool file = page_is_file_lru(page);
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
@@ -346,7 +348,7 @@ void workingset_refault(struct page *page, void *shadow)
 	memcg = page_memcg(page);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
+	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
 
 	/*
 	 * Compare the distance to the existing workingset size. We
@@ -364,7 +366,7 @@ void workingset_refault(struct page *page, void *shadow)
 
 	SetPageActive(page);
 	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
-	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
 
 	/* Page was active prior to eviction */
 	if (workingset) {
@@ -373,7 +375,7 @@ void workingset_refault(struct page *page, void *shadow)
 		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
 		spin_unlock_irq(&page_pgdat(page)->lru_lock);
-		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
+		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
 	}
 out:
 	rcu_read_unlock();
-- 
2.7.4

