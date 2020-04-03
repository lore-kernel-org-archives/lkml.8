Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45668C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100D220721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Pv/STgoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390997AbgDCOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:10:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36832 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390952AbgDCOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:09:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so8053446qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XVRAeuNidJ39fRWcp3zOg/tgGV7ciJyEMq0r6ftBFJY=;
        b=Pv/STgoODRaMYRiiqxBA4FU5tHdCrokh/6lo1YBeqlLcKeHM7c97JRYEXNAUAnZROs
         QllUwUTWuAGZHWyLGi5Aab84uIxeOrWTeM2R4dI4UW6n+5miI/RKGnScMSr40vO+fadU
         TBiSwbazclyZK1IkQRALY3ir1snq57CwVzflYbbEpJ/J2OkIUogEtqqqC54tdvstPUW+
         XTHFIK27Sr/CO2FOINnx/cqdP3yUhGen+CITv5zSh4SF0e13rf9lwY7gLGQcPe2y+ynW
         CSkmBhUM13OhPLQwmaOVHIChqkMaXM6By3d9fEE5vYL0a3FjYbkaS2x4Da+0HzR9GIr5
         eexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XVRAeuNidJ39fRWcp3zOg/tgGV7ciJyEMq0r6ftBFJY=;
        b=A025Y+OCMai+DUAPkq4AmYjThaL0eG/Ez8fWnuVhA9f7yooRifArjB6phy7QCmu1A3
         DPYJCIIg6z0OLAnPqGO8pyby/GcDHdBIbanbWof2kdYrjNiTXH5sV/2nqYuhv0EZiJzc
         z0HN0N6ckPlenf/t1LWypNxbLnkwAL/Bp3CY9acIk4VlUEbSSkq2MkvOmduPfOKDnTrh
         WfttnnrGnC+NomhRgivKF1AISZ2SnwOS1xHnEHUdzEaB0cdV15ZD7/Pkcoz2NaxBwRQ+
         rZJwIfG6+mjmsd0LJCbPgZFRX8kQQ1aNmVqpOAADho9fmGhjiKuT+7xRzXdThjdar3I8
         OJVQ==
X-Gm-Message-State: AGi0PuZfxdejG1HbM31ykGaAt5TWfXAVrx1J+VPXMsivbr8Xqru9lETY
        XO+4xzYJ09WY8eVjFjGJ0S4jJzQ/ddU=
X-Google-Smtp-Source: APiQypKG+RDjl6tsspH1xetr6qrHYm6ArZOqM7g6tH+MGmGM9+S4uAiHm7tgKrLhdEG9F8stXc7waQ==
X-Received: by 2002:a05:620a:1502:: with SMTP id i2mr8949305qkk.279.1585922997660;
        Fri, 03 Apr 2020 07:09:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s56sm6917392qtk.9.2020.04.03.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:09:56 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v4 2/3] mm: initialize deferred pages with interrupts enabled
Date:   Fri,  3 Apr 2020 10:09:51 -0400
Message-Id: <20200403140952.17177-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403140952.17177-1-pasha.tatashin@soleen.com>
References: <20200403140952.17177-1-pasha.tatashin@soleen.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 20 +++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e84d448988b6..ac6a8245f063 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -723,6 +723,8 @@ typedef struct pglist_data {
 	/*
 	 * Must be held any time you expect node_start_pfn,
 	 * node_present_pages, node_spanned_pages or nr_zones to stay constant.
+	 * Also synchronizes pgdat->first_deferred_pfn during deferred page
+	 * init.
 	 *
 	 * pgdat_resize_lock() and pgdat_resize_unlock() are provided to
 	 * manipulate node_size_lock without checking for CONFIG_MEMORY_HOTPLUG
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d95bfd328107..5ffa8d7e5545 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1784,6 +1784,13 @@ static int __init deferred_init_memmap(void *data)
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
@@ -1806,8 +1813,6 @@ static int __init deferred_init_memmap(void *data)
 		touch_nmi_watchdog();
 	}
 zone_empty:
-	pgdat_resize_unlock(pgdat, &flags);
-
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
 
@@ -1849,17 +1854,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 
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

