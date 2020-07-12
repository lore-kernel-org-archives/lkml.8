Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12628C433F1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDFC2068F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MVO/tVV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgGLOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 10:09:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17433 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGLOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594562995; x=1626098995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPXYksHE/6skyxwfmW3layVz9HGsj0QnR14maadzSj4=;
  b=MVO/tVV9jln+/Ulx/N+LYbvN6dIJNAie0mzA/JDLcOvDPS8chmsNo+sJ
   zS/PIceP21Ik657fHi0XR+jT8/ceTtTK5iPwIJjix3GMbKAZmjroO2BeH
   V4WJOF9I/clC7PNLKZj12WTkdYp3BzmVDpsRnl0PR5nBrk7/U1xBQ274G
   dTaQHj7qLbQGL2+2YNsUbshQ4rRd6VKORqoUxBdE18+PDsF5zEqbWiAo6
   jog35zG/AkKCwgzacw0FLBdDtg0/eo/ZKxXoGr93x1L/pPX/LrVajpTWt
   0FWpc6WdwgDTxnJAZD9pDh57GAN7vS/aUU4r6NeUMgV/H4/l9tNs1tape
   w==;
IronPort-SDR: BEtuzvHiir74LdaccL6nV/76IIORNNt2+xcTOjMu1C3EA62CXF6eQnECVQn+kPJfL0VWvFU5v4
 Ke8n+dpgQbk9xfhXD9uy+VhThWUeSspPVoLVX+8NgOxuUvwwbavcIg1gNmwWfl2nyad1s30kDp
 U2KXY47Vrs7FNZk3aW0ivKbf6P820SQCQGywVqsLr6Bdrd78mUiiL9J+fPupOrFLR/kptE9iqi
 DvvQPqW7NRIRLuS0CLSPCTLIjH+7Mz34adS8a8E2UToq6cfLXToipRxIDLIZVUyoG4KOTgHyVf
 +mc=
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="79604287"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 07:09:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 07:09:54 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Sun, 12 Jul 2020 07:09:23 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 12/12] net: bridge: Add port attribute IFLA_BRPORT_MRP_IN_OPEN
Date:   Sun, 12 Jul 2020 16:05:56 +0200
Message-ID: <20200712140556.1758725-13-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
References: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new port attribute, IFLA_BRPORT_MRP_IN_OPEN, which
allows to notify the userspace when the node lost the contiuity of
MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_link.h       | 1 +
 net/bridge/br_netlink.c            | 3 +++
 tools/include/uapi/linux/if_link.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index cc185a007ade8..26842ffd0501d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -344,6 +344,7 @@ enum {
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
 	IFLA_BRPORT_MRP_RING_OPEN,
+	IFLA_BRPORT_MRP_IN_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index c532fa65c9834..147d52596e174 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -152,6 +152,7 @@ static inline size_t br_port_info_size(void)
 #endif
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
+		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_IN_OPEN */
 		+ 0;
 }
 
@@ -216,6 +217,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
 							  BR_MRP_LOST_CONT)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
+		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
 		return -EMSGSIZE;
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cafedbbfefbe9..781e482dc499f 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -344,6 +344,7 @@ enum {
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
 	IFLA_BRPORT_MRP_RING_OPEN,
+	IFLA_BRPORT_MRP_IN_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
-- 
2.27.0

