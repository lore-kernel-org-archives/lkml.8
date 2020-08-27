Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E15C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4920848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g4pcl2Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgH0XmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0XmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:42:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 83so9679979ybf.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0Hnjgxs1FODqIFSLlA6dKst+CBRSb6xS7lVECFzeV8Y=;
        b=g4pcl2Gm0G1W3HdUB3pJZJjDi4Cz5qZuTb1AWrvOuVmZ/b+ZtAsmcca10al2XPG0RJ
         MFYHAkFPLZ6glOxCEydRuZnX5SUdcpziRl9r+xBx3O1NiptTb1KM4rlk4vFggAfcVBpb
         3t3wW2+oP08BeIq0ZOzkr64I5ZR+dqAsR7CshISuWG4SDPrC8r82As9LQfg+TVvRibQM
         jLHmz3cXCgAri5RUkYTBky9qf4f7Bl08voRCMf/K9Za8rYMIUzr9gjr+/wd9fbfCP73Q
         YDp5mFpZKC6Z1bemplKD77ZBUMs9Qbx1QPIs7TuiYfGxewXHEeSeVx7X3s9u6TvfGvm1
         2XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0Hnjgxs1FODqIFSLlA6dKst+CBRSb6xS7lVECFzeV8Y=;
        b=uL2Oxb7JRaR+EWdip0x4ybXuEukloQl0mZHC40R5u3uQUM90Dd84a3xtTNDU+ksWHb
         CHBqCqMZsC8sAF1nP8BDmYvkYFhwSBITDWxnmBhtKF1ny7l3GlxTo9T6G+7lLzwDaOUP
         oX5h7cmHo72K/AUyF+tOdeKmgUmrsriyoDyZeo4+Zh9rJR8/eXA3uFkeBtDdpaglq18v
         IkJFIJW85YRljnMTxsQG6qeQYzfvJq0m/56KKvv7VkLDsqbrDTX+nX3Jk2YPDpv/530r
         P3bA4cAUlKvssgYQw72ilW3XM5/Z4q1k/xWtjgS2HuRk9f+F5MadvvdjLD0JzJJ94YoO
         CsJw==
X-Gm-Message-State: AOAM5301141aJC6poVraf4Y+YDQd67tmhLGsbnkyrdxEUOjFwAVN4/Mf
        iaxKQSrREoUS9imohQBQjGqcqTZBn9M=
X-Google-Smtp-Source: ABdhPJx+jlYfgffMXl8kCT6JKh0xS8rZOWY5VAiBeGbHusL3uPkAsSinSwCcoCJaZ7MyUpnglnLYHh7ZeK0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:a143:: with SMTP id z61mr33466264ybh.468.1598571729777;
 Thu, 27 Aug 2020 16:42:09 -0700 (PDT)
Date:   Thu, 27 Aug 2020 17:42:02 -0600
In-Reply-To: <20200827234202.4027996-1-yuzhao@google.com>
Message-Id: <20200827234202.4027996-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20200827234202.4027996-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 2/2] mm: use self-explanatory macros rather than "2"
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial clean-up patch. Take it or leave it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h | 12 ++++++++----
 include/linux/vmstat.h |  2 +-
 mm/vmscan.c            |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..be1cdbf8317f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -266,6 +266,8 @@ static inline bool is_active_lru(enum lru_list lru)
 	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
 }
 
+#define ANON_AND_FILE 2
+
 enum lruvec_flags {
 	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
 					 * backed by a congested BDI
@@ -283,8 +285,8 @@ struct lruvec {
 	unsigned long			file_cost;
 	/* Non-resident age, driven by LRU movement */
 	atomic_long_t			nonresident_age;
-	/* Refaults at the time of last reclaim cycle, anon=0, file=1 */
-	unsigned long			refaults[2];
+	/* Refaults at the time of last reclaim cycle */
+	unsigned long			refaults[ANON_AND_FILE];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
@@ -406,6 +408,8 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#define ASYNC_AND_SYNC 2
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -525,8 +529,8 @@ struct zone {
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 	/* pfn where compaction free scanner should start */
 	unsigned long		compact_cached_free_pfn;
-	/* pfn where async and sync compaction migration scanner should start */
-	unsigned long		compact_cached_migrate_pfn[2];
+	/* pfn where compaction migration scanner should start */
+	unsigned long		compact_cached_migrate_pfn[ASYNC_AND_SYNC];
 	unsigned long		compact_init_migrate_pfn;
 	unsigned long		compact_init_free_pfn;
 #endif
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 91220ace31da..d5431c1bf6e5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -28,7 +28,7 @@ struct reclaim_stat {
 	unsigned nr_writeback;
 	unsigned nr_immediate;
 	unsigned nr_pageout;
-	unsigned nr_activate[2];
+	unsigned nr_activate[ANON_AND_FILE];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b479ced26cd3..c4ddb2a88b07 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2231,7 +2231,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
-	u64 fraction[2];
+	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
 	unsigned long ap, fp;
-- 
2.28.0.402.g5ffc5be6b7-goog

