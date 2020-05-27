Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F5B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WSN6uRto";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qzyt8NY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgE0Pqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:47 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59649 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389890AbgE0Ppx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA6D2581DE2;
        Wed, 27 May 2020 11:45:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=f/R5tcDXGnC0L
        EgPODfQACCnYjD2fbOepAi73Ul4TFY=; b=WSN6uRtoio4k4p3quFvI93ND21+OJ
        17faETKVw1rRtEVc1Yzc7PsFzL7WAc1039+FK3cV9riAudmUNoXsThAK3LKxO6E+
        svGVxeuk4Uk52Q5aXH4wZ736syi+sgNMUzHVAKuZAC+N2BavXhwsVHHLgEBwyAQn
        cmH4ZVOnWXNVoYAzhd0k3dfvr4neGjV9FpJT3k8yG4PWDCYFbGUDjBkHGW4LrOa5
        xq/1fwS4+iR40vJZOJq85jWBHOZMOoVlUFPwbNxR+UYH3MzjOjIcwovOettxj7Jz
        IqliylzJ6v9jTGz8ExGos2wbzozmRlcm7tT9EChVS458HDQ7V63XCyAxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=f/R5tcDXGnC0LEgPODfQACCnYjD2fbOepAi73Ul4TFY=; b=Qzyt8NY8
        Vdln1eR5m1i2RXYvsagPIaRvnQFdXyLtEa92iVNyeys/0nNlvi/cwlkv449IOpSa
        tnMxcXp2n7bHEo9PDtgarsvf7bkmyHjWpCcxeOaj/rhKe9bAsoG0Yr0csMhrv3Hy
        f+MXawRd0oZEjvOvv6F40uvncPxXNLD9H/0iG7DxNTDMdvlm8tAgWtkv3DheRcE1
        BdF/duizdmOHe7LPO0wbbw2Hk8da/3/Nep1ToN1WXG2Tk7HflRPL+H7kWHOuSoyR
        5LlBAoxKaynUomn53mXwKIxJzyfa4G5DtS+THm3r4/oD6YRt1f0DpaEdiF6WRcjo
        z9Mx2aicKmuoMg==
X-ME-Sender: <xms:L4vOXkOjtPlG7rnDCftRfTJlPCkE9adooKo4no7Gr7yRRkzXO9xtqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:L4vOXq_RUYCjQxV7MlaM8MVDgXbslHlZ7CvcZNjVkMLd1eB_umyyvQ>
    <xmx:L4vOXrTZ7Ss4Axv4SWuynSX2zVaGue-EnEfMREa3lxgliXO4k6jZfA>
    <xmx:L4vOXsvVsHQyGS1jhj2IpgdPiEvnCADM0yDTvKOofEDfqoFV42X-cQ>
    <xmx:L4vOXjyXVmCdnXHbQY09pFgDXlXTLt-9AZ3LbtgbddWN-MrdKWumXA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8952A328006C;
        Wed, 27 May 2020 11:45:51 -0400 (EDT)
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
Subject: [PATCH v3 16/25] clk: bcm: rpi: Rename is_prepared function
Date:   Wed, 27 May 2020 17:45:12 +0200
Message-Id: <31639df90c3b1e84bb1d24c07561916f5c448662.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
registered in the driver, but any clock exposed by the firmware.

Since we also implement the is_prepared hook, make the function
consistent with the other function names.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 3fce49a65a79..58ac1b104429 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -85,7 +85,7 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 	return 0;
 }
 
-static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
+static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -166,7 +166,7 @@ static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
-	.is_prepared = raspberrypi_fw_pll_is_on,
+	.is_prepared = raspberrypi_fw_is_prepared,
 	.recalc_rate = raspberrypi_fw_pll_get_rate,
 	.set_rate = raspberrypi_fw_pll_set_rate,
 	.determine_rate = raspberrypi_pll_determine_rate,
-- 
git-series 0.9.1
