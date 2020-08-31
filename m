Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC5C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D85E20639
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="knBREK3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHaRux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:50:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:50:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w17so9895826ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JpWL57E/IIAL9R1H0roONADTldmwz1McUqD3J7o9bl0=;
        b=knBREK3DrTQlkiin5j15dgIYsIECOHJXCsck6vGRe6vUS6N6qDIc6aVfoMM+0UuMGj
         7aofl7ZzlV+/ybYpNv+MLmlskZ4gAOWUuW3HIBnO5Xy+L24sKJYvl5n2Fc/Xo7CN9l6I
         mktKoBS61HT19+MddqdZ9ZBOx9O7RhhsXkkUQiaSerge46HDozxhXGCKfwH2B4dy9rm0
         y8ZFDWvg9hwAwujA/Sr50czu7FPPu6Iw50LK7583+8+buvvJOjP5l4DZnVJ0NwYz99Np
         /Y8Ls/MJgIp4Ic98iDLIVvT0etqPSzpPGNm69iUY3G0clpmIWs2g7hN95jWQFX0LTEjU
         wj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JpWL57E/IIAL9R1H0roONADTldmwz1McUqD3J7o9bl0=;
        b=RerYfbc06WjjjW97xrilgl6325Xyq01JQLOv2KHhyU1sYExiYfQCUX7sYdxO3Ze7Af
         hwH8v+xwp2Qtiqx+hYEHYMJxAyJpbqKPraaBhCINDx410w8vBg/9y5cNxJQLMl28J7zm
         5iZGjNdZgD0gVpQrPLpnR/YyJL3RTzSTvk2Yk1d2p/JqO/tU/KW2rCS0AJD/sJfir18V
         eLxM/QaUg68I8la3utHaIQXLd53ae8Txdk1OPbqsv6SjPFLykf33+i64QCJHBdSlxe87
         IPNRha4doEPesdzWepJmwCte5hwOr17UGPb1xhsZ5pfnRg78GFocIYhCRuZyKRdIslN6
         1DCA==
X-Gm-Message-State: AOAM533HyvQuIggA+M1e0t6j1ff/mBmfynCwvQ4EMAJzpp6PXWHh+ZOG
        s1ZHKR1r8m6uoAxQ5TGQElO59LJDd+8=
X-Google-Smtp-Source: ABdhPJx9rXxD1uqCrBCzxGHI+Q0iPaRack91VwRf10zVbssXVm/L8ws1r6QoHwp4qni6pMnDnPx7YLRzNRc=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a5b:d0a:: with SMTP id y10mr4071246ybp.128.1598896250522;
 Mon, 31 Aug 2020 10:50:50 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:50:41 -0600
Message-Id: <20200831175042.3527153-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 1/2] mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial but worth having clean-up patch. There should be
no side effects except page->lru is temporarily poisoned after it's
deleted but before it's added to the new list in move_pages_to_lru()
(which is not a problem).

[ I was under false impression that page_off_lru() clears PG_lru;
  Alex Shi <alex.shi@linux.alibaba.com> pointed that out. So in v2,
  we keep __ClearPageLRU(). ]

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c   |  4 +---
 mm/vmscan.c | 13 ++++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 40bf20a75278..2735ecf0f566 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec,
-				       LRU_INACTIVE_ANON + active);
+		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796eb833..1b871c3987e7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
-	enum lru_list lru;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			list_del(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
@@ -1860,16 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
-		lru = page_lru(page);
-
-		nr_pages = thp_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
+		add_page_to_lru_list(page, lruvec, page_lru(page));
 
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
-			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -1878,6 +1872,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
+			nr_pages = thp_nr_pages(page);
 			nr_moved += nr_pages;
 			if (PageActive(page))
 				workingset_age_nonresident(lruvec, nr_pages);
-- 
2.28.0.402.g5ffc5be6b7-goog

