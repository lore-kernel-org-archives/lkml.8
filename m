Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD3C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61852206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b4ILqo6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgDZNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:24:03 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31726 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgDZNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587907437; x=1619443437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0yptRMo4MvCwLf+WjvAV0w3pbDKYihM8FVKq9kNuzYw=;
  b=b4ILqo6D9mf38bYWeJ6+SS10pJ5Xou3hLbARO2/phZyG36gmoBIa3GxF
   gUDk0lNQJuhGG3sNnjg00E3n4T5IoGDYZ/sW642ghI/434+o7bBuc1uXl
   KEvfOLuS5eLvSafNrV5cDeoltZeOPhu0g0YocJX3mKTGpAN68gqTDI9zn
   qM4TR3//DdD+wp8CyHqKI/4Nl+7l3UnYIwUfd3zKDTes757nj5eVIRMEj
   hPXnMI++xZqEFkJuMaii+c1locPDNschvXx+sfhVMGL57kuMyTu1azMes
   SL0vBfJ6krt/Gp/QAoDCAemDuH4a1uO+mdOPyCpSYqZb0eIP12ZqwfXJ8
   g==;
IronPort-SDR: Wq3cMYIuHx4JdRbED1w8onuPKdhxeuQ9aXFNvaZ7q+jp7Wygrg4uQZQGPf6ejgObQy4pFtPC1o
 VHaBi6ee1tiKynntqNajNqG+OcFLFgtaKsdxQd9tHjZZEb+GekmeX0ui5e54NrlRxw/iRRMapS
 WSpEFF0xLVwCA8TL794s8SNI0ywEhAZ9d8rXmyhMRM6idwhH1Uhuirb3OrkcDhreJgJ9785fjo
 fXa1WagPLl3Dk0ZYIpA5lND3BNX39MtC3PEg3RDt9mANbDTzsLBuxwLRCRo6nDONOo7zo1CnI9
 Xgc=
X-IronPort-AV: E=Sophos;i="5.73,320,1583218800"; 
   d="scan'208";a="73846772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2020 06:23:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 26 Apr 2020 06:23:55 -0700
Received: from soft-dev3.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Sun, 26 Apr 2020 06:23:53 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <jiri@resnulli.us>, <ivecera@redhat.com>, <kuba@kernel.org>,
        <roopa@cumulusnetworks.com>, <olteanv@gmail.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 03/11] bridge: mrp: Extend bridge interface
Date:   Sun, 26 Apr 2020 15:22:00 +0200
Message-ID: <20200426132208.3232-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426132208.3232-1-horatiu.vultur@microchip.com>
References: <20200426132208.3232-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To integrate MRP into the bridge, first the bridge needs to be aware of ports
that are part of an MRP ring and which rings are on the bridge.
Therefore extend bridge interface with the following:
- add new flag(BR_MPP_AWARE) to the net bridge ports, this bit will be
  set when the port is added to an MRP instance. In this way it knows if
  the frame was received on MRP ring port
- add new flag(BR_MRP_LOST_CONT) to the net bridge ports, this bit will be set
  when the port lost the continuity of MRP Test frames.
- add a list of MRP instances

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/if_bridge.h | 2 ++
 net/bridge/br_private.h   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 9e57c4411734..b3a8d3054af0 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -47,6 +47,8 @@ struct br_ip_list {
 #define BR_BCAST_FLOOD		BIT(14)
 #define BR_NEIGH_SUPPRESS	BIT(15)
 #define BR_ISOLATED		BIT(16)
+#define BR_MRP_AWARE		BIT(17)
+#define BR_MRP_LOST_CONT	BIT(18)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1f97703a52ff..835a70f8d3ea 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -428,6 +428,10 @@ struct net_bridge {
 	int offload_fwd_mark;
 #endif
 	struct hlist_head		fdb_list;
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	struct list_head		__rcu mrp_list;
+#endif
 };
 
 struct br_input_skb_cb {
-- 
2.17.1

