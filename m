Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE8C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B890521835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEAXvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:45 -0400
Received: from mail-bn8nam12olkn2037.outbound.protection.outlook.com ([40.92.21.37]:23264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728052AbgEAXvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvJaeJwrLk8z51AJvulvjDbt91L/WGY606Ng1XJTyTwS/IVjVQOXiA8Peh39Xz5Ma2YGFGzvxnX2w5saztdLie1jJOorUtHSgqVLqe3KSI5sXJI3VFs9iONiO0rM1KT3sNdfv/Q/UcLz+XnEMISZ6AueuWsMhq8kcSL5sZ+XaZhgd0aqInZflbtzRoH0sUVwyRc497cL+1/XhJDMyNsTdU6ixfgXYNeBp3HR5Q/vrj1L7tp/oTXdEPOiiX0Ig0qOCLwGtTTwvJ7JNbCHYuuVnxf1SKU3/AXshEo7nVTp7204Fo3jGbNeHWLqvs1pyOXX0wAFInSoV3UPABE4bqGKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuSsQLnvaeBAu9mi/LZBYzTGtfgk2GJTsPVrGYGkj6w=;
 b=FdS8qnETMvUyIzGC80/qBqlcgT5wImYcIUenApeqNI4gPf1IycX12mTCNRdqxdZZfbSZf75l9qFG5iRzAb615HWviQVCpslqO9IZeA26wJsayMdmc52/RGQk7vrNeJTc6JBMr4qP0pjjq4e7ZEcRgZemZfuBg/ePkRi8wXkd+Bnv2kcTQwKoBGNX8rtJS9As+BMhbleQ1hwWCd1Af9T7a9475l6uqTODGHU+8eeCtKFDakSjccWtE3g55BTV/Qbn5Xor7jD25arymBU3Mhlcplrt0jUbIXZy3IYsgYY1pko/r7zJbZ5O0PQMOW4C/7TXmR6jbySw6ifTGz4ZHWZppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4b) by
 DM6NAM12HT076.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8481FDDB90DECD21CD77A9C2EAA499E39D3B3606FEAB1E4349DDAAB0D51AF547;UpperCasedChecksum:A2258F2FC251969D3644D15808277C50463222317D88EE0F13FCECBDFEE0B9F8;SizeAsReceived:7863;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:36 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 15/18] ARM: dts: s5pv210: Assign clocks to MMC devices on aries
Date:   Fri,  1 May 2020 16:50:16 -0700
Message-ID: <BN6PR04MB06601888FBEC1B871D908D4BA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-16-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:35 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-16-xc-racer2@live.ca>
X-TMN:  [KG8T1QH8FXDLHXl7GinGPYaCqahgisrCYIDgHW7BB4JWEhJkdvG/axkSUvT5B5mn]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: efd21990-e2d2-487f-7f59-08d7ee2a958d
X-MS-TrafficTypeDiagnostic: DM6NAM12HT076:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7D1UleFS2pYXswAT7WXCuOxOTLbysm2LXcDXNCCETEh51gJZ0qw2zWeeG+C0AmPEtj2L9UvcSjXSby6rTHEF24yOqbZuftqQq8R69SCl0Zr0Fw4ej5KA46ZuA8oVcURV9FwA35dWc84FnLZ3EHP0upGP++qTejToCdeoiLsat2rFdFX83fSKTR6iKwnNWriSr6cQ3I5C2QoLcSI/crXKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: L6XVwuhcl6bgLhlU/UifA3qxZt5NYFKkmou565RBtip+3MaNK7n2mUj0I/6Wjq7MLwNWZwaGdw70GVqwkzd86earH0bPBPhXGvxapGIWaDiFkWjmbloPnl2PyUuvNnDJqWn6UnIPORryjq3CViSInar/6U4n17xmc+Gm3RmBXRa8QKberI91MRgxVefgjmYPxbwvri4GR7zVGdndNu2xNQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd21990-e2d2-487f-7f59-08d7ee2a958d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:36.4858
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

The SHDCI controller on aries devices is a little bit peculiar about
the clocks and with a slightly off clock can run into errors such as

[ 141.533993] mmc2: ADMA error: 0x02000000
[ 141.535137] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 141.540246] mmc2: sdhci: Sys addr: 0x347e4cc4 | Version: 0x00002401
[ 141.545358] mmc2: sdhci: Blk size: 0x00007004 | Blk cnt: 0x0000fffc
[ 141.550470] mmc2: sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
[ 141.555583] mmc2: sdhci: Present: 0x01fa0000 | Host ctl: 0x00000012
[ 141.560696] mmc2: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
[ 141.565809] mmc2: sdhci: Wake-up: 0x00000000 | Clock: 0x0000010f
[ 141.570921] mmc2: sdhci: Timeout: 0x0000000a | Int stat: 0x00000003
[ 141.576034] mmc2: sdhci: Int enab: 0x03ff004b | Sig enab: 0x03ff004b
[ 141.581147] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[ 141.586259] mmc2: sdhci: Caps: 0x05e80080 | Caps_1: 0x00000000
[ 141.591372] mmc2: sdhci: Cmd: 0x0000163a | Max curr: 0x00000000
[ 141.596485] mmc2: sdhci: Resp[0]: 0x00000920 | Resp[1]: 0x00000000
[ 141.601597] mmc2: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
[ 141.606710] mmc2: sdhci: Host ctl2: 0x00000000
[ 141.609831] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x349a3208
[ 141.614942] mmc2: sdhci: ============================================
[ 141.620057] mmc2: sdhci: 349a3200: DMA 0x347e4cc0, LEN 0x0004, Attr=0x23

Specifically assign the mmc sclks to be parented from MPLL with specific
rates that match the vendor kernel.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi  | 8 ++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 9f4694d71203..0bd65401ec65 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -752,6 +752,10 @@
 	non-removable;
 	status = "okay";
 
+	assigned-clocks = <&clocks MOUT_MMC1>, <&clocks SCLK_MMC1>;
+	assigned-clock-rates = <0>, <50000000>;
+	assigned-clock-parents = <&clocks MOUT_MPLL>;
+
 	wlan@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
@@ -768,6 +772,10 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &tf_detect>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	assigned-clocks = <&clocks MOUT_MMC2>, <&clocks SCLK_MMC2>;
+	assigned-clock-rates = <0>, <50000000>;
+	assigned-clock-parents = <&clocks MOUT_MPLL>;
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index a99fdda25262..5d10dd67eacc 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -355,4 +355,8 @@
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	assigned-clocks = <&clocks MOUT_MMC0>, <&clocks SCLK_MMC0>;
+	assigned-clock-rates = <0>, <52000000>;
+	assigned-clock-parents = <&clocks MOUT_MPLL>;
 };
-- 
2.20.1

