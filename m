Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10683C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E540220C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Gm2g75Hp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxXyW92y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbgE0Ppx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51899 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389838AbgE0Ppn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 726A2581DC2;
        Wed, 27 May 2020 11:45:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=n0QSF+s7WNrvA
        CQUMag7Hrl5LkSGFMi3zaAhmTrJUaw=; b=Gm2g75HpZ+CJtYWJmlbVWIH4cZbIZ
        f8/LaHICAaR26ZPHUreHjRvyv+ymsJxjFoEKhnJfFbkyfheo9leX96fP0E5kBlLy
        wjIZn3Abo/9xiB9e39u86Gipf+uJ83dbT22y1IxQ1GXupWGO6FA0xJW9nnKBW3EZ
        HZG190aUDsLevi3am+rPln/BSTYteuOej21ta28PJHgiF7i/CR+wXuk0IrtVLmxk
        q/jW/hrSlJT88cUQIWrgxMX0db4jYhq/x/MMjK+WzmPuG2g/dKKK4YHZm5IPO7u2
        WtUIZsKJcF9Y9szBeRRG1DCWTTfOSa96IuFjGZ9CqMx/opGKeVBEHltAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=n0QSF+s7WNrvACQUMag7Hrl5LkSGFMi3zaAhmTrJUaw=; b=fxXyW92y
        vtfUYQb89RbnpiOKFoPb+fabiigMWMbUToCFgmDg/nUdFlZNtm5EeduJRrpJiIjk
        APzBmerR5/917MDbeYFBJpap0kPEDggBzDYcaO60gS3F2/CUv3ow1pGbEVZJFXZW
        JcW5jecYMT+8oYcYz01GeZ/ckdjcbvyBR/aOPXrd8HW+U61raDTIgFXIgpYozD87
        j86C4bzqnIS4Pd2Txi59X4iGzUFR4NfjDzig3OsvOESv58/3HXlIz1kocKwu3Jn2
        Y6oyPpK8k1odgwJrRfjfoMw30b7aFf71/FyR96gkBf4Sx0wsMSzCEeaTK15bWW6W
        BNgCuBsE/cWpeA==
X-ME-Sender: <xms:JovOXkM7UYB53LmfyFsLrkAy6P8O9sjYLnYz0L-d4I73uQWSrZ9FDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JovOXq-JjqEcc2Faf0OyV8DEwvmUM5q9FvfV3AKMdY_rX_fFvqu7Mw>
    <xmx:JovOXrQxGIBaaK-pemFzw-Hay6vyL5KxAwAj4qgoSgMoQXo21LSHwg>
    <xmx:JovOXstNyHXsHaTpyBySRiBm5kcM-ehnUqGyU-8qYm2VDu1kHjTizg>
    <xmx:JovOXjzvxvOOSoRW1nTWefbfr1uZbPwDXi3TtluTzE_cP-3akWR-qw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DD323280060;
        Wed, 27 May 2020 11:45:41 -0400 (EDT)
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
Subject: [PATCH v3 10/25] clk: bcm: rpi: Switch to clk_hw_register_clkdev
Date:   Wed, 27 May 2020 17:45:06 +0200
Message-Id: <d21f81fe036fa4b0935764f939653b9911c42a6a.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't care about retrieving the clk_lookup structure pointer
returned by clkdev_hw_create, we can just use the clk_hw_register_clkdev
function.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5a06c4991c7f..23f06618a356 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -237,7 +237,6 @@ static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
 
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
-	struct clk_lookup *pllb_arm_lookup;
 	int ret;
 
 	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
@@ -246,11 +245,11 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
-					   NULL, "cpu0");
-	if (!pllb_arm_lookup) {
-		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		return -ENOMEM;
+	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
+				     NULL, "cpu0");
+	if (ret) {
+		dev_err(rpi->dev, "Failed to initialize clkdev\n");
+		return ret;
 	}
 
 	return 0;
-- 
git-series 0.9.1
