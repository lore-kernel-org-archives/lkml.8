Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3501E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598642455;
	bh=tCiKCoT33Ggoi/1v/hk0H+qANkB2eST5EjHvrPEODE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANgSgqx5PhREOPHZfMNrAib9W8otU5AEOzgnEdzj5M7DAYzbcFArg52NqElFD3gMd
	 4WUlHg2PCyLEQl0GSF1kCCtYCXW8NNsXdULELWdPp3fowZMudlgX8oI9vrZiWukO7k
	 YyR1iGH2CXWwSPFKaJm8KwMJWiiaxvYRiADS05mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1TUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgH1TUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:20:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC8620897;
        Fri, 28 Aug 2020 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642452;
        bh=tCiKCoT33Ggoi/1v/hk0H+qANkB2eST5EjHvrPEODE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYnTcWmka2xDbOWnMi2rNhLPwPrt9uvs9bJsfWUPtY0ZNNmVpfCvhGRcwJ9GrWRnc
         POx6/jYAx9p/vjUpUfoPW9OKrEWN3jzwfUGPEfYIZHU4EuTVkiDfTTaUjFQ7NzY1AB
         1fw1RXTf7I6pueX5kXDnlLVTMOLHR5H2ao5aAYmc=
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
Subject: [PATCH 2/4] ARM: dts: imx23: Align GPMI NAND node name with schema
Date:   Fri, 28 Aug 2020 21:20:35 +0200
Message-Id: <20200828192037.22897-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828192037.22897-1-krzk@kernel.org>
References: <20200828192037.22897-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects NAND controller to be named
"nand-controller", otherwise dtbs_check complain with a warning like:

    arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
        $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx23-evk.dts | 2 +-
 arch/arm/boot/dts/imx23.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 0b2701ca2921..8cbaf1c81174 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -53,7 +53,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_pins_fixup>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 18289f6fb1f3..7f4c602454a5 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -76,7 +76,7 @@
 				status = "disabled";
 			};
 
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				compatible = "fsl,imx23-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1

