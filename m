Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC27C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DE521582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEIJ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:29:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbgEIJ3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:29:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65F8A76E6C49B76A88C6;
        Sat,  9 May 2020 17:29:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 17:28:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yufeng Mo <moyufeng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 5/5] net: hns3: disable auto-negotiation off with 1000M setting in ethtool
Date:   Sat, 9 May 2020 17:27:41 +0800
Message-ID: <1589016461-10130-6-git-send-email-tanhuazhong@huawei.com>
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

From: Yufeng Mo <moyufeng@huawei.com>

The 802.3 specification does not specify the behavior of
auto-negotiation off with 1000M in PHY. Therefore, some PHY
compatibility issues occur. This patch forbids the setting of
this unreasonable mode by ethtool in driver.

Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 1a105f2..6b1545f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -773,8 +773,13 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 		  cmd->base.autoneg, cmd->base.speed, cmd->base.duplex);
 
 	/* Only support ksettings_set for netdev with phy attached for now */
-	if (netdev->phydev)
+	if (netdev->phydev) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg == AUTONEG_DISABLE)
+			return -EINVAL;
+
 		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
+	}
 
 	if (handle->pdev->revision == 0x20)
 		return -EOPNOTSUPP;
-- 
2.7.4

