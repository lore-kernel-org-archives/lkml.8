Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620002166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bth+Smwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgIIQq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:46:27 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:20520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730854AbgIIQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqFYzdSj8Qrw84dBOWXu9UqPydbuVLBliKNoLNcy2P0txyS7CqQhSO69uj3+AvK2ca4IbayNj9rv3g+b4U4Rp19FHCfJgOOFx7bazHf3OH5+Xpwfj5x0nUJe4cZiv0f68JU2cNJOVAgx5E7zGoMGjgOCs7W39EScpIWKrlkjg/jh/xMIQvzRTsEUIiDbBkGhiqaQ0JGXwj0bsfg3eCdo8bZfoJCaaqK6teoHqKMlrhFojqW/FzndCB6xECmGl/DxZSzApMc5KCgqEv14kdyiiZdyO8bFoAwT9x2mw/VzvGCWkUgQRSW/VRNsRsmanUzkeHV4xzf6IUZcJeUcfIiCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcxFN4oeON1YsgquLNgKALNnxmet68CBuPz9ddGyWCg=;
 b=Vrf6uZEW3FFDu2L7MRhTktaIv2+Rk8uvfWEv6iLpSdWP66GZIrztfjleIdaKJUoz79qd4ATGUBQIQVvg8334jPuY/oTSCXkYpm3oFs3U4xvzoRDf2/jZErL5X8iBv9c/FinmFp6xQa77Cxtkr23chPijqQGBeYuht77MXq2qeY6+c/ONmblHr7a78XqXojlvPE3ApoH48wBe/K66QJIPHpgX3gXsC81+kWp8Tlteqm4eTPbQSyCHxdJNWp/QPJpMLq5OSs25Jm0s9qQ5f9a7V0TXNuccYzKQLIdWujJoxTi7tReBc/Bi9f2v/PNj4/QT0G3aBIxYswXoQrXJ307zIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcxFN4oeON1YsgquLNgKALNnxmet68CBuPz9ddGyWCg=;
 b=Bth+Smwynou/e5OsirBmh5bK6Hloh47qNYzSa0cvyO0YJlwoAHEYgbRTsjkYsrVfZYxhkvhHN2NJ+uYSQgbgQxxOKvGUyWQbmU9G5IYtYV1ei8cFBE1HkYUrNDgO1RWOHQIlZBhz41nnStn7t6B2sJR3RmsbqQkR0bD/zrhlqeI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:02 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:02 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 2/6] arm64: dts: ls1012a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:32 +0530
Message-Id: <1599659076-28121-3-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:45:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22ab4025-bf79-4828-352d-08d854c68d56
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3710C0EAB4CAD8C3064CA620D1260@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtPexlNRtc7yh/bF9whGQeSfKuly4YiXdzt9rei8CT+9c6zAv5ow3VhofWHC86TVRgk0k1BzeKsgCASKyZ9/Nm4pQT3LGBJvTCdukqMS0Hqs+jpRtqGT0aH5myI+7LC3HBYYZrWhdKnXbQ9zW7TcWJDOcQJslnh9cKi5Neg2GTcBBZhFONvzex2JoeUarIY7ONnjXHz2n4QePxa44OiH/iSklIVMwAQyF7dsV9bTzY9zlv5x2jLYYCLV74p2SMaZtBttETV0JlKYPWqgBAFlGtnKEHw5XcirNduj8iRX2Jk4YDZhavyqeNtdgXf00Lnv/m6N0FL9if8PT2GO+6tE/knewraE806xvruiP6UbLLn3yn3ADVFrixZW4ryZJ655
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8936002)(5660300002)(1006002)(2616005)(16526019)(186003)(8676002)(316002)(956004)(6486002)(44832011)(83380400001)(478600001)(66946007)(6506007)(6666004)(55236004)(52116002)(2906002)(66476007)(66556008)(4326008)(6512007)(26005)(86362001)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 767uMNuyttYB1MnjzecEjpWIthzr3LMe6rYFf3yAD8IxIlgTARp1A7z75GJSJacO512+CWGmy8D3fDHl7d5K+SVYeGQOrM5NSuCtxNpUkeQ8TzDMGHMQTCGh/PzApBvzR30JFYrCG5JKjgl2UzOKnMtVXN1/vrPVtakH/0CiV6IB+rW1C1P53JB3gECbXOL3VxfALU5oLMFlTxIkPYRTE3ZiwtmvrCezLT475HTOZaAp2lnPYk51tkvaOPqtP6JTfZzdAka60QlzrLwcmESif/aRfoeIGApc3pUp0ewK6BJDYrK/p95NMOfVCO2oLuoy3nhwTn1hALjwN5FeKXo3jcAY7AXlLwGP9ufPhDUz2VQU88/hxj9R3sFuUlPM2rtnv5OWWyx3BUwztKohc6wKI6Hn3c6SCsAkcGiVlCHVXm3LUUhTaIJ1e0x1uKlDY0cRZYNVyydEZIPN/wY6Nr5z/UPTWqYw1/J8po09cikwCx58uGGwkQlynBAiiZ2lZjP1OjFJbKcI2cW7Qn8VoXsuVlLAsDQ8lWq1r/hhD3cwPuQEcq0jZMMkiUOpDvCDWPPqhYQBdlxlmSjcQTd9kGlURq93NryUZxDVk8l9EVQAR3Bgfy4np9uPO7hddYUJubidHz/uQwJZ/mapPJAZPm9DXw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ab4025-bf79-4828-352d-08d854c68d56
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:02.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrEQ9/sb1lF4EI7mRpSyICNykBaX1nwVhekSAuM36ITEMmlvQjblKWHOAsIU2WTNlg7YrSgUrisiYfH/9ePbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
index 9927b09..242f4b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
@@ -87,7 +87,7 @@
 	status = "okay";
 };
 
-&pcie {
+&pcie1 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index ff19ec4..6a2c091 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree Include file for Freescale Layerscape-1012A family SoC.
+ * Device Tree Include file for NXP Layerscape-1012A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  *
  */
 
@@ -489,7 +490,7 @@
 			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pcie: pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1012a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

