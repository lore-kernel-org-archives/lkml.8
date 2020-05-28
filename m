Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563F220814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbgE1Nv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:51:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390534AbgE1NvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:51:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 367BFE212A58D6ED24D0;
        Thu, 28 May 2020 21:50:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 21:50:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: modify an incorrect type in struct hclge_cfg_gro_status_cmd
Date:   Thu, 28 May 2020 21:48:12 +0800
Message-ID: <1590673699-63819-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590673699-63819-1-git-send-email-tanhuazhong@huawei.com>
References: <1590673699-63819-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify field .gro_en in struct hclge_cfg_gro_status_cmd to u8
according to the UM, otherwise, it will overwrite the reserved
byte which may be used for other purpose.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e3bab8f..463f291 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -884,8 +884,8 @@ struct hclge_cfg_tso_status_cmd {
 
 #define HCLGE_GRO_EN_B		0
 struct hclge_cfg_gro_status_cmd {
-	__le16 gro_en;
-	u8 rsv[22];
+	u8 gro_en;
+	u8 rsv[23];
 };
 
 #define HCLGE_TSO_MSS_MIN	256
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e9b0e1c..1e4f285 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1456,7 +1456,7 @@ static int hclge_config_gro(struct hclge_dev *hdev, bool en)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_GRO_GENERIC_CONFIG, false);
 	req = (struct hclge_cfg_gro_status_cmd *)desc.data;
 
-	req->gro_en = cpu_to_le16(en ? 1 : 0);
+	req->gro_en = en ? 1 : 0;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
-- 
2.7.4

