Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333DFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B1920720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TgYql2bk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2lTzgG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHaDtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41815 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbgHaDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D2FC0580544;
        Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=M0CdV6kHU/iX2
        H9POhKaJG2gciwsmAXpW0BjK/sUQO4=; b=TgYql2bk0GGBYtG0ReW0PxVoQZQMY
        ZCezA7GNb/AJEP16ZApl8+FrnpDWeGBrFVsqx5vcfdpe/hmpW97Wk29otX6S/P8E
        pt0zDm/n+YTXXncySyvRa5R5Jc1/UQkFUw+eYeFuNTCY/W2Z2R5J0Tu+CHXYNh8C
        z4wA7hP2cXDlDtR/2pDxKjRQUMemOj4ZfPKKrctKama58l/iIvIOOg5keI4TRlQV
        SoicAEws7VhKoeORTKrWIXwRZXLPwKo5NG5NYwmEIguZGyV8rTtEuzwaxkoJWVh2
        CeXT1Hp2oFY1WaKK+LKLLHdDphq0rsRtMjP32NemuAMUrzphlb/a7+BOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=M0CdV6kHU/iX2H9POhKaJG2gciwsmAXpW0BjK/sUQO4=; b=A2lTzgG7
        KUKWFXbhDTzRIrXxqZgZeqgB/N4+Q/mNHM40huBmY1N/bUZBaYk0+veHrBnVVMQW
        RnlMqHD28/3iBPMv3Y/OUCNq2NBgSnaw3dTZ6Y7Iaqufppek5pgjm3xVef/TGmTU
        fMnVqoIrPHJTUuAmGrKLSOi59+yFsVlfY8CqO8UkbjDROAyginyad2gjiIchnyfA
        ay8dAGAkqw0yjH0WEzejp7RAk7ZEUOfGU3FVlxzzTlmDyn2FT8H7r0jtrvVubuYQ
        Bb5HS/4eINc43NCUiul2/JSLt6g0nIRWEoobPIY+cuC6f5b5WbfR1fLfqkMKObMd
        XcFmhHG5XBKllw==
X-ME-Sender: <xms:JnNMXx7XVcWiPVW-HJQPqhUGdqLpaEVi5sJkuGhtjr1WxaLM9cB1rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:JnNMX-6nb8Bn7nX1m92MaIHUT2K6WcjHwYlwvlJen2BjD1Px4lXNrw>
    <xmx:JnNMX4esMms5601H4gVBr2f3OusumfxJzDGBzDz-2wiJJPROq62Eug>
    <xmx:JnNMX6Ir7I7yhssdMIudY25PbGLHnfUVwb3Ry0WLOdHrvOjwgkKe5Q>
    <xmx:J3NMX6oJ6wVHN7wtgNPhmsp-JopcMcq3_o0Itcpr13GQugbFMGMviw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 61C693280059;
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
Subject: [PATCH 1/9] ASoC: sun8i-codec: Remove extraneous widgets
Date:   Sun, 30 Aug 2020 22:48:44 -0500
Message-Id: <20200831034852.18841-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for the digital part of the codec only. The analog part,
including the microphone inputs, is managed by a separate driver. These
widgets look like they were copied from sun4i-codec. Since they do not
perform any function in this driver, remove them.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index e3a1347d7ecd..52ef0f9ec79e 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -455,10 +455,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST ADC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_ADC, 0, NULL, 0),
-
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Mic", NULL),
-
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
-- 
2.26.2

