Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB032C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6570206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Jfc7UaVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgG2I0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:26:01 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:41840 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgG2I0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:26:01 -0400
IronPort-SDR: s3aZZRkiaRId31Rgx3XSSnqB7Ye4mb0dz8GnjweqUPkWjkwMShRwyhouwHbYWYSscaBtGP47fI
 QJgKlLm1FB4jIG9wHnYnUWcotnDxKxE3/tnbv7cxr0/cyj9rJPbdcApgbdkVVRnNfnu/Ft/BFQ
 ZWeHb+OVxOHGQLib+e1ia5F6Q73WnesLPrKQchjedCriQBsmhVikJH9j0GwkbBdN2tmOiGjcXp
 /06GB2kdWPyyq90//foPHYEI5V8hbh7PTblMuGhDZjpZSqDjcCgmID8qdbLbujW7NOgdH8IB6x
 V8s=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13273830"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Jul 2020 10:25:58 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 29 Jul 2020 10:25:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 29 Jul 2020 10:25:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1596011158; x=1627547158;
  h=from:to:cc:subject:date:message-id;
  bh=X4BDx6M19hv4UdiOFzxtcHDit56u8qbxUVEnCv3QTvs=;
  b=Jfc7UaVrsD00IGK3PbnX1f8+kkd2YFXKJbZTa7NztLb3i/7N0KF7Kqbu
   hoJY4A6RzaommpDkhrfRK58L71+Sg62IRNrTydTjBTVXRb1GD6+aScHd1
   y2XpGOiIych88k2zmR141vG3Fa8nKY7F9GCn72Xh32m7SPK9fzvu3R4Ji
   6nmYJ6LJxxp+ty9a2ls2g6ZLhrtvpjZ/rgOFtMw31DJCoRTRS5S0AaYkd
   VCq7DlJm5bdPaCeVV8ChWEVCsFkY9QciegRvF0AcXOdcvBPDx/0Sno/zI
   c9dPOwpVbXAB/iHv/0m9UlEvMgSIrzSscF8RaacvqODaOjtKhY1Mxf+Zs
   g==;
IronPort-SDR: TIa/e1pr70w79xg8mIFNLYXhq20KRX6dL/5JSTGraAv1A/Lw5PJB3X9dasu/RzVetyXg79oSza
 PIQg240OM5sb2cDRDPIvhUjHJLl22aWCmmWh4jNTeHiw989mJ7Z9HvkLYUMLHESlIz7kp6fnpi
 U7sX/kqJqPG1qM7U3ma5cTKWZB16xDi2kKFzAsjh81Xl/XTYPNE0iymKnshU3GDSZlIsdLg7Jx
 8SpKn0YItNS9VplzZOzr1ehNHsdY3YbHuRd9IMgIklWbqOjY9OXXcWn5bCePGPp9/523k+K1bm
 iow=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13273829"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Jul 2020 10:25:58 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 9BF35280065;
        Wed, 29 Jul 2020 10:25:58 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3] arm: dts: imx7: add QSPI
Date:   Wed, 29 Jul 2020 10:25:54 +0200
Message-Id: <20200729082554.29282-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add the
QSPI controller to imx7s.dtsi.

Based-on-patch-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
v3:
- reverted node name change

v2:
- renamed node and label
- reordered properties


 arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1cfaf410aa43..85b8eddd77f2 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1162,6 +1162,19 @@
 				status = "disabled";
 			};
 
+			qspi: spi@30bb0000 {
+				compatible = "fsl,imx7d-qspi";
+				reg = <0x30bb0000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
+					<&clks IMX7D_QSPI_ROOT_CLK>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			sdma: sdma@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
-- 
2.17.1

