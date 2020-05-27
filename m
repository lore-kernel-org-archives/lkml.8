Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472B020776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Gy93bWUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ND2sxfXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgE0Pp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:56 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35925 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389830AbgE0Ppm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DF910581DD4;
        Wed, 27 May 2020 11:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ljMPbD97vSXaP
        jP9T17Nb6L7wYve8wWAPEW/IGQNxV8=; b=Gy93bWUwMb6W3nSXKwuHD3T1rRJ7J
        qqPGv2KYhv/t12Peo6W2dksA+nUTDRl6Uiybs/F6N9gwj/GALm0X1uWLQncU91k1
        Cp9qCfTJqCq5apVV8VcBdIofEiJE0UB0d2SpwHM58NgFFpxZUxItclUo897GEHLy
        I2eUR1EpgObRDdPQTlq2n12NNJUwipJ17esQawguoqRvWpSRzsYFYBsJK1lBq6Sn
        j1Pbm6UdOahlkAtrvovmsoGNZK9B8bVthiPvv0/zDQG9PYReOgD8RoD8BxT1ZTBJ
        3tQLVv0+Af+mZ1huEUdg6m6w9HlTjNOTS8/vHp8HO7CAkpPNW4P4JgS+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ljMPbD97vSXaPjP9T17Nb6L7wYve8wWAPEW/IGQNxV8=; b=ND2sxfXV
        Ro5P0mpLlMAOAH+TPTR9XaWxRPQKW4Rvh1et37FDZ1MJwyURRMaqv/TsREH6zupw
        WmH1sEWjvRsNtcQPeGWO4yhKFNQjEgbAO5h8Cz2WsnJ20efxIoNRA6mgo8ot2xAQ
        TvacTs3I+Q7238Cw5uzeAm5QClBgz+EShTkafSZnTfyE+rgrrOc5TkjqYXLtDROL
        JXzYTuH2rxpu2x3mqCyg4UBFQVBoz7N/BITsA1P+tU2GCbtb+TCgBOLp8TMpPW6G
        2uCQ5k4iL6MaoOI6K866Mwiws6NNo6FB1LiDd13i6ie6wkuiwuK2Xt1H2THiTAEj
        f5Ek0E/yaK3TPg==
X-ME-Sender: <xms:JIvOXmekOxzNal1V0MA3xbfhvIpPjbaevlXeT_NExvEU9ehAUzz-jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JIvOXgOmA8TgLKB0pMI4VFLhUM7ercWuYGirRXH0UqXr17owO_cbzw>
    <xmx:JIvOXni52FiqOi5U_wQUOgmnizw9kVxiJ2OxSl_pt9YY44i90V7wFQ>
    <xmx:JIvOXj80bNqnkjSzptSfHvYf-VTHT8HxBZu8R8ofwvAtuyRNSe8dEw>
    <xmx:JIvOXgDwiIJoq7aE112sbL2W9xTptPDOR3ZSLzhMHNQZRX_8Lk7r-w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BD133061CCB;
        Wed, 27 May 2020 11:45:40 -0400 (EDT)
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
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 09/25] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
Date:   Wed, 27 May 2020 17:45:05 +0200
Message-Id: <03f94e7f32bdf303b26591eac2fb80999f4cc7d3.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index d62605861028..5a06c4991c7f 100644
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
