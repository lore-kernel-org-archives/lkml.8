Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28610C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2972074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHYNLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:11:16 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:37227 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727774AbgHYNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:11:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 6417F523AC4;
        Tue, 25 Aug 2020 15:10:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uAa3ThSR6OU9; Tue, 25 Aug 2020 15:10:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id F188C523B2E;
        Tue, 25 Aug 2020 15:10:55 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 70C35523955;
        Tue, 25 Aug 2020 15:10:55 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] clk: sunxi-ng: sun8i: r40: Use sigma delta modulation for audio PLL
Date:   Tue, 25 Aug 2020 15:10:49 +0200
Message-Id: <20200825131049.1277596-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio cores need specific clock rates which can't be simply obtained by
adjusting integer multipliers and dividers. HW for such cases supports
delta-sigma modulation which enables fractional multipliers.

Port H3 delta-sigma table to R40. They have identical audio PLLs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 37 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-r40.c
index 23bfe1d12f21..84153418453f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -45,18 +45,29 @@ static struct ccu_nkmp pll_cpu_clk =3D {
  * the base (2x, 4x and 8x), and one variable divider (the one true
  * pll audio).
  *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names
+ * With sigma-delta modulation for fractional-N on the audio PLL,
+ * we have to use specific dividers. This means the variable divider
+ * can no longer be used, as the audio codec requests the exact clock
+ * rates we support through this mechanism. So we now hard code the
+ * variable divider to 1. This means the clock rates will no longer
+ * match the clock names.
  */
 #define SUN8I_R40_PLL_AUDIO_REG	0x008
=20
-static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
-				   "osc24M", 0x008,
-				   8, 7,	/* N */
-				   0, 5,	/* M */
-				   BIT(31),	/* gate */
-				   BIT(28),	/* lock */
-				   CLK_SET_RATE_UNGATE);
+static struct ccu_sdm_setting pll_audio_sdm_table[] =3D {
+	{ .rate =3D 22579200, .pattern =3D 0xc0010d84, .m =3D 8, .n =3D 7 },
+	{ .rate =3D 24576000, .pattern =3D 0xc000ac02, .m =3D 14, .n =3D 14 },
+};
+
+static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-ba=
se",
+				       "osc24M", 0x008,
+				       8, 7,	/* N */
+				       0, 5,	/* M */
+				       pll_audio_sdm_table, BIT(24),
+				       0x284, BIT(31),
+				       BIT(31),	/* gate */
+				       BIT(28),	/* lock */
+				       CLK_SET_RATE_UNGATE);
=20
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-vid=
eo0",
 						"osc24M", 0x0010,
@@ -952,10 +963,10 @@ static const struct clk_hw *clk_parent_pll_audio[] =
=3D {
 	&pll_audio_base_clk.common.hw
 };
=20
-/* We hardcode the divider to 4 for now */
+/* We hardcode the divider to 1 for now */
 static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
 			    clk_parent_pll_audio,
-			    4, 1, CLK_SET_RATE_PARENT);
+			    1, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
 			    clk_parent_pll_audio,
 			    2, 1, CLK_SET_RATE_PARENT);
@@ -1307,10 +1318,10 @@ static int sun8i_r40_ccu_probe(struct platform_de=
vice *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
=20
-	/* Force the PLL-Audio-1x divider to 4 */
+	/* Force the PLL-Audio-1x divider to 1 */
 	val =3D readl(reg + SUN8I_R40_PLL_AUDIO_REG);
 	val &=3D ~GENMASK(19, 16);
-	writel(val | (3 << 16), reg + SUN8I_R40_PLL_AUDIO_REG);
+	writel(val | (0 << 16), reg + SUN8I_R40_PLL_AUDIO_REG);
=20
 	/* Force PLL-MIPI to MIPI mode */
 	val =3D readl(reg + SUN8I_R40_PLL_MIPI_REG);
--=20
2.28.0

