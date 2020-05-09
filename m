Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F02CC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B36214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEIJ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:29:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4377 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbgEIJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:29:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 61268B2BE607AE9CF394;
        Sat,  9 May 2020 17:29:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 17:28:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/5] net: hns3: provide .get_cmdq_stat interface for the client
Date:   Sat, 9 May 2020 17:27:39 +0800
Message-ID: <1589016461-10130-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589016461-10130-1-git-send-email-tanhuazhong@huawei.com>
References: <1589016461-10130-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a new interface for the client to query
whether CMDQ is ready to work.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 5602bf2..7506cab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -552,6 +552,7 @@ struct hnae3_ae_ops {
 	int (*set_vf_mac)(struct hnae3_handle *handle, int vf, u8 *p);
 	int (*get_module_eeprom)(struct hnae3_handle *handle, u32 offset,
 				 u32 len, u8 *data);
+	bool (*get_cmdq_stat)(struct hnae3_handle *handle);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3ad6a6a..1ff896a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6402,6 +6402,14 @@ static bool hclge_get_hw_reset_stat(struct hnae3_handle *handle)
 	       hclge_read_dev(&hdev->hw, HCLGE_FUN_RST_ING);
 }
 
+static bool hclge_get_cmdq_stat(struct hnae3_handle *handle)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	return test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+}
+
 static bool hclge_ae_dev_resetting(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -11311,6 +11319,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_vf_rate = hclge_set_vf_rate,
 	.set_vf_mac = hclge_set_vf_mac,
 	.get_module_eeprom = hclge_get_module_eeprom,
+	.get_cmdq_stat = hclge_get_cmdq_stat,
 };
 
 static struct hnae3_ae_algo ae_algo = {
-- 
2.7.4

