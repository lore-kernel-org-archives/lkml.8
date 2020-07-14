Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F38C43446
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742452084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qJD05AJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGNHjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:39:44 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:43825 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgGNHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594712372; x=1626248372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVKMV+YoS0rvNMp387sg/5WAHdCOziofqNB5E+Ov/pE=;
  b=qJD05AJCi2ce2Hh8bgB9uRsXCvdsBAk0UGhNcjuyx4PKfABVl7a60b2h
   aCFefG9x6B+jKvhMN/K81EnY/fPrCNylgGlnLXmoMQIGtyvX9hc/knpU3
   X921ehndpBldxoA6gwKGqisEY+I35D9tsYPo973QNniNXZWSOnxi4IY33
   OKEpiyrQIDa816yatR2ASv5MZ6nO/hPTYHEua1xdQpR8z2quLdZwRxPnl
   ACKsr3mR15WXs5PfbiBlhp7XZLzKWvO3U2K3T4MrKVOfm2pD3RlhTINV9
   TbCo42lyncEvz/c5MXForSuBuRxUEQnwt6SnAbyu+J2RCeQcA1vILXFCd
   Q==;
IronPort-SDR: HrQAAVfkbQIakGxNO3rZFsFb+7uPMCQBfCgD81OkyMIA4z4gzP40lYBzBSdzhmh98O6BagkqH/
 +qAhfSy7eao5ox2kBM+ffyXkwXUeziNxatFXt3rLIoi0TsNr7O5U0CCcw2QqrrCt0YWPsxrn9J
 bOik0Iz6E8Bx+TJf5rOzqJwdYdE3PM2dSmi0Ku8hnTj6YYHVXgKQHnO15gEjLzVZ9J4dtX28dt
 XkwaTTtOSGF058Dl9wWvAWDbaDuiS3zrvLYqMtyc1gD+FjcHzzYlPFQWEkS/aQiK3lp/ZMcV42
 wjw=
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="19100028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2020 00:39:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 00:39:31 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 14 Jul 2020 00:39:29 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 11/12] bridge: mrp: Extend br_mrp_fill_info
Date:   Tue, 14 Jul 2020 09:34:57 +0200
Message-ID: <20200714073458.1939574-12-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the function br_mrp_fill_info to return also the
status for the interconnect ring.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index a006e0771e8d3..2a2fdf3500c5b 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -474,6 +474,11 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 				     p->dev->ifindex))
 			goto nla_put_failure;
 
+		p = rcu_dereference(mrp->i_port);
+		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
+				     p->dev->ifindex))
+			goto nla_put_failure;
+
 		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
 				mrp->prio))
 			goto nla_put_failure;
@@ -493,6 +498,19 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 				mrp->test_monitor))
 			goto nla_put_failure;
 
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_STATE,
+				mrp->in_state))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_ROLE,
+				mrp->in_role))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
+				mrp->in_test_interval))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
+				mrp->in_test_max_miss))
+			goto nla_put_failure;
+
 		nla_nest_end(skb, tb);
 	}
 	nla_nest_end(skb, mrp_tb);
-- 
2.27.0

