Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02455C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA98820772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGCFIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:08:38 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45210 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgGCFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:08:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U1Y4LGX_1593752912;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1Y4LGX_1593752912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 13:08:34 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH v14 02/20] mm/page_idle: no unlikely double check for idle page counting
Date:   Fri,  3 Jul 2020 13:07:35 +0800
Message-Id: <1593752873-4493-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
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
index 057c61df12db..5fdd753e151a 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -32,19 +32,11 @@
 static struct page *page_idle_get_page(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
-	pg_data_t *pgdat;
 
 	if (!page || !PageLRU(page) ||
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

