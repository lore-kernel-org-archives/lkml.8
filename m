Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853AFC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689F521835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgEAXvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:50 -0400
Received: from mail-dm6nam12olkn2052.outbound.protection.outlook.com ([40.92.22.52]:41440
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728078AbgEAXvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7n7Lf5ZakJX2GtI0n6fdMzi2F/HPHaimjuHM1TKguI/9uCqHEOplejPmKghlLLqHN4f4MjZR0iVnMhDlBseKYOW5E+B8+5IW7/2Wxr6XTpdVSeK7fpyZt5KIIizLj2XvvoEThq0kf9wSlfdhYGbzNj6TXGrS+dnwgSXW4sGO+g8IFcRSsdfDMeuujZNPa4ex6ksRQO24VML+sz3SyuSqa4l/EdNcihc2wwqKRY+Kmo0jUVkXj2/d/qKzKDo1adKMjw5HCrDl7LhvxoJwShbVKLYyUuDYJCH9TSIxwS5Pkt0BavuWMuceRM80DMFV9xmc14Jmb/aUse1knN7oLmsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30FnPkQg6MgHAbbFYq87y7gvAN61SyA8Xl8JPg7VkOY=;
 b=JRE0JMLJRz9Rg1uSiryPWD1EZf7Uu1cJJbZTOBE8GgeUUM2en2xEbSr7DmdGbcwnUtXBMDFppYH6F/AOMjh9c7ddX5dAMLUuxh+zggUfy/E6JxTSNQg9vyTZxCr3YzgHNvtknqtQ2ViivUCg7oBBpJe7QoeFEw8sFXRvMITPfFxbqQoL/ohCWGkeQLc4RV4LyiUV9fySNYMxEsEiNhUwlry6buSW0l1gKCQXpOtKCtRNf8InI7ApqmMIkbWvHC6sHJPNu4EJTRyXMctlVyr39fiRLsduCdceM3HobywBI3Agw9Pq7VidwRLoXfCVDh26hdzC2HSpD0PAB8UqJLarqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4a) by
 DM6NAM12HT116.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::100)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:39 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:39 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:AAB324946AA5C1EBD9434508F358AA077D7074415FE73BA7917102E560B8AE74;UpperCasedChecksum:663DFCD72C8516DD1BBF132ECEAB848832FA9617645C1D1EB46B7ADDA33D836C;SizeAsReceived:7857;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:39 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 17/18] ARM: dts: s5pv210: Set MAX8998 GPIO pulls on aries
Date:   Fri,  1 May 2020 16:50:18 -0700
Message-ID: <BN6PR04MB06605369BD22EC1C110587FEA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-18-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:38 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-18-xc-racer2@live.ca>
X-TMN:  [MVlAceRo7UQK6MuBisHS/Zu7Di8HvT1aOJnZyko44z2ZAYO4NwHYSkImlEU86drv]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: f1984402-c916-45e0-7be2-08d7ee2a975d
X-MS-TrafficTypeDiagnostic: DM6NAM12HT116:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UszKo8/PRi6Ldlwg2/VXCVu1XtMhz5qy6IvS8kRa6+kZbXIj0aMSrUcaG/4aSWtMTxQFQB4kZCGRfs9bBO5no0+UPtlY1ciqxxlfrkTDQSGA4H20GGM/SJmk31fDwIUamDwTpMuOunQvd4edJmKx3ORFSQKx9n1gQmIrujrqUfMAXLBZgKo8uE7BhLvOpKGKK+0ydlNJMnREmjAr87SH9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: lD1teSLpFnVRuwbc5ySzad+2XtKmnS4bSJZuFr14Ny9s+i04yfHGqmDMvO8RpgzkROdgdXz6LXDdv0LjFqoLZItL5uzf1AzSWxRjLrVulgN9TlZrxBvI8P26LKGnpGXZXo1WxteryZnY1ICjIoBNvGajEddTyNDWpkStgoPRBkYn0ySXzospUkNE5doHCkESU+dUcW/DqSN12BcDmNQ77w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1984402-c916-45e0-7be2-08d7ee2a975d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:39.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT116
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
index 0bd65401ec65..cf858029292e 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -169,6 +169,9 @@
 			max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
 			max8998,pmic-buck2-dvs-voltage = <1100000>, <1000000>;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pmic_dvs_pins &pmic_irq>;
+
 			regulators {
 				ldo2_reg: LDO2 {
 					regulator-name = "VALIVE_1.2V";
@@ -617,6 +620,21 @@
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

