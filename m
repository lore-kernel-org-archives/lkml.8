Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4618F206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIBAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:40:26 -0400
Received: from mail-oln040092003042.outbound.protection.outlook.com ([40.92.3.42]:52199
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIBAkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByVvuEPOMLMkQ1ltX0rljZe3NvRN/fATLaq49umzL/8Hlx0U5517WRQIFXbAF7NbMcwGEtNBj5NwqyU0EZoObEqgNpOBeMdlIkY4LLiB+xYBQjEe6P5fUbXii6kiTGqe2Wpi77eMyJxL3SwgIg5yuussXbkyVJgTVeFbqwI63hJ5APysm5nvokR6L4awdYBJ3Yq/CqGgV4pCn1qDIpZauPWTtB59O1jyjJ6WO7uyscuuXqOPkon8Z2HI4cwGcK5fayiLVwCdI3I1gAIuXSoSRorhCYiwH0M7ZsGJF7lNm81ICEDk1lpb9dTmo/RYB9vzeBd0yvLN/8PwiOdg2fOD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUvut6oA2xwwFJ5kMzMmCGUk6b3S+u6BlpHCPFPrMW4=;
 b=JFypnzei6+unXKbrcoOnOOL0AjXX40mHODs6fizUkk7QvTpVsbbomVNfP5FMvxHrE7OJe+/aIcB7y5Y+72orplgUb085XZiU1vVPiwbitoPzJmwkt4J6s+8ErkfsDvTZwyzwlDbn69kEfdiBisoq6PwXJumQ+EH8yrJmRBNI57UIAeUlMWo3VIBI/6tjeHy1jSg9XYMrkpW6n1VZn52I8oywOm45aByALaJ8wVY50jbvC5d+wxX9a+ELQdrAr9ZJYAPgLb6rVb+0C40GlCPpXdV083A7xjgIfF/k+3yjCoZW21Umn323IgjiK3DI8U6JZ6/JB1cCt6iM6YToD/bDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (10.152.74.55) by CY1NAM02HT152.eop-nam02.prod.protection.outlook.com
 (10.152.75.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 00:40:22 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e45::48) by CY1NAM02FT008.mail.protection.outlook.com
 (2a01:111:e400:7e45::315) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 00:40:22 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:08778E51346439A80C8B32E73CE0B4E8D041202A1DC781E4CD3BEFA101FED66C;UpperCasedChecksum:210F37ED35E9ABDD5940C60B52707AAD1C86309D21E772932F7074E4C51A37AA;SizeAsReceived:7609;Count:47
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:40:21 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, kgene@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] ARM: dts: s5pv210: Enable audio on Aries boards
Date:   Tue,  1 Sep 2020 17:38:58 -0700
Message-ID: <BN6PR04MB0660CFA802E03E73D58029CCCB2F0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200902003858.10821-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MW2PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:302:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.0 via Frontend Transport; Wed, 2 Sep 2020 00:40:19 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200902003858.10821-1-xc-racer2@live.ca>
X-TMN:  [B8rMxarMiyLPOeTL1JCWBZv/UakXtf/1iD03wOP0V4xeYUt+fT3sqZ9Dk7BUNP28]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ac7b5bcf-a8dc-4c8d-6e24-08d84ed8c5d6
X-MS-TrafficTypeDiagnostic: CY1NAM02HT152:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79WTAaRgELVcterE6soJRHT5mtKRD83w8EPTZyhf5IXmNmmO+RzNkXFBI2BUpehU0RWVgprKSpEcGt9inTKOqqOqOTqVzJjbzkQtFhAV43tsT3G8X8Z8/Z58kdINk7KPfcuXd6eR6tgA2mSUu68QMHDnysrF+PuG7hxpgJElgT+5GVRVkOb8yjjhrZSr39bfX6vlHJfd7DWCVBpItqvGJQ==
X-MS-Exchange-AntiSpam-MessageData: 2v4DFv/3ENHKGyNIzYDZyASxLzc3u16xwpte82EZgrCxjAXne5mhABYSk0Pxm4A7OObKvssnUfue4V0VM4GgrZmRKkYrKbqx4q7DUjFfs3eyr5NC8S83Htqu7FM9y2FfBMu3hJUu9V7b0yPUKEFaTVYQU18O5ii/JhddzPlhSd0IWbNSGYFP2QyylTDJdX5JIOT/0Bjp9Mb9sdSotKoXIw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7b5bcf-a8dc-4c8d-6e24-08d84ed8c5d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:40:21.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the galaxys and the fascinate4g have a wm8994 codec,
but they differ slightly in their jack detection and micbias
configuration.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi      | 10 +++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 98 +++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 85 ++++++++++++++++++++
 3 files changed, 193 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 822207f63ee0..a3f83f668ce1 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -47,6 +47,11 @@
 		};
 	};
 
+	bt_codec: bt_sco {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <0>;
+	};
+
 	vibrator_pwr: regulator-fixed-0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vibrator-en";
@@ -624,6 +629,11 @@
 	};
 };
 
+&i2s0 {
+	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
+	status = "okay";
+};
+
 &mfc {
 	memory-region = <&mfc_left>, <&mfc_right>;
 };
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index 65eed01cfced..ca064359dd30 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -35,6 +35,80 @@
 			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
