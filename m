Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B08E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rH3rHkqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TuUdEJvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgE0Pq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:29 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42847 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389834AbgE0PqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:46:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A330C581DEE;
        Wed, 27 May 2020 11:45:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FyUcCHOFsyuvq
        quxAGpxzLB3J1lVMUHe9bD76zXi07U=; b=rH3rHkqNdjEN0iiWeOLF4dO5FI3hf
        th/M2YLH3jRDMOjxfi1u2TmKOOo1bcBDotVnenYNCiDgVdyrjfK7XetA+QE319/7
        Syh7mr8dLpPL6xpvnzSla//63HAZaOXai1GO2DGfXs7b/VKfJXRhNfb7hPTcqJ4P
        uXnLN1u76Jdh59CuLKro7T1yL87Wz5RBaRCovZVTvWKgNcue/HTw820Ekfs3KhG1
        8raMnfydJ+uWC0I2BLaSoTy9EOKoc96A2kJzUSQqkYUks0vg2W3LATMxGBitd/Vv
        eYTSH9Ncjcreebu7IqdwwxdIcbI1bLG8gk/b0FLMg3Ft45t2Cg6YWnT1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FyUcCHOFsyuvqquxAGpxzLB3J1lVMUHe9bD76zXi07U=; b=TuUdEJvl
        icyO9TtAjHCOHbtzft+h7JUi+dhKKdCmtf3nssyx2gYtU7tYOhJcmvkOrpp0Cx/L
        81fBGGhmGVX/or0iHFyqoK/69P0LJDVGq6NicqrMgSOB2cad+QfGJzn//gD6Bmik
        r6uvLZYzGxartGU9b2m5zvmRn566U4eakV0j0p6ToN3apWyLMPBcvPj53eGOQyEA
        u4iqOydDNplYYOWlA36iDRwKkRB+8Nqxw1Qi6lSwMiyRbyptAB2fSBD/ot0IBMHr
        Xl962aYRvcnnayNJeiAKk0W7LW3iYgOPs5bwqPgNcmiHYvAJdgf/5Vo5ZdWwu4du
        TyAs8AJgucNn2A==
X-ME-Sender: <xms:N4vOXiLRAIWsYtK1ecez4aTJFZpWI3abLk4cVtB08p5av2jlVCacHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:N4vOXqKzi-zEtA6Mw9L8rVwhW6c45K7lziblHq8ktDDiA_QktglKVw>
    <xmx:N4vOXitgl0cTvLWCafe_2Hh2vrHmjc-sC2DRWyjY2Y9zLEm-3vbd3Q>
    <xmx:N4vOXnYAYrIJb_myLOZhVCUVkgavNw2Ue-JoXIw5eWoWUSRyzXXUlQ>
    <xmx:N4vOXnOpWkcalTsZhXSvlrjcDfaJnmW2lUT_lFeHFuddhAP48774lQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D93230618C1;
        Wed, 27 May 2020 11:45:59 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v3 21/25] clk: bcm: rpi: Discover the firmware clocks
Date:   Wed, 27 May 2020 17:45:17 +0200
Message-Id: <d3791b14fceec639085ff427e934852f275e348c.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RaspberryPi4 firmware actually exposes more clocks than are currently
handled by the driver and we will need to change some of them directly
based on the pixel rate for the display related clocks, or the load for the
GPU.

Since the firmware implements DVFS, this rate change can have a number of
side-effects, including adjusting the various PLL voltages or the PLL
parents. The firmware also implements thermal throttling, so even some
thermal pressure can change those parameters behind Linux back.

DVFS is currently implemented on the arm, core, h264, v3d, isp and hevc
clocks, so updating any of them using the MMIO driver (and thus behind the
firmware's back) can lead to troubles, the arm clock obviously being the
most problematic.

In order to make Linux play as nice as possible with those constraints, it
makes sense to rely on the firmware clocks as much as possible. However,
the firmware doesn't seem to provide some equivalents to their MMIO
counterparts, so we can't really replace that driver entirely.

Fortunately, the firmware has an interface to discover the clocks it
exposes.

Let's use it to discover, register the clocks in the clocks framework and
then expose them through the device tree for consumers to use them.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c          | 151 ++++++++++++++++++++--
 include/soc/bcm2835/raspberrypi-firmware.h |   5 +-
 2 files changed, 144 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index eebd16040f8a..8d3acf3ee053 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -296,6 +296,142 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 	return &raspberrypi_clk_pllb_arm.hw;
 }
 
