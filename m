Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE951C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858E322B4D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XtBPFpbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGQOnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:43:03 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27969
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgGQOm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8jIv4Ln/VYBHppYWP7qVrPv1zqsyb3Q775IJSPiUbWfaf8OR/3cYK40MpWevutiWSfUqUkZoDY7YaPHe7mv8x/110a3gtWtN+MGa4HmVDMIQffe/jYJEDychi7okxc1rWP0TeIgFAdgjDsROOmKmPIlTdhiYhB0SQK+AVg9StPRNv0dEjfSePWxoi3Ip1w7Wxa7r+qtB2yo76SF0fiJyie+KCq87FILsG9G/jphf4sak/28d7IRijv+aBKhgpS7N5Pow9Yz/X0IOuGCBxdqYva6816dBz56c5EF6MFnfjhMXFoVpYRBQo43fjkH9mMFLPwVnP7GGpHiZPZN5sSe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQidYtEHaaVmN58ty0BpN5J9mbFff7t8em3qmaLa2DU=;
 b=Hh2TzWk/fPxfBNFmBYPPc4XAV737P6QosxkLU+47CDrFI4yIL8lXRhm+mokG6k/SRX1+J+xZIUXKZeRkt4WgOZkt9lf+q3SXhulZnCAxaisFCUQhPW2eYSovZ+iybWeQMF76MFszRG0ZYWtn4PXBCvl/OioH2itN6sOUDlloAGLpC9BV5liX+hCTcE/EI+q+vmqNGQEHgPd1zssaDWS4yHPF93iN6R7hnLmBV3u8mjFqHNwfxjbs1a5/hZ2RW7rsQvVADXqLm/jOtLqP+CKocbd6nKEjK/NXNlZniYqDpPkjXFdIo7MRv2iFWZmtO0Nc0N4M81IlCpmRKZKrrsEnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQidYtEHaaVmN58ty0BpN5J9mbFff7t8em3qmaLa2DU=;
 b=XtBPFpbYJPzp3446Xuk/YZ79i6LBcnCZDRfkrAuV4ZYPUZGDB8shIFmuCbe07FwizE8zZXpSPybw4QDznlcfiwx4V30XEbGnUSmtpPU66muqLOLLMeXHGJLIJOwZiNSqIfbWgmxNnR8nFJFQbC4b7zXbuJAOPgRUjiUviyz3YNE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6959.eurprd04.prod.outlook.com
 (2603:10a6:803:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 14:42:32 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7%5]) with mapi id 15.20.3174.029; Fri, 17 Jul 2020
 14:42:32 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     lukas@mntmn.com, agx@sigxcpu.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, laurentiu.palcu@oss.nxp.com,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/4] dt-bindings: display: imx: add bindings for DCSS
