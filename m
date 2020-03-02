Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6ADC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79ED2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCBLD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:03:57 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48618 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgCBLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:03:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrQzvOW_1583146854;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQzvOW_1583146854)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:00:54 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/20] mm/page_idle: no unlikely double check for idle page counting
Date:   Mon,  2 Mar 2020 19:00:13 +0800
Message-Id: <1583146830-169516-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As func comments mentioned, few isolated page missing be tolerated.
So why not do further to drop the unlikely double check. That won't
cause more idle pages, but reduce a lock contention.

This is also a preparation for later new page isolation feature.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_idle.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..914df63948b1 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -31,7 +31,6 @@
 static struct page *page_idle_get_page(unsigned long pfn)
 {
 	struct page *page;
-	pg_data_t *pgdat;
 
 	if (!pfn_valid(pfn))
 		return NULL;
@@ -41,13 +40,6 @@ static struct page *page_idle_get_page(unsigned long pfn)
 	    !get_page_unless_zero(page))
 		return NULL;
 
-	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
-	}
-	spin_unlock_irq(&pgdat->lru_lock);
 	return page;
 }
 
-- 
1.8.3.1

