Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0AA207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEVCvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:51:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4881 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbgEVCvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:51:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD3EBD66CACCBD24277F;
        Fri, 22 May 2020 10:51:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 10:51:03 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 4/5] net: hns3: remove unnecessary MAC enable in app loopback
Date:   Fri, 22 May 2020 10:49:45 +0800
Message-ID: <1590115786-9940-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590115786-9940-1-git-send-email-tanhuazhong@huawei.com>
References: <1590115786-9940-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufeng Mo <moyufeng@huawei.com>

Packets will not pass through MAC during app loopback.
Therefore, it is meaningless to enable MAC while doing
app loopback. This patch removes this unnecessary action.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6e1e2cf..7c9f2ba 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6583,8 +6583,6 @@ static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
 	/* 2 Then setup the loopback flag */
 	loop_en = le32_to_cpu(req->txrx_pad_fcs_loop_en);
 	hnae3_set_bit(loop_en, HCLGE_MAC_APP_LP_B, en ? 1 : 0);
-	hnae3_set_bit(loop_en, HCLGE_MAC_TX_EN_B, en ? 1 : 0);
-	hnae3_set_bit(loop_en, HCLGE_MAC_RX_EN_B, en ? 1 : 0);
 
 	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
-- 
2.7.4

