Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7215CC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A00214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDZSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:57 -0400
Received: from mail-co1nam11olkn2065.outbound.protection.outlook.com ([40.92.18.65]:26569
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgDZSgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezxdUwS3p3CknL/pHTj5WiDxztZ3U4VFHeMGh7K7qVGIJM9zthTPJKBy72WqXyHWBOuRY2AOZpJk8JkNBQGEcrvvB2WckbS7CaDI2EE+bUpdaj/7+dKIJjvM2AD5k5/ZXKpTuZ2zE3pGMUyXV7r2tNW9/eqwmk9DOMsg39Y0DTXT1P6MQ5rnUGu4ngzupjRBEtM25VcdzDAesbT7n2YQwvyCD3fVvCavZoBK7yTsBnT9W9EO9wgpv8TLeYeKKGbbsBtrKJQJp5rdKEA9EeCBCvJrFMeOlSc2v/DNNgMEtDfHfPqNNRue4KfhQ2kjQAM98N/g5eUKBdTLNlkkZwOZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOSeV4eT86/g0Brn0wyPQFC8hKAx7Ey9Mne0kgl0nFs=;
 b=Z//uwF4O8nGkBFmeyH4kpBwhRVOMjY8Em/a8udUubh0SD1JRahnCyQPR9L2I7kfgk9YIgKVg20bj22l3ymMXjLucgXS2jBKr5DVI8XnuuFARd22pPOrH63P8KJEoquG+UKDRRtjAiuLYj08TiliagVp1d6ZzSYFHM5Sm6POBziW2z9EnE1Dfu0cpUoti9deLWKSK17zcGL3RD/2OGx5F080PZ6GUAc1k3PfOezjfGbUZYrT01Gp56Vg2XSd+PuIuDzANAPSiDR0+aEevcwWBZWkES7w9lxsvY2K3q9ScoVUdJclIMnG+rnfX1RHslZ+76sJPMTyH8gOP3pni7zRXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::53) by
 CO1NAM11HT190.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::184)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:48 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0BFDB984871B69F4CDF82D49C2AC4A9C2E9268B8CEFDF7733D362178511C9931;UpperCasedChecksum:CDCBC175BA55E477A2F1205A4514F52F58F2568F9F7E2BFD62093E07E9208B65;SizeAsReceived:7807;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:48 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 13/13] arm: dts: s5pv210: aries: Set MAX8998 GPIO pulls
Date:   Sun, 26 Apr 2020 11:36:04 -0700
Message-ID: <BN6PR04MB06605CBCAA817375BE008EB7A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-14-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:47 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-14-xc-racer2@live.ca>
X-TMN:  [uKUguzY0MMM+H2cjqLqU88q9ORfdnLMUmXkPEF7Abtk4e/C94NGkf/O3ufpo6leo]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 62b06bdd-f1a1-4f1c-03ca-08d7ea10c75a
X-MS-TrafficTypeDiagnostic: CO1NAM11HT190:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh13DoDW7bqfIIJgOK07C8B1uEm4nxSrNEWfLyy3uBfmufbgJ18hQUCYWYd/j/FWjIPhksL5LiAZjm6mxh17jiwtCReq1VLByBuyTgtqN8U+xBW18ZJnSwMIyRDF+0ZSsrm9y+ZPU5ZfEahcb75O9dC0AnEA3eKEhwcXtSTzKHs+dKGrMpVbVXPLp3S95R0ndi0TeYrNLoou39uo4KevAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Do2ZAQQZeArxM6o08J6Mmz10+tpqMuYMMfnItVzF5HCNxPF5R2NoW641SP5ZVpFntF6vwfK9BV0ve52Lkne5Mm8oxjf+igQXVoFLLNSOQ8mOWjANFzXdvrDf+wjMRywPDEOoa3sJiBJp2f0ZwDttzUfIbPNhcBOIsMu+T7l5g3U6Dll9vMJliZq1wTrKf9xDsOAYciib7qfxGaOkFwlrMg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b06bdd-f1a1-4f1c-03ca-08d7ea10c75a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:48.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the GPIOs are configured correctly
for the interrupt (otherwise it won't fire) and disable the
pulls on the DVS GPIOs which are outputs.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 7e113d750b97..000f582e9a0b 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -167,6 +167,9 @@
 			max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
 			max8998,pmic-buck2-dvs-voltage = <1100000>, <1000000>;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pmic_dvs_pins &pmic_irq>;
+
 			regulators {
 				ldo2_reg: LDO2 {
 					regulator-name = "VALIVE_1.2V";
@@ -605,6 +608,21 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
+	pmic_dvs_pins: pmic-dvs-pins {
+		samsung,pins = "gph0-3", "gph0-4", "gph0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-val = <0>;
+	};
+
+	pmic_irq: pmic-irq {
+		samsung,pins = "gph0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	wifi_host_wake: wifi-host-wake {
 		samsung,pins = "gph2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-- 
2.20.1

