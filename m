Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE7C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F020705
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO+9SIDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgCDQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:21:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33101 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCDQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:21:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id c20so2023229lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O24KKwE3bCNAXE/AxZ3sPbGF9KCAkXxe3BjPmV9rOX0=;
        b=EO+9SIDWbT6LZnKAEg2mm+Jw4k8sOnlYlZ9tgunN/Co1d9dVdLGkLI6P4phqXvRH8/
         59o564h/u1w1zeeO2HPhyo1ELWswxne/hSkVEKyTpVoLPDAg1aiNQ8setYoGCHqKtEc3
         JSpS+/yZMdwQiEMARmvBCkfZ/zqUlz7Tr0gdbMwjBHivE/DEbE6ii8m1FoaonnMobmH4
         ncCniwywa69Ox/6RE8S2td0tCDdlRJadj+gfK4N5eJxjCMFayAqYWgnyuC0BMFww2zRW
         JGGJSh1+MmRA0F7wC7rALOi/wuMvoB47ZTXkGlzXLwBjRNdmMD9OcJhsbMKz5euWE4y8
         /iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O24KKwE3bCNAXE/AxZ3sPbGF9KCAkXxe3BjPmV9rOX0=;
        b=JxsDKrLscdd2xGtNiuURlS5dATy4iTOWuUIJDAdGMZ8k9MGBtaauaSB6WXbO40o/Mv
         ga7qspOzWZNcoXELuVcMh7V/Aljzq5DSH7PdqAFGRhmBRuFh+HwJrgYHBuARrb7cbfMs
         sjT+5Vs8CuTb8F5k74YBqcgm8ohYhAMC88sNv6afvH8gQ8FXYZynVEYuUpSAJefNuNke
         KZ5PjvaP/diMYMJUG+50rZrK+eZ6ksitedmYlrMw1Y+CK1PCv1xxdle3RzrRiedBxdZv
         ryBhkHwDi2WIEXUWGoQ+UYOFS2zfGRa1vM/M/xi6xQvPMJnyGuhphv2WM/D/iOJ/pFO7
         Kpug==
X-Gm-Message-State: ANhLgQ1PuPy9zkFg9mX5ir6fsq98p66b6e/K+A0UOxgcVRKBpilhciRb
        d7RZOLGdn2vdqPntcOQA1yg=
X-Google-Smtp-Source: ADFU+vu8XOFeWJMwK9k3vQ9qTzW4w5iJib5+Lj2Ig0FCvGWB9de+h99yB+IrqJPyd6/c0UmhasAToA==
X-Received: by 2002:ac2:5f62:: with SMTP id c2mr2517936lfc.207.1583338916346;
        Wed, 04 Mar 2020 08:21:56 -0800 (PST)
Received: from localhost.localdomain (188.146.98.66.nat.umts.dynamic.t-mobile.pl. [188.146.98.66])
        by smtp.gmail.com with ESMTPSA id w24sm13445961ljh.26.2020.03.04.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:21:55 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, mgorman@techsingularity.net
Subject: [PATCH v2] mm: Micro-optimisation: Save two branches on hot - page allocation path
Date:   Wed,  4 Mar 2020 17:21:18 +0100
Message-Id: <20200304162118.14784-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

This patch makes ALLOC_KSWAPD equal to __GFP_KSWAPD_RECLAIM (cast to int).

Thanks to that code like:
    if (gfp_mask & __GFP_KSWAPD_RECLAIM)
	    alloc_flags |= ALLOC_KSWAPD;
can be changed to:
    alloc_flags |= (__force int) (gfp_mask &__GFP_KSWAPD_RECLAIM);
Thanks to this one branch less is generated in the assembly.

In case of ALLOC_KSWAPD flag two branches are saved, first one in code that
always executes in the beginning of page allocation and the second one in
loop in page allocator slowpath.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 86372d164476..f089fc98fc08 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -535,7 +535,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
-#define ALLOC_KSWAPD		0x200 /* allow waking of kswapd */
+#define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79e950d76ffc..eed9f790eef7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3609,10 +3609,13 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 static inline unsigned int
 alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 {
-	unsigned int alloc_flags = 0;
+	unsigned int alloc_flags;
 
-	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
-		alloc_flags |= ALLOC_KSWAPD;
+	/*
+	 * __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
+	 * to save a branch.
+	 */
+	alloc_flags = (__force int) (gfp_mask & __GFP_KSWAPD_RECLAIM);
 
 #ifdef CONFIG_ZONE_DMA32
 	if (!zone)
@@ -4248,8 +4251,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
-	/* __GFP_HIGH is assumed to be the same as ALLOC_HIGH to save a branch. */
+	/*
+	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
+	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
+	 * to save two branches.
+	 */
 	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
+	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
@@ -4257,7 +4265,8 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
 	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
 	 */
-	alloc_flags |= (__force int) (gfp_mask & __GFP_HIGH);
+	alloc_flags |= (__force int)
+		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
 	if (gfp_mask & __GFP_ATOMIC) {
 		/*
@@ -4274,9 +4283,6 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	} else if (unlikely(rt_task(current)) && !in_interrupt())
 		alloc_flags |= ALLOC_HARDER;
 
-	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
-		alloc_flags |= ALLOC_KSWAPD;
-
 #ifdef CONFIG_CMA
 	if (gfpflags_to_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
-- 
2.17.1

