Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD80C5ED47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7720801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgB0OUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:20:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389647AbgB0OU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:20:28 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 824AD17C06583325A54F;
        Thu, 27 Feb 2020 22:20:22 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 22:20:12 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, Luo bin <luobin9@huawei.com>
Subject: [PATCH net v1 1/3] hinic: fix a irq affinity bug
Date:   Thu, 27 Feb 2020 06:34:42 +0000
Message-ID: <20200227063444.2143-2-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227063444.2143-1-luobin9@huawei.com>
References: <20200227063444.2143-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can not use a local variable as an input parameter of
irq_set_affinity_hint

Signed-off-by: Luo bin <luobin9@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h | 1 +
 drivers/net/ethernet/huawei/hinic/hinic_rx.c    | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
index f4a339b10b10..79091e131418 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
@@ -94,6 +94,7 @@ struct hinic_rq {
 
 	struct hinic_wq         *wq;
 
+	struct cpumask		affinity_mask;
 	u32                     irq;
 	u16                     msix_entry;
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 56ea6d692f1c..2695ad69fca6 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -475,7 +475,6 @@ static int rx_request_irq(struct hinic_rxq *rxq)
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_rq *rq = rxq->rq;
 	struct hinic_qp *qp;
-	struct cpumask mask;
 	int err;
 
 	rx_add_napi(rxq);
@@ -492,8 +491,8 @@ static int rx_request_irq(struct hinic_rxq *rxq)
 	}
 
 	qp = container_of(rq, struct hinic_qp, rq);
-	cpumask_set_cpu(qp->q_id % num_online_cpus(), &mask);
-	return irq_set_affinity_hint(rq->irq, &mask);
+	cpumask_set_cpu(qp->q_id % num_online_cpus(), &rq->affinity_mask);
+	return irq_set_affinity_hint(rq->irq, &rq->affinity_mask);
 }
 
 static void rx_free_irq(struct hinic_rxq *rxq)
-- 
2.17.1

