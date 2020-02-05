Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43543C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1782E218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBEObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:14 -0500
Received: from comms.puri.sm ([159.203.221.185]:48982 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgBEObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7653CE0304;
        Wed,  5 Feb 2020 06:31:12 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dw3NlkAExb7l; Wed,  5 Feb 2020 06:31:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 07/12] arm64: dts: librem5-devkit: add the regulators for DVFS
Date:   Wed,  5 Feb 2020 15:29:58 +0100
Message-Id: <20200205143003.28408-8-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Specify which regulator is used for cpufreq DVFS.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index ac0145839a69..6a8f6cee96cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -223,6 +223,26 @@
 	};
 };
 
+&A53_0 {
+	operating-points-v2 = <&a53_opp_table>;
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_1 {
+	operating-points-v2 = <&a53_opp_table>;
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_2 {
+	operating-points-v2 = <&a53_opp_table>;
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_3 {
+	operating-points-v2 = <&a53_opp_table>;
+	cpu-supply = <&buck2_reg>;
+};
+
 &clk {
 	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
 	assigned-clock-rates = <786432000>, <722534400>;
-- 
2.20.1

