Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB44207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gcY4V/Yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGIKCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:02:03 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6868 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGIKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594288915; x=1625824915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VmtK8G/xeP+sqbHDRW00jGBGN8YV1TASrTdld+tic0=;
  b=gcY4V/YxpfMdk9mW+9SfQcszhwv3DW4azfcvFN+iZDShbU32jeee/jAG
   8JLzj6WL7xk0pjyX/Ims5Cg88XrGOSNV20c1YSI9ngl1mNpFe6mhgfTP6
   8zSEMktMUE7swhM+DcUqmzWWVQM6Ko6BUtIuJBdG/b7yWP/tqBSOIoxP6
   q7Ccm9QKKkPw2P9562jkQ3SjUigeo9ZKYCHcmg2OHP3KmIPOZaAa5YYKs
   fAQowmBVQpO072tVy+PSSjVXjLXKbrxtHr9JdtvGagAZmvsiTyxETWx8O
   FgwcF6Om3mf1yUap306eaTKNTBr3NlrSbGsxpMr6ukoiuqQ5h3ZyIDyFW
   Q==;
IronPort-SDR: xtwD/Th7eYwwzUrb07QQyvgXxiwo4JMXdWoa19T0iL6WJk6HHrHiAF1dmaw/JwIN5wSEe/vJ2o
 LXv4+/rxvBl79bOYvaNVGowX1KoA69CHgv8w2sRk6CReQE8nem2Rlg3DWMiWPG8tkuPF3dKBJk
 7C+X5PsvX+BCLQBkgOy2AfL9tej8SFk1uJR/FRWs+dW0L4X30cWqWRHo+ResaNJI2AJsM0sdwS
 6rvoOe3jNSu+IepXzIrVuw07rgsidPBEvIM0z5M1ZEyIjHu2pyCPbvNrujyU5eeBYPAozzIPMR
 jnI=
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="81197239"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 03:01:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 03:01:53 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 9 Jul 2020 03:01:50 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
        <ivecera@redhat.com>, <andrew@lunn.ch>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 06/12] bridge: mrp: Add br_mrp_in_port_open function
Date:   Thu, 9 Jul 2020 12:00:34 +0200
Message-ID: <20200709100040.554623-7-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709100040.554623-1-horatiu.vultur@microchip.com>
References: <20200709100040.554623-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function notifies the userspace when the node lost the continuity
of MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 22 ++++++++++++++++++++++
 net/bridge/br_private_mrp.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index acce300c0cc29..4bf7aaeb29152 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -389,3 +389,25 @@ int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
 out:
 	return err;
 }
+
+int br_mrp_in_port_open(struct net_device *dev, u8 loc)
+{
+	struct net_bridge_port *p;
+	int err = 0;
+
+	p = br_port_get_rcu(dev);
+	if (!p) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (loc)
+		p->flags |= BR_MRP_LOST_IN_CONT;
+	else
+		p->flags &= ~BR_MRP_LOST_IN_CONT;
+
+	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
+
+out:
+	return err;
+}
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index d5957f7e687ff..384cb69b47e02 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -75,5 +75,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 
 /* br_mrp_netlink.c  */
 int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
+int br_mrp_in_port_open(struct net_device *dev, u8 loc);
 
 #endif /* _BR_PRIVATE_MRP_H */
-- 
2.27.0

