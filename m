Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C818C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BE920700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDZSgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:50 -0400
Received: from mail-co1nam11olkn2108.outbound.protection.outlook.com ([40.92.18.108]:42912
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgDZSgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joYUXd6aoWRF9X2sY+WVSqSFIjVz7DtwOYkhXdMVzJvzSnUjXCFyWktbI8TMqsi1gqmWafLscFYPv2RnfmYmM9Rv2XzQ9/JYGxstitqSWNld33m8AVwJbbJiROeHL9I3xakuJOyRQ/97EugyWtyTiiagfjIBMQ4NVedMGBqzSRRAxiCM5SwWHA01l7uNQN6k8al0d6A/H8aYUNaW4tYCfXxxXAuC26w30v4ngLdqSNZmOl/Kj/VPI6wXjtXbJLDjOz33l5K9ThcrIVrhmts3KS94MG7t9fDNys7Ga/fx+SA4SpM+csP+6WmNfKj1EBcFJOd+kQU6s1CjoGWCUG/8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viZyGxXbl8jlBbHWJF/ycbjLcFnah0lFxRD1Cje0RvM=;
 b=RN21tglBOtX8X5oxfI/Rd2r2mUWV04BEyg2ikYaslrgm1d1Kv3GF30k2xXHT6dMVPiM/jJIM6v5B5PqITfP0Oufjyi3GgII5qq9AGXPtY6o0eMiHEJlVcpN7BvuS4+MaMwZSWmLjxYkgNZomrUN4/JpXnDTrl8VGdo3CS1g2rRbs73AmPyoufTSd/3Bntj5EyCklkg3U87FBW261YQ8V30n9VPrc8St7PG4HHS3WTCRMIFL9nuMBQ9bohzEPXopSHddahZ/PVGzLmYuBwpjL301mVbvo/ncbClx/vCgNOB+Ds+/vwcN9DIDpTJ2V4JNidlttGup3TreiTff5FWDvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::53) by
 CO1NAM11HT028.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::249)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:45 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:45 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:EAD9E85ECF52A01CA1168448B3DC5CBA9C9CEF07F8F91BAC7D4DB2D52625D3E3;UpperCasedChecksum:5F1B2796082AC0FDD721EF5CD12086A1D684C9E7DF9D1F038F556F80F961A203;SizeAsReceived:7820;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:45 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 11/13] arm: dts: s5pv210: Assign clocks to MMC devices
Date:   Sun, 26 Apr 2020 11:36:02 -0700
Message-ID: <BN6PR04MB06608CA5113D4034849C94A4A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-12-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:44 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-12-xc-racer2@live.ca>
X-TMN:  [lBC470yQhS2GdzrQToJXbH+QTT+ZyS8kYmBMAJ5GcdsMrQeP5pl/zuXK9uqHaw/B]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e6fc1cd4-b153-4313-0eec-08d7ea10c5ac
X-MS-TrafficTypeDiagnostic: CO1NAM11HT028:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIsqcpWDpXzOQJ+Fzeh0fyRJCYxdKw6BSNlzLVR0zAO/BorwXYTsmS9O7w/FYHAKy8dnd6o2KDK2uUCqwpIBE5DzMmOy89PdDw64gICuHVzXn1k3P5Lwec0Yvxj5aF1+Dxq7aHVANzULQwiyeV5Kbsh42ZPZ7AKMbAhnxHT9CLg9ISrqYDMV+Dhou1/KUMO6atfBK6kCsQN4yKQ1ap7L8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: us2Mo2r/EGC8/Q2MCYHeGTVAKD3OX9NsLOTa4e5vwCaWFvELexa503Yq+eVEui3vu33uObDn0VMUAmJhvcvl9WmMefWXsdGtOge1NFV80PqMe3Y2McgyBNOFH9Mwo22VA1CN93TNkWzQVu4NockVWAeiUz32B+zDxOLsiT82aKI8Y45mF7cmsTlDyz+bywjEH5k6T4Zq6qat/LF3lj8Eaw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fc1cd4-b153-4313-0eec-08d7ea10c5ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:45.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT028
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
index a103ddb0d720..7e113d750b97 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -734,6 +734,10 @@
 	non-removable;
 	status = "okay";
 
+	assigned-clocks = <&clocks MOUT_MMC1>, <&clocks SCLK_MMC1>;
+	assigned-clock-rates = <0>, <50000000>;
+	assigned-clock-parents = <&clocks MOUT_MPLL>;
+
 	wlan@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
@@ -750,6 +754,10 @@
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
index f5c13eb8ae71..6958fe040106 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -354,4 +354,8 @@
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