+static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
+					      struct clk_rate_request *req)
+{
+	/*
+	 * The firmware will do the rounding but that isn't part of
+	 * the interface with the firmware, so we just do our best
+	 * here.
+	 */
+	req->rate = clamp(req->rate, req->min_rate, req->max_rate);
+	return 0;
+}
+
+static const struct clk_ops raspberrypi_firmware_clk_ops = {
+	.is_prepared	= raspberrypi_fw_is_prepared,
+	.recalc_rate	= raspberrypi_fw_get_rate,
+	.determine_rate	= raspberrypi_fw_dumb_determine_rate,
+	.set_rate	= raspberrypi_fw_set_rate,
+};
+
+static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
+					       unsigned int parent,
+					       unsigned int id)
+{
+	struct raspberrypi_clk_data *data;
+	struct clk_init_data init = {};
+	u32 min_rate, max_rate;
+	int ret;
+
+	if (id == RPI_FIRMWARE_ARM_CLK_ID) {
+		struct clk_hw *hw;
+
+		hw = raspberrypi_register_pllb(rpi);
+		if (IS_ERR(hw)) {
+			dev_err(rpi->dev, "Failed to initialize pllb, %ld\n",
+				PTR_ERR(hw));
+			return hw;
+		}
+
+		return raspberrypi_register_pllb_arm(rpi);
+	}
+
+	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+	data->rpi = rpi;
+	data->id = id;
+
+	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);
+	init.ops = &raspberrypi_firmware_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+
+	data->hw.init = &init;
+
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
+					 &min_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get clock %d min freq: %d",
+			id, ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
+					 &max_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get clock %d max freq: %d\n",
+			id, ret);
+		return ERR_PTR(ret);
+	}
+
+	dev_info(rpi->dev, "Clock %d frequency range: min %u, max %u\n",
+		 id, min_rate, max_rate);
+
+	ret = devm_clk_hw_register(rpi->dev, &data->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	clk_hw_set_rate_range(&data->hw, min_rate, max_rate);
+
+	if (id == RPI_FIRMWARE_ARM_CLK_ID) {
+		ret = devm_clk_hw_register_clkdev(rpi->dev, &data->hw,
+						  NULL, "cpu0");
+		if (ret) {
+			dev_err(rpi->dev, "Failed to initialize clkdev\n");
+			return ERR_PTR(ret);
+		}
+	}
+
+	return &data->hw;
+}
+
+static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
+				       struct clk_hw_onecell_data *data)
+{
+	struct rpi_firmware_get_clocks_response *clks;
+	int ret;
+
+	clks = devm_kcalloc(rpi->dev,
+			    sizeof(*clks), RPI_FIRMWARE_NUM_CLK_ID,
+			    GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	ret = rpi_firmware_property(rpi->firmware, RPI_FIRMWARE_GET_CLOCKS,
+				    clks,
+				    sizeof(*clks) * RPI_FIRMWARE_NUM_CLK_ID);
+	if (ret)
+		return ret;
+
+	while (clks->id) {
+		struct clk_hw *hw;
+
+		switch (clks->id) {
+		case RPI_FIRMWARE_ARM_CLK_ID:
+		case RPI_FIRMWARE_CORE_CLK_ID:
+		case RPI_FIRMWARE_M2MC_CLK_ID:
+		case RPI_FIRMWARE_V3D_CLK_ID:
+			hw = raspberrypi_clk_register(rpi, clks->parent,
+						      clks->id);
+			if (IS_ERR(hw))
+				return PTR_ERR(hw);
+
+			data->hws[clks->id] = hw;
+			data->num = clks->id + 1;
+			fallthrough;
+
+		default:
+			clks++;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -303,7 +439,6 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
-	struct clk_hw *hw;
 	int ret;
 
 	/*
@@ -340,17 +475,9 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	hw = raspberrypi_register_pllb(rpi);
-	if (IS_ERR(hw)) {
-		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
-		return PTR_ERR(hw);
-	}
-
-	hw = raspberrypi_register_pllb_arm(rpi);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	clk_data->hws[RPI_FIRMWARE_ARM_CLK_ID] = hw;
-	clk_data->num = RPI_FIRMWARE_ARM_CLK_ID + 1;
+	ret = raspberrypi_discover_clocks(rpi, clk_data);
+	if (ret)
+		return ret;
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					  clk_data);
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 3025aca3c358..1c48f8269eab 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -136,6 +136,11 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_DMA_CHANNELS =                       0x00060001,
 };
 
+struct rpi_firmware_get_clocks_response {
+	__le32 parent;
+	__le32 id;
+};
+
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
-- 
git-series 0.9.1
