Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7F620776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mKJOO2/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDP8NOl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgE0PrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:47:07 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34629 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389793AbgE0Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A9A28581DC2;
        Wed, 27 May 2020 11:45:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LSIsfiNq5IpAS
        JINyuaxA/q7xkNPFUcq7XPKpT78W2w=; b=mKJOO2/bAUXe1b1kiUFbNvhIia3FO
        xFI0szLda8wvBvsyVWRHyjWB+7LuB+/fge3TqBcCGpDGIjoM70HSh53bG0Vojebc
        NRzzr692PINjjsmIUxqGqqWGv7ybJS711/eaeZfxIVgAf3L5MAyl/dUhjTZ7LW1G
        zLgZxdCS+1QTibRQH0ycKtDpXJ++84JTiNA5oHYob+9FWmX2M+vzKokxqHib4txo
        Z4xMQtxwuBPDRhfbreu1+nP6g1gok7ndkCpk4JtVD0LhNfqcXEME0TuVm/R9C6sS
        RKz0Ag/Zj1dP551QDw9NmFzfdWwVoRFiU1C/caN0B6o1UvhTN/AFjMOPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LSIsfiNq5IpASJINyuaxA/q7xkNPFUcq7XPKpT78W2w=; b=mDP8NOl4
        b/upWAP7fi6qHQgsmL901ocbRkeRIy5quvNKYTrEG+jQ4nMi973cs8AryDw/IVLu
        a2rDtOw8bJdm4+4hrUx5hFMiTiNJ4TKnu9O9AGH2cs5Bp+eiZqmxhevxraLPZduq
        L94wGENQX0eIilqrOL2PL1FHv14ABcCu4TqeopPIbNKQ9tPkLNFWFcMZRSeq5flH
        kUpU1YW7IYG/EkL/SDVC5tBKAI+Gl67kGudQGiRAqKxT/6pheJ4xuB1qN+zbZVAx
        JrMAswsG63FUbeLnbJWO2KptpqaFDpPACGZK1Ua3lkqY2TcaRy8E7/tgDxOHmjmb
        RhfIEgy1UqW+HQ==
X-ME-Sender: <xms:HovOXrGWow-yut4TZNUArXeZMGGWuqeh80TIwotobhggYBQtBroKMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HovOXoVLLFOzJUU-uqZ7DonH8f2Y7pGKesrZ0A4PR6-lojPebV9q8Q>
    <xmx:HovOXtL9sSH11F9IG8-jCPSw_5lM-lztQW4tt-A10RGb2_K7Sopw2g>
    <xmx:HovOXpEqT6G3HUCYiteANiFHI86Tq3Y1Iu52ayht79UTGyB8X3-hjQ>
    <xmx:HovOXtr-A-03jTviwOXrggcGfc7rnT7ybkLI0KxN0OXtHz9-VRfFsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49BCE30618B7;
        Wed, 27 May 2020 11:45:34 -0400 (EDT)
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
Subject: [PATCH v3 05/25] clk: bcm: rpi: Statically init clk_init_data
Date:   Wed, 27 May 2020 17:45:01 +0200
Message-Id: <0a5615fe97082eafb44221164cdefba48d38e654.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of declaring the clk_init_data and then calling memset on it, just
initialise properly.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 8610355bda47..ddc72207212e 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -175,11 +175,10 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 
 static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 {
+	struct clk_init_data init = {};
 	u32 min_rate = 0, max_rate = 0;
-	struct clk_init_data init;
 	int ret;
 
-	memset(&init, 0, sizeof(init));
 
 	/* All of the PLLs derive from the external oscillator. */
 	init.parent_names = (const char *[]){ "osc" };
-- 
git-series 0.9.1
