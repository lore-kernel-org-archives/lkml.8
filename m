Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34573C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D34520767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W3IoGo37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGJJwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:52:10 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:54030
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgGJJwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcciSGfvbRj9a8O6dQHWM7Qa1/CBdXLyNDA4+k8S7AZ/EACKxxxBxA+xqk76ntENLoNpzk3LsLcd/5SRkOQpMFuJ6Qr1Bx+dPSQOKveIz3KJUxOWmdpkXbn7tzp6dnWSVlATf916HejRjLF7uSD+iJiYSf5amMB5QlA38uN6CYno1aNDk3BLTqiK/fso0xnqRy+StxpCqDVciI/FBLzs2lGQA74p62ggrFbYZaRjAimDTXL1UIqa9Bm6CVnXrRUifdkLcJSyb128PONL+RFgIiTTGlQmXcDcZVXrTYh/I2KwmLbMXI1sU8wXLS3XnQ+vnP53XV09DIRZoX8FA0XmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj1p96EV+bN+Q7ds+bpmiVZu2zjFogs0q0tQ1bFVtQ8=;
 b=bcBKgdrp6U9AvGHJh7kqDrEN+JS1ccfpaw6AMVkft5h/YbXwJrZAaYkGywMfwKQwkSFJ3zUiFdZDY73K+4Vd8P5PWhsjeZEnwfQQVmYQFqB+v8VY/GA58ofZjv2heiC7d3A2pdY+WTGIpAqH4+EzEvttNOX9Tj1CsrMiLFKDU4Qylt5b/D/fRiBAzN5zcR7TW3zlv2+uByO6iWg173CDEVjhcznMC6k0AQ+yAjrqomNyuJ8O2VE528ArtXvDdpvwv7GUmXBi+VLoRol7oOu7/unrzm+lyvJ/SSRI75PSLWa4Q2U9SmdvgU85/WwqicA5D92/TWKfZp9UE9/hSwNVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj1p96EV+bN+Q7ds+bpmiVZu2zjFogs0q0tQ1bFVtQ8=;
 b=W3IoGo37JcwmngSmOtKKhIq3Sq27tuhc3ZqidGEhTCBvmwkZVE6W21CbkSvY/cggxl7BiooFReOhSdWrzErdkdCzFdVvP70Pax8clNGJu9ExpuvGZsm5h+nxTsqYJdODoWWjz7t2K6esLSqB+hjBoX9wCAtBFYlVgqApoB8tthY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB3200.eurprd04.prod.outlook.com (2603:10a6:802:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 09:52:06 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::81c4:97a6:7592:f225]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::81c4:97a6:7592:f225%7]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 09:52:06 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, zhiqiang.hou@nxp.com,
        V.sethi@nxp.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH] arm64: dts: lx2160a: Increase configuration space size
Date:   Fri, 10 Jul 2020 15:21:44 +0530
Message-Id: <1594374704-11323-1-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0055.apcprd02.prod.outlook.com (2603:1096:4:54::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 09:52:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52ed5485-8170-4c73-3043-08d824b6e759
X-MS-TrafficTypeDiagnostic: VI1PR04MB3200:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3200ECE010F26956E4245180D1650@VI1PR04MB3200.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bM4A5LKGWAoqP2JwnbRh5CS6Ok5J6t+bwVoKy9qwLYR/RloddnT5Aouyad5hqNFALeuTyHGKniZnuK8lGYOeaJIY/uEQi9Y12UR8C4sYMlUq/gT9mbJm5pC01FoXJPzkfnmiqyhIjlqulTP3+smjIOWJYsfT+7V2bxuDtZLFgwXheO06EPL8pLGVFEBaAVVZNZmvVyp9x35ro9wowBlqCguqcziHjL5cmL4MRfTnUPlcwT0rXeVIEF+tEVu4UyRFKzW3kDcTAMqupiQvm1MEVdd3xAtuzQc2T5GMoAVET4pyhwwpNTvGoWmxXfWYpQBf5X2NADNgTw4xC97gaJUDu/OaN+JHMEJKAwZz3aY9j/h7Qd8Dz5mcqznsHfYV+hH/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(44832011)(52116002)(16526019)(2616005)(4326008)(5660300002)(83380400001)(956004)(186003)(66556008)(26005)(6512007)(478600001)(2906002)(66946007)(66476007)(6506007)(316002)(8676002)(6486002)(6666004)(55236004)(86362001)(8936002)(1006002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cYjU8NXraVn6oQZ/reWpkRHv/0r/H1aNA5gx74w5nhRzjVAUfZamts1lFtlnqt+7OKYWqf8bsRBW2TnEHARpjTZ1vhvlGbczxPdc+XinrPto2Pi3XEpdzTEmtwvV0Xs/6/EzLyZPIGYHKHFlE6g/VKSTYa63pM9QVDwlPhN1+ipElNwtDibl0FqDXsF8NEYoHV6dFZLbhMZw0YvGt8c7OCAUmeXB4nAuLaMo468WLRLeyl5hG6SABUP0jMx8xfSnYODxB3d0knTLSJV/mXBXNSDe6bH2qD9PVci7kMccGGKSdd0Cw1C6RsR+2zRicg/clIzIg1rv+nIFPd0qi1DE815ac2CVETrofA8SldtP+FNwCIjzAchsfcyTc9sVhUeBgPDvC/FuMdyQMFKBI/6R6NhAiCJh5v26t9fH++4m3duP1PfeUnrV4UyedkBR9qiRJO3+UmliC5KklPS0cyZxYv38AfzxK9PDUoK58wEulh5+xHo3KEhlI45pZIluZcWi
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ed5485-8170-4c73-3043-08d824b6e759
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 09:52:05.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozo9FuwfEQsCGdlySAIw2V7a7V1Nj/Pxf8CAj3yXLJG/IxbGFCL+NFkjsmKP4u3zYfx0J+TRQ1Hjj7X2CLk+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

lx2160a rev2 requires 4KB space for type0 and 4KB
space for type1 iATU window. Increase configuration
space size to 8KB to have sufficient space for type0
and type1 window.

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
Reviewed-by: Li Yang <leoyang.li@nxp.com>
Acked-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index abaeb58..037c4b9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -2,7 +2,7 @@
 //
 // Device Tree Include file for Layerscape-LX2160A family SoC.
 //
-// Copyright 2018 NXP
+// Copyright 2018-2020 NXP
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -957,7 +957,7 @@
 		pcie@3400000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
-			       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
@@ -985,7 +985,7 @@
 		pcie@3500000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
-			       0x88 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
@@ -1013,7 +1013,7 @@
 		pcie@3600000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
-			       0x90 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
@@ -1041,7 +1041,7 @@
 		pcie@3700000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
-			       0x98 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
@@ -1069,7 +1069,7 @@
 		pcie@3800000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
-			       0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
@@ -1097,7 +1097,7 @@
 		pcie@3900000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
-			       0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
+			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "csr_axi_slave", "config_axi_slave";
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-- 
2.7.4

