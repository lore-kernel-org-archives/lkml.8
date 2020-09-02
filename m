Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CEDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07FD2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:40:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbgIBJk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:40:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 473F060BB822D08A1849;
        Wed,  2 Sep 2020 17:40:55 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Sep 2020 17:40:47 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net 3/3] hinic: fix bug of send pkts while setting channels
Date:   Wed, 2 Sep 2020 17:41:45 +0800
Message-ID: <20200902094145.12216-4-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902094145.12216-1-luobin9@huawei.com>
References: <20200902094145.12216-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling hinic_close in hinic_set_channels, netif_carrier_off
and netif_tx_disable are excuted, and TX host resources are freed
after that. Core may call hinic_xmit_frame to send pkt after
netif_tx_disable within a short time, so we should judge whether
carrier is on before sending pkt otherwise the resources that
have already been freed in hinic_close may be accessed.

Fixes: 2eed5a8b614b ("hinic: add set_channels ethtool_ops support")
Signed-off-by: Luo bin <luobin9@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index a97498ee6914..a0662552a39c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -531,6 +531,11 @@ netdev_tx_t hinic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	struct hinic_txq *txq;
 	struct hinic_qp *qp;
 
+	if (unlikely(!netif_carrier_ok(netdev))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
 	txq = &nic_dev->txqs[q_id];
 	qp = container_of(txq->sq, struct hinic_qp, sq);
 
-- 
2.17.1

