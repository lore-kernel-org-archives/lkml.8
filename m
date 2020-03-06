Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA0CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C697220828
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCFC6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:58:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbgCFC6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:58:02 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66351D6014C0E3BD13FE;
        Fri,  6 Mar 2020 10:57:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 10:57:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: add a check before PF inform VF to reset
Date:   Fri, 6 Mar 2020 10:57:14 +0800
Message-ID: <1583463438-60953-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583463438-60953-1-git-send-email-tanhuazhong@huawei.com>
References: <1583463438-60953-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When setting VF's MAC from PF, if the VF driver not loaded, the
firmware will return error to PF.

So PF should check whether VF is alive before sending message to
VF when setting VF's MAC.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6da55fb3..69e2008 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7617,11 +7617,17 @@ static int hclge_set_vf_mac(struct hnae3_handle *handle, int vf,
 	}
 
 	ether_addr_copy(vport->vf_info.mac, mac_addr);
-	dev_info(&hdev->pdev->dev,
-		 "MAC of VF %d has been set to %pM, and it will be reinitialized!\n",
-		 vf, mac_addr);
 
-	return hclge_inform_reset_assert_to_vf(vport);
+	if (test_bit(HCLGE_VPORT_STATE_ALIVE, &vport->state)) {
+		dev_info(&hdev->pdev->dev,
+			 "MAC of VF %d has been set to %pM, and it will be reinitialized!\n",
+			 vf, mac_addr);
+		return hclge_inform_reset_assert_to_vf(vport);
+	}
+
+	dev_info(&hdev->pdev->dev, "MAC of VF %d has been set to %pM\n",
+		 vf, mac_addr);
+	return 0;
 }
 
 static int hclge_add_mgr_tbl(struct hclge_dev *hdev,
-- 
2.7.4

