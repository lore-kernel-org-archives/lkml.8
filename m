Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54461C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B17B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AafhPAJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2PiJpHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFKHcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:39 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57147 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbgFKHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 31F025800D2;
        Thu, 11 Jun 2020 03:32:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2TSSMWRmw4rUS
        X5F6y3mivXYay4IQn7sWRRQkKrhFfQ=; b=AafhPAJaUhH3wo+0RsyuzjECR+DB+
        jzW34z755eVw04xvbvGoRbCsKOahoGN8NIcJEPiWVOOK1rq2X0fRlppp9BDWUxR9
        OFUUDMXdEOAdtldv2jnYCABB+LFCaa1ebPZZCRq8aG2YBtze6hmiqMaaeV3BfrqA
        xLu5C9PanRi9/6VneyECCslUiGhsR9sIQj+zeuYZQxme7TUAMD2p6/JLaz07jyM+
        VCoecPqcd2se9xSSv5Z7aq/Hr4aZs6on4qFaZLHk81tPBUVixDPz6Nnz27R0z1YF
        50l8B/scT7TDYDDKNql9WQOtPC6Q1zx9bk/KusJs2Po++hdi5dHfMTDfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2TSSMWRmw4rUSX5F6y3mivXYay4IQn7sWRRQkKrhFfQ=; b=F2PiJpHU
        f0SDQ4mS63hKiEnmdhXArd/P6aEv52NgFFgZNpUZwWH/iqtfNzu3LCO3EaQKcPx8
        kFsAcPBmaDYpxHiS3cOvpsD0RhQUoImROedq02q8Y6xI/4U0EiNFgSy2r/HUM/Rx
        Zd336SEQxAA6L6nfxjOz3a3PZnk5j+XzL1U3Oaj4zu7lPcA8qTd89zoX1WwTgvmH
        Kb1tsKDshLZ+shTaF7DHq37Qos/SIk4ymKcL1aHs5KT3AyBQjFCyNcH5hlZpAioO
        5jp1oX8pZlAEham9P260syk3RbUSLJJ1CW33MqLz1NwrCHNCIXxMfnICx3RfDePt
        2QY1iM9hH7sRFg==
X-ME-Sender: <xms:EN7hXuTFDtxpx5cIJ5Ow1uMo9TMhb_3mJlHg9bU-h-IYMO1V1ySIIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:EN7hXjw2O2YlabWhOQsT7dIfatyuK5Zy_xz8Lkz07X2NSbz-5wRNDQ>
    <xmx:EN7hXr1XoLj5_3vgF0M4hm8Xr64p-P465xekMbr5HjxfuYs6EuUWog>
    <xmx:EN7hXqCVOLgf8ZNbwNUYElDVw7k_utxrJDOgy8ee8SV3xKEBzvLDaA>
    <xmx:EN7hXoWpuPrrgnTND9YvCJ7DWoVDz_6cpRW_q3tqqK2Wt8zJI7I27g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6B043061856;
        Thu, 11 Jun 2020 03:32:31 -0400 (EDT)
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
Subject: [PATCH v4 07/27] clk: bcm: rpi: Remove global pllb_arm clock pointer
Date:   Thu, 11 Jun 2020 09:31:56 +0200
Message-Id: <e0fd75888a920efadf783f8e6f3628abf930a153.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
anywhere but in the raspberrypi_register_pllb_arm.

Let's remove it, this will make our lives easier in future patches.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5f0d4875e145..b21dd6ddc4fe 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -40,7 +40,6 @@ struct raspberrypi_clk {
 	unsigned long max_rate;
 
 	struct clk_hw pllb;
-	struct clk_hw *pllb_arm;
 	struct clk_lookup *pllb_arm_lookup;
 };
 
@@ -246,12 +245,12 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
 		return ret;
 	}
-	rpi->pllb_arm = &raspberrypi_clk_pllb_arm.hw;
 
-	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
+	rpi->pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
+						NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		clk_hw_unregister_fixed_factor(rpi->pllb_arm);
+		clk_hw_unregister_fixed_factor(&raspberrypi_clk_pllb_arm.hw);
 		return -ENOMEM;
 	}
 
-- 
git-series 0.9.1
