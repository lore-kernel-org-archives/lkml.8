Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8662C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958C5206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Y1kA1pm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X205fPC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGZCxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55455 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727854AbgGZCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E44A15804FB;
        Sat, 25 Jul 2020 22:53:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=EWGgSuNfoXkgq
        73IQIruj8n5iO5IxWJSFMyIpdf6H4g=; b=Y1kA1pm9VpCqZwlBktwKnD6axa3Oq
        Q1ONj7J2gFEhYCRyipaI1Y9n58YEq4eaBU7f3zQNfcqxP35hiBfinbX+6rC3MwZj
        aQT+yzHQUN6t6v1e/MloYiRhM41D0UCzpEc2Jkflz8yF9WPSpcFEGvaWzd7mkGqz
        eLisbtMthJC8qPeO16XMqzXFKZdQrIcuOMgtmqWt35LAqiQD2molzlg7jI0ZyRd7
        BK7ty1KL1/yTV8r+cpLN1dLEIhZjdqodSsPOxg7xz+krQShptyJBeJjxH2rb8DWS
        4pNxUOo0Z2dy8oIfzv5M13F1zflHyPW8u6FwrCi0o6fkyTmfNiLd68VFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EWGgSuNfoXkgq73IQIruj8n5iO5IxWJSFMyIpdf6H4g=; b=X205fPC6
        bdNXcUJh0SJ0W7HkfEApXlXJYQxoxrZX0NCu7G6iAliSh5/UlLH3PJO3LBUM0joF
        Xv4M4q8ah4A/dRop37BQTNDAxf/frKzOOa6mo9G39aUBvNcVG3nYwrTE44IBqKqg
        dWlBl7oFhpfSl9KfMxE2o5PF3Sb7MkYOH4r5DU51G3f8Ku1JxLoaTP/PNhvG5MA3
        RCUnUC+ozbCZtl64PJNQVd7ewqq0PwwdWd6Sdj3NC1V7SC0G6tGwRFWqdhq8BgzA
        er97+NNd9aTkC6/wMvVqqGtA39mn31DhIbgXz7IWDMnr4OW3XL87C5rmgDTDDdS5
        aYzafxk7KFFsaQ==
X-ME-Sender: <xms:MPAcX1RZ5kxNOqioW9U3p6xbMKaxj7rHtMVtKRfRxsyl4OQf0CTTPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:MPAcX-ycuyt4BzL5Ck3D4Z27q3kBG-kprR1TQt59Gy3d87sLY11yMw>
    <xmx:MPAcX60wznZ0zwjjZZ7TyL-FoIVRYuICOwfXW_C1Sf1A64wf2irzQg>
    <xmx:MPAcX9CT5f-2Bpyzgfnu9fRmNpamGj7oVbTXD46sF2FGAxkhtaJflw>
    <xmx:MPAcXyg6Nh8JBEV4Dkfr-h2NpTIEcZ_2Bnfnxhli6qkAHsbsAuqiNg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50AFD328005D;
        Sat, 25 Jul 2020 22:53:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/8] ASoC: sun50i-codec-analog: Group and sort mixer routes
