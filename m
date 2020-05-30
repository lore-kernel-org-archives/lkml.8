Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30ADC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A683E206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgE3BKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:10:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728624AbgE3BKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:10:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE2C4275174B2C4C86B9;
        Sat, 30 May 2020 09:10:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 30 May 2020 09:09:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 6/6] net: hns3: remove some unused codes in hns3_nic_set_features()
Date:   Sat, 30 May 2020 09:08:32 +0800
Message-ID: <1590800912-52467-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590800912-52467-1-git-send-email-tanhuazhong@huawei.com>
References: <1590800912-52467-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NETIF_F_HW_VLAN_CTAG_FILTER is not set in netdev->hw_feature for
the HNS3 driver, so the handler of NETIF_F_HW_VLAN_CTAG_FILTER
in hns3_nic_set_features() won't be called, remove it.

Reported-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9fe40c7..b14f2ab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1544,12 +1544,6 @@ static int hns3_nic_set_features(struct net_device *netdev,
 			return ret;
 	}
 
-	if ((changed & NETIF_F_HW_VLAN_CTAG_FILTER) &&
-	    h->ae_algo->ops->enable_vlan_filter) {
-		enable = !!(features & NETIF_F_HW_VLAN_CTAG_FILTER);
-		h->ae_algo->ops->enable_vlan_filter(h, enable);
-	}
-
 	if ((changed & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    h->ae_algo->ops->enable_hw_strip_rxvtag) {
 		enable = !!(features & NETIF_F_HW_VLAN_CTAG_RX);
-- 
2.7.4

