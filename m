Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE5D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="PMicSRLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5DPFZfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFKHch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39395 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgFKHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A8FC45800D1;
        Thu, 11 Jun 2020 03:32:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=1CRffqz/Ml8mm
        POvizsQdWw+f6223btgJ0KputgcYZQ=; b=PMicSRLsc50Uy5HsAF2bSwQRfbzve
        0X1KLS+OBk0ulj8Tk32ot4AnvQHkbCIZHIN31diwKv6rIYJs5145etCo8cKwSacK
        rY3XEl/I7otw3YoYvNXYPpUXX3b+3PcJArQ5ghYo2sY3ACa9OGZNRwah5mCUXAVe
        ZaYl0EHr/rFgtQJ2iCWkEvtm7Az2t0hrctKg+koFO9jYwDhj1zWeh+yW1c0TMm80
        3lW9jSU8FU0vWqw8sOZMeGWG8ApZXmBv7sMD7FyH0gOhS+06X8dEApkH8xIrmk1R
        6ewOiDhxd2y1Nl1UwUqYZyw6F2peo+XwULij/O1wJw+Fi9m/7mwj6bYxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1CRffqz/Ml8mmPOvizsQdWw+f6223btgJ0KputgcYZQ=; b=T5DPFZfC
        h0T1PSPj2fvnovdBXxuYZyq1FIf7tNBjNoZt478cUBuIHhEofYmcGWcYZA9m4k79
        whYe3B3hp3NFEr0EVQheCJal9570IUMvkoR0rAkJA51VkrOnYO8lsdT4DehYzXou
        hwykHd1W+GgA+Z6R4eh0t/5wk29n9hqUsWQlQNI5xNzGQk3NpxpYzBZacEK33ErU
        1J9C4XXexF9gbdaGWuqQu/3hWaZfs4DYZnLXy8s9dGFdbOBTW4npkuys/ewEPda1
        /RznXxX93AQ9mFXjgqW0mk+1wtLCmZdjegdkIVnb7f5UGdO09UJ2DORwzxIXAWvp
        VpnMwuQu6q4L7A==
X-ME-Sender: <xms:Dt7hXrT4pLZSw-9WrFr7bk3C9K9_nbM5J6bxuHBUFxrHewfpT3elIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Dt7hXsy4laFABwwjNGSjmvC_McQOoeR-nTPLRar5mbBuXXNHQbE1MQ>
    <xmx:Dt7hXg1PN4xXmxKlT97J1448UVg76omPMVI9wRWmLJW4auAXbIKqPw>
    <xmx:Dt7hXrDCcc9BtHcAnB8kZr4Q_crB2AFPPt9v7yFcYHPrZt516HTf1Q>
    <xmx:Dt7hXtUUPPLqI5KWO94R9xG0wKQrnogy637jMQwaviAdXorU734mZw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4A8B93280064;
        Thu, 11 Jun 2020 03:32:30 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 06/27] clk: bcm: rpi: Use clk_hw_register for pllb_arm
Date:   Thu, 11 Jun 2020 09:31:55 +0200
Message-Id: <c131bc0722ff3b8ef7018b14357fb73668b48868.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
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
