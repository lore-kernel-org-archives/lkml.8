Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC85206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHAJLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:11:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgHAJLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:11:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4A2C6BBC4E29DDDCD8A5;
        Sat,  1 Aug 2020 17:11:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 1 Aug 2020
 17:11:18 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <aelior@marvell.com>, <GR-everest-linux-l2@marvell.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: qede: use eth_zero_addr() to clear mac address
Date:   Sat, 1 Aug 2020 17:13:54 +0800
Message-ID: <1596273234-24230-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Use eth_zero_addr() to clear mac address instead of memset().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 29e285430f99..e1617a67a714 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2678,8 +2678,8 @@ static void qede_get_generic_tlv_data(void *dev, struct qed_generic_tlvs *data)
 		data->feat_flags |= QED_TLV_LSO;
 
 	ether_addr_copy(data->mac[0], edev->ndev->dev_addr);
-	memset(data->mac[1], 0, ETH_ALEN);
-	memset(data->mac[2], 0, ETH_ALEN);
+	eth_zero_addr(data->mac[1]);
+	eth_zero_addr(data->mac[2]);
 	/* Copy the first two UC macs */
 	netif_addr_lock_bh(edev->ndev);
 	i = 1;
-- 
2.19.1

