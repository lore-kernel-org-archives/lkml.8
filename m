Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1367C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A97208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="zZIK4LeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VA4+Ixzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBXJJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:13 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35999 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgBXJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9F7F75E9;
        Mon, 24 Feb 2020 04:09:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=RA0maRjIFng70
        1n6PiOOHPmNpTe6VLKblsL5phqkTNA=; b=zZIK4LeCe85vxmM5YSQmORs4CZcLk
        NoiENbMpZdmhQ7XGc7STYfFwA56FFa7CSACCq1VblSNeiElaqpDvruyk+8JFlwQu
        pBkpXmeK90Pm8jEUJWTDoOnP8esh2UOqNl5W51+W7ubCi7wNz43+v3n7xBGh1tU5
        JGZAMMmpKf65uBHY3e6U1lpZCJ5y1LXHk8ZwYYG/QOUAfnlvcuuOJJPv467GBLXk
        rT3lwiXrE/JI+RrT7y/AW2cXc3eI179sPabpcCstBhypy/t4tnI09JTF9HmP9XYm
        364EsJkSMtHZGFS2Vl+Xx0LhcrRo5TUekDFa4U8o9Gz48WxI0XSk8hI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=RA0maRjIFng701n6PiOOHPmNpTe6VLKblsL5phqkTNA=; b=VA4+Ixzn
        qQMS1xdvHK4iRNwtvJqNhVE7N9xQAhhViFe5TJUrp/oSF8fo+JOKes728zrfpvTG
        zN0ulpI4TDTehmb92YGKet89UTgg4WXV5hcSt2HA/v2FV0b2i4B/G80kq0KqbdGX
        3yR9zsUX8MYe/DguFICfQo01R4aeX8KYCzfT1QNVKif6Q6mHsKHpbvCJFT5vxwRN
        uSopoH/8twU6mYn1Mip9nHpu/kAYmhOu1S3py8OgcTG+2dUOvxgoWXc4pGaIjMpW
        RhPEFlXHmSXjTlts54iPsx0BxD6xTc8/Kr6EGmeEWo7NTX4GeL0pVeaZnLHzoPav
        2EiqT9FgMFI9oQ==
X-ME-Sender: <xms:sJJTXl37Qy19Ptk--4nuKjM6l6iyHgTi-drHHrwDfk3FDoY_yfnFfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sJJTXgWKqFog-Wr7IJ0TtoEFuYzljs30luCokhzTIRhvRHe9nHo4Qw>
    <xmx:sJJTXg4vClpKbKlg4de-O_eWUsmVP5WRKuoPIN9-BbAf5krIVF69BA>
    <xmx:sJJTXnKmgxBHJT9SBWYF2o_-NgTRIpr5eLFsB4PyovBvPQ5t1lStTQ>
    <xmx:sJJTXgOzMOyQRPiH_h9pCsnoIT_j__5PfRmHO2hm9QCjux8aisdiTTAZNkE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC81F3280063;
        Mon, 24 Feb 2020 04:09:03 -0500 (EST)
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
Subject: [PATCH 10/89] clk: bcm: rpi: Remove global pllb_arm clock pointer
Date:   Mon, 24 Feb 2020 10:06:12 +0100
Message-Id: <3876f732b3fec2059270678d464d27b7d3a0414b.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 48cffa44db64..61a942f9a6a2 100644
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
