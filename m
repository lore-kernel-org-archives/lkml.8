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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D741C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F4D20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBwgNec4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgE0Gq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgE0GqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF1EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so1497204plt.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVdVVfxhZvfnyL0MAVnSG4rUWF/WkfXZ+WWr8J5EunM=;
        b=WBwgNec4uNhh7ME9Y8eO7A+vnQ3wXjHclbvB0q51ijklLhHwIOkVoQZmY/T0+La8eA
         rLf6rCdVKJIaXoS08XOuOqRx7XWzDrWMS2caaV4VLH5VTNwZLUScW9Nim5/9y2MIy80D
         GxcDsz3hv1q8KVDPBwB+boOXsJKTBKgppy7iE+QPbzjsDjbES3pkUbUb1fBEUJtWulwx
         Ppx8Lp5tDdW6QD6mfyjkx1LM+IYxxPH2b2vGZcVnV6jrjvI/vIu3vQ6r0EHlczw+sdBN
         eyqKkWtqsUK9VGS5mIW2dS9bzNCkrXEWgro/Xc/G1vfvE6i/XV6KS3yQE3vkq1X1k2B2
         EGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aVdVVfxhZvfnyL0MAVnSG4rUWF/WkfXZ+WWr8J5EunM=;
        b=N57rzZCCoYDk/Ob57BAFg2VOVpPcD3bXTn0Ii/W9YbXfL1UQS9fS/KZ6c/l6C0ISqb
         xiHEhA3ATvUAflOEIDX84RqqzT6RMT3qEN745/0ax4p9i0YFnkp+Itt21hqypxmlO+9n
         yavj9SVkD7Dp5O3EPk+OqQyb1HkEJlQexeS2mFu8qdwLwb8ey/kG1Z6kWsiN79hbLhDQ
         rapvznPHsLABjSK5vkTdztOjQD/Pv8tXh8+w9xrb6xWjNdeM1gz79EeRiK2OqSARy38o
         jToHslPfXzWage6GaBA1khZ0H/oxhoH4kHc2dQRwRgy+5hiDaf68VkujOhCH1dewKGUe
         bmAA==
X-Gm-Message-State: AOAM531ZzzEa7+zm1FcWe8mXfvVh3c7wzl5ARLwcDPH2FJRGdwjnX6kf
        97uxGuxE7DP5d2oD/GonpAM=
X-Google-Smtp-Source: ABdhPJz7nYNIfgZiwi7ETzJTmgtEPvU+hH3xTK4PtfDi/TZOpiSqviLZpd0lF3u/LFynLmll3+kF7A==
X-Received: by 2002:a17:902:7c90:: with SMTP id y16mr4225057pll.75.1590561982027;
        Tue, 26 May 2020 23:46:22 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:21 -0700 (PDT)
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
Subject: [PATCH v2 12/12] mm/page_alloc: use standard migration target allocation function directly
Date:   Wed, 27 May 2020 15:45:03 +0900
Message-Id: <1590561903-13186-13-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no need to make a function in order to call standard migration
target allocation function. Use standard one directly.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/page-isolation.h |  2 --
 mm/page_alloc.c                |  9 +++++++--
 mm/page_isolation.c            | 11 -----------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 35e3bdb..20a4b63 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -62,6 +62,4 @@ undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
 
-struct page *alloc_migrate_target(struct page *page, struct alloc_control *ac);
-
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9803158..3f5cfab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8359,6 +8359,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	struct alloc_control ac = {
+		.nid = zone_to_nid(cc->zone),
+		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	migrate_prep();
 
@@ -8385,8 +8390,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
-		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
-				    NULL, NULL, cc->mode, MR_CONTIG_RANGE);
+		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
+				    NULL, &ac, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index aba799d..03d6cad 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -297,14 +297,3 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 	return pfn < end_pfn ? -EBUSY : 0;
 }
-
-struct page *alloc_migrate_target(struct page *page, struct alloc_control *__ac)
-{
-	struct alloc_control ac = {
-		.nid = page_to_nid(page),
-		.nmask = &node_states[N_MEMORY],
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
-	};
-
-	return alloc_migration_target(page, &ac);
-}
-- 
2.7.4

