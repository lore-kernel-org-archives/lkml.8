Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F6C54FD6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101222073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCYPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:39:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52820 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgCYPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA4AE1A04EA;
        Wed, 25 Mar 2020 16:39:24 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD1571A00F9;
        Wed, 25 Mar 2020 16:39:24 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 244D8203CE;
        Wed, 25 Mar 2020 16:39:24 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 02/13] Documentation: mfd: Add DT bindings for i.MX Audiomix
Date:   Wed, 25 Mar 2020 17:38:40 +0200
Message-Id: <1585150731-3354-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX Audiomix is a mix of clock gates, reset bits
and some other i.MX audio specific functionalities.
Add information for the MFD, its clock and reset controllers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/mfd/fsl,imx-audiomix.txt   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt

diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt b/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt
new file mode 100644
index 00000000..1622818
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt
@@ -0,0 +1,34 @@
+Freescale i.MX Audiomix
+======================================
+
+Audiomix is a conglomerate of different functionalities.
+
+Required properties:
+- compatible: Should be "fsl,<chip>-mix" for the MFD device
+	Should be"fsl,<chip>-audiomix-clk" for the clock controller
+	Should be"fsl,<chip>-audiomix-reset" for the reset controller
+	Some functionalities of the audiomix will be registered as syscon.
+- reg: should be register base and length as documented in the
+  datasheet
+
+example:
+	audiomix: audiomix@30e20000 {
+		compatible = "fsl,imx8mp-mix";
+		reg = <0x30e20000 0x10000>;
+
+		audiomix_clk: clock-controller {
+			compatible = "fsl,imx8mp-audiomix-clk";
+			#clock-cells = <1>;
+			clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
+				 <&clk IMX8MP_CLK_AUDIO_AHB>,
+				 <&clk IMX8MP_CLK_AUDIO_AXI_DIV>;
+			clock-names = "audio_root",
+				      "audio_ahb",
+				      "audio_axi_div";
+		};
+
+		audiomix_reset: reset-controller {
+			compatible = "fsl,imx8mp-audiomix-reset";
+			#reset-cells = <1>;
+		};
+	};
-- 
2.7.4

