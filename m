Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A3C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6713522B51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="jKOZVObm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgGSWD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgGSWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:03:51 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA576C0619D2;
        Sun, 19 Jul 2020 15:03:50 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 674A22304C;
        Mon, 20 Jul 2020 00:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595196225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RLcusxa68OiGJ5XTLStxjGnOrZ3QWjMjRqpSt+jQdQ=;
        b=jKOZVObmfp5BWgpo0qQBeSgBVtzvVa6YlUWB5PS7tX6GzhfOwEAudSGfmaM3uVkguEVLrw
        Mx88ZHy5uyhKq2sL7L+Vw82AlOKFBcsC8T/Qv3vpVdMYrG/yfhW12EjULOCQtK//IrHHaq
        kl5jGV5KAkkAk2eyzjG6Q2MuhAGAY38=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Michael Walle <michael@walle.cc>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v7 2/4] net: dsa: felix: (re)use already existing constants
Date:   Mon, 20 Jul 2020 00:03:34 +0200
Message-Id: <20200719220336.6919-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719220336.6919-1-michael@walle.cc>
References: <20200719220336.6919-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are USXGMII constants available, drop the old definitions
and reuse the generic ones.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 45 +++++++-------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 1bdf74fd8be4..9b720c8ddfc3 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -11,35 +11,15 @@
 #include <linux/packing.h>
 #include <net/pkt_sched.h>
 #include <linux/iopoll.h>
+#include <linux/mdio.h>
 #include <linux/pci.h>
 #include "felix.h"
 
 #define VSC9959_VCAP_IS2_CNT		1024
 #define VSC9959_VCAP_IS2_ENTRY_WIDTH	376
 #define VSC9959_VCAP_PORT_CNT		6
-
-/* TODO: should find a better place for these */
-#define USXGMII_BMCR_RESET		BIT(15)
-#define USXGMII_BMCR_AN_EN		BIT(12)
-#define USXGMII_BMCR_RST_AN		BIT(9)
-#define USXGMII_BMSR_LNKS(status)	(((status) & GENMASK(2, 2)) >> 2)
-#define USXGMII_BMSR_AN_CMPL(status)	(((status) & GENMASK(5, 5)) >> 5)
-#define USXGMII_ADVERTISE_LNKS(x)	(((x) << 15) & BIT(15))
-#define USXGMII_ADVERTISE_FDX		BIT(12)
-#define USXGMII_ADVERTISE_SPEED(x)	(((x) << 9) & GENMASK(11, 9))
-#define USXGMII_LPA_LNKS(lpa)		((lpa) >> 15)
-#define USXGMII_LPA_DUPLEX(lpa)		(((lpa) & GENMASK(12, 12)) >> 12)
-#define USXGMII_LPA_SPEED(lpa)		(((lpa) & GENMASK(11, 9)) >> 9)
-
 #define VSC9959_TAS_GCL_ENTRY_MAX	63
 
-enum usxgmii_speed {
-	USXGMII_SPEED_10	= 0,
-	USXGMII_SPEED_100	= 1,
-	USXGMII_SPEED_1000	= 2,
-	USXGMII_SPEED_2500	= 4,
-};
-
 static const u32 vsc9959_ana_regmap[] = {
 	REG(ANA_ADVLEARN,			0x0089a0),
 	REG(ANA_VLANMASK,			0x0089a4),
@@ -845,11 +825,10 @@ static void vsc9959_pcs_config_usxgmii(struct phy_device *pcs,
 {
 	/* Configure device ability for the USXGMII Replicator */
 	phy_write_mmd(pcs, MDIO_MMD_VEND2, MII_ADVERTISE,
-		      USXGMII_ADVERTISE_SPEED(USXGMII_SPEED_2500) |
-		      USXGMII_ADVERTISE_LNKS(1) |
+		      MDIO_USXGMII_2500FULL |
+		      MDIO_USXGMII_LINK |
 		      ADVERTISE_SGMII |
-		      ADVERTISE_LPACK |
-		      USXGMII_ADVERTISE_FDX);
+		      ADVERTISE_LPACK);
 }
 
 void vsc9959_pcs_config(struct ocelot *ocelot, int port,
@@ -1063,8 +1042,8 @@ static void vsc9959_pcs_link_state_usxgmii(struct phy_device *pcs,
 		return;
 
 	pcs->autoneg = true;
-	pcs->autoneg_complete = USXGMII_BMSR_AN_CMPL(status);
-	pcs->link = USXGMII_BMSR_LNKS(status);
+	pcs->autoneg_complete = !!(status & BMSR_ANEGCOMPLETE);
+	pcs->link = !!(status & BMSR_LSTATUS);
 
 	if (!pcs->link || !pcs->autoneg_complete)
 		return;
@@ -1073,24 +1052,24 @@ static void vsc9959_pcs_link_state_usxgmii(struct phy_device *pcs,
 	if (lpa < 0)
 		return;
 
-	switch (USXGMII_LPA_SPEED(lpa)) {
-	case USXGMII_SPEED_10:
+	switch (lpa & MDIO_USXGMII_SPD_MASK) {
+	case MDIO_USXGMII_10:
 		pcs->speed = SPEED_10;
 		break;
-	case USXGMII_SPEED_100:
+	case MDIO_USXGMII_100:
 		pcs->speed = SPEED_100;
 		break;
-	case USXGMII_SPEED_1000:
+	case MDIO_USXGMII_1000:
 		pcs->speed = SPEED_1000;
 		break;
-	case USXGMII_SPEED_2500:
+	case MDIO_USXGMII_2500:
 		pcs->speed = SPEED_2500;
 		break;
 	default:
 		break;
 	}
 
-	if (USXGMII_LPA_DUPLEX(lpa))
+	if (lpa & MDIO_USXGMII_FULL_DUPLEX)
 		pcs->duplex = DUPLEX_FULL;
 	else
 		pcs->duplex = DUPLEX_HALF;
-- 
2.20.1

