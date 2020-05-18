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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32654C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071AD207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ZwSIMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgERBWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgERBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so4064735pgb.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tK4U7isuNc1L5J2aGZLuInkmuw8DqNCKJzG8CU9ZYFs=;
        b=E7ZwSIMmH6P8ZPBcOQfqyXmFDWq+HehSfLxpuDA4qHAVd9ukCtQfvxx7S93GtpfSr8
         dPjJq4FsbL3qqGvyD57C8/THom8Wac66YCO42EZ6Psu5tiPqHt29KY2GrNzm4tUqE2xZ
         FGpC/fsqeTTd3a1Fh3c/zus6s+NUpGCkphBZ1xyGBdL3mFvTyuCGLXNIElbJ6WbCF98i
         jzB0FdzVAJacZ5QqFePf0D460dBUT69l+TEB2i0X2xM8mCpSVeCJSvB5bNow+4rZTDWr
         aycAcceJLF9t7pifBjtDK/GyOVz9sMpESGs7ilN+d0qk5LbhunvnxmjlzmZybQ/QWsOF
         xqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tK4U7isuNc1L5J2aGZLuInkmuw8DqNCKJzG8CU9ZYFs=;
        b=AyJpkWzdR8654lvuSSxUWtptEIzb/LUPJgM5JH5UTYby/Y8u5wq1/MqfiQz/zir0lR
         d7yEjz/bmFR1S+UCzE9EHNwO6+gP2+7bixd7bo0OD8PZkQ0ojlle54lypLOuHZTYoLEY
         LgxfSclQNUc6fJKXAMtY87St3XwBncUGTTPThdt3iUoZA2PEXZkb3SPlQN5OlVWjiYx1
         afbHqjpl0gnWjYMVokssF++FLJthHJMRIh2kY3dI8TjWaudZkDjDq8Kd2h2c6E2mo3Hw
         u8PtF35lWnfqBrQ/Ep01U5GaB5A96RSMC2eN1dIFOpR4DcAu6I0c8FlbpwCUnt6nu//x
         PFTA==
X-Gm-Message-State: AOAM533QYVJY88TG1RwRqX1JbtVK//2WamwmUUeGAz5UFmcFuaVY7zyJ
        +VmsdUe9uNvxKWKUpF4mi/ef21X2
X-Google-Smtp-Source: ABdhPJxFZ9JSbKcpTJVti63DQlE4HO3bBBYCHnEunJ+kKmGdRZXaLdyvNFaiwoBGrEBHbq87nzKQpA==
X-Received: by 2002:a63:2f41:: with SMTP id v62mr12895534pgv.178.1589764935068;
        Sun, 17 May 2020 18:22:15 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.22.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:22:14 -0700 (PDT)
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
Subject: [PATCH 11/11] mm/page_alloc: use standard migration target allocation function directly
Date:   Mon, 18 May 2020 10:20:57 +0900
Message-Id: <1589764857-6800-12-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index afdd0fb..2a7ab2b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8288,6 +8288,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	struct alloc_control ac = {
+		.nid = zone_to_nid(cc->zone),
+		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	migrate_prep();
 
@@ -8314,8 +8319,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
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

