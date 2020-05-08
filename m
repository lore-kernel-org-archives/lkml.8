Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D8CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F1420A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XY5On+Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEHVW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgEHVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:22:26 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49BC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:22:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r5so3020557pfh.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H7ED1E6iU6GJrL2T+LX5Bj/uEQY3JnE8s7k3T/+egkg=;
        b=XY5On+GozPMjP6G7zkPxPhW0eE2rp4+jjdvdyV+TE6avG+bX2A6pptdCo2RW+Rn3no
         KQU1jyKtWYfy9dkYUy4EImZ9+uEOAdDNPH0YwlyphH5/olIWRcFiT8PHrG0uYO6VgAgO
         E/dVasAEh4SuLPL7R9m2RQCh6iAMAIo8SZvlMpxpYiJTLphr4eSjp2MuwGrDq5yyaNzx
         4N+w8pQqM2elRyzuI36Dqha8UAGJbBpiCNZBetFNyysG+bhxK79vAv6P6/dmFhDWQ0cZ
         53BuMgiu5tPKdTehsHF+yErNAw9OFP+cGYZN4uCLlChZJodaZgBljzVYxcpHxpU3zoun
         Gm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H7ED1E6iU6GJrL2T+LX5Bj/uEQY3JnE8s7k3T/+egkg=;
        b=SiTgpESgsFuSGfGunnk9edXQ6fvNo9OgtcO+741Bh3W7WKK+Qv7SGcIqJR1MUSO6fP
         GfEhdqQymO7kvgSAQ6eA39/PnGky01JKrpNH06I31K14Adf2seseTI590Ozbe9kLqRvr
         e94uuly5MAmZcYCV4kCnUHKOxJnGUsqJCxhpXpesIVBBg/TX2xhFwUZfxkw0U4Vk/15D
         rPj9WDACeIt/15kClNPYSjNtonyyz/krjbju7ICwrs55if5YpeZ79Sq7YMkFIwRjzTWk
         nDRO9TwrIBSJRHmlvxRaNCLdErVCH7WEmQQiIi3ivV68K6r3wyIjilcoFUab1j8JoYeK
         FE4Q==
X-Gm-Message-State: AGi0PuZTu8ZXU8Dd3Oe1Smwsrr+J5OxWiI9slqzvlrjwRP6umI0p1C8H
        /uy2BDG3T+111SWiTU9LMgKj1AScWLi8KQ==
X-Google-Smtp-Source: APiQypLfungZ5Nzv+f2ielEC+coRuoHMgMXQgXBUaRp75fbEnt3diNF+/f9OMq68YEUmbJsRsjKINr5ubL8GLQ==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr7520557pjt.62.1588972946092;
 Fri, 08 May 2020 14:22:26 -0700 (PDT)
Date:   Fri,  8 May 2020 14:22:13 -0700
Message-Id: <20200508212215.181307-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 1/3] mm: swap: fix vmstats for huge pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the callbacks called by pagevec_lru_move_fn() do not correctly
update the vmstats for huge pages. Fix that. Also __pagevec_lru_add_fn()
use the irq-unsafe alternative to update the stat as the irqs are
already disabled.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
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
2.26.2.645.ge9eca65c58-goog

