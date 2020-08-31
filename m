Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E233C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3292076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hQeLlKHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dR80+nW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHaDtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:46 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54339 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgHaDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D37B558054E;
        Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=vuHoEqUnlx/Z5
        PQhy2y3P36C8JzS/AOw1EeZvaEYsUk=; b=hQeLlKHiSG0COlQZgbKfxOFyur2kz
        cmsCZtMbGoKELzwPleO74JqS8+3CGmaVLhuGLpxzGJ0uiXQ08AH/VIZQonMi5vgp
        kbsS0oykrS3cfhO+9Hp464wl0H0GmZmzropL4PCMeamaC5s0JAXtBEKxPJMpOfs2
        LrZDWgR6HkADTCsejkhg9Sxxyhl9CkSRlc2RMQPAP92YxjRVjSBlA3UxTnRJNYid
        hxrzjLA9k7TicD9FI9mBacok1xBPQ+hwIYM5SGDhxZCKCuRhgH8SPrejBtXEOAfA
        32inhhUb0HtEqyb1nreS2xTOUujWyZbe68uz96RDdKkntHIkStvc3xmpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vuHoEqUnlx/Z5PQhy2y3P36C8JzS/AOw1EeZvaEYsUk=; b=dR80+nW1
        hr11+rlosEOyNZhj89Hy9CSpvsPTXbNAoDi/rH1JTytVa5XvmrZJGbI8lGvzl7BS
        1IlL5kBYYfQ5hoAsIVkKthhhI17H/jc1xKtcaMitxdbOimWWHv2ujl2vRZ15v1ZR
        99Id81fmN7/bgKpZPmNG4jUoJkR0GzqxDo4h9sfmTkU7qFH6Xhe/sPa88uBxydvq
        2pC9xjYXHhGF47MZ9oW6nJW2NjxgIB3LidGWozai7RJcoQIgiqQUpgOuyHkY3P4u
        k1uZppDqMShHeAFO10saakNwFug0Qogq77th9thc4oBDFHdWuCe5QpjsCZBYeJ85
        g82fUPYwVONmEQ==
X-ME-Sender: <xms:J3NMXzRJ2Uxsm8o69iJZgZK93na29E9BPTf0UUD3PI2a5XEKZkTagg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:J3NMX0z_LswX-2Qojpu8r6d2Em6ndQmHr7dytuYu6Pq2udE2BqBnaQ>
    <xmx:J3NMX41T0WJT8YH2MnwTNvkdHt7LrY1Y4mjJpcNruTYYTmzbOZ8fmw>
    <xmx:J3NMXzCtELVjlbjMmo5GvV7sWUMcSTZnm6nIflK1XFJp1Lf55T1mFg>
    <xmx:J3NMX4j0xlaaZEUsuITrK0qJWeAPi84vxPmr-F8E4W-FApPnbRHqcQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1C26328005D;
        Sun, 30 Aug 2020 23:48:54 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/9] ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
Date:   Sun, 30 Aug 2020 22:48:45 -0500
Message-Id: <20200831034852.18841-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name should reference "AIF1", not "AFI1".

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 52ef0f9ec79e..263c1e7c3cc2 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -431,7 +431,7 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			sun8i_input_mixer_controls),
 
 	/* Clocks */
-	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
+	SND_SOC_DAPM_SUPPLY("MODCLK AIF1", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MODCLK DAC", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_DAC, 0, NULL, 0),
@@ -464,11 +464,11 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "SYSCLK", NULL, "AIF1 PLL" },
 
 	{ "RST AIF1", NULL, "SYSCLK" },
-	{ "MODCLK AFI1", NULL, "RST AIF1" },
-	{ "AIF1 AD0L", NULL, "MODCLK AFI1" },
-	{ "AIF1 AD0R", NULL, "MODCLK AFI1" },
-	{ "AIF1 DA0L", NULL, "MODCLK AFI1" },
-	{ "AIF1 DA0R", NULL, "MODCLK AFI1" },
+	{ "MODCLK AIF1", NULL, "RST AIF1" },
+	{ "AIF1 AD0L", NULL, "MODCLK AIF1" },
+	{ "AIF1 AD0R", NULL, "MODCLK AIF1" },
+	{ "AIF1 DA0L", NULL, "MODCLK AIF1" },
+	{ "AIF1 DA0R", NULL, "MODCLK AIF1" },
 
 	{ "RST DAC", NULL, "SYSCLK" },
 	{ "MODCLK DAC", NULL, "RST DAC" },
-- 
2.26.2

