Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA15722DD6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgFTCrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:47:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731973AbgFTCrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:47:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4EFA8DE9F8059814A852;
        Sat, 20 Jun 2020 10:47:06 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:46:57 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <vishal@chelsio.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <hariprasad@chelsio.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liheng40@huawei.com>
Subject: [PATCH resend] net: cxgb4: fix return error value in t4_prep_fw
Date:   Sat, 20 Jun 2020 10:49:21 +0800
Message-ID: <1592621361-39925-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t4_prep_fw goto bye tag with positive return value when something
bad happened and which can not free resource in adap_init0.
so fix it to return negative value.

Fixes: 16e47624e76b ("cxgb4: Add new scheme to update T4/T5 firmware")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---

resent with netdev cced

---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 2a3480f..9121cef 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3493,7 +3493,7 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 	drv_fw = &fw_info->fw_hdr;

 	/* Read the header of the firmware on the card */
-	ret = -t4_read_flash(adap, FLASH_FW_START,
+	ret = t4_read_flash(adap, FLASH_FW_START,
 			    sizeof(*card_fw) / sizeof(uint32_t),
 			    (uint32_t *)card_fw, 1);
 	if (ret == 0) {
@@ -3522,8 +3522,8 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 		   should_install_fs_fw(adap, card_fw_usable,
 					be32_to_cpu(fs_fw->fw_ver),
 					be32_to_cpu(card_fw->fw_ver))) {
-		ret = -t4_fw_upgrade(adap, adap->mbox, fw_data,
-				     fw_size, 0);
+		ret = t4_fw_upgrade(adap, adap->mbox, fw_data,
+				    fw_size, 0);
 		if (ret != 0) {
 			dev_err(adap->pdev_dev,
 				"failed to install firmware: %d\n", ret);
@@ -3554,7 +3554,7 @@ int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 			FW_HDR_FW_VER_MICRO_G(c), FW_HDR_FW_VER_BUILD_G(c),
 			FW_HDR_FW_VER_MAJOR_G(k), FW_HDR_FW_VER_MINOR_G(k),
 			FW_HDR_FW_VER_MICRO_G(k), FW_HDR_FW_VER_BUILD_G(k));
-		ret = EINVAL;
+		ret = -EINVAL;
 		goto bye;
 	}

--
2.7.4

