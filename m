Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D1C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B183B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qg9BuVR5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FSWtlH0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBXJJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:07 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37709 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbgBXJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 3B5725D0;
        Mon, 24 Feb 2020 04:09:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=rQ9z3JDnGS1f+
        +roKHzhbrCbzlUT0lEu5PjHEQxG818=; b=qg9BuVR5FAzM2euH/IkvPtLOBE2ep
        P7/VyC2U7F9F6f4ZG0rScPxxIhaonni4EimEx7UCxkoYWr1TT5dqXzcVAiAxvDV8
        jEd6kwhp5lmufuAw34lV9w3vZtNCv3joddJYenrlJ6hObtTpt/lkIoFUuXSKs4rO
        SoyLLeMvTms8TPRJht+47Ewz/9eUVvLGefT7zOa5qD4FZImOseP6KAxzHR+Tjll0
        l8q+8CRrygs3iP/D1uyi8hplskCgN3xR47mYp7dElYetsDT4HgEDqboV86Rx5SPU
        b+zubbPMHjF1Qmt62DtsvAh6xIURb+YTBFttsgsK77c3TasJ+vPg1joMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rQ9z3JDnGS1f++roKHzhbrCbzlUT0lEu5PjHEQxG818=; b=FSWtlH0N
        lWUnUP3KHN1EIBN00dQuY9S1Tq9qb/0C3HFMi+e1CZClTB8arLEkjy2Db9nIoJH1
        ik5+5OoO6NjoZXqEGQBRGApK5/U5gdZlT4SsGwQrrIWDyG3wS/Bovixu6LDQASiN
        dIpDjDEtSOqv2q10jdB1HvQuJfMEvgpySNHaR77l2kUTwb+tzo29sH7FeJvjkfps
        utmcAdoWBgtsNNdRI9RN1BMj0oSEXxoKDV+FTURPkm3EeNR5kW2/k/N6jtRzmZ6O
        bPphhT8o4vKGzKsQBTEeAVTy0rNEJs96GJH40fTXSR6hhgE/8jlb6zfg7yf6b4w1
        nP5kx26ngJYyZQ==
X-ME-Sender: <xms:rpJTXsn8d_uX8Mw9kl53CScKZaJrvOLpOIX0-U0ylYNLL6w5wE_cBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rpJTXlKnbBqn53WOeXyX1jbQWAQt-8yAFyG75-9HxDJAsDHxEwaLCg>
    <xmx:rpJTXh65pKB3RuovxMQgx-QdCIBnGhH53-RA4_s9-THTDJkc9ccLAQ>
    <xmx:rpJTXp3kS59pszfzNrimUokfsBVSQmkRdh8bGrfOcX0DhG_WT-ATmA>
    <xmx:rpJTXoIJx-324ab2IubKFkLyuwgmVfIMvYQBrnwkxybQME_3TVhAp3AOZHE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7AB4B3060F9B;
        Mon, 24 Feb 2020 04:09:02 -0500 (EST)
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
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 09/89] clk: bcm: rpi: Use clk_hw_register for pllb_arm
Date:   Mon, 24 Feb 2020 10:06:11 +0100
Message-Id: <1c47c839fda93460994d37b4c851d805a3282d5f.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock is defined as a fixed factor clock with the pllb clock
as a parent. However, all its configuration is entirely static, and thus we
don't really need to call clk_hw_register_fixed_factor but can simply call
clk_hw_register with a static clk_fixed_factor structure.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 64fd91b5ffe9..48cffa44db64 100644
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
