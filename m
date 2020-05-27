Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0422089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNW0I7VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgE0Srx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6FCC08C5C5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:29:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s135so20218097pfs.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=umlZmjF/xRJ/ByIszoMII6nD5KbkyV6mpjK0jZ/NaXE=;
        b=TNW0I7VXkAn0j2BLWEim22wstMZleW6Z39EFJ2CSnOOxlUqvHExjE3VD6l2REop6DH
         JNmHvRwF/gyW/TqMxOiIdiFim+3z2QSIRjoArucOgnQFFZsIhg01hmeTnBrS9n1mttvI
         kTvEW1YOf7PvHic1t2ooTL6U9y2xWgoRlspZbgW/LwoZDgXWL6kY5ckbovNbIhx7oru2
         VGwe9wM9i6MGKAO8kfngkzHfHuzihBhKjo9eenekHs2qSrFJ6J4R2i0WXkR8SI7Hmthb
         z9zKpnmCB0G6B5XaB9rlX5KyP0+VF5pKd1G9JNmTkFa30dNY2goKO7NNMc6DRJMzx1co
         F1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=umlZmjF/xRJ/ByIszoMII6nD5KbkyV6mpjK0jZ/NaXE=;
        b=r5btTuqyyfW2pumVYjjj3FvBDBxRBxcRbQ9bY8xwFGOzOSUsDxY9hm/ZTuDtqot8uY
         xBKxstOMmEJkUinZi1nIYLM1XTjOZWUEHFASEHbcOCbLLDybleknqkVLU/fjfD6KOhi4
         Q2Y3gGg01V+fa/hB/Ja3XdOUaGMWqMVBX8jw9dKv3E/5NK3jfUP0xgapPlZk/ICurvSS
         GFePSlvIzz9QwQN52bSaTyGJLuphmpduEHBCzdcbpbR6rqr4NsZFFxL1D0Yu6t1dqovY
         tBiKUTwoem2AhDeJLjZ74TYNxnh91+p9ai68/B9ydi6RdWICsT4ckVQeuZshp2MY6rks
         rEYA==
X-Gm-Message-State: AOAM531NuiQ+ZCERMK/qQ5S8qJ4l/tCVlgpI7YbXinvNO2dibvir+8j1
        0HhI0egBL3Q26fklKkoe0rm59MdyfMOi9Q==
X-Google-Smtp-Source: ABdhPJyN2FB/FWPyNcSELEB3nINQwo30vwWeEX0qSwroQp8Ua126Oy6z2xHpvU8JohPT3Gk/+oheDuMcri5w/A==
X-Received: by 2002:a63:f305:: with SMTP id l5mr2461116pgh.387.1590604166120;
 Wed, 27 May 2020 11:29:26 -0700 (PDT)
Date:   Wed, 27 May 2020 11:29:14 -0700
Message-Id: <20200527182916.249910-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH resend 1/3] mm: swap: fix vmstats for huge pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the callbacks called by pagevec_lru_move_fn() does not correctly
update the vmstats for huge pages. Fix that. Also __pagevec_lru_add_fn()
use the irq-unsafe alternative to update the stat as the irqs are
already disabled.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index a37bd7b202ac..3dbef6517cac 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -225,7 +225,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
-		(*pgmoved)++;
+		(*pgmoved) += hpage_nr_pages(page);
 	}
 }
 
@@ -285,7 +285,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 		trace_mm_lru_activate(page);
 
-		__count_vm_event(PGACTIVATE);
+		__count_vm_events(PGACTIVATE, hpage_nr_pages(page));
 		update_page_reclaim_stat(lruvec, file, 1);
 	}
 }
@@ -503,6 +503,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 {
 	int lru, file;
 	bool active;
+	int nr_pages = hpage_nr_pages(page);
 
 	if (!PageLRU(page))
 		return;
@@ -536,11 +537,11 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		 * We moves tha page into tail of inactive.
 		 */
 		add_page_to_lru_list_tail(page, lruvec, lru);
-		__count_vm_event(PGROTATED);
+		__count_vm_events(PGROTATED, nr_pages);
 	}
 
 	if (active)
-		__count_vm_event(PGDEACTIVATE);
+		__count_vm_events(PGDEACTIVATE, nr_pages);
 	update_page_reclaim_stat(lruvec, file, 0);
 }
 
@@ -929,6 +930,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
+	int nr_pages = hpage_nr_pages(page);
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -966,13 +968,13 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 		update_page_reclaim_stat(lruvec, page_is_file_lru(page),
 					 PageActive(page));
 		if (was_unevictable)
-			count_vm_event(UNEVICTABLE_PGRESCUED);
+			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
 		lru = LRU_UNEVICTABLE;
 		ClearPageActive(page);
 		SetPageUnevictable(page);
 		if (!was_unevictable)
-			count_vm_event(UNEVICTABLE_PGCULLED);
+			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
 	add_page_to_lru_list(page, lruvec, lru);
-- 
2.27.0.rc0.183.gde8f92d652-goog

