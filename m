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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E70C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F9D207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuabhevI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgERBVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD2C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so3550526plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdhvkN9n6gLXPp8p9fdMhb+WcIMgtYO8SWbLKHJyjj4=;
        b=MuabhevIbTfQchpQvS5cn2iMMKfM/8aBJ3m/YWbNcOt3/i4wK1bg0d9kj3pSzWUOFW
         xaA023MDC/j7WagLjaLtIL7MK8mub3C3Se23T4C+Z2+Ke15npDeZuBRJa1Il5vBCzZMI
         T08r5KWO+PDfI5kwN5lpw0VjQpzrRXf6ywfshsZ3lPTVPI7/yYzDFNiGpeys0fD3bec7
         pFSy3PJokHLHLpU5dCUFMqgGUeelgDS1fRDGtqCMDiMV13LjHvy9oLCUZJWz6ecwjlqS
         Yd2hp+W3dFu/dFKabSf3HALmnjDVHJZf8dsVeEwLcObCYEJh8YS7YdwQCLNhiF+WUuuR
         s/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdhvkN9n6gLXPp8p9fdMhb+WcIMgtYO8SWbLKHJyjj4=;
        b=lwXZl91N2ex//E7pj2gKVX8bhhL1htTfE+YDxrZ0kqT0gN/GK6HNJ9OWp/nxicMGNQ
         c5SczD2bl8V2lEvNaRS8mgQrWSEBJPxFMOGrVYwSayXomgUgB0I9UELIke2tNzyzmJ4f
         Rj0fz/zyoU0ceZfWQIG2030xU12en2acIBpQb6xqaMkd/vO5RCV2Z5fSO6vU7JfSvScV
         4VnGBvt/mhXGPN+p/hScG0UMroX9owZoCOQa6OjnSeoCX1mXTOmbJed2C2ST2CjaP4kV
         VIrs4s+AMbMpafGL8ZTQhroLeb+JAVI/JMwc7axNVmU73O+1Ecn+hwKKgWL+ykmDplI/
         cZTg==
X-Gm-Message-State: AOAM530oWzP5zLQRpDqw9la9/FBm5tJlpe2LmQBVZ0LKvdDnc/YYXRH8
        UfxVGMIBNAJvCscL6xFpsUo=
X-Google-Smtp-Source: ABdhPJx9mnMgjeutTyZLT+Z8mO/ZGkK19uLNJJsY2u/Fcns2KKXtmE2mLWv428N5YmcR5IoOF2ZaKg==
X-Received: by 2002:a17:90a:eacb:: with SMTP id ev11mr16142233pjb.80.1589764906444;
        Sun, 17 May 2020 18:21:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:46 -0700 (PDT)
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
Subject: [PATCH 02/11] mm/migrate: move migration helper from .h to .c
Date:   Mon, 18 May 2020 10:20:48 +0900
Message-Id: <1589764857-6800-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's not performance sensitive function. Move it to .c.
This is a preparation step for future change.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h | 33 +++++----------------------------
 mm/migrate.c            | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3e546cb..1d70b4a 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -31,34 +31,6 @@ enum migrate_reason {
 /* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
 extern const char *migrate_reason_names[MR_TYPES];
 
-static inline struct page *new_page_nodemask(struct page *page,
-				int preferred_nid, nodemask_t *nodemask)
-{
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
-	unsigned int order = 0;
-	struct page *new_page = NULL;
-
-	if (PageHuge(page))
-		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
-				preferred_nid, nodemask);
-
-	if (PageTransHuge(page)) {
-		gfp_mask |= GFP_TRANSHUGE;
-		order = HPAGE_PMD_ORDER;
-	}
-
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
-		gfp_mask |= __GFP_HIGHMEM;
-
-	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
-
-	if (new_page && PageTransHuge(new_page))
-		prep_transhuge_page(new_page);
-
-	return new_page;
-}
-
 #ifdef CONFIG_MIGRATION
 
 extern void putback_movable_pages(struct list_head *l);
@@ -67,6 +39,8 @@ extern int migrate_page(struct address_space *mapping,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		unsigned long private, enum migrate_mode mode, int reason);
+extern struct page *new_page_nodemask(struct page *page,
+		int preferred_nid, nodemask_t *nodemask);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -85,6 +59,9 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
 		int reason)
 	{ return -ENOSYS; }
+static inline struct page *new_page_nodemask(struct page *page,
+		int preferred_nid, nodemask_t *nodemask)
+	{ return NULL; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 5fed030..a298a8c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1519,6 +1519,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
+struct page *new_page_nodemask(struct page *page,
+				int preferred_nid, nodemask_t *nodemask)
+{
+	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	unsigned int order = 0;
+	struct page *new_page = NULL;
+
+	if (PageHuge(page))
+		return alloc_huge_page_nodemask(
+				page_hstate(compound_head(page)),
+				preferred_nid, nodemask);
+
+	if (PageTransHuge(page)) {
+		gfp_mask |= GFP_TRANSHUGE;
+		order = HPAGE_PMD_ORDER;
+	}
+
+	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+		gfp_mask |= __GFP_HIGHMEM;
+
+	new_page = __alloc_pages_nodemask(gfp_mask, order,
+				preferred_nid, nodemask);
+
+	if (new_page && PageTransHuge(new_page))
+		prep_transhuge_page(new_page);
+
+	return new_page;
+}
+
 #ifdef CONFIG_NUMA
 
 static int store_status(int __user *status, int start, int value, int nr)
-- 
2.7.4

