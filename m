Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE6B20759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1MBXqpD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgETX0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgETX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p4so2238266qvr.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YB631ifqXCSgSJTd0qtcdsdE2wZ/BeBb/PETguDBZ3s=;
        b=1MBXqpD1aFpHw165X+FC9nGMW0T95Jxsnt4XOC7AgQUgsdiHpDYQk/saWpqTNLgFYs
         PzCCUkT3nRULKqA9705MjHZXPneWXmrgjjaJqGg+zrHZkXdPqXGK8/TGsM+fMxsFcrMC
         c54J8REBGDNyJTGugU5J1FMAAZzn8mT3e4hWSUHhMQO3zIQ1yRUHndfe+jtJHm+wHSRn
         zH1QCMOUl4zIikJQpG5bNDC4Ze2Zk0j/yVAiVURjIROF6fYk0pxzFqwXO4U3OsOSsM9B
         BB8OvWj9BBODjPg7rnIDI/1MSp5ZXWXnz4Wo9kYnQv3PDyzwkhNC20yd32DRo/dvOWpG
         031w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YB631ifqXCSgSJTd0qtcdsdE2wZ/BeBb/PETguDBZ3s=;
        b=gKNaerpq7YQWicwoaBcNZfPVrjY0rjf0W5ImvF7UaewBYXNAXHPnA30+ZeV0dyxBRG
         aN7fytjwrjRVuqBm8VKHjnEFx9ogsChCpi1CUf3OwGy/e7kTAbhdtMipwk333NvVBnTj
         pCWvdiub4qpysgBuT6Rg7trbPhJyvQBJQqN22WLK78/M6WN3wWnbz16WVTlckgNYn1gn
         T8h7IC8RSvu8g06d3083NvnYyiTUSI67CGMdO59j/1TC2LTxIoNmA32mXSxWx1CcTi5H
         GKu5SvrNY1oe+zCBxw/MTU3rIwnxlz85Poryds65Hj1P7NXcMQ/ynyrgaINU1Tbhbc3s
         4Zog==
X-Gm-Message-State: AOAM5305YWBF7U5edS+jdk2oEDOLt6qfbrxse93awCrN2+VVcoj55Ixf
        C9/rw0gC5LLpjGaicDquxO1Dww==
X-Google-Smtp-Source: ABdhPJxLMyX89YOB3AHomG7E8lWZKxV5Wrb3mzIrpS/hIG6SDGi63YgQU4/iwCWZW0KkCgIHwu/ARA==
X-Received: by 2002:a0c:ab19:: with SMTP id h25mr7526704qvb.108.1590017169194;
        Wed, 20 May 2020 16:26:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id 124sm3333412qkn.73.2020.05.20.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:08 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/14] mm: remove use-once cache bias from LRU balancing
Date:   Wed, 20 May 2020 19:25:17 -0400
Message-Id: <20200520232525.798933-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the splitlru patches divided page cache and swap-backed pages
into separate LRU lists, the pressure balance between the lists was
biased to account for the fact that streaming IO can cause memory
pressure with a flood of pages that are used only once. New page cache
additions would tip the balance toward the file LRU, and repeat access
would neutralize that bias again. This ensured that page reclaim would
always go for used-once cache first.

Since e9868505987a ("mm,vmscan: only evict file pages when we have
plenty"), page reclaim generally skips over swap-backed memory
entirely as long as there is used-once cache present, and will apply
the LRU balancing when only repeatedly accessed cache pages are left -
at which point the previous use-once bias will have been
neutralized. This makes the use-once cache balancing bias unnecessary.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/swap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index c93a6c84464c..3b8c81bc93cd 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -277,7 +277,6 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
 
 		del_page_from_lru_list(page, lruvec, lru);
@@ -287,7 +286,6 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 		trace_mm_lru_activate(page);
 
 		__count_vm_event(PGACTIVATE);
-		update_page_reclaim_stat(lruvec, file, 1, hpage_nr_pages(page));
 	}
 }
 
@@ -936,9 +934,6 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	if (page_evictable(page)) {
 		lru = page_lru(page);
-		update_page_reclaim_stat(lruvec, is_file_lru(lru),
-					 PageActive(page),
-					 hpage_nr_pages(page));
 		if (was_unevictable)
 			count_vm_event(UNEVICTABLE_PGRESCUED);
 	} else {
-- 
2.26.2

