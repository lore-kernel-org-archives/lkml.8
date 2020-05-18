Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434F3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF072207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUjdtCUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgERBWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgERBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13037C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k19so3541553pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6uPPKA46HFm7qd/ohf4EnpdbNdhoH4yr+ZK/CbIpQY=;
        b=sUjdtCUxRDga2htnkeilcDZoqmFmobZHCGxrgS0Br9In4PWlmf6Z/PFqIAzqH+seLk
         rCS7fNPywxBVBEBaVHjrn9/pt04qc+meM+YkAa7XUMep4VxFc3L38bAddl/1N2O3BDtY
         UAIKFCfHQ1PSXBcLD5m0osrPhTZ5a1Mo7W/vJSoFwftVaGUX1QFsQA8dshzv26YRnuD7
         C4zzBKyR/uj6DajCgOwXgEMjx5VATdJGKi340F+FRjqud4sDvNqCFF8zmWtTNm0ptPMc
         CBvcQtDgAHztV97n7f3wsubXb0aPjpNlegUUinn/QvXD8uGc8uZjR34WSau2nRW73S29
         yQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6uPPKA46HFm7qd/ohf4EnpdbNdhoH4yr+ZK/CbIpQY=;
        b=MVuN0/+1V/k7gNTdp6FSyfz4lvQS7OiSq+M0t0Dmn0xxBFpqWZNimerlw4YftnKLO5
         Z1lqyUrqXAPdzUOW3Mn6T0K+EBWWzu0qEC/73izuouHsbgkXAoeVHqtdqxYVYwsoMBV7
         Iz1ilWDXMhKokzrhR+CfgpZ1uz9RnR9FP8GGFfhcEBJz1rmkDLgo2dxaAdlCPsOWjHb5
         HPgDEX9ej/cQbYJfyV+vYZPnKtzrEthph7oul9a594aTbNRixhYpMcqx9zYavJoVRI6L
         q8eZwkfNGFKBYgzAnCN0DRIGfk23/FeRoYkeQzR3Kz0M/2df8WMu2+eDoXVjzt5rzt3G
         zNNg==
X-Gm-Message-State: AOAM533RXs27Oiwmes63UgOd2dImFvUw1TDG0Vta4F7bSwlA5rzLRaEk
        1DQ46tjRMQdfkKWPViQ68N4=
X-Google-Smtp-Source: ABdhPJwcP/wE3o2VggFkMMVemZRp109/1GcCE7J6JTY4IKDn6RKA/YxRhsLiAM3v8mqflLnX8qexdw==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr13714077plb.94.1589764925541;
        Sun, 17 May 2020 18:22:05 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.22.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:22:05 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 08/11] mm/migrate: make standard migration target allocation functions
Date:   Mon, 18 May 2020 10:20:54 +0900
Message-Id: <1589764857-6800-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There are some similar functions for migration target allocation. Since
there is no fundamental difference, it's better to keep just one rather
than keeping all variants. This patch implements base migration target
allocation function. In the following patches, variants will be converted
to use this function.

Note that PageHighmem() call in previous function is changed to open-code
"is_highmem_idx()" since it provides more readability.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h |  6 +++---
 mm/memory-failure.c     |  3 ++-
 mm/memory_hotplug.c     |  3 ++-
 mm/migrate.c            | 26 +++++++++++++++-----------
 mm/page_isolation.c     |  3 ++-
 5 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 923c4f3..abf09b3 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -40,8 +40,8 @@ extern int migrate_page(struct address_space *mapping,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		struct alloc_control *ac, enum migrate_mode mode, int reason);
-extern struct page *new_page_nodemask(struct page *page,
-		struct alloc_control *ac);
+extern struct page *alloc_migration_target(struct page *page,
+					struct alloc_control *ac);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -60,7 +60,7 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
 			free_page_t free, struct alloc_control *ac,
 			enum migrate_mode mode, int reason)
 	{ return -ENOSYS; }
-static inline struct page *new_page_nodemask(struct page *page,
+static inline struct page *alloc_migration_target(struct page *page,
 		struct alloc_control *ac)
 	{ return NULL; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3f92e70..b400161 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1626,9 +1626,10 @@ static struct page *new_page(struct page *p, struct alloc_control *__ac)
 	struct alloc_control ac = {
 		.nid = page_to_nid(p),
 		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	return new_page_nodemask(p, &ac);
+	return alloc_migration_target(p, &ac);
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 89642f9..185f4c9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1249,7 +1249,8 @@ static struct page *new_node_page(struct page *page, struct alloc_control *__ac)
 
 	ac.nid = nid;
 	ac.nmask = &nmask;
-	return new_page_nodemask(page, &ac);
+	ac.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	return alloc_migration_target(page, &ac);
 }
 
 static int
diff --git a/mm/migrate.c b/mm/migrate.c
index ba31153..029af0b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1519,31 +1519,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
-struct page *new_page_nodemask(struct page *page, struct alloc_control *ac)
+struct page *alloc_migration_target(struct page *page, struct alloc_control *ac)
 {
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	unsigned int order = 0;
 	struct page *new_page = NULL;
+	int zidx;
 
+	/* hugetlb has it's own gfp handling logic */
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
-		struct alloc_control __ac = {
-			.nid = ac->nid,
-			.nmask = ac->nmask,
-		};
 
-		return alloc_huge_page_nodemask(h, &__ac);
+		return alloc_huge_page_nodemask(h, ac);
 	}
 
+	ac->__gfp_mask = ac->gfp_mask;
 	if (PageTransHuge(page)) {
-		gfp_mask |= GFP_TRANSHUGE;
+		ac->__gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
+	zidx = zone_idx(page_zone(page));
+	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
+		ac->__gfp_mask |= __GFP_HIGHMEM;
 
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
-		gfp_mask |= __GFP_HIGHMEM;
+	if (ac->thisnode)
+		ac->__gfp_mask |= __GFP_THISNODE;
+	if (ac->skip_cma)
+		ac->__gfp_mask &= ~__GFP_MOVABLE;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order, ac->nid, ac->nmask);
+	new_page = __alloc_pages_nodemask(ac->__gfp_mask, order,
+					ac->nid, ac->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 1e1828b..aba799d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -303,7 +303,8 @@ struct page *alloc_migrate_target(struct page *page, struct alloc_control *__ac)
 	struct alloc_control ac = {
 		.nid = page_to_nid(page),
 		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	return new_page_nodemask(page, &ac);
+	return alloc_migration_target(page, &ac);
 }
-- 
2.7.4

