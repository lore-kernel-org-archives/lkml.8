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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6571E207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm5UwG+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgERBWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgERBWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683CBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so3550776plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HXYaPMT+SVgZJKyj+XorbmOxAFnVq7RiQ7gBCNzN/kI=;
        b=hm5UwG+Zx1o4N1ihTvYSjyxBc7/uy2dWCq2ulN17NpxWmVr7Kg63sHo+4FsHYXc+rj
         jVA+TehaieVkUt7meL7EpEKdaLCkSSmvaXZUJ44cHrVSmAOFIPe8J48UmXIaL7Rc2bhC
         GMLIlyx7MMwdq9gSaSph6/S0rR7m22pz3dPmn5QgJPXweDSP/h3YK4mYO6iPIwJ8UMpo
         JyS0Y7zbp2sNY0wLCUtme6wNtr4Lcah9wceoS7cO1zusXHd4lmQ7ea6vE34H0FwXPhpL
         AkeznJkwuNW5OuMET5RFr6Udm1oplUzPDluv8v1dwVeibQdBPwfn8yJ8QxRvifoEF8zw
         GcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HXYaPMT+SVgZJKyj+XorbmOxAFnVq7RiQ7gBCNzN/kI=;
        b=gnp4xU2WfqMo3Re9GT+MM0KUw8ODk3mgIX3/+nYbckUrWIsBzEZPjBKWPixP8JCdHJ
         k9VATlUFnxKhFw9LR3MQKpVxxNgdfkcL0AfhltyDhQyDUe/1l8dJGE8TEsFn6Kn28RqM
         WGb7BHOjpDU6UCRkBK1QvyKMykkh05YHn0JPm4FemKwPCP0pCANsc7DkNs0SRMraiuuK
         FDvZ67Nk0KVvv105Sl3+y1R9ab+rqcUxrx8qA4ceXgwLYBLCDY21mtOj/0iNckbHAkfa
         2cZ7Lcpc21+G+uLPkzd9EMAhyrtN645AGcZJpzwrtU1G6KOEnfOFtyZrvWO2PDRLClCK
         3wOg==
X-Gm-Message-State: AOAM533CJF0t+nQittbM6R5r8mdZza0KNEEsKWchH7+vZcvN4MudORSs
        TTo9X9bEsXT/WBGCpW4KwXw=
X-Google-Smtp-Source: ABdhPJzQLX/QK88KtjHmhxzKx7FYJGgbKyKlaasqEJOPwsmOPrl3zaNCB3La0U1yyYqhwFK4kGSOyQ==
X-Received: by 2002:a17:90a:9606:: with SMTP id v6mr10046595pjo.20.1589764931926;
        Sun, 17 May 2020 18:22:11 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.22.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:22:11 -0700 (PDT)
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
Subject: [PATCH 10/11] mm/mempolicy: use standard migration target allocation function
Date:   Mon, 18 May 2020 10:20:56 +0900
Message-Id: <1589764857-6800-11-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no reason to implement it's own function for migration
target allocation. Use standard one.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h  |  3 ---
 mm/mempolicy.c | 33 ++++-----------------------------
 mm/migrate.c   |  4 +++-
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index abe94a7..5ade079 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -612,9 +612,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-struct alloc_control;
-extern struct page *alloc_new_node_page(struct page *page,
-				struct alloc_control *ac);
 
 struct alloc_control {
 	int nid;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7241621..8d3ccab 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1065,33 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	return 0;
 }
 
-/* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, struct alloc_control *__ac)
-{
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-		struct alloc_control ac = {
-			.nid = __ac->nid,
-			.nmask = NULL,
-			.thisnode = true,
-		};
-
-		return alloc_huge_page_nodemask(h, &ac);
-	} else if (PageTransHuge(page)) {
-		struct page *thp;
-
-		thp = alloc_pages_node(__ac->nid,
-			(GFP_TRANSHUGE | __GFP_THISNODE),
-			HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	} else
-		return __alloc_pages_node(__ac->nid, GFP_HIGHUSER_MOVABLE |
-						    __GFP_THISNODE, 0);
-}
-
 /*
  * Migrate pages from one node to a target node.
  * Returns error or the number of pages not migrated.
@@ -1104,6 +1077,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	int err = 0;
 	struct alloc_control ac = {
 		.nid = dest,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE,
+		.thisnode = true,
 	};
 
 	nodes_clear(nmask);
@@ -1119,8 +1094,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, &ac,
-					MIGRATE_SYNC, MR_SYSCALL);
+		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
+					&ac, MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 029af0b..3dfb108 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1574,9 +1574,11 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	int err;
 	struct alloc_control ac = {
 		.nid = node,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE,
+		.thisnode = true,
 	};
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, &ac,
+	err = migrate_pages(pagelist, alloc_migration_target, NULL, &ac,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
-- 
2.7.4

