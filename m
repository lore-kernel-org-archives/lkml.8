Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F22EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396F72064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FvA34UBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgG1L23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:28:29 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:50096 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgG1L22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:28:28 -0400
IronPort-SDR: 4+Eq1WfItBIOCJMB3PK+JeKhRQbamQBbaT1nb9vuVwxrnfL/8yu+89CvXZnD7ffp8gUc6l06QO
 rE3EaQ9J5/CJ2LHg9lQsj5y+o85B6s3AeVZ3qI3HPS2ADy+lpfZ5JSWQFCdjT8BlJnfyx+gxDe
 2eJ7VfU+eCbte8f8yb5xP9dD8viSWgqUbmk9cS5m1urFmic4EGjxkgtIosucGZjq+mZgvwKiV4
 HUZUBQYbjiTFdOlGFsjO3xfCfiAYSrotOw0LYiXV6hmc7AXHBoenK8Yzo99s4N6KzgyT/s69fX
 fJ4=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13262243"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Jul 2020 13:28:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 28 Jul 2020 13:28:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 28 Jul 2020 13:28:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1595935707; x=1627471707;
  h=from:to:cc:subject:date:message-id;
  bh=GTkpCAy+ud0FSlBwFAAC9NVSctuBoE/kJ20sETQOlr4=;
  b=FvA34UBTJyLN0CSS3zEyF5r9ZOCrPG/EZzlIGiZtj2ERPyEZiJ3Rnz3t
   y9sXGuMx/jtGnYcLaEqxv6J0CfLRkdFKsZaQUwnI1Ikdh17/x4ASbihSt
   XgUNOr/GI+PM0CJQEk1FW8a3uhSJlwkFm/vlWNnGAH9hIa22//BJJFg4M
   wOPpeAIi6tNJMysw5VH3lC9lau2X+QUnlkhvV/rk/pf9MWnifVUe6bulH
   bmg0mEzmMaj1QHBd1PTd/QA5iFrgqjwc7rTtFAiHTbPPZT0vlA4jqCs1p
   6ulbI1lAxKracr2Wnv3ZDVT3vle56KF7pimwGeg3AdW8QgEuhFBWPi2Io
   w==;
IronPort-SDR: HYgETk8OEE67fVRWrlUBgVhu624UVV8GMFG4hex4OuiJuPdZaYUtkFmpwkUQlNgQ4CbvlYUK91
 4c+spQybcNFt3v1hVaDtZerIZPNwekW65SloOz5tZnW26Mneu5rQe/w7fHyUSLi+EQ+9ob/dR/
 URvROyOrlDp4vfQZHv7C2iOIVG75YzlYqxuNBszcdyh8NNAczgYtUji6xhVhzPeJ16WZ2sSeLB
 rgJlcJVPg6KSBQJte9udusDr0ujnFO0hBQWHYumggfOFQ/uLkIZP/LwqWP530mxLdHz4PHg9vN
 tA0=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13262242"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jul 2020 13:28:27 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D3DD8280065;
        Tue, 28 Jul 2020 13:28:26 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm: dts: imx7: add QSPI
Date:   Tue, 28 Jul 2020 13:28:14 +0200
Message-Id: <20200728112814.14158-1-matthias.schiffer@ew.tq-group.com>
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
 arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1cfaf410aa43..e45683e61593 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1162,6 +1162,19 @@
 				status = "disabled";
 			};
 
+			qspi1: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx7d-qspi";
+				reg = <0x30bb0000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
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

