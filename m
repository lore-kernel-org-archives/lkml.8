Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3694F20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgGVIxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:53:53 -0400
Received: from mail1.windriver.com ([147.11.146.13]:45061 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGVIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:53:53 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06M8rcie010699
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 22 Jul 2020 01:53:38 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 01:53:37 -0700
From:   <qiang.zhang@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/dmapool.c: add lock protect in dma_pool_destroy
Date:   Wed, 22 Jul 2020 17:05:16 +0800
Message-ID: <20200722090516.28829-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

When traversing "pool->page" linked list, to prevent possible
other path operations this list, causing it to be destroyed, we
should add lock protect for this list in dma_pool_destroy func.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 mm/dmapool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f9fb9bbd733e..f7375b25af6c 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -267,6 +267,9 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
 void dma_pool_destroy(struct dma_pool *pool)
 {
 	bool empty = false;
+	LIST_HEAD(discard);
+	struct dma_page *page,*h;
+	unsigned long flags;
 
 	if (unlikely(!pool))
 		return;
@@ -281,8 +284,8 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
 
+	spin_lock_irqsave(&pool->lock, flags);
 	while (!list_empty(&pool->page_list)) {
-		struct dma_page *page;
 		page = list_entry(pool->page_list.next,
 				  struct dma_page, page_list);
 		if (is_page_busy(page)) {
@@ -297,8 +300,12 @@ void dma_pool_destroy(struct dma_pool *pool)
 			list_del(&page->page_list);
 			kfree(page);
 		} else
-			pool_free_page(pool, page);
+			list_move(&page->page_list, &discard);
 	}
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	list_for_each_entry_safe(page, h, &discard, page_list)
+		pool_free_page(pool, page);
 
 	kfree(pool);
 }
-- 
2.26.2

