Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E301F20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eNkGV25c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSaAX2hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbgE0Pps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39763 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389810AbgE0Ppi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C1E55581DCB;
        Wed, 27 May 2020 11:45:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2TSSMWRmw4rUS
        X5F6y3mivXYay4IQn7sWRRQkKrhFfQ=; b=eNkGV25cySlfOHk1w3ri2TXPvFOFZ
        j7PBoisoudVwxia21WaepMTDA/3lVhmJdLvgxm0JVK+1OnaZiFbLpJsA0p45SxlC
        71tywHdiS7lBvPOKwyv0vnRFleknyN4QH1QkCMJ00FmUizzKBvSYElkGanOH2Qi1
        VAuqso4qYWmoGtFxoKFo/n6WlmPZRVxKUCiELd2bJawtkb10j4EDHsP2BFEWZoxS
        7dAblZx9siKkT/jCAn+i96xW6hiJgBzNt0PvNPN8k30r4IQ6fQQukXgAJDUo0IfD
        BBnie5YEQSXuAR2M4LYdGY7od/+GW94J7p3dkfMLqZIkze1oLsPXwBAPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2TSSMWRmw4rUSX5F6y3mivXYay4IQn7sWRRQkKrhFfQ=; b=oSaAX2hi
        DI1t149R+FnavpOfCIpO/qBpz1Uqxu1+1lN8x+X1i/xqe0wQPoz+pbqKj25Zsr9P
        GhBW0qCvBaCgLDzFlE0hGGWlxI3n82KEYhHjSEie2IONPsshEIkRy67ZbiVbnewe
        n053LE1TXrtvqNEebED1f+dXVF/TUleoqABVSnWHiYsgSRrrPSYPX37BxfDesVXX
        Z/e9W1rTaWWAruVFLrY0TudRxd3WzOmibaWPY8YzTLbLTjRd4iHJS3dGr+7Yoqi5
        na7R0KpLBs9qvPUVkihgvXL8woM6obfOcPBfr7Afwj5LYUGdn8PUuIq4UVLAekEG
        Y5d81jSq0KZ0tw==
X-ME-Sender: <xms:IYvOXr8ujK-OxybRRbuSju5QnHip0FOZHaegxFRfbxjcHAFjSBMASg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IYvOXnudubJ_o7BK9H8unlI8RazyGu5NnDreW0B86XVyOTk0lsmvXg>
    <xmx:IYvOXpDnSKtG54QY6TpwNfWruhxcesV_jPSpYcyAk-AaWYDq_65DQA>
    <xmx:IYvOXndkuQurDccQPZN5k0MhJZqZRfFQUhXn6QpdoNwDHLeFMC5n_A>
    <xmx:IYvOXhjUQDSXrVB_Fia-4pgn4BRc0gzoNZ7c5CeQSg8zDKWyuIuZhQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62A9F3062499;
        Wed, 27 May 2020 11:45:37 -0400 (EDT)
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
Subject: [PATCH v3 07/25] clk: bcm: rpi: Remove global pllb_arm clock pointer
Date:   Wed, 27 May 2020 17:45:03 +0200
Message-Id: <60c15bf9db6c54d36a60970cfefec8fa4a11d35d.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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
