Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFAC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AC2206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="WNTqREg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SuQ5Ms0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGZCxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:41 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49405 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbgGZCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 50F0458050B;
        Sat, 25 Jul 2020 22:53:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=mJuPaeFZ/TtUC
        wF3A6FAm7Kyf5fli2VKl5DI4MtgM7E=; b=WNTqREg2V1HmtJOPrziyiFG10Nzyr
        IH/X0U81dmphQGcSn4/JwMdSTqferhALQlOr+H5Yu7zyRiI+2hrtsvQs13ZAd00E
        pqSSnQ9jhpneaahWSa3bapwe/OEYDetDKy0RMxR4QQQOl6L/v/wwZf/QQ4Lz406K
        XUYZNDl83RpiDKTasC77vgzerLXtiIk6Y2ifMFtURIgvhcNsrE6RfLqusr7I/3oH
        EJyMO4cxAfRK7F8MAhz6TaicQyLVgjU2FrDaTArkE8XyLAfcKmhLmsn0NzK0yIGL
        m9HZsnSjGBrXv2onSu41wZermPlFrKWxKlm2RgG4YN+qGwjioxT+kom0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mJuPaeFZ/TtUCwF3A6FAm7Kyf5fli2VKl5DI4MtgM7E=; b=SuQ5Ms0U
        i9ozBbJUnIazU6JZ/2zoCAvoYyiJhDTg6bgWd2ugh0fWw3RsgU1TsaDRDkt0UICw
        PCGQ3nONZKPD4XhCG6qnpR6cL09LG9B2AuFGouzVZ9rHHe1S09BNouXNWpFkV27y
        LpY4KFIXssStn5bVvKXAcYYPWFhy7EtRgKKmsksZaFwXbo7kXG8agS+uoNqB1Z0i
        Ja98j2k5dr9azwgi8Hiq2I2mFUsSlk6EuNDimRGNelmPypBlWH+VXTa/PiZ+7HsQ
        VZLZLa54IxDeLio3L9tu7bgcRE8Zvx7pJmNSgdBf7l1XAlcBpCKkgLlwlP8vfI6Y
        iDIsBqweyXDuWg==
X-ME-Sender: <xms:M_AcX7TNm4SmwFX-l60DrJIIQ03UC7muRrmsLB-Ckqvvn7O2QbM8uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:M_AcX8xpDHMvdqSCfdlLtf5tzXmvXmZ_Cifq5xn4W5qCsQohHlHf9w>
    <xmx:M_AcXw2sxoolvxZmJcpu_W4XHsWtDq2IhuHJQSTaP2_jI1VEm1hrtw>
    <xmx:M_AcX7BbCryvX-sM5ZZc2Ev4xRoCTraFxTWNYT29qKQDBNOKFmgL_Q>
    <xmx:M_AcXwj_07HdimxH3-lEYAPYrc5qQC9oFnap59VWldwT7ln-EqXfTA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF3A3328005A;
        Sat, 25 Jul 2020 22:53:38 -0400 (EDT)
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
Subject: [PATCH v2 8/8] ASoC: sun50i-codec-analog: Enable DAPM for earpiece switch
Date:   Sat, 25 Jul 2020 21:53:34 -0500
Message-Id: <20200726025334.59931-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By including the earpiece mute switch in the DAPM graph, both the
earpiece amplifier and the Mixer/DAC inputs can be powered off when
the earpiece is muted.

While the widget is really just a simple switch, it is represented
as a "mixer with named controls" to avoid including the widget name
in the kcontrol name. Otherwise, it is not possible to give the widget
an accurate, descriptive name without changing the kcontrol name
seen by userspace (which should be stable).

The mute switch is between the source selection and the amplifier,
as per the diagram in the SoC manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 84bb76cad74f..a41e25ad0aaf 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -232,11 +232,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		       SUN50I_ADDA_EARPIECE_CTRL1,
 		       SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
 		       sun50i_codec_earpiece_vol_scale),
-
-	SOC_SINGLE("Earpiece Playback Switch",
-		   SUN50I_ADDA_EARPIECE_CTRL1,
-		   SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
-
 };
 
 static const char * const sun50i_codec_hp_src_enum_text[] = {
@@ -295,6 +290,12 @@ static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
 		      sun50i_codec_earpiece_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_earpiece_switch[] = {
+	SOC_DAPM_SINGLE("Earpiece Playback Switch",
+			SUN50I_ADDA_EARPIECE_CTRL1,
+			SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
+};
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -341,6 +342,9 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 
 	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
+	SOC_MIXER_NAMED_CTL_ARRAY("Earpiece Switch",
+				  SND_SOC_NOPM, 0, 0,
+				  sun50i_codec_earpiece_switch),
 	SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
 			     SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
@@ -462,7 +466,8 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Earpiece Source Playback Route", "DACR", "Right DAC" },
 	{ "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
 	{ "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
-	{ "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
+	{ "Earpiece Switch", "Earpiece Playback Switch", "Earpiece Source Playback Route" },
+	{ "Earpiece Amp", NULL, "Earpiece Switch" },
 	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
-- 
2.26.2

