Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628FFC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A5206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="pjGLBhX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5mJfYrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgBQGok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:40 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60403 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbgBQGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88656522A;
        Mon, 17 Feb 2020 01:42:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=eKD/+XfScmpnS
        qlhCFWsXWiucNFzH6aj/knZgkkVSvg=; b=pjGLBhX2W4qKJ0ycJ8/5clEZvnbtD
        zYrp6sc7tE96elJ+GDWEEW9S6HjPLn8s0Wwy8yjsCD0G5Z4u12T3Ts/zlpYpW8TR
        DTJ4c1+t3CxrGEo+mSKJXWa/UHpcqbpWuDM75hzYPXW+cymYlI+8/+bqEmIVknUj
        +vuZxtxzrqThyO5i9Lrnk0kWPYMjkO/yuiVMMqK4K1pgGI1cDRHNCQK4BSO6RezT
        /YUGOFpKI1S/A/SE3hxOilsD9p1EYLdpkGNmHtdYRrEvLSrPB7drWDm2ocSF9OyP
        pZBf3vjGF3DvB3s0M8H/e/KILWQW8cmqRddfvcuy14r7w9+LOyGm+Mdlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=eKD/+XfScmpnSqlhCFWsXWiucNFzH6aj/knZgkkVSvg=; b=t5mJfYrP
        C1ac6eWjB+ssvZHhw5Y31KCY/YMC8QB35p4Pb3C4Upn4Az7UMoHAqzqTv8x8pPar
        q2FVGZwG+zt1qJviFpwvAKQo5N9BuFgiW9oliChFOuLiYsUqCvKAcLbVoHFvFP9A
        KbUKSd6RZQjbesK2YN3d1/SDY+nQ1TBxax34dcoGVXu5UYvF4aytk4ll9Assledj
        dlZf5PjdeqVIjebFf/arlZKyiTgXMpdxpzlK0f3vnQ4aIgGOabyZZA5JEkGsL0l6
        GL4nQUdQsGyDrQ1IAmjimJnz5aOcg25Q1nGR5R6YpV5YJpdCD3Fg4kNhgrUVl7g1
        IEQ1le0hq9ctSA==
X-ME-Sender: <xms:8TVKXnZkH370LRVYVjpEQGFA3gHUs08guuRy8DFCbMj1S-pnTYETuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8TVKXmULydfE0Y8aU_T76vjTNZpd-wo4htiuzHC6emp-t8jii-Gm5g>
    <xmx:8TVKXli286flikrxgFtDAwZkEhnWdrgGnjP83yGFvomsajdS2PU33w>
    <xmx:8TVKXikIgD6BoNClFg_itC-BJZfXiL_t0mPekxGEi63PZBFdNc1wlA>
    <xmx:8TVKXvmstRxWwOZdnT6J8wz7HbnjF5SWjq-vOPRpgafdBy27mktaeA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3585328005D;
        Mon, 17 Feb 2020 01:42:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>, stable@kernel.org
Subject: [RFC PATCH 10/34] ASoC: sun8i-codec: Advertise only hardware-supported rates
Date:   Mon, 17 Feb 2020 00:42:26 -0600
Message-Id: <20200217064250.15516-11-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware does not support 64kHz, 88.2kHz, or 176.4kHz sample rates,
so the driver should not advertise them. The hardware can handle two
additional non-standard sample rates: 12kHz and 24kHz, so declare
support for them via SNDRV_PCM_RATE_KNOT.

Cc: stable@kernel.org
Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index dca6f4b9d4b8..bf12f5199e96 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -86,6 +86,11 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 
+#define SUN8I_AIF_PCM_RATES (SNDRV_PCM_RATE_8000_48000|\
+			     SNDRV_PCM_RATE_96000|\
+			     SNDRV_PCM_RATE_192000|\
+			     SNDRV_PCM_RATE_KNOT)
+
 struct sun8i_codec {
 	struct regmap	*regmap;
 	struct clk	*clk_module;
@@ -515,7 +520,7 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SUN8I_AIF_PCM_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	/* capture capabilities */
@@ -523,7 +528,7 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SUN8I_AIF_PCM_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		.sig_bits = 24,
 	},
-- 
2.24.1