+
+	headset_micbias_reg: regulator-fixed-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "Headset_Micbias";
+		gpio = <&gpj2 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&headset_micbias_ena>;
+	};
+
+	main_micbias_reg: regulator-fixed-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "Main_Micbias";
+		gpio = <&gpj4 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_micbias_ena>;
+	};
+
+	sound {
+		compatible = "samsung,fascinate4g-wm8994";
+
+		model = "Fascinate4G";
+
+		extcon = <&fsa9480>;
+
+		main-micbias-supply = <&main_micbias_reg>;
+		headset-micbias-supply = <&headset_micbias_reg>;
+
+		earpath-sel-gpios = <&gpj2 6 GPIO_ACTIVE_HIGH>;
+
+		io-channels = <&adc 3>;
+		io-channel-names = "headset-detect";
+		headset-detect-gpios = <&gph0 6 GPIO_ACTIVE_HIGH>;
+		headset-key-gpios = <&gph3 6 GPIO_ACTIVE_HIGH>;
+
+		samsung,audio-routing =
+			"HP", "HPOUT1L",
+			"HP", "HPOUT1R",
+
+			"SPK", "SPKOUTLN",
+			"SPK", "SPKOUTLP",
+
+			"RCV", "HPOUT2N",
+			"RCV", "HPOUT2P",
+
+			"LINE", "LINEOUT2N",
+			"LINE", "LINEOUT2P",
+
+			"IN1LP", "Main Mic",
+			"IN1LN", "Main Mic",
+
+			"IN1RP", "Headset Mic",
+			"IN1RN", "Headset Mic",
+
+			"Modem Out", "Modem TX",
+			"Modem RX", "Modem In",
+
+			"Bluetooth SPK", "TX",
+			"RX", "Bluetooth Mic";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&headset_det &earpath_sel>;
+
+		cpu {
+			sound-dai = <&i2s0>, <&bt_codec>;
+		};
+
+		codec {
+			sound-dai = <&wm8994>;
+		};
+	};
 };
 
 &fg {
@@ -51,6 +125,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
+	headset_det: headset-det {
+		samsung,pins = "gph0-6", "gph3-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
 	fg_irq: fg-irq {
 		samsung,pins = "gph3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
@@ -58,6 +138,24 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	headset_micbias_ena: headset-micbias-ena {
+		samsung,pins = "gpj2-5";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	earpath_sel: earpath-sel {
+		samsung,pins = "gpj2-6";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	main_micbias_ena: main-micbias-ena {
+		samsung,pins = "gpj4-2";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	/* Based on vendor kernel v2.6.35.7 */
 	sleep_cfg: sleep-cfg {
 		PIN_SLP(gpa0-0, PREV, NONE);
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index 5d10dd67eacc..560f830b6f6b 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -72,6 +72,73 @@
 			pinctrl-0 = <&fm_irq &fm_rst>;
 		};
 	};
+
+	micbias_reg: regulator-fixed-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "MICBIAS";
+		gpio = <&gpj4 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&micbias_reg_ena>;
+	};
+
+	sound {
+		compatible = "samsung,aries-wm8994";
+
+		model = "Aries";
+
+		extcon = <&fsa9480>;
+
+		main-micbias-supply = <&micbias_reg>;
+		headset-micbias-supply = <&micbias_reg>;
+
+		earpath-sel-gpios = <&gpj2 6 GPIO_ACTIVE_HIGH>;
+
+		io-channels = <&adc 3>;
+		io-channel-names = "headset-detect";
+		headset-detect-gpios = <&gph0 6 GPIO_ACTIVE_LOW>;
+		headset-key-gpios = <&gph3 6 GPIO_ACTIVE_HIGH>;
+
+		samsung,audio-routing =
+			"HP", "HPOUT1L",
+			"HP", "HPOUT1R",
+
+			"SPK", "SPKOUTLN",
+			"SPK", "SPKOUTLP",
+
+			"RCV", "HPOUT2N",
+			"RCV", "HPOUT2P",
+
+			"LINE", "LINEOUT2N",
+			"LINE", "LINEOUT2P",
+
+			"IN1LP", "Main Mic",
+			"IN1LN", "Main Mic",
+
+			"IN1RP", "Headset Mic",
+			"IN1RN", "Headset Mic",
+
+			"IN2LN", "FM In",
+			"IN2RN", "FM In",
+
+			"Modem Out", "Modem TX",
+			"Modem RX", "Modem In",
+
+			"Bluetooth SPK", "TX",
+			"RX", "Bluetooth Mic";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&headset_det &earpath_sel>;
+
+		cpu {
+			sound-dai = <&i2s0>, <&bt_codec>;
+		};
+
+		codec {
+			sound-dai = <&wm8994>;
+		};
+	};
 };
 
 &aliases {
@@ -88,6 +155,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	headset_det: headset-det {
+		samsung,pins = "gph0-6", "gph3-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
 	fm_irq: fm-irq {
 		samsung,pins = "gpj2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
@@ -102,6 +175,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	earpath_sel: earpath-sel {
+		samsung,pins = "gpj2-6";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	massmemory_en: massmemory-en {
 		samsung,pins = "gpj2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
@@ -109,6 +188,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	micbias_reg_ena: micbias-reg-ena {
+		samsung,pins = "gpj4-2";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	/* Based on CyanogenMod 3.0.101 kernel */
 	sleep_cfg: sleep-cfg {
 		PIN_SLP(gpa0-0, PREV, NONE);
-- 
2.20.1

