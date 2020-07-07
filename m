Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1048F2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpdQnD6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGGHpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGGHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB634C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so19638849pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WCuo1hnAUaO0+Z2p2Fsc+u9rGTZbpOKXHgrmd/p494=;
        b=JpdQnD6k+V6ba5PJn/GrzAKU8muopio2PJq0dEuINtMXUp48S0FwmS1wN3Sai0ljZw
         z71aGQQ4r6ZE1u8JElbTPLyNJKx8pf93ZwWNVTKDtctBKFF4BWtZyeGv0+GucY7G8rBO
         Mir/s2/7JliyHxd2sZRknrGQArJl4UPeAIrFclivu0xtDNgAKJVmFnwXT93lhBzBxPgN
         /cUslNQdthBxQ5zq9vpo8rzLsKLqjw2LjuMEsTRuV53CHAcTOBXdIilBWKY0ILAAdL4e
         30LoJCBza9OC9SVBhLXtbQoURT2ThQN9mVyM7UGF/AfDf0cJyGChRiryVsPc4JnKZaQX
         EBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WCuo1hnAUaO0+Z2p2Fsc+u9rGTZbpOKXHgrmd/p494=;
        b=YGG/qy641JAzPr/cNyu/RhSBGEkhvt2PtT05yXIsAeUi+ZmouHe+z1y2BjKTWUajgu
         W5jEh2xDiY/kFg0iA9IJbpguBTLrF2403KTEQ8yuKSDoC6RpCqeHipfGEHAgDphZYO3d
         ffaNpUycFmiaaUDOMJ7tCLUxc6K5sWJQ3AqyLtz1g3OQPyWWbJrRaXVuGatbDixyLR2b
         x23T2BcIkylyGzRCPMmV2xD/t8ND3lma0e2afRFs1pKZwbQR4wc9QaYmIp996IJj6KNE
         VykiRqrai7QBREwpASrAPDhILkCI4FuuJZOOeU2NXLYkYw6HYdBw2YOQg08Q0zNPfg//
         G7Yw==
X-Gm-Message-State: AOAM530FSep2vbWIwcsa0ThuHPcs1acDBc4QhOsqL1VSqqkXoWpm42H9
        w8ZoaGgkwiKR8c1wjwT6A00=
X-Google-Smtp-Source: ABdhPJwTRoCvXaC3wp8nMbfqXJZdgd11trQAs5VSp1+5X4PUATzPS2jov1YpYikkz7vOR6F0MlfZOQ==
X-Received: by 2002:aa7:9736:: with SMTP id k22mr46221449pfg.62.1594107917231;
        Tue, 07 Jul 2020 00:45:17 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:16 -0700 (PDT)
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
Subject: [PATCH v4 02/11] mm/migrate: move migration helper from .h to .c
Date:   Tue,  7 Jul 2020 16:44:40 +0900
Message-Id: <1594107889-32228-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's not performance sensitive function.  Move it to .c.  This is a
preparation step for future change.

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
index d105b67..7370a66 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1531,6 +1531,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

