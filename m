Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74356C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAD321835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgEAXwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:52:21 -0400
Received: from mail-dm6nam12olkn2107.outbound.protection.outlook.com ([40.92.22.107]:41988
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbgEAXvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8GiRXKNhXnk4N3JUUSAI+IUne52SaQ/sg/v+TpVLhbSsNuQEjuUA5qGqytcY/OLE1ZU+8CBpbEW6U6IKJ4haOTesFv5ScSMkupYiaVsnEkhF9nLQia/3PKybDEQwV/PdOA2sD/bM5wPFbQgnlXXkMNpZ5wsMj2Uh2K59fBLEj1VKpgFb5N3xM+gl7lrOWgo/5bMtIOPPUp/0WyHR9BlHnEiIRoIrvEy04fG0/Fxq1AONL7/40+QpFzBXH26DhjbTRveiadBf9bIoMk8APEcesRUu3//QDimjnIhDKcnzLIe1MKF2ZZEMzSHMNes1VhjIWv7neXJmuAFu4zIxYZy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTdLaOeMx1KQOz5RjQT8yD1nYu8gN/kN8v7SJpm8bzo=;
 b=JJNk83wobcH9U9ogW5pVWdj37lwFr03b7/sR8Ga4CKlbSasIE3BP8ZvuyGEOGPMawcvDOTf5I931tcaZw1rtqVnrmqfJGidiuPoRO4lvBUWcenQwZSV8ZkhfeEuHebWZwPgfCxV45Q21HB0p53NOze62ycfSoS36TOgi0CeBS+0/+8Y3CM2s624jRoeY6LeV8YpbSILbOTyQfLmvD0gMDQvlOZ4M3BgmJvxAwDzAfgLrQPkOCnSDJzrJ2p8CwqO7NzWYmvV03AyKQLrRoY9VyOi4mxve3+j88tGNwpR/peaAPWHgEdhg9xn5tocwNtAcILMmDln20426hpN3xx1fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::42) by
 DM6NAM12HT131.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::99)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:16 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:375553D82454E29E4F5E0B8A91A3F4B8D0ED67AFAC3EA887B6A9353A75896CDF;UpperCasedChecksum:4CA75806AB678B6058B5235B8A1694F9B24043928D0C4B48C73E17E5FD13BAE4;SizeAsReceived:7866;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:16 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 03/18] ARM: dts: s5pv210: Add sleep GPIO configuration for galaxys
Date:   Fri,  1 May 2020 16:50:04 -0700
Message-ID: <BN6PR04MB06603E005E03EF5718568A92A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:15 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-4-xc-racer2@live.ca>
X-TMN:  [z6pbDJZHokT7KxnJgJKyxAxCb9cPT1oVz5Fx1jHDyKA/vzcOW1R7fw6RSjaFdSDS]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a29848cf-84d0-4444-803f-08d7ee2a8987
X-MS-TrafficTypeDiagnostic: DM6NAM12HT131:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJKyFXVxRvUMt1Ymj9UlIFRCDoTtP/lKzmEzu0Xo73zWkAdECE630qrjV62A5PngmkuGYZohsSkqyvc2QwbNa2LONr+55jtV8Af6E2UIXcKSnUzriArJW+9U8IuMQi3RdT94hoxsHatgpFL5uhLLB23ddWn/G92ogk8XRR6JkLcTRcA+aP0nxRFilAAbdWUF9S4sl3+3JncXc2KvVJQMmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: xmWfqdq70eZRgke4LY7PNWBtOcHXmIi6TM7m0+NphG8pFQrNwbdnx1UxuaVwON7BH60yvHxhS8YhLlwFcycpDUoW5v9VxBj1jI+hB60cBzg1Lz+jz2TQ++FSzbJjPyV38sMenwPpE2EQir/KzeBCOnqexbxabSAiu/DW9HMwpIjnTnqpywwkT2FPqGDW5juB51jXQ06pqg88qdQqJIruCw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29848cf-84d0-4444-803f-08d7ee2a8987
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:16.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to minimize leakage current during sleep, set a config
for sleep GPIOs.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

---
Changes from v1
- Note where sleep GPIOs came from
---
 arch/arm/boot/dts/s5pv210-galaxys.dts | 241 ++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index cf161bbfbacf..9bf4a5b95b74 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -52,12 +52,253 @@
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
+	/* Based on CyanogenMod 3.0.101 kernel */
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

