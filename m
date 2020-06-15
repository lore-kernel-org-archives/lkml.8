Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF352053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fFP7q37+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDOXDgWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgFOIlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:42 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44021 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729190AbgFOIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DBCCE58014E;
        Mon, 15 Jun 2020 04:41:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=V/nRMsYk1B+vc
        JHswGWvvufzB8kNbmgE8sNaF9Rj/Y8=; b=fFP7q37+f/EqdpGCR797lFzTI9K85
        YOj9XAFvKasNh1B5aZdm2G1GcRNZMxoRNlOAk14q2Y2Ztw+jvlNHThb0qA/SM8zR
        Ccn7oim3Sx98mhsdXEB0hp64dfrF/XabmhCTEfblOAc9sU1uzP6CZEczIkIrQe5A
        UG7QV4jcgH4PHM5FO9jXAmOZBh500K3J94LkwH4hRJSo8eQwvyfrVw34NUwf8bYA
        GM45Jc36sUY/JDYGXhR596UAykDOkem2KHdZ0LdcOCK724kso28JGJ3Vh7n8WJSJ
        nImBmjCjO436Uqtf4cDBG420g6E2lkrjXMWCDcsWLNlLtRwm/fX1Ysgog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=V/nRMsYk1B+vcJHswGWvvufzB8kNbmgE8sNaF9Rj/Y8=; b=oDOXDgWN
        B40FEfVVPwo3XpkYS22tpKsv/B9cxauaoQHF+6rAAPrWoUY1lf3WXm1ml+nVaS4t
        n20V+fOpksE2kJb3Mp6hPFVcU8tVTB0VgqYTKttnKoAJIMtFggeEu5pEVQJJz6wr
        JMvwriuunRC8Z0LAeEUOQ2tUBmk7yzN4ILNP7jsAQDeaFRxlhcYtPLd99kUn+p2D
        2Glfms2bo0aQHfxU8XYDiSt3L2t5sCnvTEDr6o/aAPxh6uwB3Z2YY+HxHwF/YEUX
        ctSVeUn5PrUGZXGj+hJ9iGDHjHXmxy2PUlKQhl1bsVRfnmmSCYKzUsHAp8PZuFjq
        qF86j2jWgiW1Cg==
X-ME-Sender: <xms:PjTnXjADajRxeDIY7ubhDMCVB3f8-zoxUfLvwvPkMrYi-yknM9o7JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:PjTnXpiXNmhNKW5bXadkAOkIO1dDeI3b0YNcqmYhoDi-RDGbX42_-Q>
    <xmx:PjTnXulz8fJ51oWzTvzov-xEN7vdANl9MMp_woNRyNmQfC73XR_i1w>
    <xmx:PjTnXlwcoYzcmur7X2qfmBDzmCEFjqpu3g3cscACZGRERq2R2iMzcA>
    <xmx:PjTnXh8M5m2yjmQyH4TMKRmgvJJLMbPWVCQg78LV8q1EktpvIZizpA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7070830618BF;
        Mon, 15 Jun 2020 04:41:34 -0400 (EDT)
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
Subject: [PATCH v5 09/27] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
Date:   Mon, 15 Jun 2020 10:40:49 +0200
Message-Id: <189407f54906d2b07c91de7a4eeb6d8c8934280f.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
anything but to store the returned pointer to clkdev_hw_create, and is not
used anywhere else in the driver.

Let's remove that global pointer from the structure.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index d62605861028..5a06c4991c7f 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -40,7 +40,6 @@ struct raspberrypi_clk {
 	unsigned long max_rate;
 
 	struct clk_hw pllb;
-	struct clk_lookup *pllb_arm_lookup;
 };
 
 /*
@@ -238,6 +237,7 @@ static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
 
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
+	struct clk_lookup *pllb_arm_lookup;
 	int ret;
 
 	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
@@ -246,9 +246,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	rpi->pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
-						NULL, "cpu0");
-	if (!rpi->pllb_arm_lookup) {
+	pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
+					   NULL, "cpu0");
+	if (!pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
 		return -ENOMEM;
 	}
-- 
git-series 0.9.1
