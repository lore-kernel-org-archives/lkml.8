Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C32C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FA120866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjBLDLRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgCDOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:23:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39685 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:23:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id f10so2219791ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 06:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DuM4SHf1sVSRFd0iAfPg/3FUWAci4sdx8YlPTtxLHUA=;
        b=AjBLDLRaVZo2u3eVMtEp8eF/n6W+A+BSXG1x0tQJO17cbACepFUj9lAAQYvLH+nwIT
         kFtbfwM6ADxCwKKha/V5bMdPvRNkj1PBa2ds4tOgWDCS6UxryiCc2PLfDFGA1mg+/qtj
         tu/segWSBZ4AjX0KJ2fF8H9CqDT3NMzYEHWfBrZnJOumiDvXYN+MFgseacU3MoUd5rmR
         80fqvqmWZzMTG7ig66oQpPjGKJ/7xyzSmlbRFGGcWWmn/lg+anX8O1BnCn3ZI5Yy4HL7
         LwIbnYpjhvzSEUpQbMAxEbvCmBmG/Y2P2vba5qmJ9i7wmARKsj4ZCCkHv+I1LYEuEpDI
         6ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DuM4SHf1sVSRFd0iAfPg/3FUWAci4sdx8YlPTtxLHUA=;
        b=Cu6FllzU6Nyf82IwRntHrFzqCjcCPPqrVhFDJbeGPntJTvFnJwKjMgC4eiPIRr1gzM
         m0WXPkB8QABZClhthSwTLGqOkCs4nqpXxmda4G4KM/hIWy/NSYYg455cIWkeuQIhMYM1
         ktULhLDBZ76AvIQkFk7tqfrkA7DckLtsOjWv7uGKOVrxwH8sTmOCpnS4PaGGy7rJ4l1W
         EA1Shc7DOzsw0goXZQEbMIsD5k4sb1QiJrphdK42hN3HL0nKTDnZ+greF7/4Zjh5WoG4
         MXHNxgKj3skp2xu3ffUJrh77kNc6VG+LhUZGSDEDVza/OXDo7qMOgIzyetqkTor4+NUj
         rQ5w==
X-Gm-Message-State: ANhLgQ2MLCCptzSc/vlL9IGHOJVw+lj2AC4IMe4WTTsAZ6txF7CJ+QKe
        yoiPX2QkA8G92nnlnjsD8K8=
X-Google-Smtp-Source: ADFU+vvKA4imZdpFdR2Wcr5JQLvnEaAwkgmbc8Utlu+oNaDX0sfIzjqzNhUBEv1GqpQkCoaeD+Fm+Q==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr2123355lja.103.1583331791595;
        Wed, 04 Mar 2020 06:23:11 -0800 (PST)
Received: from localhost.localdomain (188.146.98.66.nat.umts.dynamic.t-mobile.pl. [188.146.98.66])
        by smtp.gmail.com with ESMTPSA id z23sm9575712ljg.99.2020.03.04.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:23:11 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [RFC PATCH] mm: Micro-optimisation: Save two branches on hot - page allocation path
Date:   Wed,  4 Mar 2020 15:22:30 +0100
Message-Id: <20200304142230.8753-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

This patch makes ALLOC_KSWAPD
equal to __GFP_KSWAPD_RACLAIM (cast to 'int').

Thanks to that code like:
```if (gfp_mask & __GFP_KSWAPD_RECLAIM)
		alloc_flags |= ALLOC_KSWAPD;```
can be changed to:
```alloc_flags |= (__force int) (gfp_mask &__GFP_KSWAPD_RECLAIM);```
Thanks to this one branch less is generated in the assembly.

In case of ALLOC_KSWAPD flag two branches are saved,
first one in code that always executes in the beggining of page allocation
and the second one in loop in page allocator slowpath.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 86372d164476..7fb724977743 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -535,7 +535,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
-#define ALLOC_KSWAPD		0x200 /* allow waking of kswapd */
+#define ALLOC_KSWAPD		0x800 /* allow waking of kswapd */
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79e950d76ffc..73afd883eab5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3609,10 +3609,14 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
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
+	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
+	alloc_flags = (__force int) (gfp_mask & __GFP_KSWAPD_RECLAIM);
 
 #ifdef CONFIG_ZONE_DMA32
 	if (!zone)
@@ -4248,8 +4252,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
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
@@ -4257,7 +4266,8 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
 	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
 	 */
-	alloc_flags |= (__force int) (gfp_mask & __GFP_HIGH);
+	alloc_flags |= (__force int)
+		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
 	if (gfp_mask & __GFP_ATOMIC) {
 		/*
@@ -4274,9 +4284,6 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
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

