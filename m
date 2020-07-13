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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB94C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B020720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvB99VW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGMGm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3898C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so5759699pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WCuo1hnAUaO0+Z2p2Fsc+u9rGTZbpOKXHgrmd/p494=;
        b=fvB99VW/LWQ5I3IASm0gYYQ6DoiaRRGaNC9niBODuOfHie6auT8YHer0bkt4y7nkQ2
         gVVGcwUlCLQHebNSvPSM/PKKZsNFfEXvDraKyFhVbqhJJ4EcHreYdByivy578CS1anXK
         IAI+A7tQdGIDe0oPAyqkEpmrca0Wy8tLKhceRPywiKuNCCAVxA25leIDZbGDZBsFALSI
         +NMV0k2mhVMSfvlBA7XEdsK1PB1JvyKjly5TVLLSfPCSEh3EEtd/23wgg958ul6eU0ap
         DzOQ4+2u3IQ9WMr9YcTwMoAkOratsaU7eInmC3B6HXioHd4bR/X/ICJhVRpO7VLqAWZI
         2f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WCuo1hnAUaO0+Z2p2Fsc+u9rGTZbpOKXHgrmd/p494=;
        b=rVdRZ/9wknHI36QDjQDVo/rHmzSYutMeS0ALjtosb2tlIX7S9v/JoRxiRKqaETTFgz
         9ZoJsz+Iib14i0/5JWA5Cx+j+RVlUdC6UsnirztGdrUggidBcteQVbJFUkJoRtx+vfPk
         iOs5JI+GEDvXVqNdys9hOfn8zDmQ6HcLE7JxlKoG4UMRZr7qAxqMZOqpDk98bpd9L2wv
         el60ME9k/VFAcs44n1OqEPM8azQkyZaPFTA/JZN8sCvEFH+AfjiNOQqZ1CLgT1CBXDU8
         OsViO6/0+AtixPGsnP7xaNtBQ8rNwacedAPkg8NLs5lKiy8YNtnLy7OegMufI6mxU4q0
         ZrAw==
X-Gm-Message-State: AOAM530yqQHHQ2sIuGVNKKNYvFV9OFtJuy2vnibhwmwIHDdNA8LIlaSo
        8grykiXYBkiT3EMvqY0IHyt9T4ZU
X-Google-Smtp-Source: ABdhPJzNPX2G4NvuWUMTHo2kR7+iy2ba5GxYclH4gWjIX99gFAuDxqS0Jf54uf9Lmgo1ME25ffWddA==
X-Received: by 2002:a17:90a:d912:: with SMTP id c18mr18273943pjv.184.1594622542591;
        Sun, 12 Jul 2020 23:42:22 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:21 -0700 (PDT)
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
Subject: [PATCH v5 2/9] mm/migrate: move migration helper from .h to .c
Date:   Mon, 13 Jul 2020 15:41:50 +0900
Message-Id: <1594622517-20681-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
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

