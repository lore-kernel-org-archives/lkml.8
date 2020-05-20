Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C5020759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Lb7ndAEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgETX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgETX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:02 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so4103712qte.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ozutM1RuMVFVDvSIK8bxM1gfp4d+rFh7jBPaadPhlY=;
        b=Lb7ndAEuNhjpm7qFW7cY/KXnvFygKYOdT4JswXczLPm909v/DQ8GR7bbm44g/X0spu
         p+/16sYWRdQx8Pm26HKQwjp4euw6hp95qZ8If2y+6Lox6HQZx2c+LIwq5Y0oPZxBzXs3
         ZA3Arusf3P6B4eajc4K3WyFw2kA4iSUUg1kEJ96RgKwwEWmlVQ2wDIvpq6YM/ddUvEKn
         oEjySAahIKLRb9VG1+Twv7hYdcsJI4ETtJdTABdfTl7Opktcpi2wNjDAtfxC2xkALi/K
         o2svRWYCilFhKKJYzc7pz7+IYAeMn0+Gbgr0Txxt00hvGDR9FzKc8alzfLV2+uOXOopH
         9JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ozutM1RuMVFVDvSIK8bxM1gfp4d+rFh7jBPaadPhlY=;
        b=jdhjcqyoDjgU6CdxxmhXKjK3yNnzuW83PssKutp06G0X8Vp9PEnbfBWZUurQm8ZWir
         RdcRXBxEcekRLQeVjSxw6XSrsrmDrNV6Y1TvFWcDs6B0SubcyGQKiOCQXyTyxtP/yovw
         b/sjA0tHlqdyIecMpNmejivuwUwfYBxMx0XXL6ccbyWSa0so+xzfru/ZEAQQ93QBGOwB
         jzlcvfH0KLW90duHg/XSrg6cTN34djwofAldspr3EH8DBUPi0ye7e0vDdKmDzCRakh6P
         CZqOTZdLL3zzlhh3D/NAdVSZ38o9VhGmfHSsZVv9qZJZqEPnx0N1V8KrynAYtTnISHa/
         AYDg==
X-Gm-Message-State: AOAM533TTZEPoeEdWThlLOwJN+wujtmNwyjqgDpX1/XA/lJkjn8uIQTh
        8G90/SWctifrisAlP7FvKLDdZA==
X-Google-Smtp-Source: ABdhPJwHDsn4V5BDMrhnRfBkMRRvO8wA+GSitS0IWz8FXvpMWlAjzbtWutB3L5QWvt/43zchkIBqSg==
X-Received: by 2002:ac8:6615:: with SMTP id c21mr8107277qtp.185.1590017161371;
        Wed, 20 May 2020 16:26:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id l6sm2544316qkc.59.2020.05.20.16.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:00 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/14] mm: fix LRU balancing effect of new transparent huge pages
Date:   Wed, 20 May 2020 19:25:12 -0400
Message-Id: <20200520232525.798933-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, THP are counted as single pages until they are split right
before being swapped out. However, at that point the VM is already in
the middle of reclaim, and adjusting the LRU balance then is useless.

Always account THP by the number of basepages, and remove the fixup
from the splitting path.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Rik van Riel <riel@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/swap.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..68eae1e2787a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -263,13 +263,14 @@ void rotate_reclaimable_page(struct page *page)
 }
 
 static void update_page_reclaim_stat(struct lruvec *lruvec,
-				     int file, int rotated)
+				     int file, int rotated,
+				     unsigned int nr_pages)
 {
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 
-	reclaim_stat->recent_scanned[file]++;
+	reclaim_stat->recent_scanned[file] += nr_pages;
 	if (rotated)
-		reclaim_stat->recent_rotated[file]++;
+		reclaim_stat->recent_rotated[file] += nr_pages;
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
@@ -286,7 +287,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 		trace_mm_lru_activate(page);
 
 		__count_vm_event(PGACTIVATE);
-		update_page_reclaim_stat(lruvec, file, 1);
+		update_page_reclaim_stat(lruvec, file, 1, hpage_nr_pages(page));
 	}
 }
 
@@ -541,7 +542,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 
 	if (active)
 		__count_vm_event(PGDEACTIVATE);
-	update_page_reclaim_stat(lruvec, file, 0);
+	update_page_reclaim_stat(lruvec, file, 0, hpage_nr_pages(page));
 }
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
@@ -557,7 +558,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 
 		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
-		update_page_reclaim_stat(lruvec, file, 0);
+		update_page_reclaim_stat(lruvec, file, 0, hpage_nr_pages(page));
 	}
 }
 
@@ -582,7 +583,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
 		count_memcg_page_event(page, PGLAZYFREE);
-		update_page_reclaim_stat(lruvec, 1, 0);
+		update_page_reclaim_stat(lruvec, 1, 0, hpage_nr_pages(page));
 	}
 }
 
@@ -890,8 +891,6 @@ EXPORT_SYMBOL(__pagevec_release);
 void lru_add_page_tail(struct page *page, struct page *page_tail,
 		       struct lruvec *lruvec, struct list_head *list)
 {
-	const int file = 0;
-
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
@@ -917,9 +916,6 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 		add_page_to_lru_list_tail(page_tail, lruvec,
 					  page_lru(page_tail));
 	}
-
-	if (!PageUnevictable(page))
-		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -962,8 +958,9 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	if (page_evictable(page)) {
 		lru = page_lru(page);
-		update_page_reclaim_stat(lruvec, page_is_file_lru(page),
-					 PageActive(page));
+		update_page_reclaim_stat(lruvec, is_file_lru(lru),
+					 PageActive(page),
+					 hpage_nr_pages(page));
 		if (was_unevictable)
 			count_vm_event(UNEVICTABLE_PGRESCUED);
 	} else {
-- 
2.26.2

