Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C626C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E662720772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJdc2Dds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgFWGOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFWGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4173C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so9599190pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+MVtWxNOjft+jnGBXpp4pllO9Ogv4crRgAM5bysUzc4=;
        b=vJdc2DdsINl4/duViwymAa2D/kIoWhki7coFXXsCJJ/saKbX3fjWfBe+ncAeJT/iEF
         joiD9mYpK1OxlPN5G3lrkNXEwY69XOkf6CpxNLD2W8cKodX6CmN/krlcq5WBd2U2hr7l
         ADmF5eBwGoqNB1DTHnA8g7uSeMPNYWD2mnKtuDL+5pLD1LrWYBW8pW3SF6oPxAzMmmyE
         cwsC/cLfoBN/CZKMLzVmSWYQ/74kyg/YY3MX8ozzeDxIFkkhhQ4pEDdDiA+Z9RhAMj6i
         5R7c/FbCx8+F38QkX2+1lQFgFNMhg6fR34RrDexlw/mxbxIVDnk1umcTaaBoeJ4Yq8x6
         V6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+MVtWxNOjft+jnGBXpp4pllO9Ogv4crRgAM5bysUzc4=;
        b=KtPAbKY8ZXfl7nDuAREeSJPhQXvirjvCBe3Ki44K3ocHFzHEAIWZC63WKVz8vEf4T1
         wDcHqp7fBXfzOJXr/UvwFu4e4M2tcvAZ5565mItsXMems+12lYZ+iM7eQ6qHVAE/TFaR
         X948Ftc3uJhwe5lsdicQS72bD8VJqcZcIhAIMX7nDN0fn0PGP0Z2cbIMLwRJNxo4BGFo
         x3l+OuaaGq6fPndYmO4QZZJRvxCu66qIKxyPxSRlS2KWSoAvn/cqs6HooB1SykPUyK56
         SkAeKPb7rmzph4fooyvlcPQmukQ7jgtLZt5Y0Ad0RvU4EPzYjlhnQku1K2s7L3LC9gHL
         wHvg==
X-Gm-Message-State: AOAM530CmKIQxXtnFEgH8egdIohRE/Kf9NOMtYZhvLmsDqPvitiCYGAE
        2v5dZMOlQN4HScziG1GiXP0=
X-Google-Smtp-Source: ABdhPJxvGPPxCMlACeH3Qo4G5gtuVjR48+Qt5rn3qikPJKHVLEIXNh/BCaT2G+RN58qcSRYI0gyW+A==
X-Received: by 2002:a63:af50:: with SMTP id s16mr16564252pgo.365.1592892871363;
        Mon, 22 Jun 2020 23:14:31 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:30 -0700 (PDT)
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
Subject: [PATCH v3 2/8] mm/migrate: move migration helper from .h to .c
Date:   Tue, 23 Jun 2020 15:13:42 +0900
Message-Id: <1592892828-1934-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's not performance sensitive function. Move it to .c.
This is a preparation step for future change.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
index c95912f..6b5c75b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1536,6 +1536,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

