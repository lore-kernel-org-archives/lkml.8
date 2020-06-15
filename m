Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE562053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DI6bXX4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cn6/wGgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgFOImu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:50 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36647 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729200AbgFOIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 60C3058014B;
        Mon, 15 Jun 2020 04:41:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8e09siK1Fv+Ea
        Hw3aq1BNtlwtwt6mBCvjLLOKREMn6s=; b=DI6bXX4bx1kcH3PUXv+7obsBHwaXL
        TCnhUbCopdwEIG6+yssAGqT7VYfOLxXbCaSm6W2KTCUWf+gyqL9E+pY4NX8TP75F
        CW/i0cZ/tBfxNKt2CFmsm7Neop2sin1vv2RH+Hr3Z0k05wSmhTyNaymB3CG3IOzH
        c0houHxITUXYeX44e74sYmC0P77pqASK91VbodyOUS1BYJi66pvXKlAFAmhBeCcq
        JhB82mfx8oHshjFxaCM6S88HmJnsHhQosgIENOvvbpwt0cvyg5u9aGVnc7Bz4zCl
        txLgm37B/SiS1I2PWr87BifHsR+GN6YXfjYCK7q/6kwiiQeeqkXg6NbxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8e09siK1Fv+EaHw3aq1BNtlwtwt6mBCvjLLOKREMn6s=; b=cn6/wGgH
        iE9yaOjyDzpJ652/jMwL1E17w9ARQjkZ42HYLVH+IEQX60/DjUGI0eFKeiuVKyXW
        eXDOYzpitmLMajXuDCUoYC1X2IGvHpPh0L9zSKV020ECFC2Lj+uBX+uetrbe7jHg
        6fAc56vsMefxN6fyrZbMlOIDxuEuKMhXN/u9RrxPIxWvKBtiCw/2Wsl2MPZmZO7n
        64y3owoHta+7/4XfxiSdesXzyWR/StudfrmjqOXvrKLiD3czHjBTfTAMxTTWm+qd
        79aHKC12YAIHAZxlXtuaA9d+oyYWiwiDTjuoOXrnpWNt4nNTmOouACQTpgwxHE5S
        WDr/Xwn7+yyQvg==
X-ME-Sender: <xms:QDTnXmfUA_krjmwF3oyZ-eEknGfSli5gDAnLxy3u5jPBVSt77PuLyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QDTnXgMWYOD_sDNSpSxahw_CwXERdm3MfJpfDKtLJQXbNw2Hu2XQPw>
    <xmx:QDTnXnhp1LjtrOu4rRYhdTKtrySmXRkfh9OhVdpHL9eSO4bzVsxU1Q>
    <xmx:QDTnXj8kthgUg1X81GjJN3XwPrtGES9c6UD8YE8FNrz0913xs3zchg>
    <xmx:QDTnXsLSKNxzWIvZTet7MwL3s5otxuC-PE17H8cYXUpslseuNYZ_aw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 116413280064;
        Mon, 15 Jun 2020 04:41:35 -0400 (EDT)
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
Subject: [PATCH v5 10/27] clk: bcm: rpi: Switch to clk_hw_register_clkdev
Date:   Mon, 15 Jun 2020 10:40:50 +0200
Message-Id: <59f6208b6fe3367e735b0cca4f65c2c937639af9.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
