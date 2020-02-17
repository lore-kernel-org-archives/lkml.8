Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0442C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53F206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="kNIOJ+rf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vynmf9ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgBQGoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:20 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40587 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbgBQGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:03 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 07EAC53D5;
        Mon, 17 Feb 2020 01:43:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=buZiaTnEqm5DH
        U8YzwhYJsnJNFjdJst45DN+p+GxpTc=; b=kNIOJ+rfmN1lPi0tn+TttrWHKN9L+
        L2bZVT62wMcFR4mz+K3SH0tPfI1MwpuYWTpri7Mbi9gCwihLBWmqw6SxuqQdTrxN
        t9b5oM9Agh8DNZ9VBjii219iQuJM7eoD23u3Ykc4GoyUuqCEqTNtk6MpOSOhFTli
        Xr6OMIyPBmQEjWQ7g8KfeyuTFqxgEGCrf4liMhjvbc0cqFCBBXk4hf6vN1cEmxVq
        zJ5xAH8JFVAHVXBusXcJsBFRJdzPppmrogb3PM9j6jbDy1Q8xriePcbffrpjFDaK
        5geWVYuQl2u8H0Hqfbd0kJZIECAjsfyRABsMA3DVteOsMxS5wEw57OnNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=buZiaTnEqm5DHU8YzwhYJsnJNFjdJst45DN+p+GxpTc=; b=vynmf9ZJ
        tbgAM9KDNydNd0H56cXFsSVp1aYVrV3map3U03rGp0vdUQf452wVPyLlgukvhwxN
        u2uFBAwNsN3nyRkC7LHn+lquFMrxelRS489PJvemEoFH4hgylwdRDcp/avYF7UuS
        5U8ZfVI8qRsGnE+Btr8kM5pRTnIO2grtOTw3k8A0Qkjp7OKWLez2Wm+540vpTyDx
        fFe7bolpakgdLN4FnEuVfz7zmPSx7HLd+Di7bOODELYIiyusXIZP+viPNbP537/J
        ZFICRpmFr1iC6Us/a5eULLO49tT6OZx++CJCr60vwgrOhoplBby1nd9rwMXYJidR
        VSdkDkA7pRn1sw==
X-ME-Sender: <xms:9jVKXoKLkxyCmdj47pjvko4CjxeZFYBGN1r0gPiqSPeAy8lnEJM7Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedujeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:9jVKXmpwh_GVvDt2Zjbo62aLRQjanGviCXCO7raOQ2V5zIYx8SJLrA>
    <xmx:9jVKXvg0XonRxLJc9HWPGk6_3Y69d1rqhhOfE3zufGIkXxKfgIW80g>
    <xmx:9jVKXlapudbBbQTDJ_whu2mpPmDJIwdsESuJ5Hrd510eXRumvvB5sA>
    <xmx:9zVKXicV6aP1V1KfsmtHCJ7paxetTOak3gbdthOLMykrsJwFHE9IHw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 463C8328005E;
        Mon, 17 Feb 2020 01:43:02 -0500 (EST)
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
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 19/34] ASoC: sun8i-codec: Support mono DAI configurations
Date:   Mon, 17 Feb 2020 00:42:35 -0600
Message-Id: <20200217064250.15516-20-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the correct clock rate for a mono configuration.

The AIFs have a bit that must be set for mono input/output.
Set the bit when the number of channels is 1.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index f8cde149a92b..2df899daec67 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -47,6 +47,7 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
+#define SUN8I_AIF1CLK_CTRL_AIF1_MONO_PCM		1
 #define SUN8I_AIF1_ADCDAT_CTRL				0x044
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA		15
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA		14
@@ -280,10 +281,11 @@ static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
 
 static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
 				   unsigned int rate,
+				   unsigned int channels,
 				   unsigned int word_size)
 {
 	unsigned long clk_rate = clk_get_rate(scodec->clk_module);
-	unsigned int div = clk_rate / rate / word_size / 2;
+	unsigned int div = clk_rate / rate / word_size / channels;
 	unsigned int best_val = 0, best_diff = ~0;
 	int i;
 
@@ -316,8 +318,10 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
+	unsigned int channels = params_channels(params);
 	int sample_rate, lrck_div;
 	u8 bclk_div;
+	u32 value;
 
 	/*
 	 * The CPU DAI handles only a sample of 16 bits. Configure the
@@ -327,12 +331,13 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16);
 
-	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params), 16);
+	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params),
+					    channels, 16);
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
-	lrck_div = sun8i_codec_get_lrck_div(params_channels(params),
+	lrck_div = sun8i_codec_get_lrck_div(channels,
 					    params_physical_width(params));
 	if (lrck_div < 0)
 		return lrck_div;
@@ -341,6 +346,11 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
 			   lrck_div << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
+	value = channels == 1;
+	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
+			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_MONO_PCM),
+			   value << SUN8I_AIF1CLK_CTRL_AIF1_MONO_PCM);
+
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
 		return sample_rate;
-- 
2.24.1

