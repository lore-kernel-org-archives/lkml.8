Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CBD21531
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fGv0KXNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGCTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:48:48 -0400
Received: from vps.xff.cz ([195.181.215.36]:47752 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgGCTsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593805725; bh=DNJd01/b0whNwirtAYo5GM95YcqeAD7uQXrSuwhX34o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fGv0KXNOSoUial8t7V/PcuVYJsfb0YL8uCFOFiXEwprmCszcEy1ivghdmxqTfkCo7
         z70P7iEKXH8l0negWDCqmjAFMKgs4ebHEBQUQkzIGDfqkAz+ozzOkHgFZ8pcn983Cp
         QUl21epOlErJYrW8eNZyLtK+FuPRT8AwR+he+t+Y=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: allwinner: Add support for PinePhone revision 1.2
Date:   Fri,  3 Jul 2020 21:48:41 +0200
Message-Id: <20200703194842.111845-3-megous@megous.com>
In-Reply-To: <20200703194842.111845-1-megous@megous.com>
References: <20200703194842.111845-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revision 1.2 should be the final production version of the PinePhone.
It has most of the known HW quirks fixed.

Interrupt to the magnetometer is routed correctly, in this revision.

The bulk of the changes are in how modem and the USB-C HDMI bridge
chip is powered and where the signals from the modem are connected.

Also backlight intensity seemingly behaves differently, than on the
1.1 and 1.0 boards, and the PWM duty cycle where backlight starts
to work is 10% (as tested on 2 1.2 PinePhones I have access to).

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-a64-pinephone-1.2.dts    | 40 +++++++++++++++++++
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 +-
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index e4d3cd0ac5bb..916d10d5b87c 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.0.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
new file mode 100644
index 000000000000..a9f5b670c9b8
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
+
+/dts-v1/;
+
+#include "sun50i-a64-pinephone.dtsi"
+
+/ {
+	model = "Pine64 PinePhone (1.2)";
+	compatible = "pine64,pinephone-1.2", "allwinner,sun50i-a64";
+};
+
+&backlight {
+	power-supply = <&reg_ldo_io0>;
+	/*
+	 * PWM backlight circuit on this PinePhone revision was changed since 1.0,
+	 * and the lowest PWM duty cycle that doesn't lead to backlight being off
+	 * is around 10%. Duty cycle for the lowest brightness level also varries
+	 * quite a bit between individual boards, so the lowest value here was
+	 * chosen as a safe default.
+	 */
+	brightness-levels = <
+		5000 5248 5506 5858 6345
+		6987 7805 8823 10062 11543
+		13287 15317 17654 20319 23336
+		26724 30505 34702 39335 44427
+		50000
+	>;
+	num-interpolated-steps = <50>;
+	default-brightness-level = <500>;
+};
+
+&lis3mdl {
+	/*
+	 * Board revision 1.2 fixed routing of the interrupt to DRDY pin,
+	 * enable interrupts.
+	 */
+	interrupt-parent = <&pio>;
+	interrupts = <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index a3b400ff972b..904122711a89 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -142,7 +142,7 @@ &i2c1 {
 	status = "okay";
 
 	/* Magnetometer */
-	lis3mdl@1e {
+	lis3mdl: lis3mdl@1e {
 		compatible = "st,lis3mdl-magn";
 		reg = <0x1e>;
 		vdd-supply = <&reg_dldo1>;
-- 
2.27.0

