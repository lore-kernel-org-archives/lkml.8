Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50002C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C5208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFQNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:36:20 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40931 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFQNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:36:18 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BCEEAE000B;
        Wed, 17 Jun 2020 13:36:13 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com,
        foss@0leil.net, antoine.tenart@bootlin.com
Subject: [PATCH net-next v2 1/8] net: phy: add support for a common probe between shared PHYs
Date:   Wed, 17 Jun 2020 15:31:20 +0200
Message-Id: <20200617133127.628454-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617133127.628454-1-antoine.tenart@bootlin.com>
References: <20200617133127.628454-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared PHYs (PHYs in the same hardware package) may have shared
registers and their drivers would usually need to share information.
There is currently a way to have a shared (part of the) init, by using
phy_package_init_once(). This patch extends the logic to share parts of
the probe to allow sharing the initialization of locks or resources
retrieval.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/linux/phy.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8c05d0fb5c00..058219b6441f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -244,7 +244,8 @@ struct phy_package_shared {
 };
 
 /* used as bit number in atomic bitops */
-#define PHY_SHARED_F_INIT_DONE 0
+#define PHY_SHARED_F_INIT_DONE  0
+#define PHY_SHARED_F_PROBE_DONE 1
 
 /*
  * The Bus class for PHYs.  Devices which provide access to
@@ -1554,14 +1555,25 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, shared->addr, regnum, val);
 }
 
-static inline bool phy_package_init_once(struct phy_device *phydev)
+static inline bool __phy_package_set_once(struct phy_device *phydev,
+					  unsigned int b)
 {
 	struct phy_package_shared *shared = phydev->shared;
 
 	if (!shared)
 		return false;
 
-	return !test_and_set_bit(PHY_SHARED_F_INIT_DONE, &shared->flags);
+	return !test_and_set_bit(b, &shared->flags);
+}
+
+static inline bool phy_package_init_once(struct phy_device *phydev)
+{
+	return __phy_package_set_once(phydev, PHY_SHARED_F_INIT_DONE);
+}
+
+static inline bool phy_package_probe_once(struct phy_device *phydev)
+{
+	return __phy_package_set_once(phydev, PHY_SHARED_F_PROBE_DONE);
 }
 
 extern struct bus_type mdio_bus_type;
-- 
2.26.2

