Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E45C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBE62073A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598642561;
	bh=SsWfjA5eIV9Q084cck3GujGTUi9QVLgIgfP8+HxBqiU=;
	h=From:To:Subject:Date:List-ID:From;
	b=OMLPG7YsbSMh6wing49aI8+yaOwzA7e39SEUJbQbyGqN7Ex17skx5XKn0rOkgRm4u
	 27PWg88OVtcWX2Hr+9etgWsbiHVcLZXR30sp8qxtM91hoGPeLxPcAzvw9q9Lk9sKpc
	 3agHil3McKt4j5IJvCngGMEFB1DiEbaIVI7lWkws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH1TWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgH1TWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:22:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EFF42073A;
        Fri, 28 Aug 2020 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642558;
        bh=SsWfjA5eIV9Q084cck3GujGTUi9QVLgIgfP8+HxBqiU=;
        h=From:To:Subject:Date:From;
        b=WkZbgQVmzaU+skuXsf0aAlFCfz9y6XpCS6a0SshPjaTCVfVKAabZ9TRsj0t11DFq0
         wJT+kWYj9xsqrPTIxDjMBIwI4Cdfv0LVxTpkcg820gCJgdlRycBR3Bpvvi3tfLZeOO
         /bEUo2Y/fv6oHTIIQem6+tbCvrhip61ZZo1RTNTQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq-librem5-devkit: Add missing clock-cells to PMIC
Date:   Fri, 28 Aug 2020 21:22:28 +0200
Message-Id: <20200828192228.23060-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC node can be a clock provider (for its 32 kHz clock) and authors
of imx8mq-librem5-devkit.dts apparently wanted this because they added
input clock and clock-output-names.

Add necessary clock-cells to the PMIC node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 377591a0e6e9..40b43625f20f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -285,6 +285,7 @@
 		pinctrl-0 = <&pinctrl_pmic>;
 		clocks = <&pmic_osc>;
 		clock-names = "osc";
+		#clock-cells = <0>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 GPIO_ACTIVE_LOW>;
-- 
2.17.1

