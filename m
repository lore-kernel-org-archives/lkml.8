Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD3C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C9B24954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgEAXve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:34 -0400
Received: from mail-dm6nam12olkn2095.outbound.protection.outlook.com ([40.92.22.95]:16121
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbgEAXva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMB9AyTJVYlZZwXN1BCn1Bdx5mvBUdZKoLA/LwEGXB5MicmbAzMHw9IlXPjX/pG2hcNa0rEkkNvVTioHEInyZUTLXQsz8erlVRgJoevOZHXHLQTvopQClk/bAcSHynw+Q5QCaGgN4ldyJaL39i6pUpLJwYygTTQkzfRm6GfaitSq+978HqTAKG3noUM7OaA6X3gnOgGRWG2Ed7GOCFbXAYoTitV0kxUzAgSnEjo1SVUwICUK1FjX3UkoaEjsi5PgSxJL75Kryy7vfJ0zj8gy70dt0kI42KnrKVrialuiBvU/QEW/V/RWOZHMVTwvoRTuH5/6GH9aMnHUznJvSWig+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MDUkQ2dTjod1xk/8rLC43jTcn9lJdoxoad9bhahzOw=;
 b=dO8l+87pRbo3jh1/MuGYaNNj4EI3BXVCj6kPTpVud8Q1FdSUN5wjUefTu1aIOgnbkSMiz4mbTh7sOF7h1KYy7pk/L2W5VBRuYToWMJharGW/mKUQVsg3BGYV1PSOW3D4UmCxdec8jJ6C51pIb1Cb1VEDduev7jMmxCrANbksCQF0zNDCDaryoezZ7gmqYmQl57SfwCQMcmSS7Cop58TXMj0Ghj0jA3mqY1945O8LsR9S+YmWTUJKmd4cPr8R8+QzFTWD/VwPRcGL3tjUDLZik4xk+l/kyR1213t1+M8fq2WqYdZg/5Hc4oZyXvsUi3LjZwOODtLYTmgC9XKmBKD1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::46) by
 DM6NAM12HT200.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::74)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:27 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:27 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:7B8FB2A95B641A94B2893361021141BA26A1A074922B8EF1389B40ED794C0699;UpperCasedChecksum:9CFC7257941493FD6A1F2557DC4F7F6BD660A071B6583183981E4773F8BA7602;SizeAsReceived:7866;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:27 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 10/18] ARM: dts: s5pv210: Add remaining i2c-gpio adapters to aries
Date:   Fri,  1 May 2020 16:50:11 -0700
Message-ID: <BN6PR04MB0660BC97F0946E50B75309E7A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-11-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:26 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-11-xc-racer2@live.ca>
X-TMN:  [WIqVT9i6m7B9rblWchqbVR9EmRyruzCkXD2rRB2oEDeEFSqI29EzXZYx8WLqsbUj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 597a8baa-984a-4610-6a67-08d7ee2a9034
X-MS-TrafficTypeDiagnostic: DM6NAM12HT200:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9xYEOsxatyo7CuQMQP57iwnEaaJpsk4k3h2hV3c77Y1FKOZKSGxIdD7mc6wMdPekrRLaQDJM+JlAuj6tahb93oSt2PlnsQeQZqvEFwmILPEHVX7FK9IdEZ26rQCTkCF8KBSr4SAhzHPbY3/H1SJSH/xUwQxOyJIW9nEiyMO/d0l2b4LflTzHBKm8VlagpGQLETLYuKDL5O1VFKyGsVnWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: RFo0M/d/YpnhJGZiSbymtdxVy7w+aTYtInu/6WrTrNr83o/La3vAkZM6cW1ICakYWe+IDrB9WRT+3FI2VNXKB8fvlZ9sjGhag9Yl9OmuUn7iXrOcdbn5Md+VlRnq6PmuPm7/OSzqr292KdE1CmeBEclTlFKf2OhgDtHOyBKrKa5Hb+5zZvESvqULuj5SuL28kz3B8BbpD1lhIYJxyi3t1Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a8baa-984a-4610-6a67-08d7ee2a9034
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:27.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining i2c-gpio adapters that are common to all aries boards
have devices without mainline bindings attachted to them.  Add them
here for documentation.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 046366d58aa0..a3748705dce8 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -13,10 +13,13 @@
 
 	aliases {
 		i2c4 = &i2c_sound;
+		i2c5 = &i2c_accel;
 		i2c6 = &i2c_pmic;
 		i2c7 = &i2c_musb;
 		i2c9 = &i2c_fuel;
 		i2c10 = &i2c_touchkey;
+		i2c11 = &i2c_prox;
+		i2c12 = &i2c_magnetometer;
 	};
 
 	memory@30000000 {
@@ -120,6 +123,22 @@
 		};
 	};
 
+	i2c_accel: i2c-gpio-1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&accel_i2c_pins>;
+
+		status = "disabled";
+
+		/* bma023 accelerometer, no mainline binding */
+	};
+
 	i2c_pmic: i2c-gpio-2 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -435,6 +454,38 @@
 		};
 	};
 
+	i2c_prox: i2c-gpio-6 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpg2 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpg0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&prox_i2c_pins>;
+
+		status = "disabled";
+
+		/* Sharp gp2a prox/light sensor, incomplete mainline binding */
+	};
+
+	i2c_magnetometer: i2c-gpio-7 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj0 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj0 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&magnetometer_i2c_pins>;
+
+		status = "disabled";
+
+		/* Yamaha yas529 magnetometer, no mainline binding */
+	};
+
 	vibrator: pwm-vibrator {
 		compatible = "pwm-vibrator";
 		pwms = <&pwm 1 44642 0>;
@@ -546,6 +597,12 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
+	prox_i2c_pins: gp2a-i2c-pins {
+		samsung,pins = "gpg0-2", "gpg2-2";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	wlan_gpio_rst: wlan-gpio-rst {
 		samsung,pins = "gpg1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
@@ -586,6 +643,12 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
+	magnetometer_i2c_pins: yas529-i2c-pins {
+		samsung,pins = "gpj0-0", "gpj0-1";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	ts_irq: ts-irq {
 		samsung,pins = "gpj0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
@@ -611,6 +674,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	accel_i2c_pins: accel-i2c-pins {
+		samsung,pins = "gpj3-6", "gpj3-7";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	pmic_i2c_pins: pmic-i2c-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-- 
2.20.1

