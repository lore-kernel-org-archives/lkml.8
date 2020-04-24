Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBB0C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7920767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XpIkg/Rx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8xNkNDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgDXPfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:35:41 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40121 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgDXPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C6090EB7;
        Fri, 24 Apr 2020 11:35:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bKSy+blvmCNF0
        dSFR73sumQcWt8VaokjCxExjWW0esg=; b=XpIkg/RxlOOS6DIbhgnMMwxw0zFEd
        Hb9DsX1ZU4B1wSt8wLQB+iM3vt/XlE1pDqS5Kb71jDmNonaTUDFOf1bHQlLYeDOI
        LVPr0+DjhtAQj61fEpJf534kOGWp/PMcUieoHKgkhmKO6OqhGhfFaJqnVRqqApJ5
        jldguKg6W8pJ6I1IXb4yJt/y3L6Hq2MeVpyDHmGMOcKBmv1WgL+WzUJvaSufH3o5
        /qmwikseWBlMK0QmeG8Ycpu8Bj0J+6KOpeE//2FQ9rpZ5xRPe0/Y+B9cQy8GOIF2
        ZfYDIl5cN1gnl5u137h0AOF6s1CQrugpriVTwEh8SZmmlxoRvTGFlqXeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bKSy+blvmCNF0dSFR73sumQcWt8VaokjCxExjWW0esg=; b=e8xNkNDC
        Ub7hPWePdSeE4oSBts5XoE4fpx62jcnY6VugTrWrjKglBPj7GatnQ3wDN3XTBkA4
        4srA4GJBgnaz8P+kUv5HPOpJ95E+gGiUL9QrbuNGHYid5mfdGyWlMlhNGjkrSu0B
        mpuKl2LfJf5mmovBYUTSfg3bmWwu3vkknKL4yMWFZDThvlTRDnHLRLhCv/GnnCBa
        MHBVtfx3MVeZTCtvOtiuMncAG+SRhvh9mzhiPIUoroSJfBKsO2ZLnUUbmXUNxK7f
        cdpUWhWCiaYC9GwsU2Xu4oLHBp8BW0yKXcI0hQAYETHu4jzZywaeCObclPVRI7jI
        j5IsxTmdVzDJwg==
X-ME-Sender: <xms:RwejXn_uFOykmPuHQF-1wnQEcL4zeDGbAz3biW7fOqbGRCLqkKqhbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:RwejXqMb0EOHEu06qjFyqCxt7k17Se7rbM745aVcaLD5MkQnDRWeQg>
    <xmx:RwejXoPXsAuPdVWM2SmC_mGVZdGT1K6XNM2i8v_LHYDxNWvv9JyFiQ>
    <xmx:RwejXtcJEGHkfQxFvOJnQb_KFAVpiBN4lhpjwk4nvgdC-dUWTL3Jww>
    <xmx:RwejXgY73G0NJFT4sCFKWjaakw4tH3Q-MWkgnBuYgLO7lFDoNsGw1EQg8YM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F7B23065D9A;
        Fri, 24 Apr 2020 11:35:34 -0400 (EDT)
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
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 09/91] clk: bcm: rpi: Make sure pllb_arm is removed
Date:   Fri, 24 Apr 2020 17:33:50 +0200
Message-Id: <3eda4a838ba441b5cd8daf59a7e5115172d82c97.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock was created at probe time, but was never removed if
something went wrong later in probe, or if the driver was ever removed from
the system.

Now that we are using clk_hw_register, we can just use its managed variant
to take care of that for us.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index a99e8189311f..859eac020122 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -240,7 +240,7 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
 	int ret;
 
-	ret = clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
+	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
 		return ret;
@@ -250,7 +250,6 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 						NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		clk_hw_unregister_fixed_factor(&raspberrypi_clk_pllb_arm.hw);
 		return -ENOMEM;
 	}
 
-- 
git-series 0.9.1
