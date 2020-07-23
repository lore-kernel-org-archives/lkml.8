Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E01622B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8cXPsMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGWHtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC11C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so3981346pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F16ehYtLz0xefegEOJ/APaSEoIC5nLFPwAu2t4aT5Rk=;
        b=u8cXPsMobMbSqpjcoLbBncTigilPGdxwy9HmBwGbqEKKFOCoWRZHZ1l5J2P47lwO2m
         Ij3yU94fDkmn72Ho0r9k+03FMEa5hgmjhhoA3iBHEPX8qPjXGNj37flvm2e/zLZlZcam
         g7Lz+MWzgcEUF+dLhanvWH4gqzbJsIWJha5TAd0u5sNZlNNzBtAjMhxngFvuJ3SgvN0T
         sqGuy9ck7IAI0mJPbNKcjWyOKfUSJg4xcC0FXeBBY8eZIoUdPY8FD500mwljZ973Unzu
         IFy2e97YL4CyYBQfsArb6Gv2GDHWkdJkUkB4Nxvqpgr9AU0adZ4s9eSfJpX6A5V7SICF
         0mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F16ehYtLz0xefegEOJ/APaSEoIC5nLFPwAu2t4aT5Rk=;
        b=XgHCeK7tJqM9IXVfTpWiv+qhUlpJ+u/aVZomm2JulEdRKDaRYeYpuHfVgknzyFpTiM
         pOp53yuHLuB8ts+6oRG4wnTqSWpi6SkhC7pNCEpsFIpUZ68J5MZRBTpvu5uaLp4wn1SU
         PHHUJEMMywxeUyBZGIqSxWWsVKngEZyejl5LpXKGgiXm8cw16XIDPeaumudwwap+wIe1
         91DRNUSEJKpsYetPPlncykn0VMnDuvpJkrp11r4YhOpyqs3792zJSTdLg+UnBb3TGAAz
         OzHzwgaH7+VbGnEgPjBbwWfOMP5OL4C09heJ6OwXQCYwwJ4I97f1tHPR1xqEhJWK4FPS
         Bdrg==
X-Gm-Message-State: AOAM531ThCjsoXm9bymRLR0piH+vVMxXvsEdivCZOkg2/kvIZgIPrjAp
        sGUPKEWscIuG/bAC6S+UImo=
X-Google-Smtp-Source: ABdhPJyuDwJTe5YD2AibkK0NRvsERns6+W/ultD7PRy4o6JLYcHQviwlHZUB67cEDk4TYzIFyQOHEg==
X-Received: by 2002:a17:90a:2683:: with SMTP id m3mr3226109pje.8.1595490588712;
        Thu, 23 Jul 2020 00:49:48 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:48 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v7 3/6] mm/workingset: prepare the workingset detection infrastructure for anon LRU
Date:   Thu, 23 Jul 2020 16:49:17 +0900
Message-Id: <1595490560-15117-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

To prepare the workingset detection for anon LRU, this patch splits
workingset event counters for refault, activate and restore into anon
and file variants, as well as the refaults counter in struct lruvec.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/mmzone.h | 16 +++++++++++-----
 mm/memcontrol.c        | 16 +++++++++++-----
 mm/vmscan.c            | 15 ++++++++++-----
 mm/vmstat.c            |  9 ++++++---
 mm/workingset.c        |  8 +++++---
 5 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 635a96c..efbd95d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -173,9 +173,15 @@ enum node_stat_item {
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
@@ -277,8 +283,8 @@ struct lruvec {
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
index 14dd98d..e84c2b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1530,12 +1530,18 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
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
index 9406948..6dda5b2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2683,7 +2683,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2694,8 +2697,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2972,8 +2975,10 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
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
index 5b35c0e..6eecfcb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1190,9 +1190,12 @@ const char * const vmstat_text[] = {
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
index 21b2986..2d77e4d 100644
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
@@ -366,7 +368,7 @@ void workingset_refault(struct page *page, void *shadow)
 
 	SetPageActive(page);
 	workingset_age_nonresident(lruvec, thp_nr_pages(page));
-	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
 
 	/* Page was active prior to eviction */
 	if (workingset) {
@@ -375,7 +377,7 @@ void workingset_refault(struct page *page, void *shadow)
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