Date:   Fri, 17 Jul 2020 17:41:29 +0300
Message-Id: <20200717144132.2206-5-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To VI1PR0402MB3902.eurprd04.prod.outlook.com (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Fri, 17 Jul 2020 14:42:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 906cce2c-32a9-47e5-cbe8-08d82a5fa32b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6959:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6959FC3656E4ED3C4555D4EDBE7C0@VI1PR04MB6959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6i97HYo4UtKvBzjQW/uCRmU22A3qZ0/O2K6lbsLbvinmGHfNC/8+gvGAZ43wbfhpDoJi5pGboIkyzkUBh+GK6rl+FvGJyraDtK9LD2BXcaimiKGntFtCVGI4FvJVcOfKvBECI1ZMfOHgZVz7LjGraSZuZXkL1icaGAg//ABsA+eb4WbWKj5Fz3bQLWUa+dO/Zkk7+Eg4Hd25KfuS+BvfKTmXQ27iz93cnDY7vIhrXdp204B5lj1UYVBg/B9ZgzHoA2V9C14jXz8iFAUm1GQHs2fMyTmdUEz5kRdMB7gh8OY3wqnxuNQYEPvbl60NMK9LhVVuOTZ11Pc7zUbfU8+kY/+UZqcVjZMZTuv0xcV6L+IimaEw6+AJhLhlH8YUmTApzUG2vfjjkwZYyWsUYV4aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(110136005)(186003)(44832011)(16526019)(1076003)(8936002)(2906002)(6506007)(86362001)(26005)(6486002)(2616005)(5660300002)(66946007)(478600001)(66476007)(7416002)(66556008)(6512007)(4326008)(316002)(83380400001)(956004)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W9q6XRZt6cL7CRNbofIjAFOFKYbIagljU9PQ9JU34C+UwuH3o1QYO80FXEj2GbRh4/PhLCynBW160r6IBAM4PDCnUgBH1e071nkZwee+/MSUOws5sepHdkEKbEY9I2oqOHs2G8z+2vSYa2y1PMOt3JWYirezCSvRWu0uNm3n7Gydq6BWkJMhhHeYk0lU/8V6UHK5pLeaWNpU+n4VzWbRhFepFSW61+LyiZB3Py0HtV2EZ5VmD8N6InOIDmWjCj3OjsHbItcY1ZXJ+UcVx/rp3WGaZ1a9ivhFgLFMH783aaJoYiK73kgBFdG13FQ6dU3R+5R1PdTUEz/D01V1KgzjPv2FUlnLaLOhUQQtlaxn3toC0zGsAom8rOB1OoMdNUYWXbvm1435RTvgF+xc6nkeaTdSO02wcuthskdUh40/9FRu3q/pCcOArSjq6xnY/u8J2jvp9SlvdB8n11FlZnT9EIDxEXTExr0uoZgr2TwaVs0=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906cce2c-32a9-47e5-cbe8-08d82a5fa32b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:42:32.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0BRO3zr/JDFLQLP+Dn53dtweNhqym0NrX1fZO2LOSCebjFCFCwcuEv7B4b0NBsUkxMRUme1zmclpPHr+dcFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Add bindings for iMX8MQ Display Controller Subsystem.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
new file mode 100644
index 000000000000..68e4635e4874
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 NXP
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: iMX8MQ Display Controller Subsystem (DCSS)
+
+maintainers:
+  - Laurentiu Palcu <laurentiu.palcu@nxp.com>
+
+description:
+
+  The DCSS (display controller sub system) is used to source up to three
+  display buffers, compose them, and drive a display using HDMI 2.0a(with HDCP
+  2.2) or MIPI-DSI. The DCSS is intended to support up to 4kp60 displays. HDR10
+  image processing capabilities are included to provide a solution capable of
+  driving next generation high dynamic range displays.
+
+properties:
+  compatible:
+    const: nxp,imx8mq-dcss
+
+  reg:
+    items:
+      - description: DCSS base address and size, up to IRQ steer start
+      - description: DCSS BLKCTL base address and size
+
+  interrupts:
+    items:
+      - description: Context loader completion and error interrupt
+      - description: DTG interrupt used to signal context loader trigger time
+      - description: DTG interrupt for Vblank
+
+  interrupt-names:
+    items:
+      - const: ctxld
+      - const: ctxld_kick
+      - const: vblank
+
+  clocks:
+    items:
+      - description: Display APB clock for all peripheral PIO access interfaces
+      - description: Display AXI clock needed by DPR, Scaler, RTRAM_CTRL
+      - description: RTRAM clock
+      - description: Pixel clock, can be driven either by HDMI phy clock or MIPI
+      - description: DTRC clock, needed by video decompressor
+
+  clock-names:
+    items:
+      - const: apb
+      - const: axi
+      - const: rtrm
+      - const: pix
+      - const: dtrc
+
+  assigned-clocks:
+    items:
+      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_AXI_ROOT
+      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_RTRM
+      - description: Phandle and clock specifier of either IMX8MQ_VIDEO2_PLL1_REF_SEL or
+                     IMX8MQ_VIDEO_PLL1_REF_SEL
+
+  assigned-clock-parents:
+    items:
+      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
+      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
+      - description: Phandle and clock specifier of IMX8MQ_CLK_27M
+
+  assigned-clock-rates:
+    items:
+      - description: Must be 800 MHz
+      - description: Must be 400 MHz
+
+  port:
+    type: object
+    description:
+      A port node pointing to the input port of a HDMI/DP or MIPI display bridge.
+
+additionalProperties: false
+
+examples:
+  - |
+    dcss: display-controller@32e00000 {
+        compatible = "nxp,imx8mq-dcss";
+        reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+        interrupts = <6>, <8>, <9>;
+        interrupt-names = "ctxld", "ctxld_kick", "vblank";
+        interrupt-parent = <&irqsteer>;
+        clocks = <&clk 248>, <&clk 247>, <&clk 249>,
+                 <&clk 254>,<&clk 122>;
+        clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+        assigned-clocks = <&clk 107>, <&clk 109>, <&clk 266>;
+        assigned-clock-parents = <&clk 78>, <&clk 78>, <&clk 3>;
+        assigned-clock-rates = <800000000>,
+                               <400000000>;
+        port {
+            dcss_out: endpoint {
+                remote-endpoint = <&hdmi_in>;
+            };
+        };
+    };
+
-- 
2.17.1

