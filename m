Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A191C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8177321835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgEAXvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:33 -0400
Received: from mail-dm6nam12olkn2090.outbound.protection.outlook.com ([40.92.22.90]:58177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727943AbgEAXv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vax2wX3ZhSN+9gETAWlXxSZX/CBDqOPDXZyxZpT+TwOOFmz6VepDMU1N00U9LJ4FN93TwLhnhPrm6PEfc/6sRMZ1yYRiKisqx1IAZfbt27qu5hMud9Qz4ypAT5BNWR6eTWDVk81QMdM+i4UhcwM4hppTUwu3jYviFbyTn4+op39qL5h3TFIn0sb3InicLr12BTxI1pt/2ZDVUrCM1Yy38Tqe7KOJtLjNICkSqH+xHwcvDp+EQsCkNGyg9XGY/ESaVX89XV04CSlRlE+LXm7qKbluE6UIE+VTH2BsDwdqEKPwfeq9muS6ZGgbs7YfGls4ST2cerbkNePX3hBg4+oVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvnkUJXJ9Z/1kTZ8tmmShARYljmKJcMNKDCi4pA43QY=;
 b=OiTIMvqZvikutYn57546s9ghH2CPAsrMrlATFleLchpZkLkH0ZIh7gcXxnNncOYzTLpcyyYqKR9mRYRlVeQJnC9j05Fr8a98yBJAYxPi4qtBGNFtIcBuUvZxKHVDqtkPTypljpkpbwgFLwGqDvUPMEqlYUHbdGyqtqVRBNCNYRN1Xhf0emSbo4uqPdHfKyuknDAUtkHK5YH0a3isrjOwrRgM4nNZhu68mU2x6qxl47nb4YE+qkiqF+CW7ViUZLCUa2W8HkL4vJGfzlbbECWWVFqqqSmh3XvnEO5lxis9j6GmqoIT70DGhUkGqF84lffQWkcVc4Fv3FvpNW9T+ewoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4b) by
 DM6NAM12HT076.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:26 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:26 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:66ECCB6A98B1CA83001D2D364CB1B4750420FEC79B16D4528E2F1D1B8B53CF50;UpperCasedChecksum:8FD865E3A472666087EC0EFF3B4320394C0557F8CD1B336740335B6FC3AC71FA;SizeAsReceived:7874;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:26 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 09/18] ARM: dts: s5pv210: Add panel support to aries boards
Date:   Fri,  1 May 2020 16:50:10 -0700
Message-ID: <BN6PR04MB066048BB0BE7A2F52C809D1EA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-10-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:24 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-10-xc-racer2@live.ca>
X-TMN:  [Ytgf6yKrP6rrqyB3dnaR5yJdnjjZgW4jhPrGe3IBPj4GoKgEPLrTP2m/63NU5HXB]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 90b6a710-ac17-490e-fbf2-08d7ee2a8f2e
X-MS-TrafficTypeDiagnostic: DM6NAM12HT076:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRXS0Jn3NSEbR3qScY0fMJgEVn35upX1azXmj3R/vmWx7g868PyI0vjYeyifwq/ZtyCsYK4k/pKazVd7BmkUpXqViFPTnoJSkInAfjz1hTSLO7bpNQxpx7MHTRu0gub6iSNQkdwt/jeWWXK3OM3sud3SyL9qkZjRfUhjgY4MsWtS7T79KlJvYEi7bJCZLyrPUXcfE8St6zJTsqnkO6TryQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: BC5fIQ7BZgiuoQDPEuqxXV1Nv+JZW24iaUlFe7bxDJ6d4z8N/FfHkRg2xzeQScuPurJcBXP2gPAKA/JiBzf19hbesftbBVM9+UJldb9rGriviBGg2zpSQ2Lr+SIZ/94UvgT9u6ReuFFEjNvAZUZ2U305e7+Ng5BCk2JVDWuoLIbWBGR7EjqulBkTglUiR2G/UilSXGkxoJ+TI27f7jKatw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b6a710-ac17-490e-fbf2-08d7ee2a8f2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:25.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aries boards have an s6e63m0 AMOLED panel connected over i2c-spi.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 68 +++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 6683ecec905a..046366d58aa0 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -200,8 +200,6 @@
 					regulator-name = "VLCD_1.8V";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-					/* Till we get panel driver */
-					regulator-always-on;
 
 					regulator-state-mem {
 						regulator-off-in-suspend;
@@ -300,8 +298,6 @@
 					regulator-name = "VCC_3.0V_LCD";
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
-					/* Till we get panel driver */
-					regulator-always-on;
 
 					regulator-state-mem {
 						regulator-off-in-suspend;
@@ -454,6 +450,39 @@
 		offset = <0x681c>; /* PS_HOLD_CONTROL */
 		value = <0x5200>;
 	};
+
+	spi_lcd: spi-gpio-0 {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&mp04 1 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&mp04 3 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&mp01 1 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_spi_pins>;
+
+		panel@0 {
+			compatible = "samsung,s6e63m0";
+			reg = <0>;
+			reset-gpios = <&mp05 5 GPIO_ACTIVE_LOW>;
+			vdd3-supply = <&ldo7_reg>;
+			vci-supply = <&ldo17_reg>;
+			spi-cs-high;
+			spi-max-frequency = <1200000>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&panel_rst>;
+
+			port {
+				lcd_ep: endpoint {
+					remote-endpoint = <&fimd_ep>;
+				};
+			};
+		};
+	};
 };
 
 &fimd {
@@ -464,18 +493,13 @@
 	samsung,invert-vden;
 	samsung,invert-vclk;
 
-	display-timings {
-		timing-0 {
-			/* 480x800@60Hz */
-			clock-frequency = <25628040>;
-			hactive = <480>;
-			vactive = <800>;
-			hfront-porch = <16>;
-			hback-porch = <16>;
-			hsync-len = <2>;
-			vfront-porch = <28>;
-			vback-porch = <1>;
-			vsync-len = <2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@3 {
+		reg = <3>;
+		fimd_ep: endpoint {
+			remote-endpoint = <&lcd_ep>;
 		};
 	};
 };
@@ -600,6 +624,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	lcd_spi_pins: spi-lcd-pins {
+		samsung,pins = "mp01-1", "mp04-1", "mp04-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	fg_i2c_pins: fg-i2c-pins {
 		samsung,pins = "mp05-0", "mp05-1";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
@@ -611,6 +641,12 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	panel_rst: panel-rst {
+		samsung,pins = "mp05-5";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
 };
 
 &pwm {
-- 
2.20.1

