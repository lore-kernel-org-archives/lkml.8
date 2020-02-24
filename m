Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08340C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D086620675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Hsi/CNGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1hX0lwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgBXJJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:16 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56853 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbgBXJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7B7525EB;
        Mon, 24 Feb 2020 04:09:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gP4ZomwnT/rYT
        hUc5YeZEWVSbIFozmkpYRrF/X/JJys=; b=Hsi/CNGiDj/goIDdZPwn9YgaqFeKa
        ukDp8TQKpiksGu8BwVGtJ20YskLU7xyz/I1VhJwk4nQaT/waOyoZcft62vofUNQS
        Kb4YIp2LjnjrqQZhyqtE5xYOxMOfPX8L2QsX0O+AVE7h32rCtyWFVqwyUvY8LTxP
        GRUAwt35Gfcig/MU2Z+rpuTnMdMltGpA+LK0IQCHm62lHQvpV2FpLTUkOKcXRTNA
        3vCs0Obj/0V++Wc8krhKMHUaVmq11d2zOT7wrd3Bsm316hqAcvgQNtcVTJSXnwz3
        MKflgG835aglmXgP0Jy9vLIm9oN8C3WM5/EuHaw2DfGlJSVwuHgfnwMEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gP4ZomwnT/rYThUc5YeZEWVSbIFozmkpYRrF/X/JJys=; b=L1hX0lwc
        BZa9/cpjf3pbZxT6EKzzOU+UYPsmTKOi6LaTS6l/mtyasQtji40Hy5AqjTp3bMIo
        gr/tXkfgeqQYkfUuXb3Ry/KN5N6SCzJw8b5JLpFf/wN0kG7g4oRUk2lQliudisri
        uU0kOE7r3xP7iNG7553APv+OEd3qRkVAiqWZXujKT4vxqvBYOYavTm801BKFwFPh
        zsQQnRh7OaYAQKdBFMYlkIcAR38DC7/fY8SLsIpLomrMMB9qdmiKvi5eHf/dfMwy
        X4quQHrodbvk9HQLkW2vIGWhYIogWb5jLd9miDy8f0G/MB3wlI8VU6dRMfKZzLPY
        UYYIVsjKpmpRVg==
X-ME-Sender: <xms:s5JTXlJYamnO5jVUee7wMXC8-W5427htvmeWFzPOVX_lGr6vmCqD3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:s5JTXhQnQWO7JyouFjpVcxGZc_V-AkgHZDG6ovAQ5Yaebp698uHi1A>
    <xmx:s5JTXrj5HyVmnz1P0s0DjHvP8fiHpDvVkk9esdwXzH7tucVWvalXWw>
    <xmx:s5JTXqrijeKRYlvggOKa5KSdu-YX1k68ZUpYt-SnsuP7VSt_kXN4hA>
    <xmx:s5JTXn30TvTDeYLAy6K5bBNHRl7HScVhOJ_eolFNYv0YS6J5jJkGAKUed0k>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8B1D328005A;
        Mon, 24 Feb 2020 04:09:06 -0500 (EST)
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
Subject: [PATCH 12/89] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
Date:   Mon, 24 Feb 2020 10:06:14 +0100
Message-Id: <703e21467f23f63acdac0e078b58040c39b852bf.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 783c8c5e5373..0c1d6c292302 100644
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
