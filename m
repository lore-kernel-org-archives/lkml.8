Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E69C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E1D2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="FYUuNCit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZzmaGsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbgE0Ppn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:43 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42967 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389801AbgE0Pph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3CE51581DC7;
        Wed, 27 May 2020 11:45:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=1CRffqz/Ml8mm
        POvizsQdWw+f6223btgJ0KputgcYZQ=; b=FYUuNCitZjb3w6gHud5LjYl2BG0xE
        n8bb2nBGf4bHf5uHPjkGLQ0Pu0GM4L50pLRf0W+IFqtDZ4TAWTX6uDCFBid+17dj
        URdviie5nk8lr7KPpKQqg7O/mYZEWbXOAMU0Kw/u+jj2ko3AT+5K0VAoL/A7a4Nq
        /618q3PXRYO3Srw12uv72kBqlBUV9oOhLRaXvuQKDqN4/lsaeuuJPiCGZ+QHlGMh
        QSL1IR7kk9c14jzBKVWnWuKy3eplT6nycYvjVgDqgSPnRQN2uhw9lRzfGsYiis/Y
        K6SAbHmW5RuQR05o4DQOp29pJ+Mbtx1LHFsatO6EN7Ez4dV0XiLcPmZWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=1CRffqz/Ml8mmPOvizsQdWw+f6223btgJ0KputgcYZQ=; b=KZzmaGsD
        Zu30+SlsV86BEwFfSPXgko3TUDKgBRq2x5lANzrzxr5ng92dYikD3qJQpB7ZH4pm
        ncX0GW2PHz6kXhM0r7HShGfhaUJWJpBFCyv/6U3hiFPo1i0yYJTj4KMZAegj9TCm
        vMO4RYfBS509MzjLH6v3NRgamJe0y4xhY2/ijsV3/hzlQVjjeEHG4QQE/AzzWcLQ
        e/Mjfm4zgdB1qv348XIkoADloGQlD6PP8nUX+9uLH/kCut1k6oe8QCr9uDGsgfDc
        JtdsXPoit9JODCiHbwAUoNNfxZOxQmRP5LfI//8LFbhwJKoE8adwxlNz0obbjnxW
        LgrYzfJME13jdQ==
X-ME-Sender: <xms:IIvOXjPQ8NHloJ2ehaI_bsbljbUWfLrdXO7CJuIEhHSv0mKXIsDjoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IIvOXt-TkC_GgPczBZ6wsvAGEjLf40IJUk4oPpYTw6sWhiEODlX8Cg>
    <xmx:IIvOXiSoXdB8uQcGL8Vh2sIbnq1DZLuTr6WUyo_Fn_IggARTvCLQbw>
    <xmx:IIvOXntbBFs5aEgUyzu7Yf_PXtywsoLaksz8VBcdC0TAEtr3isN8pg>
    <xmx:IIvOXqzhFovdVpNtQFmBqu1DGgUjx2mqyamGFC7xNASyq9HFLtawWQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D11BB328005E;
        Wed, 27 May 2020 11:45:35 -0400 (EDT)
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
Subject: [PATCH v3 06/25] clk: bcm: rpi: Use clk_hw_register for pllb_arm
Date:   Wed, 27 May 2020 17:45:02 +0200
Message-Id: <5b3833ca16f07df2a10d2d0f08e53248620ebe03.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock is defined as a fixed factor clock with the pllb
clock as a parent. However, all its configuration is entirely static,
and thus we don't really need to call clk_hw_register_fixed_factor() but
can simply call clk_hw_register() with a static clk_fixed_factor
structure.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index ddc72207212e..5f0d4875e145 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -225,16 +225,28 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
 }
 
+static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data) {
+		.name		= "pllb_arm",
+		.parent_names	= (const char *[]){ "pllb" },
+		.num_parents	= 1,
+		.ops		= &clk_fixed_factor_ops,
+		.flags		= CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
-	rpi->pllb_arm = clk_hw_register_fixed_factor(rpi->dev,
-				"pllb_arm", "pllb",
-				CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-				1, 2);
-	if (IS_ERR(rpi->pllb_arm)) {
+	int ret;
+
+	ret = clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
+	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
-		return PTR_ERR(rpi->pllb_arm);
+		return ret;
 	}
+	rpi->pllb_arm = &raspberrypi_clk_pllb_arm.hw;
 
 	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
-- 
git-series 0.9.1
