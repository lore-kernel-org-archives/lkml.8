Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD751C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE03208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Qi/qXzru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgETX0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgETX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F3C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m11so5525177qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JD9BxGjYxOg6IYiFlF2HPLz+K3fq+w79j5nMBZBCwlM=;
        b=Qi/qXzruuxtJLTXqrhZFDKcKb5REKlP74g21aFN90SZ3bhM87tqSeN8rVQv6r7t1Jp
         ut9fAU8Db4oeQogAEkzCnYFRWK/Fy/RgT3GvUU03jI0bJbUbdhlbXZhd1FMvGRLLJLUk
         OuRrTMw8YmUqWOUue4k+R7BWWDRHlz1kjM2X2QV/PeoaVgYRQVTZhsqb2a1+kxU1B5tw
         FN6M4GOn/HpVF8XtR97Ne449r1UJ9oD9LLKkPOO7aOsgDwL2fHzuZIHi4/DN5/aFWpRz
         sQoJTlYcMFNce6uwQl+iactFlQ494ZgLPLmf5I3Fc0qMfA5+YFyjlXDcll0G3Pgv9w/n
         l8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JD9BxGjYxOg6IYiFlF2HPLz+K3fq+w79j5nMBZBCwlM=;
        b=SSrVhTfAZRo8pa+ryBlN0LJJJt1yKIKa0MuPbsu2XVkXOrIN/PrxIpmML6+dIq3X76
         2Qdz27c3HGP4ca4eKMN/CQFi5+smaii13gSgCWtQIUBMjRpXNdeZZmKRkOWcVvv1Vxi8
         7FC+M0x3YHggivqVehljOVrzuxoEiP4gqVnRQ2rRdstQTCqh+ysFMHKqbEwjoUEEZdwK
         ez0LdhrZjopcUMLBOn7JJKwpqRvedQ/8ohObAUdBtJxP9JWD6kWrcExC/B7JD4nGcPR0
         ARBrfoivq6tkV8MA8hizVLirCy+HDsxCtf2Rivn2208bvnShRn/XkTFYM+YnE01l5bLA
         tMnw==
X-Gm-Message-State: AOAM533kOvB0YlpWrXw62HkOZA3yJSfCXdkqDNkFpjyY1Xxgw/tln6Az
        8ZzDHW5S7XbObsinv3i/qU3mmw==
X-Google-Smtp-Source: ABdhPJzSL6c+84ozsdZGZDu3uGWyllg+dwn1/sWq5j9UJIWTeTeGQbmBH2yrr6HAHp7qlRYoVWHveA==
X-Received: by 2002:a37:4c48:: with SMTP id z69mr6380214qka.138.1590017173866;
        Wed, 20 May 2020 16:26:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id z65sm3372453qkc.91.2020.05.20.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:13 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/14] mm: deactivations shouldn't bias the LRU balance
Date:   Wed, 20 May 2020 19:25:20 -0400
Message-Id: <20200520232525.798933-10-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Operations like MADV_FREE, FADV_DONTNEED etc. currently move any
affected active pages to the inactive list to accelerate their reclaim
(good) but also steer page reclaim toward that LRU type, or away from
the other (bad).

The reason why this is undesirable is that such operations are not
part of the regular page aging cycle, and rather a fluke that doesn't
say much about the remaining pages on that list; they might all be in
heavy use, and once the chunk of easy victims has been purged, the VM
continues to apply elevated pressure on those remaining hot pages. The
other LRU, meanwhile, might have easily reclaimable pages, and there
was never a need to steer away from it in the first place.

As the previous patch outlined, we should focus on recording actually
observed cost to steer the balance rather than speculating about the
potential value of one LRU list over the other. In that spirit, leave
explicitely deactivated pages to the LRU algorithm to pick up, and let
rotations decide which list is the easiest to reclaim.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/swap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 5d62c5a0c651..d7912bfb597f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -515,14 +515,12 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 
 	if (active)
 		__count_vm_event(PGDEACTIVATE);
-	lru_note_cost(lruvec, !file, hpage_nr_pages(page));
 }
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
 
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
@@ -531,7 +529,6 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 
 		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
-		lru_note_cost(lruvec, !file, hpage_nr_pages(page));
 	}
 }
 
@@ -556,7 +553,6 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
 		count_memcg_page_event(page, PGLAZYFREE);
-		lru_note_cost(lruvec, 0, hpage_nr_pages(page));
 	}
 }
 
-- 
2.26.2

