Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE32FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB22C206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xEp+wHV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgF3Nps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:45:48 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12146 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgF3Npn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593524742; x=1625060742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBHDKe17OWh23IN1qsZyil4P/7Q7BPKQEEmOkyRy9rQ=;
  b=xEp+wHV4fvK0o/6oYkYh0Qj+EGQ8rhiA5SceXKydEI+2lTvnvoX8GMzW
   HbIf4g+ZBSmJgZ+1chBEvmpy6Elun3P4mI7tdCc/RrMF9Na6jRyVaZLzs
   uaOtba5byecB9KqthicvSL4ZzeczIqa6mLZ03/XtcVGmqWGH6mDNSRIVB
   yWiM7erC7WoYrz9c2bxfuw/gnO0q16IQf/iiVhh1BQ83i5tL2VcGOad8d
   MziOvqL+SHPCiaN5BCaLYwFXvJQyRX7xROOMWiFlzEq786+UnDQjxf8CB
   YB74OcMBq+r8moqRdh5fHBOj0auSpzEY4M0KFzKyJ+6OnjEvzgCIeU6I+
   Q==;
IronPort-SDR: ShV7w/bvt3WeZxL/eZIO1kIlTteNSSGYWuUcZTJUjhLUu1YktFFvJO9iLU4slq8+YB3dd/xLsS
 3TX7Qhxtt6ShRTWPx04rrxeMTUH3QutjCmDsPN/igcfVtC9WvkL6XXfsJ8n+uQvEgozzq+Egxr
 PAPnlidYFS10Of8gqwIdhCM1OtWb1VUHyg2XJ5e4yVaA1Z4BST5Wf1epqiUPQSMeg0luJ5juOh
 ABfTZGgmfsAX+eJm2n83iSZXeBruBxEl4GFbFhY3i5Tem20pVJW5QRb1qA/v08tNhk8hA6ywxK
 hJI=
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="85638706"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2020 06:45:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 06:45:42 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 30 Jun 2020 06:45:39 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@mellanox.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>, <UNGLinuxDriver@microchip.com>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 1/3] bridge: uapi: mrp: Extend MRP attributes to get the status
Date:   Tue, 30 Jun 2020 15:44:22 +0200
Message-ID: <20200630134424.4114086-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
References: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MRP attribute IFLA_BRIDGE_MRP_INFO to allow the userspace to get the
current state of the MRP instances. This is a nested attribute that
contains other attributes like, ring id, index of primary and secondary
port, priority, ring state, ring role.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_bridge.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index caa6914a3e53a..c114c1c2bd533 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -166,6 +166,7 @@ enum {
 	IFLA_BRIDGE_MRP_RING_STATE,
 	IFLA_BRIDGE_MRP_RING_ROLE,
 	IFLA_BRIDGE_MRP_START_TEST,
+	IFLA_BRIDGE_MRP_INFO,
 	__IFLA_BRIDGE_MRP_MAX,
 };
 
@@ -228,6 +229,22 @@ enum {
 
 #define IFLA_BRIDGE_MRP_START_TEST_MAX (__IFLA_BRIDGE_MRP_START_TEST_MAX - 1)
 
+enum {
+	IFLA_BRIDGE_MRP_INFO_UNSPEC,
+	IFLA_BRIDGE_MRP_INFO_RING_ID,
+	IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_PRIO,
+	IFLA_BRIDGE_MRP_INFO_RING_STATE,
+	IFLA_BRIDGE_MRP_INFO_RING_ROLE,
+	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
+	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
+	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
+	__IFLA_BRIDGE_MRP_INFO_MAX,
+};
+
+#define IFLA_BRIDGE_MRP_INFO_MAX (__IFLA_BRIDGE_MRP_INFO_MAX - 1)
+
 struct br_mrp_instance {
 	__u32 ring_id;
 	__u32 p_ifindex;
-- 
2.27.0

