Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14166C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96A320828
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCFC6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:58:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbgCFC6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:58:03 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E514ED4F500B8F380FB;
        Fri,  6 Mar 2020 10:57:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 10:57:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: remove an unnecessary resetting check in hclge_handle_hw_ras_error()
Date:   Fri, 6 Mar 2020 10:57:12 +0800
Message-ID: <1583463438-60953-4-git-send-email-tanhuazhong@huawei.com>
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

From: Yufeng Mo <moyufeng@huawei.com>

In hclge_handle_hw_ras_error(), it is unnecessary to check
HCLGE_STATE_RST_HANDLING flag, because the reset priority
has been ensured by the process itself.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index c85b72d..50d5ef7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1667,9 +1667,6 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
 		hclge_handle_rocee_ras_error(ae_dev);
 	}
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
-		goto out;
-
 	if (ae_dev->hw_err_reset_req)
 		return PCI_ERS_RESULT_NEED_RESET;
 
-- 
2.7.4

