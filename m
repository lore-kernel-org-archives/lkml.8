Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O8jCaEcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgBLGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:11:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7235 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgBLGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:11:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4397080000>; Tue, 11 Feb 2020 22:11:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 11 Feb 2020 22:11:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 11 Feb 2020 22:11:48 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 06:11:48 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Feb 2020 06:11:48 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.125]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4397220001>; Tue, 11 Feb 2020 22:11:48 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v6 5/5] arm64: tegra: Enable XUSB host in P2972-0000 board
Date:   Wed, 12 Feb 2020 14:11:33 +0800
Message-ID: <20200212061133.11665-6-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212061133.11665-1-jckuo@nvidia.com>
References: <20200212061133.11665-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581487880; bh=CL2D/NKlhQPLvGvad77j2jsXqakuLSfCoTIFZLeiZyE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=O8jCaEcbm0hWJWZzvxU4AusakreaQEVkP1vKc8+f9J8ZIj5jpRxYHKwPENs75ZCIQ
         XMUTFktqjFNiv/BN3yp2dljpiJ6Z3ioSFEfWuXqHIuIGfx4cLgR8W9WL9f8uoKXn7p
         9FUzx50rKkhcNo0qX2eB9E0gMRXhSGlKd1/MqBfZHHm+kPKdoT6TS78pr7a6AiI8e8
         Su1aPN5d3arrPG0jRMfn1D6nEzdtjrBnD2r8YQAzOcTNmwsCWlPAXf8xzGf46ImD4h
         yeo6afG2mMgWC9wRf1UN5L89O7xYKOUff/6/Q8+GmmFjQUrM8Slh6IN5LX0cbYcVcV
         DFKRz6PnuNutA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables XUSB host and pad controller in Tegra194
P2972-0000 board.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v6:
- re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
Changes in v5: none
Changes in v4: none
Changes in v3: none
Changes in v2:
- use capitalization of regulator names
- fix gpio property of VDD_5V_SATA regulator

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 36 ++++++++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 63 +++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index bdd33ff4e324..623f7d7d216b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -71,6 +71,29 @@
 			vmmc-supply = <&vdd_emmc_3v3>;
 		};
 
+		padctl@3520000 {
+			avdd-usb-supply = <&vdd_usb_3v3>;
+			vclamp-usb-supply = <&vdd_1v8ao>;
+
+			ports {
+				usb2-1 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+
+				usb2-3 {
+					vbus-supply = <&vdd_5v_sata>;
+				};
+
+				usb3-0 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+
+				usb3-3 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+			};
+		};
+
 		rtc@c2a0000 {
 			status = "okay";
 		};
@@ -234,7 +257,7 @@
 						regulator-max-microvolt = <3300000>;
 					};
 
-					ldo5 {
+					vdd_usb_3v3: ldo5 {
 						regulator-name = "VDD_USB_3V3";
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
@@ -317,5 +340,16 @@
 			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
 			regulator-boot-on;
 		};
+
+		vdd_5v_sata: regulator@4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+
+			regulator-name = "VDD_5V_SATA";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 985e7d84f161..f9f874d9d0ae 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -37,6 +37,69 @@
 			status = "okay";
 		};
 
+		padctl@3520000 {
+			status = "okay";
+
+			pads {
+				usb2 {
+					lanes {
+						usb2-1 {
+							status = "okay";
+						};
+
+						usb2-3 {
+							status = "okay";
+						};
+					};
+				};
+
+				usb3 {
+					lanes {
+						usb3-0 {
+							status = "okay";
+						};
+
+						usb3-3 {
+							status = "okay";
+						};
+					};
+				};
+			};
+
+			ports {
+				usb2-1 {
+					mode = "host";
+					status = "okay";
+				};
+
+				usb2-3 {
+					mode = "host";
+					status = "okay";
+				};
+
+				usb3-0 {
+					nvidia,usb2-companion = <1>;
+					status = "okay";
+				};
+
+				usb3-3 {
+					nvidia,usb2-companion = <3>;
+					maximum-speed = "super-speed";
+					status = "okay";
+				};
+			};
+		};
+
+		usb@3610000 {
+			status = "okay";
+
+			phys =	<&{/cbb@0/padctl@3520000/pads/usb2/lanes/usb2-1}>,
+				<&{/cbb@0/padctl@3520000/pads/usb2/lanes/usb2-3}>,
+				<&{/cbb@0/padctl@3520000/pads/usb3/lanes/usb3-0}>,
+				<&{/cbb@0/padctl@3520000/pads/usb3/lanes/usb3-3}>;
+			phy-names = "usb2-1", "usb2-3", "usb3-0", "usb3-3";
+		};
+
 		pwm@c340000 {
 			status = "okay";
 		};
-- 
2.17.1

