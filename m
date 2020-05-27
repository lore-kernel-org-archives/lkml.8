Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A33C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B6920888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgE0BAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:00:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5341 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727812AbgE0BAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:00:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5900943A41C341C0CCE;
        Wed, 27 May 2020 09:00:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 09:00:34 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 2/4] net: hns3: change the order of reinitializing RoCE and NIC client during reset
Date:   Wed, 27 May 2020 08:59:15 +0800
Message-ID: <1590541157-6803-3-git-send-email-tanhuazhong@huawei.com>
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

From: Yufeng Mo <moyufeng@huawei.com>

The HNS RDMA driver will support VF device later, whose
re-initialization should be done after PF's. This patch
changes the order of hclge_reset_prepare_up() and
hclge_notify_roce_client(), so that PF's RoCE client
will be reinitialized before VF's.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b796d3f..6e1e2cf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3770,11 +3770,6 @@ static int hclge_reset_rebuild(struct hclge_dev *hdev)
 
 	hclge_clear_reset_cause(hdev);
 
-	ret = hclge_reset_prepare_up(hdev);
-	if (ret)
-		return ret;
-
-
 	ret = hclge_notify_roce_client(hdev, HNAE3_INIT_CLIENT);
 	/* ignore RoCE notify error if it fails HCLGE_RESET_MAX_FAIL_CNT - 1
 	 * times
@@ -3783,6 +3778,10 @@ static int hclge_reset_rebuild(struct hclge_dev *hdev)
 	    hdev->rst_stats.reset_fail_cnt < HCLGE_RESET_MAX_FAIL_CNT - 1)
 		return ret;
 
+	ret = hclge_reset_prepare_up(hdev);
+	if (ret)
+		return ret;
+
 	rtnl_lock();
 	ret = hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 	rtnl_unlock();
-- 
2.7.4

