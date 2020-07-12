Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57032068F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="owkH0Kkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGLOJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 10:09:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17389 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgGLOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594562982; x=1626098982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpMrZj6fM3cwqt9Q+yhloZE0v+UqbX0FuA/rq9b1ya4=;
  b=owkH0KkdZd35kSblW/ZuSitWVSzu5THEhfOE8WlYL1OLR/hp+z2kgymQ
   yqoQIfxaUvXlIlAZxv5qWIv+tSfYTgoDTej4m28yZQaRaZcSBlpGTHYVL
   QnVJrZ1yFwSEZa2oQy+KBPUW49obT1b5yNtLDu9QRVVqquiV4+gDV6DEs
   4NVn/L6pTw36LU9rObaH0SYYHl+Cp1sShO6ntIfbsVBMa42n4f0mvjhlU
   XOfs10eL6z9/SRw5F0Or/NVXEEggvUU7UJcECyD2u5E7bo01Mj0zSynHD
   /dVO5uqEG4lnkdXfcA/FHVN+5SZ2MZL0ynXeFsI+ZJJvmv09B+SFXaPw+
   w==;
IronPort-SDR: ZdGPWgZaAm4oAC25whV5lp/SZJrihXEMs1foiIkZ5FJglVDo3Rq+VT3fXNgL9SjdCnOjtzVfBw
 rnbot5vXT+TZHmUJ3hiwwZVrVQGUrBGpe+R0uUGe0L4VoDyOiNCuxGibcdA1bzmTkG64ipvph6
 Sct7KDgKhVJFioYJt5pi4hilnU8ElXAclZrPONgw1nJA4g43mrN188XyGlB2ihXMUmCTX+VdsO
 3/LHb+2wZ3hd+dLEV471Z8DOHkJ4y7XkKCXWJGk5lL4PEJd2cPnV4VHGiKWCGUkEdtoTf36cDh
 s/g=
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="79604268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 07:09:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 07:09:41 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Sun, 12 Jul 2020 07:09:09 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 07/12] bridge: switchdev: mrp: Extend MRP API for switchdev for MRP Interconnect
Date:   Sun, 12 Jul 2020 16:05:51 +0200
Message-ID: <20200712140556.1758725-8-horatiu.vultur@microchip.com>
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

Implement the MRP API for interconnect switchdev. Similar with the other
br_mrp_switchdev function, these function will just eventually call the
switchdev functions: switchdev_port_obj_add/del.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_switchdev.c | 62 +++++++++++++++++++++++++++++++++++
 net/bridge/br_private_mrp.h   |  7 ++++
 2 files changed, 69 insertions(+)

diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
index 0da68a0da4b5a..ed547e03ace17 100644
--- a/net/bridge/br_mrp_switchdev.c
+++ b/net/bridge/br_mrp_switchdev.c
@@ -107,6 +107,68 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br,
 	return 0;
 }
 
+int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
+				 u16 in_id, u32 ring_id,
+				 enum br_mrp_in_role_type role)
+{
+	struct switchdev_obj_in_role_mrp mrp_role = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_IN_ROLE_MRP,
+		.in_role = role,
+		.in_id = mrp->in_id,
+		.ring_id = mrp->ring_id,
+		.i_port = rtnl_dereference(mrp->i_port)->dev,
+	};
+	int err;
+
+	if (role == BR_MRP_IN_ROLE_DISABLED)
+		err = switchdev_port_obj_del(br->dev, &mrp_role.obj);
+	else
+		err = switchdev_port_obj_add(br->dev, &mrp_role.obj, NULL);
+
+	return err;
+}
+
+int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
+				  enum br_mrp_in_state_type state)
+{
+	struct switchdev_obj_in_state_mrp mrp_state = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_IN_STATE_MRP,
+		.in_state = state,
+		.in_id = mrp->in_id,
+	};
+	int err;
+
+	err = switchdev_port_obj_add(br->dev, &mrp_state.obj, NULL);
+
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
+				  u32 interval, u8 max_miss, u32 period)
+{
+	struct switchdev_obj_in_test_mrp test = {
+		.obj.orig_dev = br->dev,
+		.obj.id = SWITCHDEV_OBJ_ID_IN_TEST_MRP,
+		.interval = interval,
+		.max_miss = max_miss,
+		.in_id = mrp->in_id,
+		.period = period,
+	};
+	int err;
+
+	if (interval == 0)
+		err = switchdev_port_obj_del(br->dev, &test.obj);
+	else
+		err = switchdev_port_obj_add(br->dev, &test.obj, NULL);
+
+	return err;
+}
+
 int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
 				    enum br_mrp_port_state_type state)
 {
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 23da2f956ad0e..0d554ef88db85 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -72,6 +72,13 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
 				    enum br_mrp_port_state_type state);
 int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 				   enum br_mrp_port_role_type role);
+int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
+				 u16 in_id, u32 ring_id,
+				 enum br_mrp_in_role_type role);
+int br_mrp_switchdev_set_in_state(struct net_bridge *br, struct br_mrp *mrp,
+				  enum br_mrp_in_state_type state);
+int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
+				  u32 interval, u8 max_miss, u32 period);
 
 /* br_mrp_netlink.c  */
 int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
-- 
2.27.0

