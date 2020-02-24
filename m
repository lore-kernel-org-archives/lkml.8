Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEEC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C20720863
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="g5yDTxoj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Srvnlj1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBXJON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:14:13 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43833 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbgBXJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C34CF60E;
        Mon, 24 Feb 2020 04:09:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=DwriZRHRN7fN7
        mhHrJdEKvtb3nQZcEd0mgRQMVSwm/Y=; b=g5yDTxoj8S6kyr6YkHEMf6zhkqMYw
        X/hsZAJnTYpW/02DOjvTpoXhDxSJjJ+9R38OQaJoDjKW2BqbbHt0zjYFEg10Uf1H
        oCSnPOAEDiLQVu0HnrjbAVaGznXipSJHjuuPdPmDsDuPsi5fyIEgY2t/ZQrz1NKY
        n4UX8M1ShIHmhvdd40MuhmtB9PM/H32vkIC7TQkSdsky7WSGlwDhcJx+6KQij5pQ
        TfIEWojkAMLSIUWokAf+5xqMhHTUaItIEFczm+1g9eDpTW3Ln5aWxO9SA/shWmvF
        1IihAxnEI67NS82Olc6EyO05AvG2HNtkdCkPAWHE3GFYjm46IICi7xcmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=DwriZRHRN7fN7mhHrJdEKvtb3nQZcEd0mgRQMVSwm/Y=; b=Srvnlj1K
        Kxj/m1XJXkyCSWasG+E6ij6xxmoBO4dsmBDqqeZxYQMSKC1m0a8nuO11TO5cpAX9
        ZVh0ujUsk+R18ueIUCH/3IR/Ky3oQ9IFeyWKlq8Q4M4+nGC0oyX9slRROQ1mDx7P
        CUEQhAkS6fyfrt/adZul1NavZhNV3MQqC+MggvYwQu5VfmMr5VYFBRhmUYxLDy+O
        8haSarBhdGp67sY/BZecMg2rEqqPqNvcc2PwRlOw6zRgezyQY32jVYqxM55/w5Pr
        vGbp/zYNxOmJCbFG4A2tb2SbnssJg7PApEW3WlwuybPzOz0yZKBNReJFP59hWM/d
        60hJy8Fdph/pPw==
X-ME-Sender: <xms:wZJTXpfi4TORHzfU00ftYVtX0zgquzWiqLvPXgGIdOcfe53c--i0sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wZJTXjQtOglB95qFwblcXsCWP7ZIT-0qjP7-xRYaN-guU2DqkXo4-Q>
    <xmx:wZJTXoex8IxFHOCS2SRYIjibQ1zvztreNMfb4jPeOoCzlvA10SCzig>
    <xmx:wZJTXj7uwPL-zrYJOCNmIYsWGefee-Gs56OYQsb6g0e3U8PNzfT_bQ>
    <xmx:wZJTXrYacj5H5ZbCVpp5wgA5f3TKO4lLE1_urUcra4UKROaUpUbPQK4qKAo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D5743280064;
        Mon, 24 Feb 2020 04:09:20 -0500 (EST)
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
Subject: [PATCH 22/89] clk: bcm: rpi: Discover the firmware clocks
Date:   Mon, 24 Feb 2020 10:06:24 +0100
Message-Id: <d197ab836d84b89b94ff1927872126767d921e94.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware has an interface to discover the clocks it exposes.

Let's use it to discover, register the clocks in the clocks framework and
then expose them through the device tree for consumers to use them.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c          | 105 +++++++++++++++++++---
 include/soc/bcm2835/raspberrypi-firmware.h |   5 +-
 2 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 3f21888a3e3e..bf6a1e2dc099 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -285,6 +285,95 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 	return &raspberrypi_clk_pllb_arm.hw;
 }
 
+static long raspberrypi_fw_dumb_round_rate(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static const struct clk_ops raspberrypi_firmware_clk_ops = {
+	.is_prepared	= raspberrypi_fw_is_prepared,
+	.recalc_rate	= raspberrypi_fw_get_rate,
+	.round_rate	= raspberrypi_fw_dumb_round_rate,
+	.set_rate	= raspberrypi_fw_set_rate,
+};
+
+static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
+					       unsigned int parent,
+					       unsigned int id)
+{
+	struct raspberrypi_clk_data *data;
+	struct clk_init_data init = {};
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
+		hw = raspberrypi_register_pllb_arm(rpi);
+		if (IS_ERR(hw))
+			return hw;
+
+		return hw;
+	}
+
+	data = devm_kzalloc(rpi->dev, sizeof(data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+	data->rpi = rpi;
+	data->id = id;
+
+	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);
+	init.ops = &raspberrypi_firmware_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
+
+	data->hw.init = &init;
+
+	ret = devm_clk_hw_register(rpi->dev, &data->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &data->hw;
+}
+
+static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
+				       struct clk_hw_onecell_data *data)
+{
+	struct rpi_firmware_get_clocks_response *clks;
+	size_t clks_size = NUM_FW_CLKS * sizeof(*clks);
+	int ret;
+
+	clks = devm_kzalloc(rpi->dev, clks_size, GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	ret = rpi_firmware_property(rpi->firmware, RPI_FIRMWARE_GET_CLOCKS,
+				    clks, clks_size);
+	if (ret)
+		return ret;
+
+	while (clks->id) {
+		struct clk_hw *hw;
+
+		hw = raspberrypi_clk_register(rpi, clks->parent, clks->id);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		data->hws[clks->id] = hw;
+		data->num = clks->id + 1;
+		clks++;
+	}
+
+	return 0;
+}
+
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -292,7 +381,7 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
-	struct clk_hw *hw;
+	int ret;
 
 	firmware_node = of_parse_phandle(dev->of_node, "raspberrypi,firmware", 0);
 	if (!firmware_node) {
@@ -317,17 +406,9 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
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
index 7800e12ee042..e5b7a41bba6b 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -135,6 +135,11 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_DMA_CHANNELS =                       0x00060001,
 };
 
+struct rpi_firmware_get_clocks_response {
+	__le32	parent;
+	__le32	id;
+};
+
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
-- 
git-series 0.9.1
