Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52704C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3098320578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="p4neOYx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNFOIqGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgFOImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:47 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45869 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729177AbgFOIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8B1CE58014F;
        Mon, 15 Jun 2020 04:41:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+PQEhItmczD1S
        u8XNd9hu+fknO60RHPYY+kjCnpg8zw=; b=p4neOYx9SRaDGT/VZoJdWMxxxshhI
        I7mJSBzWIkue6xwAS/zeTJatrp30MgJ/98PIewPHSGNgJ88yOTxbDaFHHetxslJh
        lXFfsS+nlIXMZ1sDbdbML3GdRTfC3EmJcJ1fmaIygGg+mbJGEthagTEjOsOCMxG6
        tv3bDOJB2NsS0qeWgKgEU7wVbaVD2uHnYY01AJZpgnkqs+RmaE6Pm/Br8GhqOY6f
        RgUXpBrHPUOMB6XIplLxWU8FBouUUAR/1X83RXt3zr/tB66CWeh/QUXMH6VNzJvO
        GoLIca0ExoCk+qxQj5+c/+bZPhfs7ZdSMQSIJhKv0stLuUzv1QBa0XgMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+PQEhItmczD1Su8XNd9hu+fknO60RHPYY+kjCnpg8zw=; b=WNFOIqGz
        aXzCybrwTsA1kTAzgmDT2YYMfNt8ekR69r6TJDa2/DoJ7oXXfLaNyfiqOes7JlbJ
        5gbr36ejuFTrRZKD1En0tt/fRZo4lS9xK6i0nCHjC2VFg9GxsR2J9akifeJdMyfv
        KPUasckHB+hxhYSQa++jmEEOVnBHnYlfXlEikQDcW/vLxfc5/f2fOvIApuRp1L3k
        cF/AiCqNjrs27KtCYJuGSWTcC9sXr4I44gBk6xlwGtMzzaczfIB9319HNd3w374O
        hGcloyncC8af9IGaVEkuSlHgP6N7TH+XpcH6brRgWMxjiBQo4TpF8x72JwPoKTW0
        3tWdUPsJqMSk1Q==
X-ME-Sender: <xms:QzTnXnv-x5F9gKxyb4B8Daoc2yI0L9mCwFabt8XKoSz1QzkaDL5pNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QzTnXof4I0x1uKxJDhzSeTOKQ-1GZpkX5Ir-gXvi74qX1bPoAC-K3g>
    <xmx:QzTnXqxzbuK-B-kk93Jkubp2gkaGDcweXlrU0jMIVLdrqEmdxZL--A>
    <xmx:QzTnXmM0Z7RUApQ3Y4azNruw0V3K_f5ygLCFGj6HPXoqHRAGXn1CmA>
    <xmx:QzTnXuYzjpb6X8u-YaijHvOqaO_qChQhBag-TmF12eQM5hWMbr8OmA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A9BF3280064;
        Mon, 15 Jun 2020 04:41:39 -0400 (EDT)
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
Subject: [PATCH v5 12/27] clk: bcm: rpi: Use CCF boundaries instead of rolling our own
Date:   Mon, 15 Jun 2020 10:40:52 +0200
Message-Id: <d4c53dab6de5d5f70743d9c139d0117589530e62.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
