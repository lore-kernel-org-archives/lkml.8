Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47538C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AAA20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Aco8Ixq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWLXWMgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbgE0PqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:15 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59053 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389943AbgE0PqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:46:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 64C215C0227;
        Wed, 27 May 2020 11:46:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=p0+TM3Es/6iaR
        IBsoi7/zztX4VOE4lDImcXYw8sSWGQ=; b=Aco8Ixq5VpDWjaTBCFcRizKo5poDw
        G+hEdXL3luAFqaIwFFU4mhlSzzFSJuXk4VUFGJjv3Kb0pVEg1Uuk7WXv5r6pUYmc
        4gd1YI8mD/q4iUMCElTQ40TqoP8WIJclGluIOmtt3jc26zG9BqbMKB0gOleZP7wA
        cnONJw65ch+K/2p4mw4lBZKnZ0UaIYQjD+NjevxgtSsX1BZ2sknHwmTzMA87za/T
        CsQlo7A8WSnADxivDcYZVZyUjlLTw/FSHS2F0Ey9CD2Si3bKoL14EHlj2ghLZ4M/
        AjacbCuBVJ2OX+/IMb684CBXOHCw14rFduxMKCNFc7ewiid6psTlOaG+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=p0+TM3Es/6iaRIBsoi7/zztX4VOE4lDImcXYw8sSWGQ=; b=LWLXWMgg
        vY1yFrtXIpZ4spIQWZ4V9XQVTJqKUX0YUn9YOj3f5r3FfBrfT/c/+a247AiI7UgK
        cFHusF7hfAI8hWz/GDWCT0l5Fssh5hXBcIPl3goFOeTWbyswV4FtAK1F6CNvPFiu
        xXYDzca1v7SuQJx8KIGeCfQ0WSEpdK74qUflpoaS8ESG/qaZ86xTtYfYTnfMf/A7
        NblPUc0SpxBx40W/REJlDotCr3S85IKZ3acVdDAul2ruJ1OGJDrLOEkKdj1+Cn2F
        9OLIU3fz8d4fnQpWqNpiqNeoHbj7iRVx7X0tApY950UozVNkRcy99kfruXjAM286
        8Jn6Micm2L5zvA==
X-ME-Sender: <xms:PIvOXg_zisPY6yLm7ajZIj0CyRdZVC8qEp4lRACGphIzCb1481yQOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:PIvOXosTU3RTfSVy2W8yjXPof50byoSm9x8jwsI9SqQkhwBayKhCxg>
    <xmx:PIvOXmCMcrAqvxaxy4wCmlIk3U0HWjIp9vh9IU4_j1CAkiU55M8Ivg>
    <xmx:PIvOXgdxR_gPx1nx-XP-9JS0QplgCewuXIQlKDBqIj5FvJcTF94xBQ>
    <xmx:PIvOXo3DoczWpVYjsErY1HUSkbIJpvJ6E-ekLltNt-xIVIJZF-ACyw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 011BF3280067;
        Wed, 27 May 2020 11:46:03 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 24/25] clk: bcm: rpi: Remove the quirks for the CPU clock
Date:   Wed, 27 May 2020 17:45:20 +0200
Message-Id: <76b79454bd86310b5adb0b1a9d6885fdb60a779f.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU clock has had so far a bunch of quirks to expose the clock tree
properly, but since we reverted to exposing them through the MMIO driver,
we can remove that code from the firmware driver.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 156 +-------------------------------
 1 file changed, 156 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index cee634cb5323..c3c6fafcd101 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -152,13 +152,6 @@ static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
 	return val;
 }
 
-static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
-{
-	return raspberrypi_fw_get_rate(hw, parent_rate) *
-		RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
-}
-
 static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
