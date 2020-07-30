Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09AFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EDC2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgG3ONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:13:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgG3ONp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7647FAB3E;
        Thu, 30 Jul 2020 14:13:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     pbrobinson@gmail.com, kernel-list@raspberrypi.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: bcm2835: Do not use prediv with bcm2711's PLLs
Date:   Thu, 30 Jul 2020 16:13:37 +0200
Message-Id: <20200730141337.12753-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to previous SoCs, bcm2711 doesn't have a prescaler in the PLL
feedback loop. Bypass it by zeroing fb_prediv_mask.

Note that, since the prediv configuration bits were re-purposed, this
was triggering a miscalculation on all clock hanging from the VPU clock,
notably the aux UART, making its output unintelligible.

Fixes: 42de9ad400af ("clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

FYI relevant discussion with RPi engineers:
https://github.com/raspberrypi/firmware/issues/1435#issuecomment-666242077

 drivers/clk/bcm/clk-bcm2835.c | 79 +++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 027eba31f793..acf499d26263 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -454,6 +454,16 @@ static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
 	.fb_prediv_mask = BIT(14),
 };
 
+static const struct bcm2835_pll_ana_bits bcm2711_ana_default = {
+	.mask0 = 0,
+	.set0 = 0,
+	.mask1 = A2W_PLL_KI_MASK | A2W_PLL_KP_MASK,
+	.set1 = (2 << A2W_PLL_KI_SHIFT) | (8 << A2W_PLL_KP_SHIFT),
+	.mask3 = A2W_PLL_KA_MASK,
+	.set3 = (2 << A2W_PLL_KA_SHIFT),
+	.fb_prediv_mask = 0, /* No prediv in bcm2711 */
+};
+
 static const struct bcm2835_pll_ana_bits bcm2835_ana_pllh = {
 	.mask0 = A2W_PLLH_KA_MASK | A2W_PLLH_KI_LOW_MASK,
 	.set0 = (2 << A2W_PLLH_KA_SHIFT) | (2 << A2W_PLLH_KI_LOW_SHIFT),
@@ -1631,7 +1641,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 	 * AUDIO domain is on.
 	 */
 	[BCM2835_PLLA]		= REGISTER_PLL(
-		SOC_ALL,
+		SOC_BCM2835,
 		.name = "plla",
 		.cm_ctrl_reg = CM_PLLA,
 		.a2w_ctrl_reg = A2W_PLLA_CTRL,
@@ -1642,6 +1652,21 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.ana = &bcm2835_ana_default,
 
+		.min_rate = 600000000u,
+		.max_rate = 2400000000u,
+		.max_fb_rate = BCM2835_MAX_FB_RATE),
+	[BCM2835_PLLA]		= REGISTER_PLL(
+		SOC_BCM2711,
+		.name = "plla",
+		.cm_ctrl_reg = CM_PLLA,
+		.a2w_ctrl_reg = A2W_PLLA_CTRL,
+		.frac_reg = A2W_PLLA_FRAC,
+		.ana_reg_base = A2W_PLLA_ANA0,
+		.reference_enable_mask = A2W_XOSC_CTRL_PLLA_ENABLE,
+		.lock_mask = CM_LOCK_FLOCKA,
+
+		.ana = &bcm2711_ana_default,
+
 		.min_rate = 600000000u,
 		.max_rate = 2400000000u,
 		.max_fb_rate = BCM2835_MAX_FB_RATE),
@@ -1687,7 +1712,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 	/* PLLB is used for the ARM's clock. */
 	[BCM2835_PLLB]		= REGISTER_PLL(
-		SOC_ALL,
+		SOC_BCM2835,
 		.name = "pllb",
 		.cm_ctrl_reg = CM_PLLB,
 		.a2w_ctrl_reg = A2W_PLLB_CTRL,
@@ -1698,6 +1723,22 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.ana = &bcm2835_ana_default,
 
+		.min_rate = 600000000u,
+		.max_rate = 3000000000u,
+		.max_fb_rate = BCM2835_MAX_FB_RATE,
+		.flags = CLK_GET_RATE_NOCACHE),
+	[BCM2835_PLLB]		= REGISTER_PLL(
+		SOC_BCM2711,
+		.name = "pllb",
+		.cm_ctrl_reg = CM_PLLB,
+		.a2w_ctrl_reg = A2W_PLLB_CTRL,
+		.frac_reg = A2W_PLLB_FRAC,
+		.ana_reg_base = A2W_PLLB_ANA0,
+		.reference_enable_mask = A2W_XOSC_CTRL_PLLB_ENABLE,
+		.lock_mask = CM_LOCK_FLOCKB,
+
+		.ana = &bcm2711_ana_default,
+
 		.min_rate = 600000000u,
 		.max_rate = 3000000000u,
 		.max_fb_rate = BCM2835_MAX_FB_RATE,
@@ -1720,7 +1761,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 	 * AUDIO domain is on.
 	 */
 	[BCM2835_PLLC]		= REGISTER_PLL(
-		SOC_ALL,
+		SOC_BCM2835,
 		.name = "pllc",
 		.cm_ctrl_reg = CM_PLLC,
 		.a2w_ctrl_reg = A2W_PLLC_CTRL,
@@ -1731,6 +1772,21 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.ana = &bcm2835_ana_default,
 
+		.min_rate = 600000000u,
+		.max_rate = 3000000000u,
+		.max_fb_rate = BCM2835_MAX_FB_RATE),
+	[BCM2835_PLLC]		= REGISTER_PLL(
+		SOC_BCM2711,
+		.name = "pllc",
+		.cm_ctrl_reg = CM_PLLC,
+		.a2w_ctrl_reg = A2W_PLLC_CTRL,
+		.frac_reg = A2W_PLLC_FRAC,
+		.ana_reg_base = A2W_PLLC_ANA0,
+		.reference_enable_mask = A2W_XOSC_CTRL_PLLC_ENABLE,
+		.lock_mask = CM_LOCK_FLOCKC,
+
+		.ana = &bcm2711_ana_default,
+
 		.min_rate = 600000000u,
 		.max_rate = 3000000000u,
 		.max_fb_rate = BCM2835_MAX_FB_RATE),
@@ -1782,7 +1838,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 	 * AUDIO domain is on.
 	 */
 	[BCM2835_PLLD]		= REGISTER_PLL(
-		SOC_ALL,
+		SOC_BCM2835,
 		.name = "plld",
 		.cm_ctrl_reg = CM_PLLD,
 		.a2w_ctrl_reg = A2W_PLLD_CTRL,
@@ -1793,6 +1849,21 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.ana = &bcm2835_ana_default,
 
+		.min_rate = 600000000u,
+		.max_rate = 2400000000u,
+		.max_fb_rate = BCM2835_MAX_FB_RATE),
+	[BCM2835_PLLD]		= REGISTER_PLL(
+		SOC_BCM2711,
+		.name = "plld",
+		.cm_ctrl_reg = CM_PLLD,
+		.a2w_ctrl_reg = A2W_PLLD_CTRL,
+		.frac_reg = A2W_PLLD_FRAC,
+		.ana_reg_base = A2W_PLLD_ANA0,
+		.reference_enable_mask = A2W_XOSC_CTRL_DDR_ENABLE,
+		.lock_mask = CM_LOCK_FLOCKD,
+
+		.ana = &bcm2711_ana_default,
+
 		.min_rate = 600000000u,
 		.max_rate = 2400000000u,
 		.max_fb_rate = BCM2835_MAX_FB_RATE),
-- 
2.27.0

