Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E26C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D981720732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acta1j8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgC2II2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:08:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37108 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgC2II2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:08:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so17194736wrm.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+XfdXBS+VtHXJ6dDhCxeS+WipNF+yU7gkiw9iEz+TOc=;
        b=Acta1j8MpNHhBYr43x6Nm9YDQUHyK4dyioSB6UnWZ4pIDpX5INpFoFYTGqaVs0T2tL
         4VuWiHgrFITpQZOJqjEFAkbZYTPh9+jl4GSR+8czIuXtSi8FOFKYAJa3eg+tvFEQYnaA
         G7ta6icVNrpLiJkPfiWI2Byl6Ey2vT+6vUVnufPUZcuoQdCkebLR4KHUxcc+Nf41M5WN
         g1XsFcY7+/bsA0AbPGHPMsWJdGIqcEtqecTMYRZpjtC//aAe2/hRNJAuDtwkm5aqure2
         AQjuf/WGCvOFmKeQcrb2Erw/blgXtSOpnhwGhn2120kud1SoYokm65ZvmHO90KkmOtg9
         eOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+XfdXBS+VtHXJ6dDhCxeS+WipNF+yU7gkiw9iEz+TOc=;
        b=RdLfYID9D3jgzT4HKdvjq01R0/JkXYHtEaXLRhx+i/sbLK2q06qucuR92OEmLEYEgj
         L97SxiRIP8y48nvrAvvotcXBYJGlIrPadvnCciOgb9vSWjAC5AMlVPTVeCPMwCj9zu2J
         xgcW3jIXmZ22AFHQl4AXBWxB+vZPVWu9G/sxt3IBLZdkRKaHtiUunqqDsShNzutPsN1A
         uIWt9vyDyP5I/k57lBdeHztUx8CoQ73w5VKXfVwEV/dI8Z+LMco5Ic/X+LwUyhsJurKW
         nRRsfLXbJLbFly5neccnZtz2jEPmW1WR7J/WsZe/1XG6AE2HhG5L+GHOGllNMVGJU4l9
         qRqA==
X-Gm-Message-State: ANhLgQ32xlQTp8z4Ab2/IXpey1BZgbzXeJPw982kquOrcyPNZH+1Lp4r
        oSp3eGX4RcLLY23bHjlXRsS967fw
X-Google-Smtp-Source: ADFU+vtlRZkeX1L1RSbtoD85Sk424L2HYsEbwzkF+Nnxde1jseOPAlAxpvQ4b2L/y5Hi3I4EmsAxTw==
X-Received: by 2002:adf:f404:: with SMTP id g4mr8476182wro.194.1585469306442;
        Sun, 29 Mar 2020 01:08:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z1sm4204996wrp.90.2020.03.29.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 01:08:25 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm: rename gfpflags_to_migratetype to gfp_migratetype for same convention
Date:   Sun, 29 Mar 2020 08:08:23 +0000
Message-Id: <20200329080823.7735-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pageblock migrate type is encoded in GFP flags, just as zone_type and
zonelist.

Currently we use gfp_zone() and gfp_zonelist() to extract related
information, it would be proper to use the same naming convention for
migrate type.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/gfp.h | 2 +-
 mm/compaction.c     | 2 +-
 mm/page_alloc.c     | 4 ++--
 mm/page_owner.c     | 7 +++----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..7874b8e1c29f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -305,7 +305,7 @@ struct vm_area_struct;
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 #define GFP_MOVABLE_SHIFT 3
 
-static inline int gfpflags_to_migratetype(const gfp_t gfp_flags)
+static inline int gfp_migratetype(const gfp_t gfp_flags)
 {
 	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
 	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..784128c79e6f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2089,7 +2089,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	INIT_LIST_HEAD(&cc->freepages);
 	INIT_LIST_HEAD(&cc->migratepages);
 
-	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
+	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
 							cc->classzone_idx);
 	/* Compaction is likely to fail */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e823bca3f2f..ef790dfad6aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4182,7 +4182,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 		alloc_flags |= ALLOC_KSWAPD;
 
 #ifdef CONFIG_CMA
-	if (gfpflags_to_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 #endif
 	return alloc_flags;
@@ -4632,7 +4632,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	ac->high_zoneidx = gfp_zone(gfp_mask);
 	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
 	ac->nodemask = nodemask;
-	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
+	ac->migratetype = gfp_migratetype(gfp_mask);
 
 	if (cpusets_enabled()) {
 		*alloc_mask |= __GFP_HARDWALL;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 18ecde9f45b2..360461509423 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -312,8 +312,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 				continue;
 
 			page_owner = get_page_owner(page_ext);
-			page_mt = gfpflags_to_migratetype(
-					page_owner->gfp_mask);
+			page_mt = gfp_migratetype(page_owner->gfp_mask);
 			if (pageblock_mt != page_mt) {
 				if (is_migrate_cma(pageblock_mt))
 					count[MIGRATE_MOVABLE]++;
@@ -359,7 +358,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
-	page_mt  = gfpflags_to_migratetype(page_owner->gfp_mask);
+	page_mt  = gfp_migratetype(page_owner->gfp_mask);
 	ret += snprintf(kbuf + ret, count - ret,
 			"PFN %lu type %s Block %lu type %s Flags %#lx(%pGp)\n",
 			pfn,
@@ -416,7 +415,7 @@ void __dump_page_owner(struct page *page)
 
 	page_owner = get_page_owner(page_ext);
 	gfp_mask = page_owner->gfp_mask;
-	mt = gfpflags_to_migratetype(gfp_mask);
+	mt = gfp_migratetype(gfp_mask);
 
 	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
 		pr_alert("page_owner info is not present (never set?)\n");
-- 
2.23.0

