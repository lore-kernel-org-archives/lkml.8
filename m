Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0932469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgB0PaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:30:17 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49165 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgB0PaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:30:16 -0500
X-Originating-IP: 90.89.41.158
Received: from localhost (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 873171BF213;
        Thu, 27 Feb 2020 15:30:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss@0leil.net
Subject: [PATCH net-next 2/3] dt-bindings: net: phy: mscc: document rgmii skew properties
Date:   Thu, 27 Feb 2020 16:28:58 +0100
Message-Id: <20200227152859.1687119-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227152859.1687119-1-antoine.tenart@bootlin.com>
References: <20200227152859.1687119-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents two new properties to describe RGMII skew delays in
both Rx and Tx: vsc8584,rgmii-skew-rx and vsc8584,rgmii-skew-tx.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../devicetree/bindings/net/mscc-phy-vsc8531.txt       |  8 ++++++++
 include/dt-bindings/net/mscc-phy-vsc8531.h             | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 5ff37c68c941..c682b6e74b14 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -31,6 +31,14 @@ Optional properties:
 			  VSC8531_LINK_100_ACTIVITY (2),
 			  VSC8531_LINK_ACTIVITY (0) and
 			  VSC8531_DUPLEX_COLLISION (8).
+- vsc8584,rgmii-skew-rx	: RGMII skew delay in Rx.
+			  Allowed values are defined in
+			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
+			  Default value is VSC8584_RGMII_SKEW_0_2.
+- vsc8584,rgmii-skew-tx	: RGMII skew delay in Tx.
+			  Allowed values are defined in
+			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
+			  Default value is VSC8584_RGMII_SKEW_0_2.
 
 
 Table: 1 - Edge rate change
diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 9eb2ec2b2ea9..02313cb3fc35 100644
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
@@ -28,4 +28,14 @@
 #define VSC8531_FORCE_LED_OFF           14
 #define VSC8531_FORCE_LED_ON            15
 
+/* RGMII skew values, in ns */
+#define VSC8584_RGMII_SKEW_0_2		0
+#define VSC8584_RGMII_SKEW_0_8		1
+#define VSC8584_RGMII_SKEW_1_1		2
+#define VSC8584_RGMII_SKEW_1_7		3
+#define VSC8584_RGMII_SKEW_2_0		4
+#define VSC8584_RGMII_SKEW_2_3		5
+#define VSC8584_RGMII_SKEW_2_6		6
+#define VSC8584_RGMII_SKEW_3_4		7
+
 #endif
-- 
2.24.1

