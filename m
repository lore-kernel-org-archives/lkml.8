Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D01C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4687B206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B737exln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgDUOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:42:56 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:56807 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgDUOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587480171; x=1619016171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=j9vuAzMiBC0XIenmNk+Q7ztffNdq+mbfWZ9t9r+B3uw=;
  b=B737exlnxR4OpepXo1qi1Hj6TimNr10Mi+Zy8lzI3W71P8kkVJ13haBg
   SshGEW3/GBfrGGfOR/wKGg99MG3QW89ZfHoUA0hiF9CvdFaeMv2GIE2xa
   MOjepVLUt9DLJMAo2kX4YXdAeQYwOugZ4d6Djg/6qrzCcrEZ5IoD6CWrn
   QSy68fBQLEfloo4oyaYQeueUf5qrxJoLzjcJhrq77Ku4R6O7+Fc3/DUYd
   tJYIUbDi74G7dvMwqby3KRgib4Cd4QtbWbzxZSOsdVJgKu4kpwy7GZkbk
   K2jUBMxDPses2SmYfXtz7UrKLzaf794EWzmmnlkqETyEW/te1t2L+YIVS
   Q==;
IronPort-SDR: nlMYdjL9kaBLd6h7y1ZZ6NpXq4X4y5UkM24pNfUh/nm4Lww0r7MkV3WLSkV6eO4pdEKqZ584i4
 cOgN9BNVqHU6PzpfRWbeCk52q48i8x53Gfralcvswu0bna/oPSQD1U0XwgIp1OXNK7hb/uyFas
 NCEUA0R+fasUflTJOrDcL+7RiYh21cmXZuzrozY6jbwSreFky6toRe9cWqcYXSkCJb6D2mjNMH
 HFnFBSeEkR2in5OoSdOGLFKu/1MOCZQi0CVDvBZuyleNOpN6+LeT6q6IHgchl7AXv5t5QBv6yr
 9N8=
X-IronPort-AV: E=Sophos;i="5.72,410,1580799600"; 
   d="scan'208";a="71040873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2020 07:42:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Apr 2020 07:42:50 -0700
Received: from soft-dev3.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 21 Apr 2020 07:42:47 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <jiri@resnulli.us>, <ivecera@redhat.com>, <kuba@kernel.org>,
        <roopa@cumulusnetworks.com>, <olteanv@gmail.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 04/11] net: bridge: Add port attribute IFLA_BRPORT_MRP_RING_OPEN
Date:   Tue, 21 Apr 2020 16:37:45 +0200
Message-ID: <20200421143752.2248-5-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421143752.2248-1-horatiu.vultur@microchip.com>
References: <20200421143752.2248-1-horatiu.vultur@microchip.com>
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
 net/bridge/br_netlink.c            | 3 +++
 tools/include/uapi/linux/if_link.h | 1 +
 3 files changed, 5 insertions(+)

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
index 43dab4066f91..4084f1ef8641 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -151,6 +151,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MULTICAST_ROUTER */
 #endif
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
+		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
 		+ 0;
 }
 
@@ -213,6 +214,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
 		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
+							  BR_MRP_LOST_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
 		return -EMSGSIZE;
 
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

