Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC38B2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlJ9wcYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgE0GqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgE0GqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so11407414pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JFHlUj79R0JVLwq3d/Y7eWo9W15UBnU9tI9eUuzxnE=;
        b=TlJ9wcYie1e+tvk5v3Z4qtoxNiG8tpHbu+y5nv/BqGPSQ1va6XPpsUUXQIYYQwrgT3
         WzvMJGNiOCM6Mjr3wuHtTXlSGarBX5SbZRIjvKuIUTGPhXRJEYgbdkVe0D/YfyyTiz2c
         acWkCjxNOgd1rW7NM2G9k+TbZIXpyCWArOb+t94Jb1ZDkY2xMpX9g9X8Dyk1UtzJB4/f
         ASM4AXj+XNPz/JZfAjXlqRxWd5PkQcwNbCVlEuhMsWunPTD36Ybw5cVcC8F091DEHOUQ
         WS6l1kF8msyVq5Vl06i9t7OfueN5MsoOaJ2E9jZ5f0VzmGKeogahjPh0znlB+++pq1b8
         6keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JFHlUj79R0JVLwq3d/Y7eWo9W15UBnU9tI9eUuzxnE=;
        b=smJU3UCtDVenbzjmE1iwxnPW23baM2AXOTyOuIwHd0DECFQXSbvkfA24pXRg2MyN6B
         8N9a5aun515NIUafduHBwqHeB/IVXQDdR+gip4uJXrb0pgrGvWER+GrT+z5zItat1sSX
         lyTfSsA0Lq2Z7Uccj+1IxRtfeihSv7EKvSthuofzyhHFyp/GMDvdHMEkFVNhEDGrhbIa
         PmZudTRQOXneLiuyucJgpKBgutN5gKpXOkpDYMNXwjJly7Mp4n3UF5VPERV20SKQ7oPp
         cehjxIXEqcWDq70cdwPZFSLnuxBlX8taBd7Cys3mUbP7YmY5erexzADP9C3oHiRPbD4t
         dqAw==
X-Gm-Message-State: AOAM530bIYqnppal7CiWhNRn0g7NPUwYOeQoONRzdWThZ/QeMXwdpIl0
        rzk7/pil4SnRU/q90tM8yq4=
X-Google-Smtp-Source: ABdhPJwwP+nJTOUtjokOeo3o7ujsXWVHXIXGtjVFvZn7FAMLLbDCpTF59s+9BOX5ZEO3X07Q88Ezpw==
X-Received: by 2002:a63:e454:: with SMTP id i20mr2581612pgk.440.1590561972312;
        Tue, 26 May 2020 23:46:12 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:11 -0700 (PDT)
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
Subject: [PATCH v2 09/12] mm/migrate: make standard migration target allocation functions
Date:   Wed, 27 May 2020 15:45:00 +0900
Message-Id: <1590561903-13186-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/migrate.c            | 24 +++++++++++++-----------
 mm/page_isolation.c     |  3 ++-
 5 files changed, 22 insertions(+), 17 deletions(-)

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
index 0d5d59b..a75de67 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1639,9 +1639,10 @@ static struct page *new_page(struct page *p, struct alloc_control *__ac)
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
index 9d6ed94..780135a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1537,31 +1537,33 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
 		struct hstate *h = page_hstate(compound_head(page));
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

