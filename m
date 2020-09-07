Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E48C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F3821532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgIGRO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:14:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729636AbgIGOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:14:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C94C9136E6560B3A4875;
        Mon,  7 Sep 2020 22:14:18 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 22:14:08 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
Subject: [PATCH net] hinic: fix rewaking txq after netif_tx_disable
Date:   Mon, 7 Sep 2020 22:15:16 +0800
Message-ID: <20200907141516.16817-1-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling hinic_close in hinic_set_channels, all queues are
stopped after netif_tx_disable, but some queue may be rewaken in
free_tx_poll by mistake while drv is handling tx irq. If one queue
is rewaken core may call hinic_xmit_frame to send pkt after
netif_tx_disable within a short time which may results in accessing
memory that has been already freed in hinic_close. So we judge
whether the netdev is in down state before waking txq in free_tx_poll
to fix this bug.

Signed-off-by: Luo bin <luobin9@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index a97498ee6914..6eac6bdf164e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -718,7 +718,8 @@ static int free_tx_poll(struct napi_struct *napi, int budget)
 
 		__netif_tx_lock(netdev_txq, smp_processor_id());
 
-		netif_wake_subqueue(nic_dev->netdev, qp->q_id);
+		if (nic_dev->flags & HINIC_INTF_UP)
+			netif_wake_subqueue(nic_dev->netdev, qp->q_id);
 
 		__netif_tx_unlock(netdev_txq);
 
-- 
2.17.1

