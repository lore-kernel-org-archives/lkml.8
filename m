Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1644E206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hD05TIO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbgDAW5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:57:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbgDAW5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:57:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id i6so2048966qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Ua0ip48NRuNb7M82MPpw9n9AzPFq0D90ae7TFh2Pxk4=;
        b=hD05TIO+ZC3rcKCYSDzUly6N/UrVaUQ0LGPHMldrr06PrDntWHxAO4yQ2gYQ6M+bw8
         310p7HAxkzRHj0X9fHCS5yV+fvCbpNycZIFV60gw+ia71s0pf7pPgnBlehVPQyS9JDtL
         9nYTuVLLC2x47dHOFZbPFY5jZKAr62mdkoyB7kUbiOuHyTN1A4OKGZ4BS9rvH5YGrki3
         DpL8x5JmB018e9hMrvUD7xJlxwcQASQxBRRiey0rl2aQUZG+8tpXpVZ1N+eBeItdQTH3
         T0a6fBDMGZ5w+enooGb0d1oMlmwgZMkHstzj1G/mfOMLbAxWFvCMwQmGKrKjKSURMV6Q
         1Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Ua0ip48NRuNb7M82MPpw9n9AzPFq0D90ae7TFh2Pxk4=;
        b=I3FvGo4ZJ8by0Y9pGxSz9UIxACZiMcFkdvWMkCCyLHTPW4vH0+2EmcK5iD171ikUpL
         k/TgYtmb3YjtNL+x26FIhLmWKF9/lsvYUtFrb5H9pTze2KtcGK5E8OOn0CqbrJkQnWvP
         oQcOvyVUjI78N6SQIroU6S00rBTqyAz8MuGgLx6Dz4n37W1l1PeNY4Vbnko1sotp8/2q
         rlDeazkmLRRooHFn4rc5iYxCX8xpqgofyw/XUHYHHkWni0svMVu6GjyCwB/tI/gcN6IH
         x09Rh65ufDio+ahLWQHymSp5wiD1JTdlaYkhMHvRPLzE+CfxKZWBUUc2FVMv9fIL+oIF
         hbqA==
X-Gm-Message-State: AGi0PuZ9WWQXesQFxaHAHkPJKjAdqqVF2xIrGo0Bavbesd0Zy15vdB97
        v6MiCIIMafFAW3OTPqFfIQsILNFMNLSonQ==
X-Google-Smtp-Source: APiQypLIbzgor45d6rbnA0BNl055815+9FeI/CdjzWNSk5MG14Rpx+4uHE38nGhF1N8CbXIDJHPQFA==
X-Received: by 2002:a37:a952:: with SMTP id s79mr717481qke.368.1585781848692;
        Wed, 01 Apr 2020 15:57:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q5sm2402635qkq.17.2020.04.01.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 15:57:28 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v2 2/2] mm: initialize deferred pages with interrupts enabled
Date:   Wed,  1 Apr 2020 18:57:23 -0400
Message-Id: <20200401225723.14164-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401225723.14164-1-pasha.tatashin@soleen.com>
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing struct pages is a long task and keeping interrupts disabled
for the duration of this operation introduces a number of problems.

1. jiffies are not updated for long period of time, and thus incorrect time
   is reported. See proposed solution and discussion here:
   lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
2. It prevents farther improving deferred page initialization by allowing
   intra-node multi-threading.

We are keeping interrupts disabled to solve a rather theoretical problem
that was never observed in real world (See 3a2d7fa8a3d5).

Lets keep interrupts enabled. In case we ever encounter a scenario where
an interrupt thread wants to allocate large amount of memory this early in
boot we can deal with that by growing zone (see deferred_grow_zone()) by
the needed amount before starting deferred_init_memmap() threads.

Before:
[    1.232459] node 0 initialised, 12058412 pages in 1ms

After:
[    1.632580] node 0 initialised, 12051227 pages in 436ms

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
Cc: stable@vger.kernel.org # 4.17+

Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 22 ++++++++--------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..c5bdf55da034 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -721,6 +721,8 @@ typedef struct pglist_data {
 	/*
 	 * Must be held any time you expect node_start_pfn,
 	 * node_present_pages, node_spanned_pages or nr_zones to stay constant.
+	 * Also synchronizes pgdat->first_deferred_pfn during deferred page
+	 * init.
 	 *
 	 * pgdat_resize_lock() and pgdat_resize_unlock() are provided to
 	 * manipulate node_size_lock without checking for CONFIG_MEMORY_HOTPLUG
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e8ff6a176164..68669d3a5a66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1790,6 +1790,13 @@ static int __init deferred_init_memmap(void *data)
 	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
 	pgdat->first_deferred_pfn = ULONG_MAX;
 
+	/*
+	 * Once we unlock here, the zone cannot be grown anymore, thus if an
+	 * interrupt thread must allocate this early in boot, zone must be
+	 * pre-grown prior to start of deferred page initialization.
+	 */
+	pgdat_resize_unlock(pgdat, &flags);
+
 	/* Only the highest zone is deferred so find it */
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		zone = pgdat->node_zones + zid;
@@ -1809,11 +1816,9 @@ static int __init deferred_init_memmap(void *data)
 	 */
 	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		touch_nmi_watchdog();
+		cond_resched();
 	}
 zone_empty:
-	pgdat_resize_unlock(pgdat, &flags);
-
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
 
@@ -1855,17 +1860,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 
 	pgdat_resize_lock(pgdat, &flags);
 
-	/*
-	 * If deferred pages have been initialized while we were waiting for
-	 * the lock, return true, as the zone was grown.  The caller will retry
-	 * this zone.  We won't return to this function since the caller also
-	 * has this static branch.
-	 */
-	if (!static_branch_unlikely(&deferred_pages)) {
-		pgdat_resize_unlock(pgdat, &flags);
-		return true;
-	}
-
 	/*
 	 * If someone grew this zone while we were waiting for spinlock, return
 	 * true, as there might be enough pages already.
-- 
2.17.1

