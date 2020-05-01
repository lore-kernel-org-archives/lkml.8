Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D68C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B672321835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEAXvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:25 -0400
Received: from mail-mw2nam12olkn2019.outbound.protection.outlook.com ([40.92.23.19]:6017
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgEAXvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilqrxcHAG3ObH+bUEAkysNQ+bJcsQqzvx1MESB/QMLldHCwcF9J2Zy9rXdG/VqTkjV4q2yVpVfFZnWnW9Oc9Y0R99/gTOibnx3l/JxGcy5mBZnTjFj2ETAh7/mHhIU7s8maA19vGgVzrDheQ1pCFlWELrNxyHgQhwSyQLKjHuRNomScorQ2A80r6palzVwPXSF/RrmUuD0EZScAKPWscjsdLFTUMtjB0x9PBhtLesFb+gmkJ9JIp00/FWTjK6unYYxE/8QdW39Hbp8taFGDW5hXRrx29WRXYtppdeISVcFAVulD9E5PAuOMsXpuN+80CrIYZ3UGyGeaW8TdzT0jBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN3YzdF/wnL3hIWhRkaPqBP6Y72JqMDzTT6ZdUZZ9Yg=;
 b=g25t73o7qUTR5CLwKo8xIKn/q/3HQZ8qeYHxzBTZ57Mg9ddjb7GX8DnFRkkWG93Vtu5NCSlfwciyumIkUlCd/h0KbrpdWJh240MxvF4+kQIRwWMiZwYN7Lskm8lb4JCDLUko+eEOD2VRhBj41igGBe/lH8W5H61pFtVGmXM1Gf5jEu2yE1KfX0O5LHYIAnC6k18Xxlvd3wOUeGlQCyOe8s131eioSzESc170mQoYj4VD7ZIa70dg3uicLIzNfB27DEIMNN8nrRtNkZdJciCTZR0Tt3uqKITHdvuC2hfTsbZReSfRFIgK85JLURvbzNEAKaS5HPWdtDoVI/MBX8I0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4e) by
 DM6NAM12HT060.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::330)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:19 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:19 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F9A6FAC4135DB7D3EFC5D4E6FD5CB615C64EFE7A67FB28DBBEC03EE591223747;UpperCasedChecksum:84B3296D3FE7AEFDF5DB67E334A66B5E2F46CFCA8DCADD5E1E4DF6E6006BC0AD;SizeAsReceived:7885;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:19 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 05/18] ARM: dts: s5pv210: Disable pulls on GPIO i2c adapters for aries
Date:   Fri,  1 May 2020 16:50:06 -0700
Message-ID: <BN6PR04MB0660E1E4A8C8E1D40E79B802A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:18 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-6-xc-racer2@live.ca>
X-TMN:  [BiGxoyyM4ex80fMTrx6Ee1dRiIp+DWjTlw/ZqxFbeJeKURDQVdnlBx50Vpvj6SI0]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 3848cf1f-1312-46b1-36f3-08d7ee2a8b77
X-MS-TrafficTypeDiagnostic: DM6NAM12HT060:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWRdJ1le3zTs3Y2FO61VMSUqLrPFUKLqZr+ljde0xlA+inHsyZTk1/y7eAs3ZmhjsxSX5cLMgsAfwnuYfZiDhwnTEOtWv+WRRX9HLvegctQTD4pn+8lMQLgvPeqAk4cTzYF1mW0AkmcEH3LvXtGXdAA9uuibS6N5d1f+Ivupay3po7+Tx3Hkd4QMglIom6unG6zXwsjrOJDnxFofShFoQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: it/qooU8roBlAP9MAzTaWeAY46P3WdaSMVNKwtjbDQzk8/DhJ+si41pS+tWSkT2ORTsJdXy4Rnm//gpuMpyeW2mo3OioMJrptxFqnc8dx8RfGvs4xjTzd6adeXKfajc3j/D6dC7XC59pDUQk1kqLxWZwT8+xz89dKCALuQB2OhqPpQ33+VdsriZ+/g4vV8DIEEfICNM5JzrpBzaCysST4A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3848cf1f-1312-46b1-36f3-08d7ee2a8b77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:19.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitbanged GPIO i2c adapters have external pull-ups attached
so the internal pulls should be disabled for lower power usage.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index d419b77201f7..f83df426f2b6 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -65,6 +65,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_i2c_pins>;
+
 		pmic@66 {
 			compatible = "maxim,max8998";
 			reg = <0x66>;
@@ -314,6 +317,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&fg_i2c_pins>;
+
 		fuelgauge@36 {
 			compatible = "maxim,max17040";
 			interrupt-parent = <&vic0>;
@@ -438,6 +444,18 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	pmic_i2c_pins: pmic-i2c-pins {
+		samsung,pins = "gpj4-0", "gpj4-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	fg_i2c_pins: fg-i2c-pins {
+		samsung,pins = "mp05-0", "mp05-1";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
 };
 
 &pwm {
-- 
2.20.1