Date:   Sat, 25 Jul 2020 21:53:29 -0500
Message-Id: <20200726025334.59931-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the controls in the same order as the bits in the register. Then
group the routes by sink, and sort them in the same order as the
controls. This makes it much easier to verify that all mixer inputs are
accounted for.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 58 +++++++++++++--------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 4ad262c2e59b..17165f1ddb63 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -121,50 +121,50 @@
 
 /* mixer controls */
 static const struct snd_kcontrol_new sun50i_a64_codec_mixer_controls[] = {
-	SOC_DAPM_DOUBLE_R("DAC Playback Switch",
+	SOC_DAPM_DOUBLE_R("Mic1 Playback Switch",
 			  SUN50I_ADDA_OL_MIX_CTRL,
 			  SUN50I_ADDA_OR_MIX_CTRL,
-			  SUN50I_ADDA_OL_MIX_CTRL_DACL, 1, 0),
-	SOC_DAPM_DOUBLE_R("DAC Reversed Playback Switch",
+			  SUN50I_ADDA_OL_MIX_CTRL_MIC1, 1, 0),
+	SOC_DAPM_DOUBLE_R("Mic2 Playback Switch",
 			  SUN50I_ADDA_OL_MIX_CTRL,
 			  SUN50I_ADDA_OR_MIX_CTRL,
-			  SUN50I_ADDA_OL_MIX_CTRL_DACR, 1, 0),
+			  SUN50I_ADDA_OL_MIX_CTRL_MIC2, 1, 0),
 	SOC_DAPM_DOUBLE_R("Line In Playback Switch",
 			  SUN50I_ADDA_OL_MIX_CTRL,
 			  SUN50I_ADDA_OR_MIX_CTRL,
 			  SUN50I_ADDA_OL_MIX_CTRL_LINEINL, 1, 0),
-	SOC_DAPM_DOUBLE_R("Mic1 Playback Switch",
+	SOC_DAPM_DOUBLE_R("DAC Playback Switch",
 			  SUN50I_ADDA_OL_MIX_CTRL,
 			  SUN50I_ADDA_OR_MIX_CTRL,
-			  SUN50I_ADDA_OL_MIX_CTRL_MIC1, 1, 0),
-	SOC_DAPM_DOUBLE_R("Mic2 Playback Switch",
+			  SUN50I_ADDA_OL_MIX_CTRL_DACL, 1, 0),
+	SOC_DAPM_DOUBLE_R("DAC Reversed Playback Switch",
 			  SUN50I_ADDA_OL_MIX_CTRL,
 			  SUN50I_ADDA_OR_MIX_CTRL,
-			  SUN50I_ADDA_OL_MIX_CTRL_MIC2, 1, 0),
+			  SUN50I_ADDA_OL_MIX_CTRL_DACR, 1, 0),
 };
 
 /* ADC mixer controls */
 static const struct snd_kcontrol_new sun50i_codec_adc_mixer_controls[] = {
-	SOC_DAPM_DOUBLE_R("Mixer Capture Switch",
+	SOC_DAPM_DOUBLE_R("Mic1 Capture Switch",
 			  SUN50I_ADDA_L_ADCMIX_SRC,
 			  SUN50I_ADDA_R_ADCMIX_SRC,
-			  SUN50I_ADDA_L_ADCMIX_SRC_OMIXRL, 1, 0),
-	SOC_DAPM_DOUBLE_R("Mixer Reversed Capture Switch",
+			  SUN50I_ADDA_L_ADCMIX_SRC_MIC1, 1, 0),
+	SOC_DAPM_DOUBLE_R("Mic2 Capture Switch",
 			  SUN50I_ADDA_L_ADCMIX_SRC,
 			  SUN50I_ADDA_R_ADCMIX_SRC,
-			  SUN50I_ADDA_L_ADCMIX_SRC_OMIXRR, 1, 0),
+			  SUN50I_ADDA_L_ADCMIX_SRC_MIC2, 1, 0),
 	SOC_DAPM_DOUBLE_R("Line In Capture Switch",
 			  SUN50I_ADDA_L_ADCMIX_SRC,
 			  SUN50I_ADDA_R_ADCMIX_SRC,
 			  SUN50I_ADDA_L_ADCMIX_SRC_LINEINL, 1, 0),
-	SOC_DAPM_DOUBLE_R("Mic1 Capture Switch",
+	SOC_DAPM_DOUBLE_R("Mixer Capture Switch",
 			  SUN50I_ADDA_L_ADCMIX_SRC,
 			  SUN50I_ADDA_R_ADCMIX_SRC,
-			  SUN50I_ADDA_L_ADCMIX_SRC_MIC1, 1, 0),
-	SOC_DAPM_DOUBLE_R("Mic2 Capture Switch",
+			  SUN50I_ADDA_L_ADCMIX_SRC_OMIXRL, 1, 0),
+	SOC_DAPM_DOUBLE_R("Mixer Reversed Capture Switch",
 			  SUN50I_ADDA_L_ADCMIX_SRC,
 			  SUN50I_ADDA_R_ADCMIX_SRC,
-			  SUN50I_ADDA_L_ADCMIX_SRC_MIC2, 1, 0),
+			  SUN50I_ADDA_L_ADCMIX_SRC_OMIXRR, 1, 0),
 };
 
 static const DECLARE_TLV_DB_SCALE(sun50i_codec_out_mixer_pregain_scale,
@@ -373,24 +373,32 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 
 static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	/* Left Mixer Routes */
+	{ "Left Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
-	{ "Left Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 
 	/* Right Mixer Routes */
+	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
 	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 
 	/* Left ADC Mixer Routes */
+	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Left ADC Mixer", "Mixer Capture Switch", "Left Mixer" },
 	{ "Left ADC Mixer", "Mixer Reversed Capture Switch", "Right Mixer" },
-	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
 
 	/* Right ADC Mixer Routes */
+	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Right ADC Mixer", "Mixer Capture Switch", "Right Mixer" },
 	{ "Right ADC Mixer", "Mixer Reversed Capture Switch", "Left Mixer" },
-	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
 
 	/* ADC Routes */
 	{ "Left ADC", NULL, "Left ADC Mixer" },
@@ -410,16 +418,6 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 
 	/* Microphone Routes */
 	{ "Mic2 Amplifier", NULL, "MIC2"},
-	{ "Left Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
-	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
-	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
-	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
-
-	/* Line-in Routes */
-	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
-	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
-	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
-	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
 
 	/* Line-out Routes */
 	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
-- 
2.26.2

