Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D053AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEE5208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YyJlTrVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaKFojU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbgE0PqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:10 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40169 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389908AbgE0Pp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88B9A581DEE;
        Wed, 27 May 2020 11:45:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=RzVXnJuQ7P+h7
        7dq98s7elC5SpH+lA4e/5nMa5iIDWo=; b=YyJlTrVOwiViS31hIZTeuv1mpo/fU
        BiemPkhOfcLeL6n7XVBrbo9GRMsNY5KQo1H6X0w99fVv/wWQm3RUHeVx8EAKuusR
        IAG0jK4BJW+upS3UeiDKIBFil6KO9kobBBPfqRb4e53CSZqeb9SUcfWqwgqi+5n7
        /zdYcYlTpZsyLnWQS0jXrGQ7Ovmzs5g7bP5cOsCmo/NE3NPHk0XX5vVgz19ZPV8w
        a0EUw83ElOqUt8+c9tdNLpfXzu/IRWZCp+n8mGzvJtKQHMNGHohwgftNuQ8ENIXp
        aLFXsZ6EJvCDPox8K0fGDYXaQLzY/29B7b4qySkLkzNr7fWfXEAscQZ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=RzVXnJuQ7P+h77dq98s7elC5SpH+lA4e/5nMa5iIDWo=; b=eaKFojU5
        XkQKmsmIADCK1S6swekOdo0kuWFswQjZQhMWQDzKK6iHCB0eI/POwRlKUVmNVBK0
        boKU99I5UirK5Y+D0cCN/WlorT9O1dj5AGkryLWgUkYWFJGxCLPTsCxFWoumcLmR
        Db3tp5xWkSG1rSZ9nQbzs0leagA6nVeV2bY3mwhnCMnfaMjHDLhW0u2MwY0eLNM7
        q7hnW8d8IJsbf/NA59ciCnjUc6AxksJ6iEvsVoQYUbkDr9uiV3o3Jpdixc0G6LkV
        OOx4w9zauhyLdnXusHiezCtppQTgUljdcPZhkyhWRBJYW6gMOB0WRltaZ36YffBr
        sVZkrlGZf8qbKw==
X-ME-Sender: <xms:NIvOXhzPK7mC8rzty4oACw3q9n79AhnsnlXDjluNX0AdJ8SUWg1i0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NIvOXhRzgLG61UU7sR85gUfxf5UiYhMaz5mXBcYLQVRAIy5owgZhzA>
    <xmx:NIvOXrVP5WBh0CB6c-Hl_P9gdpUvfo2B2Dm9S2s0pdnjCiVRk9cNnQ>
    <xmx:NIvOXjj6_vwwgcBejXFd995KE3XWf9arY-Hki1_l8M9qg-mcDA3fsg>
    <xmx:NIvOXn2Pi5pWMxyvuicamP8SmOWmogKZ2HCn2IU5VZskcFFLPinmrQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C04D3061CCB;
        Wed, 27 May 2020 11:45:56 -0400 (EDT)
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
Subject: [PATCH v3 19/25] clk: bcm: rpi: Add DT provider for the clocks
Date:   Wed, 27 May 2020 17:45:15 +0200
Message-Id: <58f0ca794ae24bb2026b3051d1f5cd0affab42ee.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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
