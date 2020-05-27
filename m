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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444B62078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUZPhiYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgE0Gpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z26so11407053pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2onm8LGGwx0/W9gKK7Q4b0amq8LV/axU8U38Wddt00=;
        b=nUZPhiYvTO9IWQ8ni6JM7Nslnm/Ks6viszs//q/taDZEdswYosOCQAiVPxhC67h2Em
         tBDiQ7rQGP9cZbeB3z67itHGyPWR+ivwv17grAZiT+uJo71/GNbmYr1wojKLosS6UWkH
         mZBszb9bUrmYU0Uy/nCHJOacAi/2F5qZeIO5FPELaA+kuGwCgjjQzthhq1Cotgio3M/F
         4rTHCqhS3RI8kbTJlzhp7OirQXLsg7GM4i/FifPRMS61u0PF/OX6qqNZpzHD95FJrF0x
         ujNLb0SemrYBA8hJRXH/QoTleaeHJ1QrJmEQF0BUXs48q1Pr90ALYKqxx5kbgOS0buzN
         w+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2onm8LGGwx0/W9gKK7Q4b0amq8LV/axU8U38Wddt00=;
        b=S+UPX2zOETGGnN35nF0gsXGMnnv6QP4CTx0eaSgiVPXgOc+h86IShZTlQWFms/ZrC0
         i0HvlK0wRqqWfV1dGV2NqiMxKVxD+/h7Z3IkDIQtv6BWygvFo0lOdZRgMIW1QJZW7XCD
         XGhdZM74LaPyBHXijg42Jj/iJgv7tJ5f4JA43l7VPVXyXRf5VIYv9lxuiR7kxyZJs4IH
         IIuBjDn8jlyJUh32r12x4miq+PQiVea+8rPgW/6QvmNE7oPXa6uvk2IrSvhitkeTExk4
         r57z4H0f58zfNsYQket+IM7LcJoC/Vz9pHWCNDqkkfQZ+gsNLZ6K5Vvtq5AfqGjSMBwX
         RfIQ==
X-Gm-Message-State: AOAM5315yS9QHNzUK2rU3zS9LeRATJ5Egn8HyasInMZfachwQA+mS+1/
        KMSVYGyAM/EKHkc7VShIKpE=
X-Google-Smtp-Source: ABdhPJy3eNhYEAsuqSRep2LrEwtJKskhY70XKMcMvepzyY/qcdrROpho5G3LkjPA4rVkEoFWTO9YBA==
X-Received: by 2002:a62:60c3:: with SMTP id u186mr2555424pfb.253.1590561949690;
        Tue, 26 May 2020 23:45:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:49 -0700 (PDT)
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
Subject: [PATCH v2 02/12] mm/migrate: move migration helper from .h to .c
Date:   Wed, 27 May 2020 15:44:53 +0900
Message-Id: <1590561903-13186-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's not performance sensitive function. Move it to .c.
This is a preparation step for future change.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
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
index 22a26a5..824c22e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1537,6 +1537,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

