Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C4D20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgG3S0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:26:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgG3S0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF4CDABCE;
        Thu, 30 Jul 2020 18:26:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     pbrobinson@gmail.com, kernel-list@raspberrypi.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: bcm2835: Do not use prediv with bcm2711's PLLs
Date:   Thu, 30 Jul 2020 20:26:19 +0200
Message-Id: <20200730182619.23246-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to previous SoCs, bcm2711 doesn't have a prescaler in the PLL
feedback loop. Bypass it by zeroing fb_prediv_mask when running on
bcm2711.

Note that, since the prediv configuration bits were re-purposed, this
was triggering miscalculations on all clocks hanging from the VPU clock,
notably the aux UART, making its output unintelligible.

Fixes: 42de9ad400af ("clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v1:
 - Previous approach broken. Check if running on bcm2711 upon using
   fb_prediv_mask.

FYI relevant discussion with RPi engineers:
https://github.com/raspberrypi/firmware/issues/1435#issuecomment-666242077

 drivers/clk/bcm/clk-bcm2835.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 027eba31f793..3439bc65bb4e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -314,6 +314,7 @@ struct bcm2835_cprman {
 	struct device *dev;
 	void __iomem *regs;
 	spinlock_t regs_lock; /* spinlock for all clocks */
+	unsigned int soc;
 
 	/*
 	 * Real names of cprman clock parents looked up through
@@ -526,6 +527,20 @@ static int bcm2835_pll_is_on(struct clk_hw *hw)
 		A2W_PLL_CTRL_PRST_DISABLE;
 }
 
+static u32 bcm2835_pll_get_prediv_mask(struct bcm2835_cprman *cprman,
+				       const struct bcm2835_pll_data *data)
+{
+	/*
+	 * On BCM2711 there isn't a pre-divisor available in the PLL feedback
+	 * loop. Bits 13:14 of ANA1 (PLLA,PLLB,PLLC,PLLD) have been re-purposed
+	 * for to for VCO RANGE bits.
+	 */
+	if (cprman->soc & SOC_BCM2711)
+		return 0;
+
+	return data->ana->fb_prediv_mask;
+}
+
 static void bcm2835_pll_choose_ndiv_and_fdiv(unsigned long rate,
 					     unsigned long parent_rate,
 					     u32 *ndiv, u32 *fdiv)
@@ -583,7 +598,7 @@ static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
 	ndiv = (a2wctrl & A2W_PLL_CTRL_NDIV_MASK) >> A2W_PLL_CTRL_NDIV_SHIFT;
 	pdiv = (a2wctrl & A2W_PLL_CTRL_PDIV_MASK) >> A2W_PLL_CTRL_PDIV_SHIFT;
 	using_prediv = cprman_read(cprman, data->ana_reg_base + 4) &
-		data->ana->fb_prediv_mask;
+		       bcm2835_pll_get_prediv_mask(cprman, data);
 
 	if (using_prediv) {
 		ndiv *= 2;
@@ -666,6 +681,7 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
 	struct bcm2835_cprman *cprman = pll->cprman;
 	const struct bcm2835_pll_data *data = pll->data;
+	u32 prediv_mask = bcm2835_pll_get_prediv_mask(cprman, data);
 	bool was_using_prediv, use_fb_prediv, do_ana_setup_first;
 	u32 ndiv, fdiv, a2w_ctl;
 	u32 ana[4];
@@ -683,7 +699,7 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	for (i = 3; i >= 0; i--)
 		ana[i] = cprman_read(cprman, data->ana_reg_base + i * 4);
 
-	was_using_prediv = ana[1] & data->ana->fb_prediv_mask;
+	was_using_prediv = ana[1] & prediv_mask;
 
 	ana[0] &= ~data->ana->mask0;
 	ana[0] |= data->ana->set0;
@@ -693,10 +709,10 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	ana[3] |= data->ana->set3;
 
 	if (was_using_prediv && !use_fb_prediv) {
-		ana[1] &= ~data->ana->fb_prediv_mask;
+		ana[1] &= ~prediv_mask;
 		do_ana_setup_first = true;
 	} else if (!was_using_prediv && use_fb_prediv) {
-		ana[1] |= data->ana->fb_prediv_mask;
+		ana[1] |= prediv_mask;
 		do_ana_setup_first = false;
 	} else {
 		do_ana_setup_first = true;
@@ -2262,6 +2278,7 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cprman);
 
 	cprman->onecell.num = asize;
+	cprman->soc = pdata->soc;
 	hws = cprman->onecell.hws;
 
 	for (i = 0; i < asize; i++) {
-- 
2.27.0

