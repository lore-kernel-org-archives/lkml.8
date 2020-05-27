Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4D620899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lLA6xkqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K67sh9b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbgE0PqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:01 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51789 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389861AbgE0Pps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4CA1C581DDE;
        Wed, 27 May 2020 11:45:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=nL1h5CzLTBtwB
        4Yhuh91OpjAgsyIPeWCXA3enbNnQJU=; b=lLA6xkqdyyNVK8KxqAuo1mzrvZXr1
        v5RP7kZE1mlq1ck99SZv8kzqr57XxKUa+xR25S9114d7cxiJ7rNq/KlUD/ZaI1an
        T25oJoFE/+rsXXSb0/PLrR+93znexk7O4gKeN2JNsI72nEkL7VtJ1vexoZCavuoz
        sdZNjavpAiAWikehfcgPsrg+BA7XVro6WJMC0j7X9D5o9A9tES2jQco7DdPwT4Tb
        d86+JvyrhO3qyNgIixwAi1FZJ0xZm5Yts9yzLToGxfBtLHBaqmC9GTYXd0IJObGz
        H3Twyfo0jB1wNvAX59pMF4jXUwQrKYM/i/lqDBlsKRJhUaNv2VLluNVsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=nL1h5CzLTBtwB4Yhuh91OpjAgsyIPeWCXA3enbNnQJU=; b=K67sh9b0
        SbAz+a6PEGsyQ5x2fyjIq09vyusbrSCa+SuBqgx34VVh409aURsnNYk5pDdk2Zcp
        8fzmZAJxrrQ6MHu1PiSjDdp/bY7y2gKbgNHhdBckGj/2/tO3Lz/vAojJTgIOtIcd
        6h2FTqKccy2LvA/Suw9x8N+ZufsZNdlEY4KQyiXRuftRptzxWJKCG/aXuOe3KMi9
        3NMPqbTuPNMYHqhfN9PEQK93Nzp3Gp5sKtxjt7MFj9aaVC7vHcTfcfME46P+L+nl
        rG9nb0sbEp8/Y6yWl3As+Uo3FqZueetB+zkLa7vfi+GPw082/0+z65mIBZwgqGdD
        4wSBDyVkwuff1Q==
X-ME-Sender: <xms:K4vOXg0DHZRKTwLYFuvSYOVnL3kkna4M06jAbRHI-zjCk1dRwbTr6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:K4vOXrEWCn9YVg6X9jMABtTbkOxXEbwECcHLfsJtm2msu3K99EOAlA>
    <xmx:K4vOXo4HO4ihfKIsW8Zxkh5dQiu-GEh0CJOSDs24a_fiBbjCec3giA>
    <xmx:K4vOXp03t2kcdYImm9sP1yq6RSnlZ95ypgojyIRr6qjnC_w3zTXM4Q>
    <xmx:K4vOXpbvEvH08V8pqX6uh6NfymkkZjQsKMyMJGVjFXx-Qzytw0Panw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D57213061856;
        Wed, 27 May 2020 11:45:46 -0400 (EDT)
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
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 13/25] clk: bcm: rpi: Create a data structure for the clocks
Date:   Wed, 27 May 2020 17:45:09 +0200
Message-Id: <da903789bf0d96b5c9a8845595158c4c2623fdd9.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index e135ad28d38d..00735704eabc 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -35,8 +35,11 @@ struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
 	struct platform_device *cpufreq;
+};
 
-	struct clk_hw pllb;
+struct raspberrypi_clk_data {
+	struct clk_hw hw;
+	struct raspberrypi_clk *rpi;
 };
 
 /*
@@ -80,8 +83,9 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
 
 static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
+	struct raspberrypi_clk_data *data =
+		container_of(hw, struct raspberrypi_clk_data, hw);
+	struct raspberrypi_clk *rpi = data->rpi;
 	u32 val = 0;
 	int ret;
 
@@ -98,8 +102,9 @@ static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
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
 
@@ -116,8 +121,9 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
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
 
@@ -168,10 +174,15 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 
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
@@ -210,11 +221,11 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
 		 min_rate, max_rate);
 
-	rpi->pllb.init = &init;
+	data->hw.init = &init;
 
-	ret = devm_clk_hw_register(rpi->dev, &rpi->pllb);
+	ret = devm_clk_hw_register(rpi->dev, &data->hw);
 	if (!ret)
-		clk_hw_set_rate_range(&rpi->pllb,
+		clk_hw_set_rate_range(&data->hw,
 				      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
 				      max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE);
 
-- 
git-series 0.9.1
