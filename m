Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6711420776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="A8Yr1qDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gX5BfnMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgE0Pq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41659 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389857AbgE0Ppq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E7A25C009C;
        Wed, 27 May 2020 11:45:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AjDg50eF8/fT3
        dIsJRXR7a1XQUYcZlWK28+/sYq4TL8=; b=A8Yr1qDAjGPEvcfBDVvSflFlkBROn
        HkHZVljyA/FdA/tSVwpCND7ymE/99oez/hacuPBPg8wOi9SFUngeKWpM7zCIgMRa
        pCU3Jf68Y7o+lBdG1bfzId+Ak1qMKOkk1zcurelnr3OIbxvNzZZG8kfUi5FNow+s
        rQ3b3+8PZfmEPIHUExcm6OfdeD3sNTGaJhw3tea+kbjmQBj4rq/mrSPfRnO5IWuc
        XiKN8POh8htKBeNhYQ2VNaz5n99PqmGD2M0LC/HJr2oOpl8l8FYNWTi3IBX6CbzM
        NGXMGNU3JLjQmyw5ZtE9SoSShLxylewO5B1sSaDZjslrkYWSYa+Nfddmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AjDg50eF8/fT3dIsJRXR7a1XQUYcZlWK28+/sYq4TL8=; b=gX5BfnMm
        5i1zEdKS2FFCmxBNXukmDlOTXyOrg6SS5EjniXZsNcpQfaHRRcDngpq2qZn3nDvQ
        qfZJBMZ04xjGkboaxofO12EcWS3A6tW6gBHYHCyLS34pRP0YWxSRPxOIvBZsrKXW
        xTDeh1E0qtxs216nypnIlKRD7nYnn6RSmKqUFTY+l1Not5mqUbZ35qkwiKROAus2
        MTP4NFiBWrdW15PYRopS0OMauw1jvV2jLEQUzcqeMuJKCPzNLcivOmrKKkFbZNNE
        sLjHvq52n6VOU8plIPQDsFEAsrUbrhdM9dGNGFDiUSQeQJ8LFihyTqwP72VxlBoK
        LjelHnLThy/R/Q==
X-ME-Sender: <xms:KYvOXuiNnCHZ2dvM80J3QMxBpLIk6Byyfpg5OtZy-EsUrOEcf6bshw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KYvOXvD3_EDkBsZTXziqYuUyBgDePE2Gk1lKTGOoTCe2nLxytDqn0w>
    <xmx:KYvOXmGJF5vSL7mplmM0FQmPvh7rxi3G_px3dES6dvZlWoppzBwxUQ>
    <xmx:KYvOXnQQwjaI9g1sKfxZpcqHefwF6Zf90U6Q6HWNahEsVlj6m4w-MQ>
    <xmx:KYvOXmrXehv3cRsmuhw-4URqKWCvaK4o8O9kEZ5os6RtO2LPN90PUw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F5343280060;
        Wed, 27 May 2020 11:45:45 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 12/25] clk: bcm: rpi: Use CCF boundaries instead of rolling our own
Date:   Wed, 27 May 2020 17:45:08 +0200
Message-Id: <eb1b2838f1c3c006c24bcb9816f75e1351c63b05.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi firmware clock driver has a min_rate / max_rate clamping by
storing the info it needs in a private structure.

However, the CCF already provides such a facility, so we can switch to it
to remove the boilerplate.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index a20492fade6a..e135ad28d38d 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -36,9 +36,6 @@ struct raspberrypi_clk {
 	struct rpi_firmware *firmware;
 	struct platform_device *cpufreq;
 
-	unsigned long min_rate;
-	unsigned long max_rate;
-
 	struct clk_hw pllb;
 };
 
@@ -142,13 +139,11 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 					  struct clk_rate_request *req)
 {
-	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
-						   pllb);
 	u64 div, final_rate;
 	u32 ndiv, fdiv;
 
 	/* We can't use req->rate directly as it would overflow */
-	final_rate = clamp(req->rate, rpi->min_rate, rpi->max_rate);
+	final_rate = clamp(req->rate, req->min_rate, req->max_rate);
 
 	div = (u64)final_rate << A2W_PLL_FRAC_BITS;
 	do_div(div, req->best_parent_rate);
@@ -215,12 +210,15 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
 		 min_rate, max_rate);
 
-	rpi->min_rate = min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
-	rpi->max_rate = max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
-
 	rpi->pllb.init = &init;
 
-	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
+	ret = devm_clk_hw_register(rpi->dev, &rpi->pllb);
+	if (!ret)
+		clk_hw_set_rate_range(&rpi->pllb,
+				      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
+				      max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE);
+
+	return ret;
 }
 
 static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
-- 
git-series 0.9.1
