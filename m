Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB71C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8E21739
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NzSs5eL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KGTb3dF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBXJJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:24 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56145 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbgBXJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C614A5E5;
        Mon, 24 Feb 2020 04:09:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ld5tlwuL3Mz8O
        RDJ1ka2JWaeT1wNNxnX2ghNvSLFrmQ=; b=NzSs5eL3A6yfqnE/jeLecHtAu+Wj0
        /iRrcWE7v749yGFFekXCWO0ybrbba11ZO8+eN0RvrhCwrC/Jpors5//WcWYujAkO
        bxQZUSKKWiPC4MPUq/OBEnxEXjUbw/FIdMfRoP9YdOYRUqsmixYPEkOxZEZlT5ns
        EsEx5X3TR28hsdFnUV/m4SkaBYQ07yDcwJPAvXyNo4WVsKfXUdgKDnTRJeC/GM2j
        gFE+yH7jndZCUrNdz3uZ+rj9cvwf4iVYI2MPtQOQBv8O+emGlRkdVZzPDabGfg/N
        16RPyE+mDkR7RtvjH4RqOmQONS0wQWu8R+4QJEPrT5IjkfLxDBPJNaFQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ld5tlwuL3Mz8ORDJ1ka2JWaeT1wNNxnX2ghNvSLFrmQ=; b=KGTb3dF6
        TX1ZM7ija60p64JOpJXaHGnbWRpGhQraUhCXmI09kxcdtl+zcbuGRTzNa7N5BOao
        wLu74OXnVoE1rW0zpBY1utQ8rqusv2zKiyrbmzTqJw7dgrQO+R1UQBOxNnVaATx5
        Exa61vS1unBXjb1N8yju4rW6fFz23CfTmtJkbm82XBUf9CnmUllDwuXNv+vipdOP
        62OQDem5EUkjlT2NCua/deBk2eEttEScXixV3dBnMfWqFxlsAvmiAu4gh3og3XVF
        FbuH7ZumwpXp8V6wxaiSemdZQRxxENAOxDv9Kqk/csQMLVZgKyCfs9AJA8wb1S8F
        cqECuWi7WHU2CA==
X-ME-Sender: <xms:t5JTXsWtdJ3O3KhZV0m5UWcL288n36tnFfKzPa_rat7T8ic2bzFm-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:t5JTXsoNfugJeRZxImSLXC4YyaeHcF8hhGlvnhyuhneNCSnmADIezw>
    <xmx:t5JTXpxh5E2bLl02_MXwZ_XSbcTZYDWZLL_x1hU2KH3peAruo9rUYw>
    <xmx:t5JTXjiOV2GEBCIFc0Zc7bxBwiJLM0T3ncRVMCusJykL3F7LfrGBaQ>
    <xmx:t5JTXoWTiO6jLm2crj-HOo1TfCwCwMBKT9FveQ6Cg3cuBgV_IK3SSw3kUsE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 133133060BD1;
        Mon, 24 Feb 2020 04:09:10 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 15/89] clk: bcm: rpi: Create a data structure for the clocks
Date:   Mon, 24 Feb 2020 10:06:17 +0100
Message-Id: <adc5810f9ed6400940f36be6e0a3a7255c557687.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the driver has really only been providing a single clock, and stored
both the data associated to that clock in particular with the data
associated to the "controller".

Since we will change that in the future, let's decouple the clock data from
the provider data.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 40 ++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b8b55134ba3f..964fc8f792cc 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -35,11 +35,15 @@ struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
 	struct platform_device *cpufreq;
+};
+
+struct raspberrypi_clk_data {
+	struct clk_hw hw;
 
 	unsigned long min_rate;
 	unsigned long max_rate;
 
-	struct clk_hw pllb;
+	struct raspberrypi_clk *rpi;
 };
 
 /*
@@ -83,8 +87,9 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
 
 static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
+	struct raspberrypi_clk_data *data =
+		container_of(hw, struct raspberrypi_clk_data, hw);
+	struct raspberrypi_clk *rpi = data->rpi;
 	u32 val = 0;
 	int ret;
 
@@ -101,8 +106,9 @@ static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
+	struct raspberrypi_clk_data *data =
+		container_of(hw, struct raspberrypi_clk_data, hw);
+	struct raspberrypi_clk *rpi = data->rpi;
 	u32 val = 0;
 	int ret;
 
@@ -119,8 +125,9 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long parent_rate)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
+	struct raspberrypi_clk_data *data =
+		container_of(hw, struct raspberrypi_clk_data, hw);
+	struct raspberrypi_clk *rpi = data->rpi;
 	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
 	int ret;
 
@@ -142,13 +149,13 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 					  struct clk_rate_request *req)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
+	struct raspberrypi_clk_data *data =
+		container_of(hw, struct raspberrypi_clk_data, hw);
 	u64 div, final_rate;
 	u32 ndiv, fdiv;
 
 	/* We can't use req->rate directly as it would overflow */
-	final_rate = clamp(req->rate, rpi->min_rate, rpi->max_rate);
+	final_rate = clamp(req->rate, data->min_rate, data->max_rate);
 
 	div = (u64)final_rate << A2W_PLL_FRAC_BITS;
 	do_div(div, req->best_parent_rate);
@@ -173,10 +180,15 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 
 static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 {
+	struct raspberrypi_clk_data *data;
 	struct clk_init_data init = {};
 	u32 min_rate = 0, max_rate = 0;
 	int ret;
 
+	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->rpi = rpi;
 
 	/* All of the PLLs derive from the external oscillator. */
 	init.parent_names = (const char *[]){ "osc" };
@@ -215,12 +227,12 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
 		 min_rate, max_rate);
 
-	rpi->min_rate = min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
-	rpi->max_rate = max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	data->min_rate = min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	data->max_rate = max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
 
-	rpi->pllb.init = &init;
+	data->hw.init = &init;
 
-	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
+	return devm_clk_hw_register(rpi->dev, &data->hw);
 }
 
 static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
-- 
git-series 0.9.1
