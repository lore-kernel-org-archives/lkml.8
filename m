Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6489C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A52218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBEObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:12 -0500
Received: from comms.puri.sm ([159.203.221.185]:48908 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgBEObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A11A5E0DC0;
        Wed,  5 Feb 2020 06:31:06 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4t57zCzWLaTJ; Wed,  5 Feb 2020 06:31:05 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 05/12] arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
Date:   Wed,  5 Feb 2020 15:29:56 +0100
Message-Id: <20200205143003.28408-6-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Describe the sgtl5000 of the librem 5 devkit in devicetree.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index e7e3766198c6..56b4ac286801 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -480,6 +480,19 @@
 		vddio-supply = <&reg_3v3_p>;
 	};
 
+	sgtl5000: sgtl5000@a {
+		compatible = "fsl,sgtl5000";
+		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
+		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+		assigned-clock-rates = <24576000>;
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		VDDD-supply = <&reg_1v8_p>;
+		VDDIO-supply = <&reg_3v3_p>;
+		VDDA-supply = <&reg_3v3_p>;
+	};
+
 	touchscreen@5d {
 		compatible = "goodix,gt5688";
 		reg = <0x5d>;
-- 
2.20.1

