Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC6C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D489324670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErnGyphI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBSSZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:25:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40286 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSSZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:25:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so473925pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqZVrRoOAUt9UUKGyxeCCPnn57dTnI4JXggwFljPBlE=;
        b=ErnGyphInuohGNozRNte3SyvYzrsJDZkzP/OAgyDBsr5BDxAntKa4H2D96y+Ab33a+
         07wt6qeEnZ+l9aPtnv/Npiw48a2O0zCICWt69+2r5FWOnOHJEkbcouUmYGNgvMNFax8h
         aPcYAY5QWne+u+T9gHmV2q0J6rgSbkM8cXt67vLo5rNzqI24X/VIGDj8d6HIzATDwRFG
         nSKAYQD9hpn4rYCQwNkAjQ91eM9asJQ2H3q8c1a90luzuG+B8nyxm36+mQXcYgVBXnkf
         F/jZ+saQvZ8M+IZYW3948C0risNEyKikWm95S8fhpEGPENEzdw4vXf8nJD11n8IiI7CE
         AbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bqZVrRoOAUt9UUKGyxeCCPnn57dTnI4JXggwFljPBlE=;
        b=QXMhORDy1x48hO1zSNACnvIESGBGTwRPptRuVOSRjzVvzsUgkdGRsLIxNxSJvM7UFK
         caPlWAvXc+IbyJg4o4ET92RfP8aAZ44RpbaJqfawLYF1Hg7G8DmS69zYgq3o9qMlonTE
         +g1DFLuFTFgfk/5SGOX/Kkv8WH3QtGNYCeTp3C3AtSu5pUBtB5geQlWAoxLxSn5W469K
         s66MzLN+4Npoq/exQ3HifIdv1XFu6fBnROq0oQ7ypZHM7tTjLX7Bx5ZpZotKL7ODOj6w
         2m06AKgiXRnJJiP+wJREHIqWe3n+j7g1QiatqZCIKugaP2h9C1FaGxOz8e38qaBVsNhc
         CViw==
X-Gm-Message-State: APjAAAWpEULlqGDqFHE9WqjVv+ctyJ5rpO/lKLbppcPF+JQBZpBiv5UZ
        u1O+lEJ+YupOpszBNAIGvCewsXs6
X-Google-Smtp-Source: APXvYqwT679RENHBGltOCmpBZU2SH7qLnxN6MgBWl+jf5LO4Vf+qbeP9hyVtzy3+ySIDonRDodMuSQ==
X-Received: by 2002:a63:565b:: with SMTP id g27mr29181514pgm.309.1582136741605;
        Wed, 19 Feb 2020 10:25:41 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id t15sm389874pgr.60.2020.02.19.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:25:40 -0800 (PST)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Stop kswapd early when nothing's waiting for it to free pages
Date:   Wed, 19 Feb 2020 10:25:22 -0800
Message-Id: <20200219182522.1960-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Keeping kswapd running when all the failed allocations that invoked it
are satisfied incurs a high overhead due to unnecessary page eviction
and writeback, as well as spurious VM pressure events to various
registered shrinkers. When kswapd doesn't need to work to make an
allocation succeed anymore, stop it prematurely to save resources.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 17 ++++++++++++++---
 mm/vmscan.c            |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..49c922abfb90 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
+#include <linux/refcount.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -735,6 +736,7 @@ typedef struct pglist_data {
 	unsigned long node_spanned_pages; /* total size of physical page
 					     range, including holes */
 	int node_id;
+	refcount_t kswapd_waiters;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
 	struct task_struct *kswapd;	/* Protected by
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..2d4caacfd2fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4401,6 +4401,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	int no_progress_loops;
 	unsigned int cpuset_mems_cookie;
 	int reserve_flags;
+	pg_data_t *pgdat = ac->preferred_zoneref->zone->zone_pgdat;
+	bool woke_kswapd = false;
 
 	/*
 	 * We also sanity check to catch abuse of atomic reserves being used by
@@ -4434,8 +4436,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
-	if (alloc_flags & ALLOC_KSWAPD)
+	if (alloc_flags & ALLOC_KSWAPD) {
+		if (!woke_kswapd) {
+			refcount_inc(&pgdat->kswapd_waiters);
+			woke_kswapd = true;
+		}
 		wake_all_kswapds(order, gfp_mask, ac);
+	}
 
 	/*
 	 * The adjusted alloc_flags might result in immediate success, so try
@@ -4640,9 +4647,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
-	warn_alloc(gfp_mask, ac->nodemask,
-			"page allocation failure: order:%u", order);
 got_pg:
+	if (woke_kswapd)
+		refcount_dec(&pgdat->kswapd_waiters);
+	if (!page)
+		warn_alloc(gfp_mask, ac->nodemask,
+				"page allocation failure: order:%u", order);
 	return page;
 }
 
@@ -6711,6 +6721,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(&pgdat->__lruvec);
+	pgdat->kswapd_waiters = (refcount_t)REFCOUNT_INIT(0);
 }
 
 static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c05eb9efec07..e795add372d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3694,7 +3694,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		__fs_reclaim_release();
 		ret = try_to_freeze();
 		__fs_reclaim_acquire();
-		if (ret || kthread_should_stop())
+		if (ret || kthread_should_stop() ||
+		    !refcount_read(&pgdat->kswapd_waiters))
 			break;
 
 		/*
-- 
2.25.1

