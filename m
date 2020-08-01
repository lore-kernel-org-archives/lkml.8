Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02CDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54C52076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgHAEJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 00:09:27 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56005 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbgHAEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 00:09:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U4Mybap_1596254964;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4Mybap_1596254964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Aug 2020 12:09:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm/thp: remove code path which never got into
Date:   Sat,  1 Aug 2020 12:09:16 +0800
Message-Id: <1596254957-22560-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_huge_page() will never call on a page which isn't on lru list, so
this code never got a chance to run, and should not be run, to add tail
pages on a lru list which head page isn't there.

Although the bug was never triggered, it'better be removed for code
correctness.

BTW, it looks better to have a WARN() set in the wrong path, but the
path will be changed in incoming new page isolation func. So just save
it now.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index 8cecd39bd8b7..dfe7378ab4be 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2332,16 +2332,6 @@ static void lru_add_page_tail(struct page *head, struct page *page_tail,
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

