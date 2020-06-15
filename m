Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591BE2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fiDYs8Mv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsRGIJ0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgFOIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:38 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36183 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729177AbgFOIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3F04458014B;
        Mon, 15 Jun 2020 04:41:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=sS6BwBFUiZXRU
        4wm/8LzjilpwHkbk9SalRSRG+6ui94=; b=fiDYs8MvSbDQG2KQXX6FoEXJqQJ4N
        DnIwo19eH8PZsrSi0YBTtAs/bwEMArJ2JX1EH8JBkK6vxJ4T/HB9c4Xyyq4MEq8+
        UO5KssK/C/5j3LAQZ4lFmdsyUlwiWWoImmytvi7VozhdTljWobJ/OrIEr4+QZIwr
        J+rDPCFrHMbdUl9zhl4UBeoIb0RqZkWJTDeOEbXcl3oc7ylpgYVjynCldvT0KWNW
        wa7RoeMDpdbQHScWjGMx62xQJiX5QjsXzKCWkm86q8guLg/06gjZv2DeGMLkVbOL
        O0TVpsJHde4IT+Uw0evYGyuJQUIUHCQJhv2lS5NmeDdSd1MDbmyXMuU2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=sS6BwBFUiZXRU4wm/8LzjilpwHkbk9SalRSRG+6ui94=; b=nsRGIJ0N
        QFDKi2WxjqG/acAnjyYj70l3B4r2mRfcDcHfEYVFycj4qhCV8zYKIfb4vmu8zr/K
        cX2NhDkyOWlH1YTJjcmWEkZYVmjaYJlvEDimwseRTfhy1YH8kgvcDPIISSXci5sA
        R6bte7gz8LX1+Bu1imqXG2eguTDbNEZGnCq5/vb3CND4LGerzPPH5c7KbRaiupM0
        Lpje8PfUZcMwp7TBrnZO9GhatdWbhP50asb6NqZITKL8Ys2Xk91tlIZJwAnwDPUN
        gG0diqVbzU8tZOZLK6dDQQqlPBIpKp7GAEYyIkW3IKQlQ4crs7bJ5HvubX2Wskgj
        vjIe8AbglfiqGQ==
X-ME-Sender: <xms:PTTnXujS12lDjgK_VzP8Zn6Xdyb-o6sW8YXzph8qp_yD7QNlU8nw1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:PTTnXvBYN96YTQzpThqGDJuorYh2xorHfxfvwk7ZdiAIb5pucSUKaQ>
    <xmx:PTTnXmHWGGyocwr_EtvnIk6FSkPDOmuO37s8Axz_cBdbVLfFl2R92Q>
    <xmx:PTTnXnTZfVt8calBLTgKmo2HapQmH7UGd8kgKGl_SN9yDb_CugKbEQ>
    <xmx:PTTnXjc_TFxP9Ke_g9HKfymok_7uUrPKeJXW7e0WYKaJTL67vyYFyA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D04C23280060;
        Mon, 15 Jun 2020 04:41:32 -0400 (EDT)
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
Subject: [PATCH v5 08/27] clk: bcm: rpi: Make sure pllb_arm is removed
Date:   Mon, 15 Jun 2020 10:40:48 +0200
Message-Id: <34254ed1556614658e5dad5cca4cf4fe617df7fc.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock was created at probe time, but was never removed if
something went wrong later in probe, or if the driver was ever removed from
the system.

Now that we are using clk_hw_register(), we can just use its managed variant
to take care of that for us.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b21dd6ddc4fe..d62605861028 100644
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
