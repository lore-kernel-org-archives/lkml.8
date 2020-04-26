Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F63C5519A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EFE20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgDZSgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:46 -0400
Received: from mail-co1nam11olkn2035.outbound.protection.outlook.com ([40.92.18.35]:10112
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgDZSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvqjvSQo9eYJbRnQKSyVz+lPVH/YneWv2bEKDGUh/FK1XC06u9Qmj+xwP9ShJiZvHSW0RPMK9xY/ir8qXl+SYCmrBVj80zbqMMCdwuratH2mBi2dWCs1sxQLlYrGpxGWxHYhc2646QB3D1cseV1n4S8BTM36hPub4wi9e6iXwnZtvJTE7QsnadPUqoxmWXPyGQiRQfvq+63nDvkmnWCDqsBqW4K9+O2BTGAg2rBYAp/ysQr4LbzXTjUfxK/wUA3Op/RdfbNmOdxiWg9Wu/jehfhsT1SUsHayYJ/KWc1iZ4zMRY7yKojUWdOl9jk8JCbBuyRNlDoeVjHpuQFisvTHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ANvzOSC6QBgJ3h9QyuwoRjD/dFEnablZURsNl5Ry/Q=;
 b=JzgV5ee8298hARcMEBBxNlkmfckXj+DU8ljumAsnnWLMJywVbdUmNClHVxTFPf0geY+Lf/EcvA+G+jmAnNXMdOOmFLfp0D9Zyfo1WxS3NG90L5j4OyMsL5f8toGLH8Z2/4AjEfV3iPQfGljnRqXPXywCIq6L8418bv20Nh8V+zfLpCMBqbqM2Ad1gNJwgWGWc/OTNyF26bS5tkSAF/RkPKv41bDwFWjaeRXjWPZeqcrQNnV7xlUuYO5uKCrPXtEpASJgrPvFcuQ9v8SjgMGCnSu50nt6eP4yfY8NljhVcBQtgXA6XKPiBbwrrKWjDhthttPkuZuTlAADhFEFM/R4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::44) by
 CO1NAM11HT181.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::187)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:39 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:39 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4034047005717F4C81398863669A381DADEF24AE78B70DF6F03E6C1B3BB9044B;UpperCasedChecksum:E332E393AF75C0DE442CEDA33790EFF753C373611BD052E64E8DB0F9E72704B4;SizeAsReceived:9048;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:39 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 07/13] arm: dts: s5pv210: galaxys: Add si470x fmradio
Date:   Sun, 26 Apr 2020 11:35:58 -0700
Message-ID: <BN6PR04MB0660205C8F173BF98B4D0DC1A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-8-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:37 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-8-xc-racer2@live.ca>
X-TMN:  [7JOn8Uv2lYGIafiOEz7enJgYbAB8vFX0wgp8CpG+glcKUP7lRvolmQTR72Xnh63E]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ecc70036-b410-49b1-e922-08d7ea10c1c2
X-MS-TrafficTypeDiagnostic: CO1NAM11HT181:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htBOo5DI70WIXqNQAbGASwvQOVlFlA9rGHxiDIh9kTdiNPsZfxUXBGpSbJnULAixd9xaJ3z1fFLmiHHOe6qb4iT1DBSUdaK3MATGCYynIdcM1UDcKiELFgULRAEXGIlmwIK7Izi13GrEmt53Z+yl9syVf+vBv+6Gnd3oJa4LUFchJsdZ7YjNvDEi3BJhvp5IMR48KvtrTO6ZgQrr48NbGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: +8XU+TalfQQ99O3Kn5SgSfEtBScItEvMXVHXv/z65E3aK+5KCqwZi3eN5NzuLP6Q58hu1iZo9tRRmlXAQrS7G7fWzZuiTx/7zmmbm7DZbD91t6wQ/HvIeUplfjRc9eA3lYzSZkyizb1LQEkA44gD/Veeh6VHw2unf0zyJzb+wnr6iE530WvAo2l50oGzw0amYqDDHK6iPmFcGpFtiJFnZA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc70036-b410-49b1-e922-08d7ea10c1c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:39.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Add support for the Silicon Labs si4709 fmradio, which can be found
on Galaxy S GT-i9000 (but not most other Galaxy S variants).

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi  |  2 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts | 47 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index ef966d13d83d..12575d64aa06 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -11,7 +11,7 @@
 / {
 	compatible = "samsung,aries", "samsung,s5pv210";
 
-	aliases {
+	aliases: aliases {
 		i2c4 = &i2c_sound;
 		i2c5 = &i2c_accel;
 		i2c6 = &i2c_pmic;
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index 2eff1e66a2a5..f5c13eb8ae71 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -49,12 +49,59 @@
 			wakeup-source;
 		};
 	};
+
+	i2c_fmradio: i2c-gpio-8 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpd1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpd1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&fm_i2c_pins>;
+
+		fmradio@10 {
+			compatible = "silabs,si470x";
+			reg = <0x10>;
+			interrupt-parent = <&gpj2>;
+			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpj2 5 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&fm_irq &fm_rst>;
+		};
+	};
+};
+
+&aliases {
+	i2c8 = &i2c_fmradio;
 };
 
 &pinctrl0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
+	fm_i2c_pins: fm-i2c-pins {
+		samsung,pins = "gpd1-2", "gpd1-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	fm_irq: fm-irq {
+		samsung,pins = "gpj2-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	fm_rst: fm-rst {
+		samsung,pins = "gpj2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	massmemory_en: massmemory-en {
 		samsung,pins = "gpj2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-- 
2.20.1

