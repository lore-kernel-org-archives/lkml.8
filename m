Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2829C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9474520675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MJAftrcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b44btDP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBXJJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:21 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59903 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgBXJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 550C35F3;
        Mon, 24 Feb 2020 04:09:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=k4Hi29ghrG4JQ
        tlhyZiPN5PiSDk2Gt5z3+0c/vRW2Ag=; b=MJAftrcZMyY1DD1GO0BTeFYfjJDjD
        utcSPShPIAVxU1RL9zdAZ9LvBI21X/IJrjq7TgFPZUjWDIIyKkUwXgfRcUDIRB44
        8s8Kyo6LIDlREzkXEDWyeRA2sIkX6oBzpdD7AWgVpKvIAzUuCXZ4cFFfsCRj3YZF
        3+u85KXqtR55Fp28+wYod8ALdEuu6ZKfBGq8PwLaI9nE6pAvpkzVRstovYso0u3b
        J/nsLrVpQdjZt8ht7JnyRcp4hzMdS2me/qXVcuRF7DFHGmav7qoO8SLLp3l9DeRK
        yfLpiwj16d1VIcnfzZlpU1lvOhBnCJKJxD5jsw6PUWnZvDTpUrf+4xOkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=k4Hi29ghrG4JQtlhyZiPN5PiSDk2Gt5z3+0c/vRW2Ag=; b=b44btDP5
        93gWjsAMI1gsy3de+Q+ZAAxu9hi3McZaN2oD3iwnUkhnBpVoT//zQztvALyhg4ri
        LcipPzKUvE8UkItIgAKtQZFvirwLARBmgW3RFYrAbokyHgXDvj76KQ4zv+MRec/A
        XDReBJUvxwDSx5bO2jd1oMIAgp7tkRAIW1KRQwm7r7U+VIN+wRKyIfNtRNQv3ex2
        PJ/87PXkkQVQ1CTmIUpJb1llhWnY0JCbV23dIBji0AvLnZTKc4QmADIUwYGC56c2
        Armp8BsosWSvasNrsjyiZKW0v8YEEv32JVJyWCG9kvOVWiuCiSlbPrsIkd7vohDU
        LSO2yHITSkkQkw==
X-ME-Sender: <xms:tZJTXirPO2Ve2Yg82zTnZMcO1vFD1sKbhG_8A-wKMrZJ6vU4LZ2HHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tZJTXjY9mWVOPCuPpcHi9_q4T0y4d1iwDs1BuU3P6w5Jxt2ggb8XTg>
    <xmx:tZJTXkEvYsRTQ-DGA_LGVJHP5uU78ZwAPW_a6wHlwdJF4PUb492MMQ>
    <xmx:tZJTXpY1Lb_79HaUorehnrUMu0WH2nLLXn1jzP2rlozSvSl7VsgNbg>
    <xmx:tZJTXqgPuZ_AvPCA3oefzntlq7YxAdTvycSvlDhACZDWphsW00cB2o_os1U>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 963F9328005A;
        Mon, 24 Feb 2020 04:09:09 -0500 (EST)
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
Subject: [PATCH 14/89] clk: bcm: rpi: Make sure the clkdev lookup is removed
Date:   Mon, 24 Feb 2020 10:06:16 +0100
Message-Id: <1779dd1489125be571fb3c2ee3e04c32f9875420.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkdev lookup created for the cpufreq device is never removed if
there's an issue later in probe or at module removal time.

Let's convert to the managed variant of the clk_hw_register_clkdev function
to make sure it happens.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b97c7ec61376..b8b55134ba3f 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -245,8 +245,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
-				     NULL, "cpu0");
+	ret = devm_clk_hw_register_clkdev(rpi->dev,
+					  &raspberrypi_clk_pllb_arm.hw,
+					  NULL, "cpu0");
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize clkdev\n");
 		return ret;
-- 
git-series 0.9.1
