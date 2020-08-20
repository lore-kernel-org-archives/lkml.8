Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04162C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC99E2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHTOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:30:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727885AbgHTOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:30:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99608B060FFF36059465;
        Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:42 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/4] libnvdimm: eliminate a meaningless spinlock operation
Date:   Thu, 20 Aug 2020 22:30:25 +0800
Message-ID: <20200820143027.3241-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820143027.3241-1-thunder.leizhen@huawei.com>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

badrange_add() take the lock "badrange->lock", but it's released
immediately in add_badrange(), protect nothing. Because the static
function add_badrange() is only called by badrange_add(), so spread its
content into badrange_add(), and move "kfree(bre_new)" out of the lock
protection.

Fixes: b3b454f694db ("libnvdimm: fix clear poison locking with spinlock ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 9fdba8c43e8605e..7f78b659057902d 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -45,12 +45,12 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
 	return 0;
 }
 
-static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
+int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 {
 	struct badrange_entry *bre, *bre_new;
 
-	spin_unlock(&badrange->lock);
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
+
 	spin_lock(&badrange->lock);
 
 	/*
@@ -63,6 +63,7 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 			/* If length has changed, update this list entry */
 			if (bre->length != length)
 				bre->length = length;
+			spin_unlock(&badrange->lock);
 			kfree(bre_new);
 			return 0;
 		}
@@ -72,22 +73,15 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	 * as any overlapping ranges will get resolved when the list is consumed
 	 * and converted to badblocks
 	 */
-	if (!bre_new)
+	if (!bre_new) {
+		spin_unlock(&badrange->lock);
 		return -ENOMEM;
-	append_badrange_entry(badrange, bre_new, addr, length);
-
-	return 0;
-}
-
-int badrange_add(struct badrange *badrange, u64 addr, u64 length)
-{
-	int rc;
+	}
 
-	spin_lock(&badrange->lock);
-	rc = add_badrange(badrange, addr, length);
+	append_badrange_entry(badrange, bre_new, addr, length);
 	spin_unlock(&badrange->lock);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(badrange_add);
 
-- 
1.8.3


