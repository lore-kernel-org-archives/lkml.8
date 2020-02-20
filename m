Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E2C3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B615924672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/SxpJqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBTFMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36582 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so1072544plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9zwvQ4CGCx+wiNpWyUGWH8dCEXbiZhNqior0NhHpUA=;
        b=h/SxpJqiWyv96/GLSrLehHyIuCjBp4cSZrlSVNtlHMEafyK4voytGfzUdpCU8zrQLQ
         57SVIyMi/eYsa4LniLLSCZ8+7YYM+CSH+c5C0SR1HNBlm5RYXS8eA0W/R7ipiu/5CaqY
         WwQFzQmreg45g6p1FQOTIEuDPal+FVkDMgDl3XUgM0VBQcPV1Cj5bLzyP7MuWg05ubFD
         6hzbQUnuEZOCsWmSmQg2MT1++XXlhDV1qxnzzUKvNBHP3Zjz9giow/hvX4FcZApSfbaS
         KWuGEunVL6zQDXdQrPUZqVck4bNGf8Bp1IDvGJCCecxRmZAhHIExZxxvVYeiBhCvQbXt
         cPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9zwvQ4CGCx+wiNpWyUGWH8dCEXbiZhNqior0NhHpUA=;
        b=gEa6fo6798T/YNeB42QZSwn94LUoHrOT5/MYemwy4dcU5cTIsBM3DhUCEqObNAo+Wq
         3h+A4rA1gO/xGVaHVr1bdk0TEIxRhcdxAJy2HvXy804qim25Sb4pPXUY0raPBlHV1P4/
         iZoQ61vUg7+bwKVGW9rK9uI6yiHRVSoACbNUs4Iw5K4YCUlS3imXBaYb6I6BN3UuF5Db
         jk8Rmh4WP8eIccnatQ+UvMl2r2+30+WzeckMs7DnFGSkKFKRR1peLf0aIm2OZRe5xmeU
         oj6GxuJHp2aXzGVw0XtZWqaLXJK+VPgWtpEjYZxqDZwOZ4Z3jsfGZi2h/+bf/pzCMPfZ
         r2dA==
X-Gm-Message-State: APjAAAXUTgoKt7XP+7iBVP+O/2QxCs3ZLqM41BnEs3WfO+oz+mod1YXG
        mYOj/qU0gdCeMoSN8TMemiw=
X-Google-Smtp-Source: APXvYqyS0susRVtL7+OoCXj7RZrS7HFQ8EbXkEP2qjapjneHJ9GECVLT4k8nSwqe66TMYSL1165OQQ==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr30366372pls.1.1582175535644;
        Wed, 19 Feb 2020 21:12:15 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:15 -0800 (PST)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 4/9] mm/swapcache: support to handle the value in swapcache
Date:   Thu, 20 Feb 2020 14:11:48 +0900
Message-Id: <1582175513-22601-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Swapcache doesn't handle the value since there is no case using the value.
In the following patch, workingset detection for anonymous page will be
implemented and it stores the value into the swapcache. So, we need to
handle it and this patch implement handling.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h |  5 +++--
 mm/swap_state.c      | 23 ++++++++++++++++++++---
 mm/vmscan.c          |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 954e13e..0df8b3f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -410,7 +410,8 @@ extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
 extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
-extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
+extern void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow);
 extern void delete_from_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
@@ -571,7 +572,7 @@ static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
 }
 
 static inline void __delete_from_swap_cache(struct page *page,
-							swp_entry_t entry)
+					swp_entry_t entry, void *shadow)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a..3fbbe45 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -117,6 +117,10 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(page));
 	unsigned long i, nr = compound_nr(page);
+	unsigned long nrexceptional = 0;
+	void *old;
+
+	xas_set_update(&xas, workingset_update_node);
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -132,10 +136,14 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 			goto unlock;
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
+			old = xas_load(&xas);
+			if (xa_is_value(old))
+				nrexceptional++;
 			set_page_private(page + i, entry.val + i);
 			xas_store(&xas, page);
 			xas_next(&xas);
 		}
+		address_space->nrexceptional -= nrexceptional;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
@@ -155,24 +163,33 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
+void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i, nr = hpage_nr_pages(page);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
+	/* Do not apply workingset detection for the hugh page */
+	if (nr > 1)
+		shadow = NULL;
+
+	xas_set_update(&xas, workingset_update_node);
+
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 	VM_BUG_ON_PAGE(PageWriteback(page), page);
 
 	for (i = 0; i < nr; i++) {
-		void *entry = xas_store(&xas, NULL);
+		void *entry = xas_store(&xas, shadow);
 		VM_BUG_ON_PAGE(entry != page, entry);
 		set_page_private(page + i, 0);
 		xas_next(&xas);
 	}
 	ClearPageSwapCache(page);
+	if (shadow)
+		address_space->nrexceptional += nr;
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	ADD_CACHE_INFO(del_total, nr);
@@ -247,7 +264,7 @@ void delete_from_swap_cache(struct page *page)
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(page, entry);
+	__delete_from_swap_cache(page, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74c3ade..99588ba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -909,7 +909,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap);
+		__delete_from_swap_cache(page, swap, NULL);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 	} else {
-- 
2.7.4

