Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E8121835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgEAXwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:52:05 -0400
Received: from mail-bn8nam12olkn2088.outbound.protection.outlook.com ([40.92.21.88]:63328
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727992AbgEAXvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQi9LWdyTrmRT9UM7zas1wFvO21k2ixBs0UWipPAvyUHFhUkUH24bmP0pikCxWc5dg3+NYb3hxeHPyqh9OxkpgRMI88AOBDEN66zg40CdEh1ic5KUgfRFZkj7P4Xxq9s3yLxmEruYMKOhVeQVw4vD3on1bCc4KsOyBFE91IKro7iVX10+jw9bRYA+Zk9hQVIbfPUkIJVKpkJf6HlvLQ/nI/3qVR5oBy6lWNolBF6iHXSHFdJCxXSV/zVVY2Lg9afjuZsuvAMZYt1kLAi9KSgrct8V9fBb5nubp0pHwfjDfwCDaujeTj1aRdTmb9mg3FFE0KCDvAxWrTjcuhAYFoqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd/rQufjw4g/ZnjocC0edes0R1MAvXhYF76hCJFuEd0=;
 b=eReWpOMpYeUGuAPRltAFEu3qx1H/NSQ/vRQodXL1LW6h/k05BY9XinxM/7rcpJbbYIvCd0qZ+JGYC5Wlr6iYYbYaiwse1+SfnY5BFayBKq+uZvUxgTQgxteeoxmOFpj7uATtNv+tg78OZkgk8eTnps5Py9it53TE7iFXM67AZl84sEPPSzuf14FgQMZrhxhg3V7xho8929jZQUGT3c3khPkz4EU342CloJmOiNQS5Uf17whDRDDfdWFjPatr4jVpBuqRDxGql8p9esFM3bxQb9MHTrea24sZ6Hh0U/7LFp9Z/XzbaCqJcdRGepnfW3ZmH1osboa+DxD/1gCVqjd+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4b) by
 DM6NAM12HT076.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:29 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:29 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0DE8F0A40CC586553233A8681A370E201C08B952643FD9CF7DF753BC6D7EE667;UpperCasedChecksum:F42C7F27292D9BE2B48C4EFC4049873EF2A656C590D7C39168756702B3A3F2C1;SizeAsReceived:9094;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:29 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 11/18] ARM: dts: s5pv210: Add si470x fmradio to galaxys
Date:   Fri,  1 May 2020 16:50:12 -0700
Message-ID: <BN6PR04MB06600948771289E9B3D750F7A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-12-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:27 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-12-xc-racer2@live.ca>
X-TMN:  [DXWlrguAmHFFddJg6g/0m2ER62sAMuLqkZm57pu6EDbReCOVyZX1ffvkyRVhDBMs]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c4d1dd24-9f84-4cd0-3c9d-08d7ee2a9139
X-MS-TrafficTypeDiagnostic: DM6NAM12HT076:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aZV0zah56W1FMwEgAOotdSMHobzWONTCSrecNe2dP67aBEllbecyJCuj5F7q2PW0a2YTH/Y3+LKT1rqqFcg0BMRiEHD3HVCrJmuxMT6Wb8dGpeaBcgVfzqXPbi2Bybm6oIcI52h8W/byQL9h/GM7YrUtcFLVEZNfAEvxZR6TEDaX8oN1P2WQ9v7L81YacJ0/Dt7tXfuaQM0y0o2wFAKyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: LXvXp6pHTQNsWTd9tnFEVsqCUWcFAc5I1SZxg5HimoZm5ldRrqJuQhp6yGFUd4XXLWuJwFOe6l5uRdsPGr3rp14sqE7iF5ZKLnJ35KFvmoLVQ4yE2SBVaZCSBxXRqwo1S8cqwVwLwrwRltqBxHpuVrA/dNdYhOtGkD29e01CsLg1omZQ+CygNpHBQa9e8F0Q9BMRqyN5ibuGnMlTTyekOw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d1dd24-9f84-4cd0-3c9d-08d7ee2a9139
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:29.4356
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

From: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Add support for the Silicon Labs si4709 fmradio, which can be found
on Galaxy S GT-i9000 (but not most other aries variants).

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi  |  2 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts | 47 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index a3748705dce8..0fa3de3c985d 100644
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
index 9bf4a5b95b74..a99fdda25262 100644
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