@@ -177,142 +170,6 @@ static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long parent_rate)
-{
-	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
-
-	return raspberrypi_fw_set_rate(hw, new_rate, parent_rate);
-}
-
-/*
- * Sadly there is no firmware rate rounding interface. We borrowed it from
- * clk-bcm2835.
- */
-static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
-					  struct clk_rate_request *req)
-{
-	u64 div, final_rate;
-	u32 ndiv, fdiv;
-
-	/* We can't use req->rate directly as it would overflow */
-	final_rate = clamp(req->rate, req->min_rate, req->max_rate);
-
-	div = (u64)final_rate << A2W_PLL_FRAC_BITS;
-	do_div(div, req->best_parent_rate);
-
-	ndiv = div >> A2W_PLL_FRAC_BITS;
-	fdiv = div & ((1 << A2W_PLL_FRAC_BITS) - 1);
-
-	final_rate = ((u64)req->best_parent_rate *
-					((ndiv << A2W_PLL_FRAC_BITS) + fdiv));
-
-	req->rate = final_rate >> A2W_PLL_FRAC_BITS;
-
-	return 0;
-}
-
-static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
-	.is_prepared = raspberrypi_fw_is_prepared,
-	.recalc_rate = raspberrypi_fw_pll_get_rate,
-	.set_rate = raspberrypi_fw_pll_set_rate,
-	.determine_rate = raspberrypi_pll_determine_rate,
-};
-
-static struct clk_hw *raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
-{
-	struct raspberrypi_clk_data *data;
-	struct clk_init_data init = {};
-	u32 min_rate = 0, max_rate = 0;
-	int ret;
-
-	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
-	data->rpi = rpi;
-	data->id = RPI_FIRMWARE_ARM_CLK_ID;
-
-	/* All of the PLLs derive from the external oscillator. */
-	init.parent_names = (const char *[]){ "osc" };
-	init.num_parents = 1;
-	init.name = "pllb";
-	init.ops = &raspberrypi_firmware_pll_clk_ops;
-	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
-
-	/* Get min & max rates set by the firmware */
-	ret = raspberrypi_clock_property(rpi->firmware, data,
-					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
-					 &min_rate);
-	if (ret) {
-		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
-			init.name, ret);
-		return ERR_PTR(ret);
-	}
-
-	ret = raspberrypi_clock_property(rpi->firmware, data,
-					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
-					 &max_rate);
-	if (ret) {
-		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
-			init.name, ret);
-		return ERR_PTR(ret);
-	}
-
-	if (!min_rate || !max_rate) {
-		dev_err(rpi->dev, "Unexpected frequency range: min %u, max %u\n",
-			min_rate, max_rate);
-		return ERR_PTR(-EINVAL);
-	}
-
-	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
-		 min_rate, max_rate);
-
-	data->hw.init = &init;
-
-	ret = devm_clk_hw_register(rpi->dev, &data->hw);
-	if (ret)
-		return ERR_PTR(ret);
-
-	clk_hw_set_rate_range(&data->hw,
-			      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
-			      max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE);
-
-	return &data->hw;
-}
-
-static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
-	.mult = 1,
-	.div = 2,
-	.hw.init = &(struct clk_init_data) {
-		.name		= "pllb_arm",
-		.parent_names	= (const char *[]){ "pllb" },
-		.num_parents	= 1,
-		.ops		= &clk_fixed_factor_ops,
-		.flags		= CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-	},
-};
-
-static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
-{
-	int ret;
-
-	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
-	if (ret) {
-		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
-		return ERR_PTR(ret);
-	}
-
-	ret = devm_clk_hw_register_clkdev(rpi->dev,
-					  &raspberrypi_clk_pllb_arm.hw,
-					  NULL, "cpu0");
-	if (ret) {
-		dev_err(rpi->dev, "Failed to initialize clkdev\n");
-		return ERR_PTR(ret);
-	}
-
-	return &raspberrypi_clk_pllb_arm.hw;
-}
-
 static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
 					      struct clk_rate_request *req)
 {
@@ -341,19 +198,6 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 	u32 min_rate, max_rate;
 	int ret;
 
-	if (id == RPI_FIRMWARE_ARM_CLK_ID) {
-		struct clk_hw *hw;
-
-		hw = raspberrypi_register_pllb(rpi);
-		if (IS_ERR(hw)) {
-			dev_err(rpi->dev, "Failed to initialize pllb, %ld\n",
-				PTR_ERR(hw));
-			return hw;
-		}
-
-		return raspberrypi_register_pllb_arm(rpi);
-	}
-
 	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
-- 
git-series 0.9.1
