Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0884EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CFF20578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgG3GNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:13:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8299 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3GNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:13:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BA4AB9872DDE8245B9EA;
        Thu, 30 Jul 2020 14:13:25 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 14:13:21 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <joe@perches.com>, <dchickles@marvell.com>, <sburla@marvell.com>,
        <fmanlunas@marvell.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] liquidio: Replace vmalloc with kmalloc in octeon_register_dispatch_fn()
Date:   Thu, 30 Jul 2020 14:11:40 +0800
Message-ID: <20200730061140.20223-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of struct octeon_dispatch is too small, it is better to use
kmalloc instead of vmalloc.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/octeon_device.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index 934115d18488..ac32facaa427 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -1056,7 +1056,7 @@ void octeon_delete_dispatch_list(struct octeon_device *oct)
 
 	list_for_each_safe(temp, tmp2, &freelist) {
 		list_del(temp);
-		vfree(temp);
+		kfree(temp);
 	}
 }
 
@@ -1152,13 +1152,10 @@ octeon_register_dispatch_fn(struct octeon_device *oct,
 
 		dev_dbg(&oct->pci_dev->dev,
 			"Adding opcode to dispatch list linked list\n");
-		dispatch = (struct octeon_dispatch *)
-			   vmalloc(sizeof(struct octeon_dispatch));
-		if (!dispatch) {
-			dev_err(&oct->pci_dev->dev,
-				"No memory to add dispatch function\n");
+		dispatch = kmalloc(sizeof(*dispatch), GFP_KERNEL);
+		if (!dispatch)
 			return 1;
-		}
+
 		dispatch->opcode = combined_opcode;
 		dispatch->dispatch_fn = fn;
 		dispatch->arg = fn_arg;
-- 
2.17.1

