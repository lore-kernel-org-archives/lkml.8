Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74025C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501D520873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fCzYJNG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJ2fIS3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbgE0Ppu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:50 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42967 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389821AbgE0Ppk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5429F581DD0;
        Wed, 27 May 2020 11:45:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bKIFK4HlCTngX
        qlGFWYw+rUQ2qZUCm/IgUu0AKgZk3I=; b=fCzYJNG6JAiipLs4zis0TvjGt+cJl
        E09F9Wvm+qFfbirS5xUAVryBf39n+zIhYqwlhfzKY5GZp68pB6FX3XZhbjYZsIuU
        Fuue9yZyGw6GvpUHwhC6rb1NtQHTruTGu1bODqlTHpVQYhZf7rbilrNfV1RDXV/I
        qotBfqHQcEsF/tMoL2Ito2hIO4LBOlLBwwlu76YROmR1AA/LAT1SnOhBSN79RTSH
        N/59RqdZgzQXAGqDUFC0fM1GYUcL9IVqyAiKWEXKJP3kvWyzNpGB8rfsDj2kRio0
        hQsiPXBajN4ELURAEPYUGfstz8kc/LoPYsqXKGaMBJhKT8kLbas7reh/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bKIFK4HlCTngXqlGFWYw+rUQ2qZUCm/IgUu0AKgZk3I=; b=SJ2fIS3+
        nd6fkBX+PEDrftioFb8ecmyxv8LdrJJJCkStotspSpungI0wznY9mATTgdKKi/E4
        K12DR2oi21+MkwYxcrnfM9lxuRCzsqAVUrlpa6x1bMfMNcTGjmnsVmgqbfvAj+1F
        0Xl9FgWfgbjXQUINQ70ciz7/5k1yKFN0yBex/D4TOCSL8203gVGhAJ/UsSxv9fhR
        FO5ZVP+qOX1kmdNIV/2HCCvb5FbRr+tvGvqq/Fxc5DXBJYbJe+2O8G0NaCYA2Oz0
        pEqIAEQ5j1RCKqdTaQI6P3EFBJDWE7LGTgOkY4/MY7Szl7L6Wi+ggnXz8Xrr2aCX
        hlXkAEqINkxe8A==
X-ME-Sender: <xms:I4vOXo01HnXv9pdscBu0diQ4aH8YYIqxgpdOc4-Ly9NLowRt4mMSiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:I4vOXjGX6-0Ryl5kF6tlUwDDGRCo2v_wUTpIqAOh-Sqshot8f5z9fA>
    <xmx:I4vOXg6-sc1a7kzGPCPcbwxEZZP2fiYOx8CtsElxvV13RIQIIzUJuw>
    <xmx:I4vOXh3sOePXXi_RNG4956pxuOrRqH0nouSQpvXiv8Ubp4r6mBr2zw>
    <xmx:I4vOXhZGpDPd81WFfhHVANRxMEcRL0BdZVPXc1Dz3Fauryf5mG73wg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB4BF328005A;
        Wed, 27 May 2020 11:45:38 -0400 (EDT)
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
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v3 08/25] clk: bcm: rpi: Make sure pllb_arm is removed
Date:   Wed, 27 May 2020 17:45:04 +0200
Message-Id: <2bd4695ae7af2931f861e50b0892b81086ce972a.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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
