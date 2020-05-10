Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD19DC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D55620731
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgEKCoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:44:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgEKCoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:44:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0D7F9B4DF38CDC892A2;
        Mon, 11 May 2020 10:43:55 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:43:45 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <luobin9@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH net v3] hinic: fix a bug of ndo_stop
Date:   Sun, 10 May 2020 19:01:08 +0000
Message-ID: <20200510190108.22847-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if some function in ndo_stop interface returns failure because of
hardware fault, must go on excuting rest steps rather than return
failure directly, otherwise will cause memory leak.And bump the
timeout for SET_FUNC_STATE to ensure that cmd won't return failure
when hw is busy. Otherwise hw may stomp host memory if we free
memory regardless of the return value of SET_FUNC_STATE.

Fixes: 51ba902a16e6 ("net-next/hinic: Initialize hw interface")
Signed-off-by: Luo bin <luobin9@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_mgmt.c    | 16 ++++++++++++----
 drivers/net/ethernet/huawei/hinic/hinic_main.c   | 16 ++--------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
index 8995e32dd1c0..992908e6eebf 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
@@ -45,6 +45,8 @@
 
 #define MGMT_MSG_TIMEOUT                5000
 
+#define SET_FUNC_PORT_MGMT_TIMEOUT	25000
+
 #define mgmt_to_pfhwdev(pf_mgmt)        \
 		container_of(pf_mgmt, struct hinic_pfhwdev, pf_to_mgmt)
 
@@ -238,12 +240,13 @@ static int msg_to_mgmt_sync(struct hinic_pf_to_mgmt *pf_to_mgmt,
 			    u8 *buf_in, u16 in_size,
 			    u8 *buf_out, u16 *out_size,
 			    enum mgmt_direction_type direction,
-			    u16 resp_msg_id)
+			    u16 resp_msg_id, u32 timeout)
 {
 	struct hinic_hwif *hwif = pf_to_mgmt->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	struct hinic_recv_msg *recv_msg;
 	struct completion *recv_done;
+	unsigned long timeo;
 	u16 msg_id;
 	int err;
 
@@ -267,8 +270,9 @@ static int msg_to_mgmt_sync(struct hinic_pf_to_mgmt *pf_to_mgmt,
 		goto unlock_sync_msg;
 	}
 
-	if (!wait_for_completion_timeout(recv_done,
-					 msecs_to_jiffies(MGMT_MSG_TIMEOUT))) {
+	timeo = msecs_to_jiffies(timeout ? timeout : MGMT_MSG_TIMEOUT);
+
+	if (!wait_for_completion_timeout(recv_done, timeo)) {
 		dev_err(&pdev->dev, "MGMT timeout, MSG id = %d\n", msg_id);
 		err = -ETIMEDOUT;
 		goto unlock_sync_msg;
@@ -342,6 +346,7 @@ int hinic_msg_to_mgmt(struct hinic_pf_to_mgmt *pf_to_mgmt,
 {
 	struct hinic_hwif *hwif = pf_to_mgmt->hwif;
 	struct pci_dev *pdev = hwif->pdev;
+	u32 timeout = 0;
 
 	if (sync != HINIC_MGMT_MSG_SYNC) {
 		dev_err(&pdev->dev, "Invalid MGMT msg type\n");
@@ -353,9 +358,12 @@ int hinic_msg_to_mgmt(struct hinic_pf_to_mgmt *pf_to_mgmt,
 		return -EINVAL;
 	}
 
+	if (cmd == HINIC_PORT_CMD_SET_FUNC_STATE)
+		timeout = SET_FUNC_PORT_MGMT_TIMEOUT;
+
 	return msg_to_mgmt_sync(pf_to_mgmt, mod, cmd, buf_in, in_size,
 				buf_out, out_size, MGMT_DIRECT_SEND,
-				MSG_NOT_RESP);
+				MSG_NOT_RESP, timeout);
 }
 
 /**
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 13560975c103..63b92f6cc856 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -483,7 +483,6 @@ static int hinic_close(struct net_device *netdev)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
 	unsigned int flags;
-	int err;
 
 	down(&nic_dev->mgmt_lock);
 
@@ -497,20 +496,9 @@ static int hinic_close(struct net_device *netdev)
 
 	up(&nic_dev->mgmt_lock);
 
-	err = hinic_port_set_func_state(nic_dev, HINIC_FUNC_PORT_DISABLE);
-	if (err) {
-		netif_err(nic_dev, drv, netdev,
-			  "Failed to set func port state\n");
-		nic_dev->flags |= (flags & HINIC_INTF_UP);
-		return err;
-	}
+	hinic_port_set_state(nic_dev, HINIC_PORT_DISABLE);
 
-	err = hinic_port_set_state(nic_dev, HINIC_PORT_DISABLE);
-	if (err) {
-		netif_err(nic_dev, drv, netdev, "Failed to set port state\n");
-		nic_dev->flags |= (flags & HINIC_INTF_UP);
-		return err;
-	}
+	hinic_port_set_func_state(nic_dev, HINIC_FUNC_PORT_DISABLE);
 
 	if (nic_dev->flags & HINIC_RSS_ENABLE) {
 		hinic_rss_deinit(nic_dev);
-- 
2.17.1

