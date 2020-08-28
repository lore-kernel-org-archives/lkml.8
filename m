Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B88C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C882073A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598642470;
	bh=b+C9gooK4xJleCmMIQXtF7ckCR+IgHOmuWP1gyW97aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRm0FH3Obw7fJuOkS8pgJfeuNADI1IPNVwx1426eHN4z99Xm8jDL7rskOX9XxEY26
	 4CmAtP8GvOkwkG+5Pnfj/LyflUD2oYlxEDDxGVWLtxYSvEaW6OGkTGgObeiIP6W5Bi
	 DZeYnOznBQjncuQAmO1EIgmz1/Z+mifZm4gDB+r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgH1TVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgH1TVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:21:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6662B2073A;
        Fri, 28 Aug 2020 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642461;
        bh=b+C9gooK4xJleCmMIQXtF7ckCR+IgHOmuWP1gyW97aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbqtve0adoen2rwk86LU8WCdvmxtsyag5ihSsathppQh7s8iOn6DrwmMr/sy5kQQz
         TAfSKaGn+utTpr5exYj+dYGLJyhFvm3YV1IAeVKeIZgSgJRRQJhHr7XYcypo3+5NPg
         7v9JSWp5O06QPmzemwdHxXNeCrel4dWr73c3BAWQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/4] ARM: dts: imx: Align GPMI NAND node name with schema
Date:   Fri, 28 Aug 2020 21:20:37 +0200
Message-Id: <20200828192037.22897-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828192037.22897-1-krzk@kernel.org>
References: <20200828192037.22897-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects NAND controller to be named
"nand-controller", otherwise dtbs_check complain with a warning like:

    arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml: gpmi-nand@112000:
        $nodename:0: 'gpmi-nand@112000' does not match '^nand-controller(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi | 2 +-
 arch/arm/boot/dts/imx7s.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b480dfa9e251..dfdca1804f9f 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -213,7 +213,7 @@
 			clocks = <&clks IMX6SX_CLK_APBH_DMA>;
 		};
 
-		gpmi: gpmi-nand@1806000{
+		gpmi: nand-controller@1806000{
 			compatible = "fsl,imx6sx-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 2b088f210331..d7d9f3e46b92 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -174,7 +174,7 @@
 			clocks = <&clks IMX6UL_CLK_APBHDMA>;
 		};
 
-		gpmi: gpmi-nand@1806000 {
+		gpmi: nand-controller@1806000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1cfaf410aa43..2d237793eba9 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1208,7 +1208,7 @@
 			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
 		};
 
-		gpmi: gpmi-nand@33002000{
+		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.17.1

