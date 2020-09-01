Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C736C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B652206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIAOaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:30:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbgIAO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:28:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 856E18861D33829408F3;
        Tue,  1 Sep 2020 22:11:31 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 22:11:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dchickles@marvell.com>, <sburla@marvell.com>,
        <fmanlunas@marvell.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] liquidio: Remove unneeded cast from memory allocation
Date:   Tue, 1 Sep 2020 22:11:15 +0800
Message-ID: <20200901141115.19792-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded return value cast.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index 017169023cca..cf4fe5b17f8a 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -280,13 +280,10 @@ int octeon_init_droq(struct octeon_device *oct,
 	dev_dbg(&oct->pci_dev->dev, "droq[%d]: num_desc: %d\n", q_no,
 		droq->max_count);
 
-	droq->recv_buf_list = (struct octeon_recv_buffer *)
-	      vzalloc_node(array_size(droq->max_count, OCT_DROQ_RECVBUF_SIZE),
-			   numa_node);
+	droq->recv_buf_list = vzalloc_node(array_size(droq->max_count, OCT_DROQ_RECVBUF_SIZE),
+					   numa_node);
 	if (!droq->recv_buf_list)
-		droq->recv_buf_list = (struct octeon_recv_buffer *)
-		      vzalloc(array_size(droq->max_count,
-					 OCT_DROQ_RECVBUF_SIZE));
+		droq->recv_buf_list = vzalloc(array_size(droq->max_count, OCT_DROQ_RECVBUF_SIZE));
 	if (!droq->recv_buf_list) {
 		dev_err(&oct->pci_dev->dev, "Output queue recv buf list alloc failed\n");
 		goto init_droq_fail;
-- 
2.17.1


