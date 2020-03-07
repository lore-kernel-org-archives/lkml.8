Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14083C10F28
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EA7206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCGDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:52:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbgCGDwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:52:34 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2B79423C44678E34114C;
        Sat,  7 Mar 2020 11:52:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 7 Mar 2020 11:52:18 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 2/9] net: hns3: rename macro HCLGE_MAX_NCL_CONFIG_LENGTH
Date:   Sat, 7 Mar 2020 11:42:43 +0800
Message-ID: <1583552570-51203-3-git-send-email-tanhuazhong@huawei.com>
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

From: Yufeng Mo <moyufeng@huawei.com>

The name of macro HCLGE_MAX_NCL_CONFIG_LENGTH is inaccurate,
this patch renames it to HCLGE_NCL_CONFIG_LENGTH_IN_EACH_CMD.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index afa7c6ff..0538e81 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -1137,7 +1137,7 @@ static void hclge_dbg_dump_ncl_config(struct hclge_dev *hdev,
 				      const char *cmd_buf)
 {
 #define HCLGE_MAX_NCL_CONFIG_OFFSET	4096
-#define HCLGE_MAX_NCL_CONFIG_LENGTH	(20 + 24 * 4)
+#define HCLGE_NCL_CONFIG_LENGTH_IN_EACH_CMD	(20 + 24 * 4)
 
 	struct hclge_desc desc[HCLGE_CMD_NCL_CONFIG_BD_NUM];
 	int bd_num = HCLGE_CMD_NCL_CONFIG_BD_NUM;
@@ -1161,8 +1161,8 @@ static void hclge_dbg_dump_ncl_config(struct hclge_dev *hdev,
 
 	while (length > 0) {
 		data0 = offset;
-		if (length >= HCLGE_MAX_NCL_CONFIG_LENGTH)
-			data0 |= HCLGE_MAX_NCL_CONFIG_LENGTH << 16;
+		if (length >= HCLGE_NCL_CONFIG_LENGTH_IN_EACH_CMD)
+			data0 |= HCLGE_NCL_CONFIG_LENGTH_IN_EACH_CMD << 16;
 		else
 			data0 |= length << 16;
 		ret = hclge_dbg_cmd_send(hdev, desc, data0, bd_num,
-- 
2.7.4

