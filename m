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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B228120772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj4ZQbEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgFWGOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgFWGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so9375548pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RmnA1PFbRGGmJvObeVD1ZMw+BYis2vfr/Z0grw07WKA=;
        b=Nj4ZQbEgVVzZbOfRuxkyuT93Tk06HY9ZX5tEvbbL76EUCgqh5OUGp+AqxcqL9U9FT0
         4ArB6SMRAHR0YUQJv/9ToBrbY8t0BX0BWq/7gtRis1WR6FoOQKtr5l7M48/oEmybefOA
         U1WqnC73kIflW7uhxec1zLNe6MRIdHUjyooA0+IhpSMrW91FxFrvKRiS8rwgJjOoRBdC
         ClpuyT5FOkM2/ZWdv4rg2ufcFn08Kqr/pPLsoYaD97+9rEnc8Q1IeOCyJvzUQ60dTqAD
         HD7CKFSSSMqgJ7hmfCBO5u7baSS96Zl4OGkrJNpGoTqp4lD69ExDONhAZiOnWgUGv0ui
         +14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RmnA1PFbRGGmJvObeVD1ZMw+BYis2vfr/Z0grw07WKA=;
        b=WYy+ppMdu3DpQ7gFMhrVk3UtK8xfJVD0E3H2LQMaf2/dqD9pYWdHeR1TcMoHE6q2v/
         47wQR2q1utJXmVZz8fV8pTeY1zAOaCBU2lpAFtGKm5gibxXfJSRrdfmLn4MCTiIhjB0f
         JQkW2+jXV4plYgRB02HrIBEzzHzLR2OeDth18CcO1+oavylD4uLXFQhD1YaDSYGM0LJ3
         d4ED4iNF4siQuzp5+rtMF7ahA+kJONBTgN94QNiNMS02GxfHzzKlqmSyh6yVsGRmpL7B
         C1s7MKu0Ryug+Rzcshf9Xg9AqPwaeBtu8eCPl1XwGRYXOt8omF4HKYGwZjiIOcIJaS6o
         tP5w==
X-Gm-Message-State: AOAM533BiocnNBcVR1lHqZtJ5Rgmi9sIkuZYNRD2LrRfgWK+4nGvcc8c
        zjdcRkq67/obj8BTILN2rRY=
X-Google-Smtp-Source: ABdhPJytICau7bDEw5XuijMhkeXwsIk6IG1vYY6Tyvn5BeRX/4cv9qvLfNoROqzb+sdksxVAAVtPKA==
X-Received: by 2002:a63:8f58:: with SMTP id r24mr15413541pgn.379.1592892887953;
        Mon, 22 Jun 2020 23:14:47 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:47 -0700 (PDT)
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
Subject: [PATCH v3 7/8] mm/mempolicy: use a standard migration target allocation callback
Date:   Tue, 23 Jun 2020 15:13:47 +0900
Message-Id: <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback.
Use it.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h  |  1 -
 mm/mempolicy.c | 30 ++++++------------------------
 mm/migrate.c   |  8 ++++++--
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index fb7f7fe..4f9f6b6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -613,7 +613,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
 
 struct migration_target_control {
 	int nid;		/* preferred node id */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a3abf64..85a3f21 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1065,28 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	return 0;
 }
 
-/* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
-{
-	if (PageHuge(page)) {
-		return alloc_huge_page_nodemask(
-			page_hstate(compound_head(page)), node,
-			NULL, __GFP_THISNODE, false);
-	} else if (PageTransHuge(page)) {
-		struct page *thp;
-
-		thp = alloc_pages_node(node,
-			(GFP_TRANSHUGE | __GFP_THISNODE),
-			HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	} else
-		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
-						    __GFP_THISNODE, 0);
-}
-
 /*
  * Migrate pages from one node to a target node.
  * Returns error or the number of pages not migrated.
@@ -1097,6 +1075,10 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	struct migration_target_control mtc = {
+		.nid = dest,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+	};
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -1111,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
-					MIGRATE_SYNC, MR_SYSCALL);
+		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 7c4cd74..1c943b0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1590,9 +1590,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
 	int err;
+	struct migration_target_control mtc = {
+		.nid = node,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+	};
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
-			MIGRATE_SYNC, MR_SYSCALL);
+	err = migrate_pages(pagelist, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
-- 
2.7.4

