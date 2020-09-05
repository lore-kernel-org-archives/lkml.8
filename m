Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77BBC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC402074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIEIqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:46:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgIEIqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:46:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E04CB9627187484886C;
        Sat,  5 Sep 2020 16:46:12 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 16:46:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: swap: Fix confusing comment in release_pages()
Date:   Sat, 5 Sep 2020 04:44:53 -0400
Message-ID: <20200905084453.19353-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
ZONE_DEVICE pages"), we have renamed the func put_devmap_managed_page() to
page_is_devmap_managed().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 999a84dbe12c..041e4e31fb01 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -859,7 +859,7 @@ void release_pages(struct page **pages, int nr)
 			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
-			 * put_devmap_managed_page() do not require special
+			 * page_is_devmap_managed() do not require special
 			 * processing, and instead, expect a call to
 			 * put_page_testzero().
 			 */
-- 
2.19.1

