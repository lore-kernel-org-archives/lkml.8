Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A51C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E1A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shEu22P2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgGMGmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgGMGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F54C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so5608941pgv.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3uBP2PMxjhLbF/Qn6q1UBEwi29LNMNdydYz1iguy44=;
        b=shEu22P2JCmXlIIFbQ38vJWAUx4gInp3gxoVw4iwmwo1mZaIbkEONC/XBFxYprb/nU
         YtaTTgu8vwTKy44PKXsrTXTqMcJJ8F6x9UHSM7a5oqU4qGIUFCvWUTtrhsMqKoJs5k0G
         PdNYlGmwSduhF82avB4fixx/okO4YsXzQmP+1T3CxzOEn9Gj3fHkivQapqwaWwID2Mm4
         YQD5wrmwhPC858Mk3YXSUPdMyjm6SUkFzJuqmp2vp4JMACxQnVujgzwHtYoRTl9OvH7j
         U05dK8Mdu6OAtGHz6HDsLnR0EmNjP9689BJrpmZEz7Tyny/s22VWYwyRVVWR/BESD9Sj
         0INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3uBP2PMxjhLbF/Qn6q1UBEwi29LNMNdydYz1iguy44=;
        b=o1RKFv302HSw8r85I39GbLC+wMORs2WzhX3+q9RYWPowbWnwcM1rmDFNF5s1wHBvOf
         Jfnn8qQieACkUHRFLf4muYDrn7gCgevzy3AqQgHg4Nnok9K6XeB63mt58m4Lo7wGBF3o
         O8P9tc02ZIQNtWsAUNXKuIcKKVBYZIAU6jHCdJ9NtJp4vvCtpl19SJFHKUiajWSD7GZu
         vy6pk47KlFkhXj1pHpp0cxgZyxpy+iCNh8c567UiiPhxpKK/7nyr9JNze1XmU3tJiHpc
         GThOy5fAEAQRzWhKarTzsl5SZJAHj/8pCiWDZzfryJ1gPJbD7eFFzsbZdSiST1slCddv
         2CeQ==
X-Gm-Message-State: AOAM532xxVJJrNsm6hK1fOWua6JaLizHv0yFPlRClubbOfxLZe3sueU7
        A0hmwvPXnRUajPwCGjEG1yg=
X-Google-Smtp-Source: ABdhPJwPpmFYrn1YsAQ6i67c53VPDIBX+BbW5s3FvEk2clA/rAsyvjpKb5hQQV4RXblLbW3xVq35QQ==
X-Received: by 2002:a63:2223:: with SMTP id i35mr6735847pgi.64.1594622554361;
        Sun, 12 Jul 2020 23:42:34 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:33 -0700 (PDT)
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
Subject: [PATCH v5 6/9] mm/mempolicy: use a standard migration target allocation callback
Date:   Mon, 13 Jul 2020 15:41:54 +0900
Message-Id: <1594622517-20681-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback.  Use it.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h  |  1 -
 mm/mempolicy.c | 31 ++++++-------------------------
 mm/migrate.c   |  8 ++++++--
 3 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0beacf3..10c6776 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -613,7 +613,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
 
 struct migration_target_control {
 	int nid;		/* preferred node id */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9034a53..93fcfc1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1065,29 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	return 0;
 }
 
-/* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
-{
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(compound_head(page));
-		gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-
-		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask);
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
@@ -1098,6 +1075,10 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	struct migration_target_control mtc = {
+		.nid = dest,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+	};
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -1112,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
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
index c35ba2a..1a891c4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1591,9 +1591,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
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

