Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73023C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE83214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDZSgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:39 -0400
Received: from mail-bn8nam11olkn2018.outbound.protection.outlook.com ([40.92.20.18]:35988
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgDZSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfZ+RSu+0aldnKzOiXPLhn6sq/Pwb8rBHl13r7uX5wuWkY87NONN1lP9g/HIR+pDzuoxFbS+fI2909kOmvL1SWc3Dm/98+4LEjGjJl7btcFTX7sRf885UxAkz8WjJi8sMA6F8mxeIlsKXfbmuc0DpJ2RkoCpkrLVr+xILcekGu2dy3sGip7/35btxW0DNWVmKBVmD4mgS5Ww1gja7lVccOXNTCbIlnHrN9E361ci+fmhEU7i0X78ktT7C0u0Q7S7V25SPYSRW27tUii743GOHK6sDVjHUTf+2sWHJJbtBiu/KTR8NhJiPECy4AAEYFaDevdYUkdKtfhCqfP0mf/gJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuIUagYnJ6jGpZZxTvUjBEVF19U/VXIZ7cpZ7g4uqDM=;
 b=kA7Is/u0ACAYpunfgdwI++KMXgBG6o1+Af2NBsm600lrOWnrhUMsNbQwtNRxbrqZlMIa4nuj0qAgNB0uBDti2CQ7OrqwoUNi3ZiIOho9+TGhfoGMbVKklF4dYgLFWfPIxeoE7yLeCpI/a311E5wSa9x93RfQUoXmNHDozbQ1Bsyz7vyEvihktf95f8ODLdvvSE2SZWxkOa5KRZjO8K3/nRLPJzpDqoWtm79c9HYu5EYAcSREFociLTt2aRy782KC2oxPA1DM7Eu/ukQQxL6fnkJZU24OEw4jbTgN9ESB47r+148XeKFBRnDpcTN2Z3FRBeYFApVj1BVwOsPcpfUvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::48) by
 CO1NAM11HT004.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::335)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:32 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:32 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0FAE5F3C3F047986B8F39F9FA5F3104B6EA179615951366252E3D8889F0199E1;UpperCasedChecksum:3B6F7EC5881260D96D40DD0EDE347B4FA4F16C5B1DF9A4ED2B0AD91AE9862DA3;SizeAsReceived:7804;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:30 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 03/13] arm: dts: s5pv210: galaxys: Add sleep GPIO configuration
Date:   Sun, 26 Apr 2020 11:35:54 -0700
Message-ID: <BN6PR04MB066025AC54E922DE6ACD6610A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:28 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-4-xc-racer2@live.ca>
X-TMN:  [4ElR3UMnqrZLMt5lq6wnoHtf+hfFMKZko3swhFTSIN8oFRwsNRToaTE83RUUg/Tj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c65d89eb-bd7a-40b7-6c80-08d7ea10bc72
X-MS-TrafficTypeDiagnostic: CO1NAM11HT004:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbaDEkOBKKQxr0X0Pj/mGG/fRfyxuOCluP8LghE+zbBHuv7iHczYIG2GorpruRRUEtZP/KYT3tGO9qhbCDmMPzDoJ0er5nQTufDLK2dkSM9wEqJ3F0a+xk5MOSKjoGHtWz06SWXB2nFrHaY1tMF0qV0oOOKqdy5XzgdOQ9fapN5AitC+YbkOvDsR504w1nOxBLngDzacG+EbguPW0aWybw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: bUdQdjZtDtqqMXHwnWIyyfp4q+tD9mCgekNUw5kbncVQvN5kpRnSRuBoJj/Np6hTTpYDZuP3rSpra+RIDfF83HUkD5la4C3L6xd8m+XHn3R5ej6TWxLNLlynP0TzW370acVQ3cj5MMOXMGTBrCcbfH4jeTWT+kDpxpmKR3+YvLZcURHNdMuQ8rWYkPS3mngBOD1JDG/Bgmj5To7+orVDvg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65d89eb-bd7a-40b7-6c80-08d7ea10bc72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:30.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to minimize leakage current during sleep, set a config
for sleep GPIOs.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-galaxys.dts | 240 ++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index cf161bbfbacf..2eff1e66a2a5 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -52,12 +52,252 @@
 };
 
 &pinctrl0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep_cfg>;
