Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84124C11D29
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D4C207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8PQ2M1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBUEa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:30:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43206 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgBUEa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:30:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so312197plq.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 20:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EttScu7b3Zcxse3Lm5LZJBxiXqhV0LDxi2fVutkTFXE=;
        b=Y8PQ2M1yUf7XA8Sjia46qNZT0aDDg8iNmoBP5Z1OTOccdiwbqFNOHawUoK3dRE7S8J
         MQUz0/81iKo++qYf2L1ChFO0TbR+OAG2cZSOcqraXo9QPpvHND6d7pslM58uYRmc/Suq
         zXC0BG7pI1oPTRi9byUC+XnJnfVPkzMOIV0OUeb6NIsKoLDK3SDqoNBpF9crP1gG17jj
         nR9kO7DqZkUu1Z90ByHvAqHF8hHLthl5pSRjlh5yaOjc3qeX9r7T7zvw/kxTfsynx06K
         f/War94AlcsSZskw1mWsInkPIcJ+1DOjWb0YnFY+WPan64ueQ/bN4aWGGpMyZrBHkK5t
         5ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EttScu7b3Zcxse3Lm5LZJBxiXqhV0LDxi2fVutkTFXE=;
        b=uB86i42BQrd0jym7VHktoLHbB66OCg4Du2v5XkdH1/VEFwgFUFZ/jxVI1jf8O+//N3
         pUDXktOOJsfrKJy7m4nMCg2ofQ8RLT+YYVu19zfMQuPFB/O/fQgqAYf19NXDxR/qWbJn
         RT9xp5r6aeKtqeR0AyUs328m5FWzgoIKWqHdCzJ29yxS6k+aOsFVpKTNOLwUOILESBfS
         1usJdzsIuzc8wkxMySUMbksiSkOthwwxHoMz03Wl6uJWdBV2olR09wVVhw+6QNdC7Bmp
         VNG209DL13h1mqz7q596AggBNF2ard1JZ+/ReQDJrVH6FpS1f9DUwyzxQ6uzGWmVwb3f
         6ysA==
X-Gm-Message-State: APjAAAWx/sUiFqNLemHMiNuhpRZ1rKDQcKPErcOzWlOL/jEL2FQVgJn8
        29Zd469zgfCwIzQXVhyzSNo=
X-Google-Smtp-Source: APXvYqzJPnbzB0wQdThyd64SZw54m+AzRRm2mj7M5/HdjDw9n+m/wYxEx1fS1FjBPKcUQEF4dLRB3g==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr784816pjq.5.1582259455907;
        Thu, 20 Feb 2020 20:30:55 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id f18sm827488pgn.2.2020.02.20.20.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 20:30:55 -0800 (PST)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: Stop kswapd early when nothing's waiting for it to free pages
Date:   Thu, 20 Feb 2020 20:30:52 -0800
Message-Id: <20200221043052.3305-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219182522.1960-1-sultan@kerneltoast.com>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
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
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 17 ++++++++++++++---
 mm/vmscan.c            |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..23861cdaab7f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -735,6 +735,7 @@ typedef struct pglist_data {
 	unsigned long node_spanned_pages; /* total size of physical page
 					     range, including holes */
 	int node_id;
+	atomic_t kswapd_waiters;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
 	struct task_struct *kswapd;	/* Protected by
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..923b994c38c8 100644
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
+			atomic_inc(&pgdat->kswapd_waiters);
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
+		atomic_dec(&pgdat->kswapd_waiters);
+	if (!page)
+		warn_alloc(gfp_mask, ac->nodemask,
+				"page allocation failure: order:%u", order);
 	return page;
 }
 
@@ -6711,6 +6721,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(&pgdat->__lruvec);
+	pgdat->kswapd_waiters = (atomic_t)ATOMIC_INIT(0);
 }
 
 static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c05eb9efec07..59d9f3dd14f6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3694,7 +3694,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		__fs_reclaim_release();
 		ret = try_to_freeze();
 		__fs_reclaim_acquire();
-		if (ret || kthread_should_stop())
+		if (ret || kthread_should_stop() ||
+		    !atomic_read(&pgdat->kswapd_waiters))
 			break;
 
 		/*
-- 
2.25.1

