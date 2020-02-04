Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F1120674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QvXmD12j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDLUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:20:25 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17827 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgBDLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:19:42 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e39533f0000>; Tue, 04 Feb 2020 03:19:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:19:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 03:19:41 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:19:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:41 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e39534a0000>; Tue, 04 Feb 2020 03:19:40 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 13/19] arm64: tegra: update OTG port entries for jetson-tx1
Date:   Tue, 4 Feb 2020 16:46:59 +0530
Message-ID: <1580815025-10915-14-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815167; bh=A8BoHnAqalz3GaOqlgeziGgtfXKIEfdQonSYk61J5Qs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QvXmD12jaATNIGJ8JbrBvKa3rSB3EcC/OTvh/rrk8r5jtDRKsdRiIPMtmc2KEcMCC
         FWMdsGCrNakCjK4WoiBbT2TY/HUuFeYPP3PNN6bCRh00R+KkmK0bK7URrgwRaDqTrR
         CHoirU4LGnK6xYZf5/i1G57vqw97L/rocDK644Q1/b/1LoLm/4CY2qE6xB/+X0vkb6
         R63ueEaOqhuC8fJToNDsb0t8Lb9DoCCAMmIQ1bah2kXuA/ctw2ElQJAvO+6xP0JyK7
         HZMHH2eqioLwsc0n0YkxP8xIJLLBcO5xEYhG693zmUlodsEYDmq7Awcc/etYPEXi8k
         8paoW7RUmosjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate OTG vbus regulator. Add usb-role-switch entry to USB 2-0 port
and corresponding connector details.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V4:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index b009507..18c0610 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1336,7 +1336,6 @@
 		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-5}>;
 		phy-names = "usb2-0", "usb2-1", "usb2-2", "usb2-3", "usb3-0",
 			    "usb3-1";
-
 		dvddio-pex-supply = <&vdd_pex_1v05>;
 		hvddio-pex-supply = <&vdd_1v8>;
 		avdd-usb-supply = <&vdd_3v3_sys>;
@@ -1440,7 +1439,19 @@
 		ports {
 			usb2-0 {
 				status = "okay";
+				vbus-supply = <&vdd_usb_vbus_otg>;
 				mode = "otg";
+
+				usb-role-switch;
+				connector {
+					compatible = "usb-b-connector",
+						     "gpio-usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+					vbus-gpio = <&gpio TEGRA_GPIO(Z, 0)
+						     GPIO_ACTIVE_LOW>;
+					id-gpio = <&pmic 0 0>;
+				};
 			};
 
 			usb2-1 {
@@ -1606,6 +1617,17 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 
+		vdd_usb_vbus_otg: regulator@11 {
+			compatible = "regulator-fixed";
+			reg = <9>;
+			regulator-name = "USB_VBUS_EN0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(CC, 4) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_sys>;
+		};
+
 		vdd_hdmi: regulator@10 {
 			compatible = "regulator-fixed";
 			reg = <10>;
-- 
2.7.4

