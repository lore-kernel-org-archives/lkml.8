Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C4C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835B52468F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBMVOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:14:52 -0500
Received: from mailoutvs50.siol.net ([185.57.226.241]:44533 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728428AbgBMVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:14:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 13682522D11;
        Thu, 13 Feb 2020 22:14:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id blpx3g2otjaM; Thu, 13 Feb 2020 22:14:43 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 934EC524CAB;
        Thu, 13 Feb 2020 22:14:43 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id DA1E9522D11;
        Thu, 13 Feb 2020 22:14:40 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Move ext. oscillator to board DTs
Date:   Thu, 13 Feb 2020 22:14:27 +0100
Message-Id: <20200213211427.33004-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213211427.33004-1-jernej.skrabec@siol.net>
References: <20200213211427.33004-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that not all H6 boards have external 32kHz oscillator.
Currently the only one known such H6 board is Tanix TX6.

Move external oscillator node from common H6 dtsi to board specific dts
files where present.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts      | 11 +++++++++++
 .../arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 11 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts  | 11 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi          |  8 --------
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index df6d872c34e2..8f09d209359b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
 		};
 	};
=20
+	ext_osc32k: ext_osc32k_clk {
+		#clock-cells =3D <0>;
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <32768>;
+		clock-output-names =3D "ext_osc32k";
+	};
+
 	leds {
 		compatible =3D "gpio-leds";
=20
@@ -275,6 +282,10 @@ &r_pio {
 	vcc-pm-supply =3D <&reg_aldo1>;
 };
=20
+&rtc {
+	clocks =3D <&ext_osc32k>;
+};
+
 &spdif {
 	status =3D "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index c311eee52a35..ca11e19c2d17 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
 		};
 	};
=20
+	ext_osc32k: ext_osc32k_clk {
+		#clock-cells =3D <0>;
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <32768>;
+		clock-output-names =3D "ext_osc32k";
+	};
+
 	leds {
 		compatible =3D "gpio-leds";
=20
@@ -276,6 +283,10 @@ &r_ir {
 	status =3D "okay";
 };
=20
+&rtc {
+	clocks =3D <&ext_osc32k>;
+};
+
 &uart0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 37f4c57597d4..37fc3f3697f7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -20,6 +20,13 @@ chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	ext_osc32k: ext_osc32k_clk {
+		#clock-cells =3D <0>;
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <32768>;
+		clock-output-names =3D "ext_osc32k";
+	};
+
 	leds {
 		compatible =3D "gpio-leds";
=20
@@ -197,6 +204,10 @@ &r_ir {
 	status =3D "okay";
 };
=20
+&rtc {
+	clocks =3D <&ext_osc32k>;
+};
+
 &uart0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 3c9dd0d69754..b0642d841933 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -21,6 +21,13 @@ chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	ext_osc32k: ext_osc32k_clk {
+		#clock-cells =3D <0>;
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <32768>;
+		clock-output-names =3D "ext_osc32k";
+	};
+
 	hdmi_connector: connector {
 		compatible =3D "hdmi-connector";
 		type =3D "a";
@@ -279,6 +286,10 @@ &r_pio {
 	vcc-pm-supply =3D <&reg_aldo1>;
 };
=20
+&rtc {
+	clocks =3D <&ext_osc32k>;
+};
+
 /*
  * The CS pin is shared with the MMC2 CMD pin, so we cannot have the SPI
  * flash and eMMC at the same time, as one of them would fail probing.
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
index 41b58ffa8596..3ad7c78e9c43 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -62,13 +62,6 @@ osc24M: osc24M_clk {
 		clock-output-names =3D "osc24M";
 	};
=20
-	ext_osc32k: ext_osc32k_clk {
-		#clock-cells =3D <0>;
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <32768>;
-		clock-output-names =3D "ext_osc32k";
-	};
-
 	pmu {
 		compatible =3D "arm,cortex-a53-pmu",
 			     "arm,armv8-pmuv3";
@@ -855,7 +848,6 @@ rtc: rtc@7000000 {
 			interrupts =3D <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names =3D "osc32k", "osc32k-out", "iosc";
-			clocks =3D <&ext_osc32k>;
 			#clock-cells =3D <1>;
 		};
=20
--=20
2.25.0

