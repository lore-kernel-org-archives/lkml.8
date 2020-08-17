Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CB420758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHQIs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:48:56 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:39626 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgHQIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:48:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U6-Thdu_1597654123;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U6-Thdu_1597654123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 16:48:43 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     alexander.h.duyck@linux.intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/page_reporting: the "page" must not be the list head
Date:   Mon, 17 Aug 2020 16:48:36 +0800
Message-Id: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "page" is the list head, list_for_each_entry_safe() would stop
iteration.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 3bbd471cfc81..aaaa3605123d 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		 * the new head of the free list before we release the
 		 * zone lock.
 		 */
-		if (&page->lru != list && !list_is_first(&page->lru, list))
+		if (!list_is_first(&page->lru, list))
 			list_rotate_to_front(&page->lru, list);
 
 		/* release lock before waiting on report processing */
-- 
2.20.1 (Apple Git-117)

