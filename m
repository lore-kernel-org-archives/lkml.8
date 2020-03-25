Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785FFC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A562078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgCYPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:39:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52872 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgCYPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6F371A04FA;
        Wed, 25 Mar 2020 16:39:29 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 99C871A00F9;
        Wed, 25 Mar 2020 16:39:29 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ABF66203CE;
        Wed, 25 Mar 2020 16:39:28 +0100 (CET)
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
Subject: [PATCH v2 08/13] dt-bindings: clocks: imx8mp: Add ids for audiomix clocks
Date:   Wed, 25 Mar 2020 17:38:46 +0200
Message-Id: <1585150731-3354-9-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the clock ids for the audiomix clocks.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/clock/imx8mp-clock.h | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 47ab082..305433f 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -298,4 +298,66 @@
 
 #define IMX8MP_CLK_END				289
 
+#define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2		2
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK3		3
+#define IMX8MP_CLK_AUDIOMIX_SAI2_IPG		4
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1		5
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2		6
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK3		7
+#define IMX8MP_CLK_AUDIOMIX_SAI3_IPG		8
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1		9
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2		10
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK3		11
+#define IMX8MP_CLK_AUDIOMIX_SAI5_IPG		12
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1		13
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2		14
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK3		15
+#define IMX8MP_CLK_AUDIOMIX_SAI6_IPG		16
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1		17
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2		18
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK3		19
+#define IMX8MP_CLK_AUDIOMIX_SAI7_IPG		20
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1		21
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2		22
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK3		23
+#define IMX8MP_CLK_AUDIOMIX_ASRC_IPG		24
+#define IMX8MP_CLK_AUDIOMIX_PDM_IPG		25
+#define IMX8MP_CLK_AUDIOMIX_SDMA2_ROOT		26
+#define IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT		27
+#define IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT		28
+#define IMX8MP_CLK_AUDIOMIX_DSP_ROOT		29
+#define IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT		30
+#define IMX8MP_CLK_AUDIOMIX_EARC_IPG		31
+#define IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG		32
+#define IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG		33
+#define IMX8MP_CLK_AUDIOMIX_EDMA_ROOT		34
+#define IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT		35
+#define IMX8MP_CLK_AUDIOMIX_MU2_ROOT		36
+#define IMX8MP_CLK_AUDIOMIX_MU3_ROOT		37
+#define IMX8MP_CLK_AUDIOMIX_EARC_PHY		38
+#define IMX8MP_CLK_AUDIOMIX_PDM_ROOT		39
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1_SEL	40
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2_SEL	41
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1_SEL	42
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2_SEL	43
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1_SEL	44
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2_SEL	45
+#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK1_SEL	46
+#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK2_SEL	47
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1_SEL	48
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2_SEL	49
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1_SEL	50
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2_SEL	51
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1_SEL	52
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2_SEL	53
+#define IMX8MP_CLK_AUDIOMIX_PDM_SEL		54
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL	55
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL		56
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS	57
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT		58
+
+#define IMX8MP_CLK_AUDIOMIX_END			59
+
 #endif
-- 
2.7.4

