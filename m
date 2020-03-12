Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEAC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1739A206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgCLHMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:12:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388083AbgCLHMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:12:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F84D167B5C93E76AC93;
        Thu, 12 Mar 2020 15:12:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 15:12:06 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 1/4] net: hns3: fix "tc qdisc del" failed issue
Date:   Thu, 12 Mar 2020 15:11:03 +0800
Message-ID: <1583997066-24773-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583997066-24773-1-git-send-email-tanhuazhong@huawei.com>
References: <1583997066-24773-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

The HNS3 driver supports to configure TC numbers and TC to priority
map via "tc" tool. But when delete the rule, will fail, because
the HNS3 driver needs at least one TC, but the "tc" tool sets TC
number to zero when delete.

This patch makes sure that the TC number is at least one.

Fixes: 30d240dfa2e8 ("net: hns3: Add mqprio hardware offload support in hns3 driver")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index acb796c..a7f40aa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1711,7 +1711,7 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	netif_dbg(h, drv, netdev, "setup tc: num_tc=%u\n", tc);
 
 	return (kinfo->dcb_ops && kinfo->dcb_ops->setup_tc) ?
-		kinfo->dcb_ops->setup_tc(h, tc, prio_tc) : -EOPNOTSUPP;
+		kinfo->dcb_ops->setup_tc(h, tc ? tc : 1, prio_tc) : -EOPNOTSUPP;
 }
 
 static int hns3_nic_setup_tc(struct net_device *dev, enum tc_setup_type type,
-- 
2.7.4

