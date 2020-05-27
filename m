Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDCAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4B120888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE0BAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:00:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbgE0BAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:00:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC9355B34488991F8AFE;
        Wed, 27 May 2020 09:00:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 09:00:33 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 1/4] net: hns3: add a resetting check in hclgevf_init_nic_client_instance()
Date:   Wed, 27 May 2020 08:59:14 +0800
Message-ID: <1590541157-6803-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590541157-6803-1-git-send-email-tanhuazhong@huawei.com>
References: <1590541157-6803-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangbin Huang <huangguangbin2@huawei.com>

To prevent from initializing VF NIC client in reset handling state,
this patch adds resetting check in hclgevf_init_nic_client_instance().

Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 32341dc..59fcb80 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2713,6 +2713,7 @@ static int hclgevf_init_nic_client_instance(struct hnae3_ae_dev *ae_dev,
 					    struct hnae3_client *client)
 {
 	struct hclgevf_dev *hdev = ae_dev->priv;
+	int rst_cnt = hdev->rst_stats.rst_cnt;
 	int ret;
 
 	ret = client->ops->init_instance(&hdev->nic);
@@ -2720,6 +2721,14 @@ static int hclgevf_init_nic_client_instance(struct hnae3_ae_dev *ae_dev,
 		return ret;
 
 	set_bit(HCLGEVF_STATE_NIC_REGISTERED, &hdev->state);
+	if (test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state) ||
+	    rst_cnt != hdev->rst_stats.rst_cnt) {
+		clear_bit(HCLGEVF_STATE_NIC_REGISTERED, &hdev->state);
+
+		client->ops->uninit_instance(&hdev->nic, 0);
+		return -EBUSY;
+	}
+
 	hnae3_set_client_init_flag(client, ae_dev, 1);
 
 	if (netif_msg_drv(&hdev->nic))
-- 
2.7.4

