Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CFCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F94C206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbgE1MrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:47:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389783AbgE1Mqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:46:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 346702F7B95CB506CC26;
        Thu, 28 May 2020 20:46:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 20:46:36 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: refactor hclge_config_tso()
Date:   Thu, 28 May 2020 20:45:03 +0800
Message-ID: <1590669912-21867-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590669912-21867-1-git-send-email-tanhuazhong@huawei.com>
References: <1590669912-21867-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since parameters 'tso_mss_min' and 'tso_mss_max' only indicate
the minimum and maximum MSS, the hnae3_set_field() calls are
meaningless, remove them and change the type of these two
parameters to u16.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ff8ad4b..21ad23e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1429,26 +1429,17 @@ static int hclge_configure(struct hclge_dev *hdev)
 	return ret;
 }
 
-static int hclge_config_tso(struct hclge_dev *hdev, unsigned int tso_mss_min,
-			    unsigned int tso_mss_max)
+static int hclge_config_tso(struct hclge_dev *hdev, u16 tso_mss_min,
+			    u16 tso_mss_max)
 {
 	struct hclge_cfg_tso_status_cmd *req;
 	struct hclge_desc desc;
-	u16 tso_mss;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TSO_GENERIC_CONFIG, false);
 
 	req = (struct hclge_cfg_tso_status_cmd *)desc.data;
-
-	tso_mss = 0;
-	hnae3_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
-			HCLGE_TSO_MSS_MIN_S, tso_mss_min);
-	req->tso_mss_min = cpu_to_le16(tso_mss);
-
-	tso_mss = 0;
-	hnae3_set_field(tso_mss, HCLGE_TSO_MSS_MIN_M,
-			HCLGE_TSO_MSS_MIN_S, tso_mss_max);
-	req->tso_mss_max = cpu_to_le16(tso_mss);
+	req->tso_mss_min = cpu_to_le16(tso_mss_min);
+	req->tso_mss_max = cpu_to_le16(tso_mss_max);
 
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
-- 
2.7.4