+
 	massmemory_en: massmemory-en {
 		samsung,pins = "gpj2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	sleep_cfg: sleep-cfg {
+		PIN_SLP(gpa0-0, PREV, NONE);
+		PIN_SLP(gpa0-1, PREV, NONE);
+		PIN_SLP(gpa0-2, PREV, NONE);
+		PIN_SLP(gpa0-3, OUT1, NONE);
+		PIN_SLP(gpa0-4, INPUT, DOWN);
+		PIN_SLP(gpa0-5, OUT0, NONE);
+		PIN_SLP(gpa0-6, INPUT, DOWN);
+		PIN_SLP(gpa0-7, OUT1, NONE);
+
+		PIN_SLP(gpa1-0, INPUT, DOWN);
+		PIN_SLP(gpa1-1, OUT0, NONE);
+		PIN_SLP(gpa1-2, INPUT, NONE);
+		PIN_SLP(gpa1-3, OUT0, NONE);
+
+		PIN_SLP(gpb-0, OUT0, NONE);
+		PIN_SLP(gpb-1, OUT1, NONE);
+		PIN_SLP(gpb-2, OUT0, NONE);
+		PIN_SLP(gpb-3, PREV, NONE);
+		PIN_SLP(gpb-4, INPUT, NONE);
+		PIN_SLP(gpb-5, PREV, NONE);
+		PIN_SLP(gpb-6, INPUT, DOWN);
+		PIN_SLP(gpb-7, OUT0, NONE);
+
+		PIN_SLP(gpc0-0, OUT0, NONE);
+		PIN_SLP(gpc0-1, INPUT, DOWN);
+		PIN_SLP(gpc0-2, OUT0, NONE);
+		PIN_SLP(gpc0-3, INPUT, NONE);
+		PIN_SLP(gpc0-4, OUT0, NONE);
+
+		PIN_SLP(gpc1-0, INPUT, DOWN);
+		PIN_SLP(gpc1-1, INPUT, DOWN);
+		PIN_SLP(gpc1-2, INPUT, DOWN);
+		PIN_SLP(gpc1-3, INPUT, DOWN);
+		PIN_SLP(gpc1-4, INPUT, DOWN);
+
+		PIN_SLP(gpd0-0, INPUT, DOWN);
+		PIN_SLP(gpd0-1, OUT0, NONE);
+		PIN_SLP(gpd0-2, INPUT, DOWN);
+		PIN_SLP(gpd0-3, INPUT, DOWN);
+
+		PIN_SLP(gpd1-0, INPUT, NONE);
+		PIN_SLP(gpd1-1, INPUT, NONE);
+		PIN_SLP(gpd1-2, INPUT, NONE);
+		PIN_SLP(gpd1-3, INPUT, NONE);
+		PIN_SLP(gpd1-4, INPUT, DOWN);
+		PIN_SLP(gpd1-5, INPUT, DOWN);
+
+		PIN_SLP(gpe0-0, INPUT, DOWN);
+		PIN_SLP(gpe0-1, INPUT, DOWN);
+		PIN_SLP(gpe0-2, INPUT, DOWN);
+		PIN_SLP(gpe0-3, INPUT, DOWN);
+		PIN_SLP(gpe0-4, INPUT, DOWN);
+		PIN_SLP(gpe0-5, INPUT, DOWN);
+		PIN_SLP(gpe0-6, INPUT, DOWN);
+		PIN_SLP(gpe0-7, INPUT, DOWN);
+
+		PIN_SLP(gpe1-0, INPUT, DOWN);
+		PIN_SLP(gpe1-1, INPUT, DOWN);
+		PIN_SLP(gpe1-2, INPUT, DOWN);
+		PIN_SLP(gpe1-3, OUT0, NONE);
+		PIN_SLP(gpe1-4, INPUT, DOWN);
+
+		PIN_SLP(gpf0-0, OUT0, NONE);
+		PIN_SLP(gpf0-1, OUT0, NONE);
+		PIN_SLP(gpf0-2, OUT0, NONE);
+		PIN_SLP(gpf0-3, OUT0, NONE);
+		PIN_SLP(gpf0-4, OUT0, NONE);
+		PIN_SLP(gpf0-5, OUT0, NONE);
+		PIN_SLP(gpf0-6, OUT0, NONE);
+		PIN_SLP(gpf0-7, OUT0, NONE);
+
+		PIN_SLP(gpf1-0, OUT0, NONE);
+		PIN_SLP(gpf1-1, OUT0, NONE);
+		PIN_SLP(gpf1-2, OUT0, NONE);
+		PIN_SLP(gpf1-3, OUT0, NONE);
+		PIN_SLP(gpf1-4, OUT0, NONE);
+		PIN_SLP(gpf1-5, OUT0, NONE);
+		PIN_SLP(gpf1-6, OUT0, NONE);
+		PIN_SLP(gpf1-7, OUT0, NONE);
+
+		PIN_SLP(gpf2-0, OUT0, NONE);
+		PIN_SLP(gpf2-1, OUT0, NONE);
+		PIN_SLP(gpf2-2, OUT0, NONE);
+		PIN_SLP(gpf2-3, OUT0, NONE);
+		PIN_SLP(gpf2-4, OUT0, NONE);
+		PIN_SLP(gpf2-5, OUT0, NONE);
+		PIN_SLP(gpf2-6, OUT0, NONE);
+		PIN_SLP(gpf2-7, OUT0, NONE);
+
+		PIN_SLP(gpf3-0, OUT0, NONE);
+		PIN_SLP(gpf3-1, OUT0, NONE);
+		PIN_SLP(gpf3-2, OUT0, NONE);
+		PIN_SLP(gpf3-3, OUT0, NONE);
+		PIN_SLP(gpf3-4, PREV, NONE);
+		PIN_SLP(gpf3-5, INPUT, DOWN);
+
+		PIN_SLP(gpg0-0, OUT0, NONE);
+		PIN_SLP(gpg0-1, INPUT, NONE);
+		PIN_SLP(gpg0-2, INPUT, NONE);
+		PIN_SLP(gpg0-3, INPUT, NONE);
+		PIN_SLP(gpg0-4, INPUT, NONE);
+		PIN_SLP(gpg0-5, INPUT, NONE);
+		PIN_SLP(gpg0-6, INPUT, NONE);
+
+		PIN_SLP(gpg1-0, OUT0, NONE);
+		PIN_SLP(gpg1-1, OUT1, NONE);
+		PIN_SLP(gpg1-2, PREV, NONE);
+		PIN_SLP(gpg1-3, OUT1, NONE);
+		PIN_SLP(gpg1-4, OUT1, NONE);
+		PIN_SLP(gpg1-5, OUT1, NONE);
+		PIN_SLP(gpg1-6, OUT1, NONE);
+
+		PIN_SLP(gpg2-0, OUT0, NONE);
+		PIN_SLP(gpg2-1, OUT0, NONE);
+		PIN_SLP(gpg2-2, INPUT, NONE);
+		PIN_SLP(gpg2-3, OUT0, NONE);
+		PIN_SLP(gpg2-4, OUT0, NONE);
+		PIN_SLP(gpg2-5, OUT0, NONE);
+		PIN_SLP(gpg2-6, OUT0, NONE);
+
+		PIN_SLP(gpg3-0, OUT1, NONE);
+		PIN_SLP(gpg3-1, OUT0, NONE);
+		PIN_SLP(gpg3-2, INPUT, NONE);
+		PIN_SLP(gpg3-3, INPUT, DOWN);
+		PIN_SLP(gpg3-4, OUT0, NONE);
+		PIN_SLP(gpg3-5, OUT0, NONE);
+		PIN_SLP(gpg3-6, INPUT, DOWN);
+
+		PIN_SLP(gpi-0, PREV, NONE);
+		PIN_SLP(gpi-1, INPUT, DOWN);
+		PIN_SLP(gpi-2, PREV, NONE);
+		PIN_SLP(gpi-3, PREV, NONE);
+		PIN_SLP(gpi-4, PREV, NONE);
+		PIN_SLP(gpi-5, INPUT, DOWN);
+		PIN_SLP(gpi-6, INPUT, DOWN);
+
+		PIN_SLP(gpj0-0, INPUT, NONE);
+		PIN_SLP(gpj0-1, INPUT, NONE);
+		PIN_SLP(gpj0-2, INPUT, NONE);
+		PIN_SLP(gpj0-3, INPUT, NONE);
+		PIN_SLP(gpj0-4, INPUT, NONE);
+		PIN_SLP(gpj0-5, INPUT, DOWN);
+		PIN_SLP(gpj0-6, OUT0, NONE);
+		PIN_SLP(gpj0-7, INPUT, NONE);
+
+		PIN_SLP(gpj1-0, INPUT, DOWN);
+		PIN_SLP(gpj1-1, OUT0, NONE);
+		PIN_SLP(gpj1-2, INPUT, DOWN);
+		PIN_SLP(gpj1-3, PREV, NONE);
+		PIN_SLP(gpj1-4, PREV, NONE);
+		PIN_SLP(gpj1-5, OUT0, NONE);
+
+		PIN_SLP(gpj2-0, INPUT, DOWN);
+		PIN_SLP(gpj2-1, INPUT, DOWN);
+		PIN_SLP(gpj2-2, OUT0, NONE);
+		PIN_SLP(gpj2-3, INPUT, DOWN);
+		PIN_SLP(gpj2-4, INPUT, UP);
+		PIN_SLP(gpj2-5, PREV, NONE);
+		PIN_SLP(gpj2-6, PREV, NONE);
+		PIN_SLP(gpj2-7, OUT1, NONE);
+
+		PIN_SLP(gpj3-0, INPUT, NONE);
+		PIN_SLP(gpj3-1, INPUT, NONE);
+		PIN_SLP(gpj3-2, OUT0, NONE);
+		PIN_SLP(gpj3-3, INPUT, DOWN);
+		PIN_SLP(gpj3-4, INPUT, NONE);
+		PIN_SLP(gpj3-5, INPUT, NONE);
+		PIN_SLP(gpj3-6, INPUT, NONE);
+		PIN_SLP(gpj3-7, INPUT, NONE);
+
+		PIN_SLP(gpj4-0, INPUT, NONE);
+		PIN_SLP(gpj4-1, INPUT, DOWN);
+		PIN_SLP(gpj4-2, PREV, NONE);
+		PIN_SLP(gpj4-3, INPUT, NONE);
+		PIN_SLP(gpj4-4, INPUT, DOWN);
+
+		PIN_SLP(mp01-0, INPUT, DOWN);
+		PIN_SLP(mp01-1, OUT0, NONE);
+		PIN_SLP(mp01-2, INPUT, DOWN);
+		PIN_SLP(mp01-3, INPUT, DOWN);
+		PIN_SLP(mp01-4, OUT1, NONE);
+		PIN_SLP(mp01-5, INPUT, DOWN);
+		PIN_SLP(mp01-6, INPUT, DOWN);
+		PIN_SLP(mp01-7, INPUT, DOWN);
+
+		PIN_SLP(mp02-0, INPUT, DOWN);
+		PIN_SLP(mp02-1, INPUT, DOWN);
+		PIN_SLP(mp02-2, INPUT, NONE);
+		PIN_SLP(mp02-3, INPUT, DOWN);
+
+		PIN_SLP(mp03-0, INPUT, DOWN);
+		PIN_SLP(mp03-1, INPUT, DOWN);
+		PIN_SLP(mp03-2, OUT1, NONE);
+		PIN_SLP(mp03-3, OUT0, NONE);
+		PIN_SLP(mp03-4, INPUT, NONE);
+		PIN_SLP(mp03-5, OUT1, NONE);
+		PIN_SLP(mp03-6, INPUT, DOWN);
+		PIN_SLP(mp03-7, INPUT, DOWN);
+
+		PIN_SLP(mp04-0, INPUT, DOWN);
+		PIN_SLP(mp04-1, OUT0, NONE);
+		PIN_SLP(mp04-2, INPUT, DOWN);
+		PIN_SLP(mp04-3, OUT0, NONE);
+		PIN_SLP(mp04-4, INPUT, DOWN);
+		PIN_SLP(mp04-5, INPUT, DOWN);
+		PIN_SLP(mp04-6, OUT0, NONE);
+		PIN_SLP(mp04-7, INPUT, DOWN);
+
+		PIN_SLP(mp05-0, INPUT, NONE);
+		PIN_SLP(mp05-1, INPUT, NONE);
+		PIN_SLP(mp05-2, INPUT, NONE);
+		PIN_SLP(mp05-3, INPUT, NONE);
+		PIN_SLP(mp05-4, INPUT, DOWN);
+		PIN_SLP(mp05-5, OUT0, NONE);
+		PIN_SLP(mp05-6, INPUT, DOWN);
+		PIN_SLP(mp05-7, PREV, NONE);
+
+		PIN_SLP(mp06-0, INPUT, DOWN);
+		PIN_SLP(mp06-1, INPUT, DOWN);
+		PIN_SLP(mp06-2, INPUT, DOWN);
+		PIN_SLP(mp06-3, INPUT, DOWN);
+		PIN_SLP(mp06-4, INPUT, DOWN);
+		PIN_SLP(mp06-5, INPUT, DOWN);
+		PIN_SLP(mp06-6, INPUT, DOWN);
+		PIN_SLP(mp06-7, INPUT, DOWN);
+
+		PIN_SLP(mp07-0, INPUT, DOWN);
+		PIN_SLP(mp07-1, INPUT, DOWN);
+		PIN_SLP(mp07-2, INPUT, DOWN);
+		PIN_SLP(mp07-3, INPUT, DOWN);
+		PIN_SLP(mp07-4, INPUT, DOWN);
+		PIN_SLP(mp07-5, INPUT, DOWN);
+		PIN_SLP(mp07-6, INPUT, DOWN);
+		PIN_SLP(mp07-7, INPUT, DOWN);
+	};
 };
 
 &sdhci0 {
-- 
2.20.1

