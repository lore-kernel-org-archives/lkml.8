Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55512C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313332053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IXRHUy4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+9Kyk7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgFOIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:59 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36647 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729226AbgFOIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A84C458014F;
        Mon, 15 Jun 2020 04:41:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=SK2vOXsSpB33Y
        wZTN+hcy7zFdKGark8MlFfQ1WdFSF0=; b=IXRHUy4tZWN6b+ookc3GW2ViOjczF
        nyquEPYcCNpDQ7fy3916ocvneSGWXlflfm0ZrfNBSM8AlTPbad4P/Gev6JeqKHQD
        UEshPOGqgbVE4ElTn4u/oSFB0gfDe3oiCLW5dMgkTdj0zUF2IDRVXGJnX4T8IMiu
        0s+vHp3Y0cBxhM5oTQjwSkAnpXE7d4hewwJzuMNCQ+9cmAWBSOH4O9YqVnJ28+R5
        5W93myv7hfyq+LzKSLdcWwdwyA1BfupZavOZNkEdssWihXOVmcxAHHb82uC5IUA8
        9S+O1hUAm2iTG32RyW4L7NdLkRJsoOMZ2dKvLXgb7Q/t2W3N7ESCUQ7iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SK2vOXsSpB33YwZTN+hcy7zFdKGark8MlFfQ1WdFSF0=; b=s+9Kyk7w
        cZLH//h+kpofLem8EMTTlKs98u9sRv26apsg5MDPgARitfk1N6xCs+45gcQ87AkW
        Qnq3SYH23LgZCsNTYGttNlk9otnLvnKDNYubPgpjKKHCXvMcWjgLJlyfMoMY44RX
        auM+qUTaFKeaVvlxrgUBPdhOIth2Sh2iLb8ztcArmm1Dyxfj49yGUtY7aDo6GSLO
        kI97qibSVjHBYTyjpIug0akeL6Vgwu8yRJJhbZZnr0xZDRLiSDPz6UDhJ5MeDX5h
        rF9o+NZxwZz5qWFHq5i5fHgJ7lyUBvN4zb+Zdt7adoV4IvYayUn9iNYjp77Jri0d
        AiGpFVkESnZ+zQ==
X-ME-Sender: <xms:TjTnXp1DsXyNpoRjnJ187yfuVlXYhG21iNqIE8oiXlBHBHCXWMLbkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TjTnXgH06hx9VOTJ_0WprhZUVDLRxGEMlI5GG43xIdGG_dNo0vqulg>
    <xmx:TjTnXp4ijy1hJ_RgdKDTecJWMu3faF8qqfmmT8HXM6im6eTD3l_fHg>
    <xmx:TjTnXm0dlzG0etTmuJIbV8po_FyKJaERuwWPNiv41JLQeJjSGMeb-g>
    <xmx:TjTnXnBzEhjQ9L8YCvGydn0p1kq_2kwsO4MAIDTUZ1zwtQXe8ZNOKA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47E4B30614FA;
        Mon, 15 Jun 2020 04:41:50 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 19/27] clk: bcm: rpi: Add DT provider for the clocks
Date:   Mon, 15 Jun 2020 10:40:59 +0200
Message-Id: <4d8dbe4aaae98b3d3812ad7c3dba53d645cadbaf.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming registration of the clocks provided by the firmware, make
sure it's exposed to the device tree providers.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index d2cb90c086a7..5f4e2d49432f 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -31,6 +31,8 @@
 
 #define A2W_PLL_FRAC_BITS		20
 
+#define NUM_FW_CLKS			16
+
 struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
@@ -282,11 +284,13 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *firmware_node;
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
 	struct clk_hw *hw;
+	int ret;
 
 	/*
 	 * We can be probed either through the an old-fashioned
@@ -316,6 +320,11 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	rpi->firmware = firmware;
 	platform_set_drvdata(pdev, rpi);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS),
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
 	hw = raspberrypi_register_pllb(rpi);
 	if (IS_ERR(hw)) {
 		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
@@ -325,6 +334,13 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	hw = raspberrypi_register_pllb_arm(rpi);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+	clk_data->hws[RPI_FIRMWARE_ARM_CLK_ID] = hw;
+	clk_data->num = RPI_FIRMWARE_ARM_CLK_ID + 1;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data);
+	if (ret)
+		return ret;
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
git-series 0.9.1
