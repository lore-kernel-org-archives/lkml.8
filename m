Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA7520C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgIHDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:02:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728408AbgIHDCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:02:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8BDF3E1FE4D015A6D72;
        Tue,  8 Sep 2020 11:02:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 11:02:20 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 6/7] net: hns3: remove some unused macros related to queue
Date:   Tue, 8 Sep 2020 10:59:53 +0800
Message-ID: <1599533994-32744-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599533994-32744-1-git-send-email-tanhuazhong@huawei.com>
References: <1599533994-32744-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several macros related queue defined, but never
used, so remove them.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 0c146e7..cef6f9a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -42,13 +42,8 @@ enum hns3_nic_state {
 #define HNS3_RING_TX_RING_PKTNUM_RECORD_REG	0x0006C
 #define HNS3_RING_TX_RING_EBD_OFFSET_REG	0x00070
 #define HNS3_RING_TX_RING_BD_ERR_REG		0x00074
-#define HNS3_RING_PREFETCH_EN_REG		0x0007C
-#define HNS3_RING_CFG_VF_NUM_REG		0x00080
-#define HNS3_RING_ASID_REG			0x0008C
 #define HNS3_RING_EN_REG			0x00090
 
-#define HNS3_TX_REG_OFFSET			0x40
-
 #define HNS3_RX_HEAD_SIZE			256
 
 #define HNS3_TX_TIMEOUT (5 * HZ)
-- 
2.7.4

