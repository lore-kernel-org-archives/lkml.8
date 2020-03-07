Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA12C10F29
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A22073B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCGDwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:52:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11601 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgCGDwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:52:35 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 046BD973D302226F94EE;
        Sat,  7 Mar 2020 11:52:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 7 Mar 2020 11:52:20 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 8/9] net: hns3: synchronize some print relating to reset issue
Date:   Sat, 7 Mar 2020 11:42:49 +0800
Message-ID: <1583552570-51203-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583552570-51203-1-git-send-email-tanhuazhong@huawei.com>
References: <1583552570-51203-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies some printing relating to reset issue.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index acb796c..c54f262 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2228,7 +2228,7 @@ static void hns3_reset_prepare(struct pci_dev *pdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 
-	dev_info(&pdev->dev, "hns3 flr prepare\n");
+	dev_info(&pdev->dev, "FLR prepare\n");
 	if (ae_dev && ae_dev->ops && ae_dev->ops->flr_prepare)
 		ae_dev->ops->flr_prepare(ae_dev);
 }
@@ -2237,7 +2237,7 @@ static void hns3_reset_done(struct pci_dev *pdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 
-	dev_info(&pdev->dev, "hns3 flr done\n");
+	dev_info(&pdev->dev, "FLR done\n");
 	if (ae_dev && ae_dev->ops && ae_dev->ops->flr_done)
 		ae_dev->ops->flr_done(ae_dev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 69e2008..cdf7f4b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3442,7 +3442,7 @@ static void hclge_do_reset(struct hclge_dev *hdev)
 	u32 val;
 
 	if (hclge_get_hw_reset_stat(handle)) {
-		dev_info(&pdev->dev, "Hardware reset not finish\n");
+		dev_info(&pdev->dev, "hardware reset not finish\n");
 		dev_info(&pdev->dev, "func_rst_reg:0x%x, global_rst_reg:0x%x\n",
 			 hclge_read_dev(&hdev->hw, HCLGE_FUN_RST_ING),
 			 hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG));
@@ -3451,20 +3451,20 @@ static void hclge_do_reset(struct hclge_dev *hdev)
 
 	switch (hdev->reset_type) {
 	case HNAE3_GLOBAL_RESET:
+		dev_info(&pdev->dev, "global reset requested\n");
 		val = hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG);
 		hnae3_set_bit(val, HCLGE_GLOBAL_RESET_BIT, 1);
 		hclge_write_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG, val);
-		dev_info(&pdev->dev, "Global Reset requested\n");
 		break;
 	case HNAE3_FUNC_RESET:
-		dev_info(&pdev->dev, "PF Reset requested\n");
+		dev_info(&pdev->dev, "PF reset requested\n");
 		/* schedule again to check later */
 		set_bit(HNAE3_FUNC_RESET, &hdev->reset_pending);
 		hclge_reset_task_schedule(hdev);
 		break;
 	default:
 		dev_warn(&pdev->dev,
-			 "Unsupported reset type: %d\n", hdev->reset_type);
+			 "unsupported reset type: %d\n", hdev->reset_type);
 		break;
 	}
 }
-- 
2.7.4

