Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0253C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97767208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIEGNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 02:13:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgIEGNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:13:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C381FC90C41BB37DF5CD;
        Sat,  5 Sep 2020 14:13:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Sep 2020 14:13:38 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 2/2] net: disable UDP GSO features when CSUM is disable
Date:   Sat, 5 Sep 2020 14:11:13 +0800
Message-ID: <1599286273-26553-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com>
References: <1599286273-26553-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CSUM is not available, UDP GSO should be disable as well.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 net/core/dev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index d42c9ea..0c78306 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9402,6 +9402,18 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_TSO6;
 	}
 
+	if ((features & NETIF_F_GSO_UDP_L4) && !(features & NETIF_F_HW_CSUM) &&
+	    !(features & NETIF_F_IP_CSUM)) {
+		netdev_dbg(dev, "Dropping UDP GSO features since no CSUM feature.\n");
+		features &= ~NETIF_F_GSO_UDP_L4;
+	}
+
+	if ((features & NETIF_F_GSO_UDPV6_L4) && !(features & NETIF_F_HW_CSUM) &&
+	    !(features & NETIF_F_IPV6_CSUM)) {
+		netdev_dbg(dev, "Dropping UDPV6 GSO features since no CSUM feature.\n");
+		features &= ~NETIF_F_GSO_UDPV6_L4;
+	}
+
 	/* TSO with IPv4 ID mangling requires IPv4 TSO be enabled */
 	if ((features & NETIF_F_TSO_MANGLEID) && !(features & NETIF_F_TSO))
 		features &= ~NETIF_F_TSO_MANGLEID;
-- 
2.7.4

