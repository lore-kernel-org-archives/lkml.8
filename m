Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4DC20705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC0JWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:22:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12869 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgC0JWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:22:43 -0400
IronPort-SDR: fsCGjeChqwzcZi4UNc1Ydc2jyPtIgL7v77sSUxI+Q/Dvea7jM9nL9p/AUVErqm21U14iN6ixkk
 l6GJe+Lb8doDAf8qYFAW3eYhR+wmaxhCcf5hBXVw0k5ZryL/ITcyKfwjRBpBi+cYVQU3XCC9OO
 imiuzvgy/urInOMF3CcravAUchOM3p76JEw6OgI3yRQHwTT1iklIgXISMSBlgWzAkyI7/jB2xz
 vtZoOAmVtlsCnn40gssL9YnBAwPulSrQaliwKmaL5Q+/IAIeu0mWSZhIfmwIG80hfK7UjpqUKk
 0x8=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="73728128"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2020 02:22:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 02:22:42 -0700
Received: from soft-dev3.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 27 Mar 2020 02:22:40 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <davem@davemloft.net>, <jiri@resnulli.us>, <ivecera@redhat.com>,
        <kuba@kernel.org>, <roopa@cumulusnetworks.com>,
        <nikolay@cumulusnetworks.com>, <olteanv@gmail.com>,
        <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC net-next v4 9/9] bridge: mrp: Update Kconfig and Makefile
Date:   Fri, 27 Mar 2020 10:21:26 +0100
Message-ID: <20200327092126.15407-10-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327092126.15407-1-horatiu.vultur@microchip.com>
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the option BRIDGE_MRP to allow to build in or not MRP support.
The default value is N.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/Kconfig  | 12 ++++++++++++
 net/bridge/Makefile |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index e4fb050e2078..51a6414145d2 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say Y.
+
+config BRIDGE_MRP
+	bool "MRP protocol"
+	depends on BRIDGE
+	default n
+	help
+	  If you say Y here, then the Ethernet bridge will be able to run MRP
+	  protocol to detect loops
+
+	  Say N to exclude this support and reduce the binary size.
+
+	  If unsure, say N.
diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 49da7ae6f077..9bf3e1be3328 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -25,3 +25,5 @@ bridge-$(CONFIG_BRIDGE_VLAN_FILTERING) += br_vlan.o br_vlan_tunnel.o br_vlan_opt
 bridge-$(CONFIG_NET_SWITCHDEV) += br_switchdev.o
 
 obj-$(CONFIG_NETFILTER) += netfilter/
+
+bridge-$(CONFIG_BRIDGE_MRP)	+= br_mrp.o br_mrp_netlink.o br_mrp_switchdev.o
-- 
2.17.1

