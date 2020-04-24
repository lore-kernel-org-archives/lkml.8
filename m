Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E44C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HI6HOkm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jltMhk+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgDXPff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:35:35 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:54303 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728006AbgDXPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A328610A2;
        Fri, 24 Apr 2020 11:35:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Q0xQzta3vxRt9
        2eurDQl3ATU7iLBuCrEm24XOmSc6qQ=; b=HI6HOkm/s88oA5lwX5uW0iVmly7Iw
        85uq3muY7TgJ9pvKB7AxffHtTocCHjszXXWpI3DDr0319xLBnkN4NrXXBCn/Klpc
        Bg6PUyCiWWGtiM+4b+nCJLWIDVD3btTWokcObKjojaX2jSqCVm05tAeyJeRK/67a
        jYoWEz4K8BSOkM7obUyT8mR7ntJDT/3AJJaB90Nt0la/cDwka4JOH22TUi2McnZg
        9o6YO3FlJO2P+yM5tCDzNZk8YxnI3DD/quUFnRp0ffhy0gfFyj/C1GUV5UN+utj+
        WZDzkL+ozLxIVlej+m+d1p9vGyCLwT7S4BTAJQxFopK6WFnscDUz+wn1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Q0xQzta3vxRt92eurDQl3ATU7iLBuCrEm24XOmSc6qQ=; b=jltMhk+G
        i2j1aDMk24Tg8Um7bnmTKj3pY1rhSU3JXnwqHk42qjQOrecKRlk7ZEsYUdFgxPLz
        tH8ulNAyxe7NA5n0rI50StjYhhTNKDay07HuVYWkzAiV8zbzPXMyf+YZmfw6iO41
        44lXElw/wO9TmN/rFrj6UhJo+UAEMB85NcIM+F6v6LsvILTF8A7Ll+x7jditXtnl
        s8wuZWy+7DENR2/fdMGm2wrTpKqSBA+IdGFYtF7Hew0+y1hJBXme/1ScIBUSi65Z
        wZNudyLx/pWd8cDt3zC9Mf5olD9y0wq0E0ap+KA0c4vzKi2IImfGMklh/x+NohBE
        pKto42cGbZ6Jxg==
X-ME-Sender: <xms:QwejXtfuqhfefUxIK_PlX-0CVQ6JP6-dD2llwPSfBdd1tgMM89d5_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QwejXsII-OBLCgCNSDhMvhLsFQqFWsTRxRchY8T_L6GGbNLNYpTTNQ>
    <xmx:QwejXuZR3uZQ175TbihAxDbzC2u4jCbINTtK0-8CROqAPZD5_73Dvw>
    <xmx:QwejXsbU1qo4ZnuUJs85o9Q6XRaRgZyeZYkMlW4LnacL_bIre8qQZQ>
    <xmx:QwejXkkz8v_y9DuWSr8iJU0HF-Y0CQVvhf16QBK0V7xwRo2Z4RBvt8863Yk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9BCA328005E;
        Fri, 24 Apr 2020 11:35:30 -0400 (EDT)
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
Subject: [PATCH v2 06/91] clk: bcm: rpi: Statically init clk_init_data
Date:   Fri, 24 Apr 2020 17:33:47 +0200
Message-Id: <eeae1a92da7812f04a034498d3a1cb60e282fec7.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index aedeaaf2f66b..b6d2823c2882 100644
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
