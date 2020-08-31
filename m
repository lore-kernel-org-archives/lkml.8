Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A36C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8E220720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgHaDLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:11:13 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41464 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgHaDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7JHBzW_1598843468;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7JHBzW_1598843468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:08 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 4/6] ftrace: simplify the calculation of page number for ftrace_page->records
Date:   Mon, 31 Aug 2020 11:11:02 +0800
Message-Id: <20200831031104.23322-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following two reasones, we could simplify the calculation:

  - If the number after roundup count is not power of 2, we would
    definitely have more than 1 empty page with a higher order.
  - get_count_order() just return current order, so one lower order
    could meet the requirement.

The calculation could be simplified by lower one order level when pages
are not power of 2.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9021e16fa079..15fcfa16895d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3127,18 +3127,19 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 {
 	int order;
-	int cnt;
+	int pages, cnt;
 
 	if (WARN_ON(!count))
 		return -EINVAL;
 
-	order = get_count_order(DIV_ROUND_UP(count, ENTRIES_PER_PAGE));
+	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+	order = get_count_order(pages);
 
 	/*
 	 * We want to fill as much as possible. No more than a page
 	 * may be empty.
 	 */
-	while ((PAGE_SIZE << order) / ENTRY_SIZE >= count + ENTRIES_PER_PAGE)
+	if (!is_power_of_2(pages))
 		order--;
 
  again:
-- 
2.20.1 (Apple Git-117)

