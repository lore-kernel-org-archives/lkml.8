Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80FC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B714F21775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgEAXv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:28 -0400
Received: from mail-dm6nam12olkn2011.outbound.protection.outlook.com ([40.92.22.11]:28773
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727908AbgEAXvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWBOBaperJTsezjdIiEUHixiX5EA2KjzKDF2rfHZuhRJ70qw3xcRRxVgGCm24aM2UtYSMmB5GeT6cQJGwRKiPTm4nAK79wB2QTV/ivo/h0GKl/k6mWjp9c3i2vYkgMkXjOkCncvc4E2W6uH6EU3HbdwHEzX3w2MeRrfVwN9uGyTO3szxiOhakRGFBRwhkp2XXGRAYyAw3+VfaasroAp+huKZu6+6Hi6kGajzUs6XFpVc+SSatsyObKVOPrWskepmWtSbK9ciEU+dmHtm+NVrRJqkA5SUYCs3VrJIOgLsV7m1bTzTTjnyMKBOmSeFHfHjiwEqKoSI+4srRIlJB/tZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ8C6E3N5ce/4sn4hZuwIMmz9/7ENd8oYkbhGl+3RLw=;
 b=WnmmDl2lPIFFjsEZWcGM59thxrvseI1uSbqk/SIIF8Tv4i3YkrSS88d7ddwViO83pUTaa0WDntT4zrv7hQzo6CcoiA+onXMZNTdY6Qy3eO7/nXLSsuERau9cQSsq4pHaRwXgdkSddGan5o0zUpgbRdd1+pRAkTN3EWHbDNfHoz4AaI7hyLyEipJXrakUL3EXWon+Qy8+TttA7ippavPOTr63IQVTZsFSXrWXeVX1kFDalxl+gvu2yoPRjYXBCB5fW2sWZ+ifBrJqCl7dOA33emoExIb9vDnz27zZtT2955EiFCjBasUe2RNAFYhSYWM+WHueLoWPI66t4FCD+ytkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::51) by
 DM6NAM12HT013.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:23 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:22 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E2F6808C37FCC28E24AD5451F2C4763B3733B5A583175E2CB465DCBC8C7365E2;UpperCasedChecksum:4CD190FFF4EEF569928E21B7C16FFC61D2519F25133E5958CBD45DC88A2F3FA5;SizeAsReceived:7859;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:22 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 07/18] ARM: dts: s5pv210: Add FSA9480 support to Aries boards
Date:   Fri,  1 May 2020 16:50:08 -0700
Message-ID: <BN6PR04MB066052C8CB383D45123DA48DA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-8-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:21 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-8-xc-racer2@live.ca>
X-TMN:  [Ne+LP0yBqlESQ8WM4Q8Jx1rLd5uh+HpuzBzj5cXnYPtT15yBImUY86HNyFxq+qxe]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a3118125-3c6e-46c0-b098-08d7ee2a8d70
X-MS-TrafficTypeDiagnostic: DM6NAM12HT013:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdRR3wGxa7yb/LljF/RNGsCqP1GFFhZyfWvxj0sINl4ycj+NUm/ha7g2v8bO5oGKDk0EYet+rrBZ8O6l/1k1x2upGIcWHbnT6P+NP18EdCV6oiTuC2wHvOF/UTDCya8ucqO51Fa0eoe2fgETgeG3KMedrdDJaXBn2yazHw0cR0TbA+FjoEYwxHkwyF02FiMDPbz3nQl4pHmhgDPyo92low==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: aEagzuxzJpldCwtIYEBNTfH8+ZBC3kSxaFPvf7RnaptUVdmzVlLFXTu0fEIKAxpQHtZsR0ztTce0WQ6y42vb6e93QhkIT3KNn9kyEgUGxkCNTusFH3eWi8qqKHKQnhyyOdyEOYlXg5tA7qFiq2xBS90TmMai2Ddo6jopiR3CAgOn4tb4/bCg94k3YjpHnemwBr59IwGMSs3FEVTwbN2Xzw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3118125-3c6e-46c0-b098-08d7ee2a8d70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:22.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fairchild FSA9480 is a USB mux connected over i2c-gpio.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 7d001c22c532..6233884713cb 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -14,6 +14,7 @@
 	aliases {
 		i2c4 = &i2c_sound;
 		i2c6 = &i2c_pmic;
+		i2c7 = &i2c_musb;
 		i2c9 = &i2c_fuel;
 	};
 
@@ -358,6 +359,28 @@
 		};
 	};
 
+	i2c_musb: i2c-gpio-3 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj3 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj3 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&musb_i2c_pins>;
+
+		fsa9480: musb@25 {
+			compatible = "fcs,fsa9480";
+			reg = <0x25>;
+			interrupt-parent = <&gph2>;
+			interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&musb_irq>;
+		};
+	};
+
 	i2c_fuel: i2c-gpio-4 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -480,6 +503,13 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	musb_irq: musq-irq {
+		samsung,pins = "gph2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	tf_detect: tf-detect {
 		samsung,pins = "gph3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
@@ -500,6 +530,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	musb_i2c_pins: musb-i2c-pins {
+		samsung,pins = "gpj3-4", "gpj3-5";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	pmic_i2c_pins: pmic-i2c-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-- 
2.20.1

