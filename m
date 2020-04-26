Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED5C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF6C20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDZShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:37:10 -0400
Received: from mail-co1nam11olkn2103.outbound.protection.outlook.com ([40.92.18.103]:10179
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgDZSgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXFxn/GC6iCA597b9HQGWV/5rTZ0OJo4QhhVa2GNKFzjIzts1ltVoqXWtBDr2BFKozn6h3ijAZdjugq8OEarHvLt7YDBxzIs1PtaBUSOvLEUfPRhXNyNNferANYb5WfPi0j5rSxobTx6JMDDBcd7oqU5vW/LBQGcfYPKqwtfiKAhceIoWzS5DCFh2dNQC/L38T0nEFR6qsZGbAMH/PVvndCi/76VTu/TEix5TryHv7PP62DlYnAO+zZWpwsHo2Uhk7E/dN8MtDty81CxVkcPx1Kv0XUdaXCe7XZKxhWmid1heVLZ+4tAFvcF6hpJQ8OyPsrpna4AJam0xntKVqc6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6zvREwrSfcQ2mTsahshIeEGoLaFDehzGGiKa1r+zvY=;
 b=Qrmq1WN9LbG41Fm2Xm93BGbF/Yz+FkZQUZT8PCaKvkFJmpM5h6FyiJo0yX3icbYQ8FWLACU6GLwO2CB8InxeqE9nLao1+RYOECAj1uXLdFYNS5r3TSPYJB9cxbVuZU303lXPCQY5vy+386ot/wkFyBlJje0liD/bwByb4xUHTnHEWh2Jyjv12vESlRZIjJDwM/HcEQ0cOVa+LYq/tfb9X2tuxy0KaoYQzZ3RcDv1YIemsAyGPM29K+hPDPsKglHuFX9qnm9LIWrYMxT8NM5B1170CfqN831tkT2V4s5zltbhLqR2HpYOdkRuvvHOeBc8atg1yg7BqVlXE/Wv/KdRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::53) by
 CO1NAM11HT028.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::249)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:42 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:42 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C30222A728FCB00F506623A3DA3398881AD914B8E41EB9698F63970A0F4CB6C9;UpperCasedChecksum:F5B3EDDC3FDB3E8DCAB7D9F326048977CF029D0D3A93BD84B6DED6389AD0976E;SizeAsReceived:7807;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:42 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 09/13] arm: dts: s5pv210: Add an ADC node
Date:   Sun, 26 Apr 2020 11:36:00 -0700
Message-ID: <BN6PR04MB0660AAB00F5D36E2FEE22DE8A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-10-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:41 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-10-xc-racer2@live.ca>
X-TMN:  [VRDXn4FcQRU24MAOdrQJp/j/s3d34NttbYCH/Lx7mvI4i8d6RGpOMObhLvhjDZMK]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 65775caf-f194-4dba-c60d-08d7ea10c3b0
X-MS-TrafficTypeDiagnostic: CO1NAM11HT028:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8R/x7pWGVeNW9b5eTTPvbgtbMgTEqe67OBOuTYKvAXEMStsCP1yJwttKeKqgysfe0OxhsM+mbZeF7/4mrNy6ceW24170Mn1o4xKE5U62PsYcaxj5umq/l0Wzgw1p2TRQJ7nlhWmxXEsgPrfj4iHIRNpRP0FRzo2MAgU/7hc91cWevr0+ntVmibRpuqXh73wqV7O4j/xWKznC8F0CyvNQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Zwj/PmcbmHDRG1oQdW9itFAQ9lB0vrSko8q/VxQ/HuXCUC4um487dCISTFkDClb+1puuqGH4iabC3/acpXukJhrsMoXXrGRajrPgWXjMhTtPoT2Sjr1MNLMqxWTOG0tkDuWvurlMQoZ5a8Ue+vVv6Qyn26+ovILtn+2HFYnopVANHNR3cin8H4eEGBANC4HWXjL8lVZ0pbjbiKTgQJR+zg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65775caf-f194-4dba-c60d-08d7ea10c3b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:42.5760
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

The exynos-adc driver now supports the S5PV210, so add the DT
node so that devices can use it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 2ad642f51fd9..b3b6ad2889f9 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -159,6 +159,18 @@
 			};
 		};
 
+		adc: adc@126c0000 {
+			compatible = "samsung,s5pv210-adc";
+			reg = <0xe1700000 0x1000>;
+			interrupt-parent = <&vic2>;
+			interrupts = <23>, <24>;
+			clocks = <&clocks CLK_TSADC>;
+			clock-names = "adc";
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
+
 		spi0: spi@e1300000 {
 			compatible = "samsung,s5pv210-spi";
 			reg = <0xe1300000 0x1000>;
-- 
2.20.1

