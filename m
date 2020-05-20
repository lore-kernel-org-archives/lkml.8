Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2628E20825
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1G6DXIJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgETX0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgETX0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c24so4078345qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdHcjhZvow6usaHH6IOhGcdeIOnMYFh9EQeCamKBCKk=;
        b=1G6DXIJGh/ylA6R/q/RaFWJ/W8j3BBPQO2vuLJ34z1yQroPUpS9pk1ZGKeTrxnf+Hc
         tmEefkJvFEGoQ4hj5qcK/cg+QothlLtdAhEPtj2S/2wBMP1KY44qMyPfBrtAHZcOL0JR
         dyRAhgbmJlLBDULSLg8Jx5WbzHO5Ao+TvQdM1srUzVPMV9UA78m5ObhgZWwNE7/2CyEo
         ELuGqWPDdsKvqkf8trDnk4xL5c0IBxcalipILLmL+FJ7Rrg/xOLvpdUmTDvsKNiCmVws
         4Yku9O4MgI2DOBcZSsnFrOVKVA6PoKUnW5wC5+kQUkGl335nOvyVgUGx18XaM5BLDeW+
         Bc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdHcjhZvow6usaHH6IOhGcdeIOnMYFh9EQeCamKBCKk=;
        b=TG453vRCbqmicJujUu4lCF4ykUw/du8qijL5X15bQDSb75LQiKWEidB6ziJ/JbPUIy
         yRphMm1pxy0CGkrgFfGfYxB03Rijlt17ikIbYtZ+BYLs+26P8fGC1JjZwaNNXCF9Ihjy
         cpb8fHawT2+Jwb0uygJ0ETG+Ak3807xjq9bchIx65PxqXNeZjstiC6mAZUeMTn0UNCqL
         kK6uFzb1CbpotunXseqv+d5DJQA8MOM7jGpDmd8cJ61Huvnd+gbJl8w03uu9atARBc0Z
         FiNv4Qa/Vkkb0bMAKS+c1gRAyYYhiinMwXZl7Brabwxi+1waaB4VBv+c+cr/Zvl8hLRq
         muRQ==
X-Gm-Message-State: AOAM532CB65YphvIwwvzr+afYT6VA+PtZLtsCNTIlmnNX5DI1wtsvKvk
        D9gDxscMD7aBcprazTxsdhA0Ug==
X-Google-Smtp-Source: ABdhPJwXIhLQpueVxZvCxqygroC8yldBD9x4uWr+VG50vq899PbZhDNyaHBtVUWFrf+89u7XJLc0mw==
X-Received: by 2002:aed:221c:: with SMTP id n28mr7910631qtc.235.1590017162988;
        Wed, 20 May 2020 16:26:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id t21sm3841161qtb.0.2020.05.20.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:02 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/14] mm: keep separate anon and file statistics on page reclaim activity
Date:   Wed, 20 May 2020 19:25:13 -0400
Message-Id: <20200520232525.798933-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having statistics on pages scanned and pages reclaimed for both anon
and file pages makes it easier to evaluate changes to LRU balancing.

While at it, clean up the stat-keeping mess for isolation, putback,
reclaim stats etc. a bit: first the physical LRU operation (isolation
and putback), followed by vmstats, reclaim_stats, and then vm events.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/vm_event_item.h |  4 ++++
 mm/vmscan.c                   | 17 +++++++++--------
 mm/vmstat.c                   |  4 ++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ffef0f279747..24fc7c3ae7d6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -35,6 +35,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
+		PGSCAN_ANON,
+		PGSCAN_FILE,
+		PGSTEAL_ANON,
+		PGSTEAL_FILE,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_FAILED,
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cc555903a332..70b0e2c6a4b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1913,7 +1913,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	unsigned int nr_reclaimed = 0;
 	unsigned long nr_taken;
 	struct reclaim_stat stat;
-	int file = is_file_lru(lru);
+	bool file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
@@ -1941,11 +1941,12 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 	reclaim_stat->recent_scanned[file] += nr_taken;
-
 	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
+	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
+
 	spin_unlock_irq(&pgdat->lru_lock);
 
 	if (nr_taken == 0)
@@ -1956,16 +1957,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	spin_lock_irq(&pgdat->lru_lock);
 
+	move_pages_to_lru(lruvec, &page_list);
+
+	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
+	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
-	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
-	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
-
-	move_pages_to_lru(lruvec, &page_list);
-
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
+	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 
 	spin_unlock_irq(&pgdat->lru_lock);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4b0c90e4de71..3d06bd89d9ec 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1201,6 +1201,10 @@ const char * const vmstat_text[] = {
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
+	"pgscan_anon",
+	"pgscan_file",
+	"pgsteal_anon",
+	"pgsteal_file",
 
 #ifdef CONFIG_NUMA
 	"zone_reclaim_failed",
-- 
2.26.2

