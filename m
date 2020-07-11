Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB354C4345D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE63207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGKA7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:59:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33516 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgGKA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:59:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2KGAZr_1594429139;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2KGAZr_1594429139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jul 2020 08:59:02 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
Subject: [PATCH v16 07/22] mm/thp: remove code path which never got into
Date:   Sat, 11 Jul 2020 08:58:41 +0800
Message-Id: <1594429136-20002-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_huge_page() will never call on a page which isn't on lru list, so
this code never got a chance to run, and should not be run, to add tail
pages on a lru list which head page isn't there.

Although the bug was never triggered, it'better be removed for code
correctness.

BTW, it looks better to have BUG() or soem warning set in the wrong
path, but the path will be changed in incomming new page isolation
func. So just save it here.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b18f21da4dac..1fb4147ff854 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2357,16 +2357,6 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
 		/* page reclaim is reclaiming a huge page */
 		get_page(page_tail);
 		list_add_tail(&page_tail->lru, list);
-	} else {
-		/*
-		 * Head page has not yet been counted, as an hpage,
-		 * so we must account for each subpage individually.
-		 *
-		 * Put page_tail on the list at the correct position
-		 * so they all end up in order.
-		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
 	}
 }
 
-- 
1.8.3.1

