Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3293520739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgFMSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:45:16 -0400
Received: from mail-oln040092004023.outbound.protection.outlook.com ([40.92.4.23]:25859
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbgFMSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:45:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiCRU9zKcjrUrFyp4V4t5PQMV9curJjpB1DmSOtn/7GoBikTYAylHIbItjHqt9nGZ4GiuNSRM84c7hF4sNh7+MdLp5e698IgMr0VDaSl3vZOEq21iTzUvonncdEUQJ7v7pghLZH3vaUKyx/ggS0tGqgpsZCBfvMg8S9pLIWwGnp7CAtaoPsSBhKi1dZarcZ231UGqqWSpI1msaIuiKLy+N5bFflN5Lvr2HkJ0INHb0TNuslNF9YeKlb1SBvR+cLf+rXVdnS7dyfLNB3ZmU1j4RWkOLk9DmC7y8COAIItpZGVBZTELveWEUYYlf8wjKYjzes0A03+sJqiqZPt9sdcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvjGMlP0p4ydQzKylxk3TSXScYB3wHDWTcJTtH6GffU=;
 b=RECe3uodgeTQiYXq0nFY3fdemKQ+zNgNyUL8NDjt+WnAoGFYDeMFddgI/AWgHVDWaJgd3mBCGeLAyxhliz5MNpg/bdAaFmI8tuE8ibMRV9ZWXM+9g2+Eu4X5Lhn3A++t7qqLE+4BvZ+ycM24+q/7XlBJUiyCt++9jiH63S6OettatwTZwxabL/IoXp/ehlEn0t1m2/hIodj1vdf+10o5ZcnLHeWYH3WK4CsE2s62DcKh0ti97xZrZ2vXHOXAamgQ+ieC8oEkFpdW3LkA16zaK7LxPLBI477JoFRspFfCyKJLYFj7kNIbrqfVbUk7FFnUXCE2iwva4fGE/LThXb0jDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (10.152.76.53) by BL2NAM02HT181.eop-nam02.prod.protection.outlook.com
 (10.152.77.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sat, 13 Jun
 2020 18:45:09 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::4a) by BL2NAM02FT048.mail.protection.outlook.com
 (2a01:111:e400:7e46::109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sat, 13 Jun 2020 18:45:09 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F1B6EFC42A91AA4AB3BF9AA783FEDF4AE4AB6C6168DA52F2C1DC481C15A5934F;UpperCasedChecksum:2490ADD929B36AFAEEFAD3D87D3A147F39496B506C089934DBD0E6E962EBC957;SizeAsReceived:7764;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 18:45:09 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/5] ARM: dts: s5pv210: Correct fuelgauge definition on Aries
Date:   Sat, 13 Jun 2020 11:44:24 -0700
Message-ID: <BN6PR04MB0660BD4F8BFFFA5431D6BCC5A39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613184427.23394-1-xc-racer2@live.ca>
References: <20200613184427.23394-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:300:116::32) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200613184427.23394-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 18:45:08 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200613184427.23394-3-xc-racer2@live.ca>
X-TMN:  [qTdsrgnN2aNsunrb55IcN7Q9u5SDxbjyNcrIoJHaKcZv9lJtJhnBr6tT41fcc4jT]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 475b9800-023d-4968-2ac3-08d80fc9e5b8
X-MS-TrafficTypeDiagnostic: BL2NAM02HT181:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8heqOmyiFa4pPhKMVr2cTedQWrDNQJ3CT/aY16kdV7ZPFu7UMMs2s5TY2rmE1tjLP4kGPcvPpXIln7hJN1kx5aItjLWvNN6zks25B1kOgCu09JTGmUn3RFosthf7PNfjPIZ8i8tu7gffeQ8z4vG/VMivPkiTCV+Ltzi3YpDvq8zgUEM0D/LiIBTaALliB/yXvBQzVmoK7Egjplp5eqb0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: IzJ2ByTPHPqrUqCgRu8ByG4X7zdhURA/s34RebJcAc+YqfOqkpmkehG65TBQxRZTlMqNt19dbhAOzbRiaB8JO4hGa2i6ATkjway9l2PULjKjXaZy6Lcg8SnedpPHMCL1yd/YKQ6ww0vQbRV8nUB7PMvySw7udrH9D7DpUQqmomur7sLxSabyA2JPs82CbKQVXMfiCEHxhCkcf4uD8IVA3g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b9800-023d-4968-2ac3-08d80fc9e5b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 18:45:09.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the fuelgauge definition because only the fuelgauge on
fascinate4g has interrupt support (and even then it was wrong).

Also, assign the GPIO pinctrl so the interrupt is properly configured

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi      |  4 +---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index cf858029292e..d3aeafc0f650 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -425,10 +425,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&fg_i2c_pins>;
 
-		fuelgauge@36 {
+		fg: fuelgauge@36 {
 			compatible = "maxim,max17040";
-			interrupt-parent = <&vic0>;
-			interrupts = <7>;
 			reg = <0x36>;
 		};
 	};
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index 5e1b81823a8d..65eed01cfced 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -37,10 +37,27 @@
 	};
 };
 
+&fg {
+	compatible = "maxim,max77836-battery";
+
+	interrupt-parent = <&gph3>;
+	interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&fg_irq>;
+};
+
 &pinctrl0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
+	fg_irq: fg-irq {
+		samsung,pins = "gph3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	/* Based on vendor kernel v2.6.35.7 */
 	sleep_cfg: sleep-cfg {
 		PIN_SLP(gpa0-0, PREV, NONE);
-- 
2.20.1

