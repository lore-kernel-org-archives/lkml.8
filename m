Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA541C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B77620720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jc+tHc/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGIQsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:48:45 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:6257
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727926AbgGIQsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYo7+QhZgQ1ygs2UQZE9uPksorVV6KiolfRIS/shmwe7fXqY6GUTsfynWuUO5G+7h/ACqs2DkUxYVxCw+eUH8iEesGAmkkflzgxbQ4SA0pRduUgXgf3BONuC+KldiZaUplnpEPFsqwltcXeCRDLdwkyehA3J9ToT8g2HRvA6xB19CmyJr5Jp3aqBzi/HJgIAOo9oZaOn+NghdGnVTAq4gq7mFLqJ+Hx0wzB8JSAhHu4M/14uBenI010aBql6Xm8RhiDEEhNUHyefWqAEZO2r1TPfU/seasip/uRDgh36KXBoG5S6YA/e6zTrhPg3i9SZrjeX9A4+Z+jBMz7QEmPDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T36PisOq0j8rKIYiCn8vy4JAzon6KegVFoJ4p5bdGQ=;
 b=kDc6u/BUBcz/KdkBQNx6UCYwJB0bWIioXHzGRJsW3v7UdWJSkUMu0SWU8ckZNiI9SvT4vPEC5XZ7VdCJN6QUAWmz5bGUquJRkHKAoQLG9pbPd0EELo+ADT6tOoI95C3r6Vaao8//GA0VkjeGLxsDAC2fXdO5s38goODmgPsLcIrqYmHXXakvmjTXEZTJtsQ5Osvn3jN+x2/D3xLHeucmquSEjM0Btu3/CXrJtaqylvYNBd5j8e1WCa0YOzonf7jlVcUxgT4mxand6qv2+BkDjaJSwa0CnprZmgoVQyu0G5ewrnQ3dwCW0s5ubFoqox2aif2utqiGXowpE2JcpJd4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T36PisOq0j8rKIYiCn8vy4JAzon6KegVFoJ4p5bdGQ=;
 b=jc+tHc/F82AF1A3x2yDSBNMezjvhrbm8FgPPUIbuRKK9rStVYvNZjLcZRkTzGhe95fOakv8/rmV2EspdTklKBIg6AqAqufuHrqYyTm4OzQR/dkSr7gy55zuNbD9dhFxGf8MKnvAO+ybbMWLN8XadNonsf6ew72Yupm4gjViRc0c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6239.eurprd04.prod.outlook.com
 (2603:10a6:803:fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 16:47:59 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7%5]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 16:47:59 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        laurentiu.palcu@oss.nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/5] arm64: dts: imx8mq: add DCSS node
Date:   Thu,  9 Jul 2020 19:47:33 +0300
Message-Id: <20200709164736.18291-6-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709164736.18291-1-laurentiu.palcu@oss.nxp.com>
References: <20200709164736.18291-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18)
 To VI1PR0402MB3902.eurprd04.prod.outlook.com (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 16:47:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b46d3b7-e09c-4ea1-70bc-08d82427d683
X-MS-TrafficTypeDiagnostic: VI1PR04MB6239:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB62398D468F04D022A1247C04BE640@VI1PR04MB6239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2MmOmgNRzA04lrPQzjmulkCm+94pQpiNu2bcwpwXcSbStuFiXSPbKr+WYAchzCjhbAGZSLvg0xaz5Al8lvAcHHGVQY8J9DhqZ/2F8jRTe6+XQQDgmqNCZkMJa9NkDp2oK31Rly2AhoVkuRkqzYqLJYKSz4eMGdRdKWNn3fE/P0GkSye88hUTE0/8SkTwMOGsaj02EyMevOKGvJFNTswbjhcODCMcPkXAfgJqmwoakxC/lIJafp0vN4ZzJNHOJI6BkNvj/TWV1tTuwPpKcFmiNkVonJd7doxqchnMfmEIWqWQiFRZJvST2BHIIZdgqvslSCixkAw1Lh63psraCMHZLsGrqc3K65RKI1qOw4fTaYWxtTyiso3UiVA19zDPp2D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(8936002)(66556008)(66476007)(186003)(16526019)(6666004)(52116002)(1076003)(86362001)(6486002)(6506007)(66946007)(4326008)(5660300002)(2616005)(26005)(956004)(7416002)(2906002)(83380400001)(110136005)(478600001)(316002)(44832011)(8676002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Y49MmX8S0dY+CjQIh6s76lu137XTX8ivkZVgHUW2LS2PxjdF1JOn02BmYTQemn4cKnKukIkFg0NapyvsuzLSAl2tCWLWbKyv32VR/SBEx69uUQ7mhv1PXCopTkfTovdurMkDgT9JTxtVzMNYTRbcFGagbP+0/O85YzgZutvYpuv7Ot3iuixV7awqz0Z4BJtLojQZw3B++4fUN7DaKqiZ0gTJD3mXv4QJdgZSdDCk+ZlJXa9RuDPUgEOLtPXXb7qSWpEq5HsGtn6XuyxK3v52nCOqwxSdGXsIUzxiLG4jLm6BMOJSHUS5zZTrBeuWLpr4hsRGo/4x+AkvsaVBojqrLTKB71xAA2eFouNpyq0YO6eEhTXDyIY+aVvTO3FQbzI1kaYGYxFv9ZVoHmV8O05k4plJGk56TTJ0gy7zmbhhf9TIp5piplRJOyVbt1BRopQAnG07eoskSRaY6kMA5bKZ/WISvHdg6vnLKMCTFrtGVX8=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b46d3b7-e09c-4ea1-70bc-08d82427d683
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 16:47:59.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW0zp8z1pGlzaGFJqsYwrFmdqAiQMxj9JRWxuJdxeIRWDlRMZBVg/SxT/tf1dU9j1bd1y2wcXEUHQKZ4TTKtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

This patch adds the node for iMX8MQ Display Controller Subsystem.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 978f8122c0d2..022720cdf6ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1040,6 +1040,29 @@
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			dcss: display-controller@32e00000 {
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctxld", "ctxld_kick", "vblank";
+				interrupt-parent = <&irqsteer>;
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+						       <400000000>;
+				status = "disabled";
+			};
+
 			irqsteer: interrupt-controller@32e2d000 {
 				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32e2d000 0x1000>;
-- 
2.23.0

