Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91549C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F1820775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2gnbpn21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgDTPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:11:50 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16879 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgDTPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587395507; x=1618931507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tkYp8mXQrOUGLAhorBLa4Xkt3DBf8TC1ccFt4FP8Myo=;
  b=2gnbpn21aevri2+1N4TaqUWBpbKc1J88RNTpDJM53LZQVWJ4HJHaTWHa
   3qhC0kcVImCU2epkix4M76sjisXhsqUirBa/hwi7vJwm+Jrmk0Ggq8mCv
   Dv04/ExYd5S59Qdt6tJKoQezWhZZBQEY1eZxUW4FehXD0c9Sibjm8/DOZ
   b2cUKRiXibIkfHhnWoyk6vAO2bMyLGN9MN4dD5v27mI7/l9qUKsp4LlA0
   Ve35PpHdhKI906YEVrwcQzVXWJdcLDd233J9RRlcc03nJn8g/pNY/kcaQ
   I8anZTdGXKziuQ/cPCPIaxBPO7PBt9sJqz4pLnhHVDPRDUQPZgtvgko4+
   A==;
IronPort-SDR: LarK3s0nLkWt/N33MkLqmds25wknG4Yk76gVesC5UFCm+AQZF57WjIdekGhBebzCnoWpTSPtUI
 qK5VHfXk6eO1gA+0ObE6nwRI08CfAK0lJskkPbR0Pn/O3WgM+6rJ7ZNvWM8UEHt7o148EEhc0J
 kk73xjL3cuVJ92EiZi2xYr+QIXReNlm12U9hrFad548Yw/fSRX5umxU/os9cTp1mj72tHXzLyl
 HP7F2yLmGPsSPJH4xK6SIyPz5oS0lYrIS0pOJPwyRRSFrqFoAbYNQIwFYbCOg3l1V+LTC4iRDz
 JNI=
X-IronPort-AV: E=Sophos;i="5.72,406,1580799600"; 
   d="scan'208";a="70911705"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 08:11:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 08:11:45 -0700
Received: from soft-dev3.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Apr 2020 08:11:15 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <jiri@resnulli.us>, <ivecera@redhat.com>, <kuba@kernel.org>,
        <roopa@cumulusnetworks.com>, <olteanv@gmail.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 02/13] net: bridge: Add port attribute IFLA_BRPORT_MRP_RING_OPEN
Date:   Mon, 20 Apr 2020 17:09:36 +0200
Message-ID: <20200420150947.30974-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420150947.30974-1-horatiu.vultur@microchip.com>
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new port attribute, IFLA_BRPORT_MRP_RING_OPEN, which allows
to notify the userspace when the port lost the continuite of MRP frames.

This attribute is set by kernel whenever the SW or HW detects that the ring is
being open or closed.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_link.h       | 1 +
 net/bridge/br_netlink.c            | 6 ++++++
 net/bridge/br_private.h            | 4 ++++
 tools/include/uapi/linux/if_link.h | 1 +
 4 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 61e0801c82df..4a295deb933b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -343,6 +343,7 @@ enum {
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
+	IFLA_BRPORT_MRP_RING_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 43dab4066f91..2f3a9e50c168 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -151,6 +151,9 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MULTICAST_ROUTER */
 #endif
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
+#endif
 		+ 0;
 }
 
@@ -213,6 +216,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
 		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, p->loc) ||
+#endif
 	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
 		return -EMSGSIZE;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1f97703a52ff..735ec6ff86cc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -289,6 +289,10 @@ struct net_bridge_port {
 	u16				backup_redirected_cnt;
 
 	struct bridge_stp_xstats	stp_xstats;
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	u8				loc;
+#endif
 };
 
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 024af2d1d0af..70dae9ba16f4 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -343,6 +343,7 @@ enum {
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
+	IFLA_BRPORT_MRP_RING_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
-- 
2.17.1

