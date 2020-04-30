Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD5C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29372082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD3MqZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:46:25 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:54856 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgD3MqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:46:21 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        by skedge03.snt-world.com (Postfix) with ESMTP id C054A67A902;
        Thu, 30 Apr 2020 14:46:17 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 14:46:17 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 14:46:17 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Adam Ford <aford173@gmail.com>, Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Li Jun" <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D core
 using Etnaviv
Thread-Topic: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D
 core using Etnaviv
Thread-Index: AQHWHu1XU8cnqZiR7kmt3VxL/7fb7Q==
Date:   Thu, 30 Apr 2020 12:46:17 +0000
Message-ID: <20200430124602.14463-5-frieder.schrempf@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
In-Reply-To: <20200430124602.14463-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: C054A67A902.A0242
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aford173@gmail.com, anson.huang@nxp.com,
        christian.gmeiner@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, festevam@gmail.com, jun.li@nxp.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux+etnaviv@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

According to the documents, the i.MX8M-Mini features a GC320 and a
GCNanoUltra GPU core. Etnaviv detects them as:

	etnaviv-gpu 38000000.gpu: model: GC600, revision: 4653
	etnaviv-gpu 38008000.gpu: model: GC520, revision: 5341

This seems to work fine more or less without any changes to the HWDB,
which still might be needed in the future to correct some features,
etc.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index cc7152ecedd9..1dd0a6e849d3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -937,6 +937,42 @@
 			status = "disabled";
 		};
 
+		gpu_3d: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MM_CLK_GPU_AHB>,
+				 <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
+				 <&clk IMX8MM_CLK_GPU3D_ROOT>;
+			clock-names = "reg", "bus", "core";
+			assigned-clocks = <&clk IMX8MM_CLK_GPU3D_SRC>,
+					<&clk IMX8MM_CLK_GPU_AXI>,
+					<&clk IMX8MM_CLK_GPU_AHB>,
+					<&clk IMX8MM_GPU_PLL_OUT>;
+			assigned-clock-parents = <&clk IMX8MM_GPU_PLL_OUT>,
+					<&clk IMX8MM_SYS_PLL1_800M>,
+					<&clk IMX8MM_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>,<400000000>,<1000000000>;
+		};
+
+		gpu_2d: gpu@38008000 {
+			compatible = "vivante,gc";
+			reg = <0x38008000 0x8000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MM_CLK_GPU_AHB>,
+				 <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
+				 <&clk IMX8MM_CLK_GPU2D_ROOT>;
+			clock-names = "reg", "bus", "core";
+			assigned-clocks = <&clk IMX8MM_CLK_GPU2D_SRC>,
+					<&clk IMX8MM_CLK_GPU_AXI>,
+					<&clk IMX8MM_CLK_GPU_AHB>,
+					<&clk IMX8MM_GPU_PLL_OUT>;
+			assigned-clock-parents = <&clk IMX8MM_GPU_PLL_OUT>,
+					<&clk IMX8MM_SYS_PLL1_800M>,
+					<&clk IMX8MM_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>,<400000000>,<1000000000>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>, /* GIC Dist */
-- 
2.17.1
