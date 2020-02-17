Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B58C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB342086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hoqWU1mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJW1BZoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBQCS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:18:26 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51393 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgBQCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 988936D76;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=rZE5jshbl3oVN
        3i0+/l30LzdznQBowgsQ8ja5ppeVIc=; b=hoqWU1muNZelcwgOlCbeT9L4n5rCR
        Ohn1r90wQHvmG4wDlzgpczd0md0Pwm9dHAPiQV2BuD0SiycaA413v+HO3QKSqAKy
        hlTYHE+m2O6GBxKNOEYQr251XqvKer1UHiv03MpnHKrK4CnGrOSnKTyuBr/lZmRV
        nPpOdauXzU/sh8fmFnnHSqLR1OmhhDMlPs/p7n8UjbhVQU3gsjJasTrdruVgxEDd
        ajCxtbww+OQXWwa0XiTln0wMjQMo1f5aIgvj7cksVGfej7WjT6ZW/nd7IUhSAiEF
        rk4CBlitRt8AoMBDWs1jlEeENppd/4x/toflXgpc9I59jI3dlJh3oCjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rZE5jshbl3oVN3i0+/l30LzdznQBowgsQ8ja5ppeVIc=; b=EJW1BZoO
        h6QEndVtxj+KipqxkP5LB2i+xZXU+csYOMU7pLw4gWR6y2qCQnaMo02MHh4a35Xx
        VJEZ2TmTQnkvBcI4APVJRdlAyYOkHZrhUWM9nRi6d+R3nKSVt3gjfoAII49oooxB
        yO9Ag4N72/N18llH+eDZBrsxPcDDWurQ712XV+vTGQsRPP/FaSJUU3i1G/APX4np
        wgzMDCRtNyyJIPqpCnfz91MMQVj1zVM60o+H8gULcs5TjpY5ysre9iOkV/AHkStk
        FqEMw8PiAzMKycsTQzwubQSfUpae05WNEVc0bc9CoUnAixRLTMGAAoUMK1aYWZEE
        LMmqI7v85YKh2A==
X-ME-Sender: <xms:6vdJXtHTavFPOASuajjgaeRzrmiPyVksByFLs3BLSWfEM-5qfr1pkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6vdJXj4zJHrwOcMTT9QfePBqGmtiI8bYduxZJX7O1libaHFgk7zS-A>
    <xmx:6vdJXuYbJs8SoOA6Hr9_NJChDEJ_ewwTb-ipByL5u9agWLeS3bJo-A>
    <xmx:6vdJXphWUccKgvbt3VlAQfzNK0xJnAxsTNfpLsEDzfv84Xv3vuAnUQ>
    <xmx:6_dJXowvWCjWFhD4mWQWfWL_iRpqfjXm5T86dNUGM9pa0U-ftZK7SQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B0FC3060FE0;
        Sun, 16 Feb 2020 21:18:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 8/8] ASoC: sun50i-codec-analog: Enable DAPM for earpiece switch
Date:   Sun, 16 Feb 2020 20:18:13 -0600
Message-Id: <20200217021813.53266-9-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By including the earpiece mute switch in the DAPM graph, both the
earpiece amplifier and the Mixer/DAC inputs can be powered off when
the earpiece is muted.

The mute switch is between the source selection and the amplifier,
as per the diagram in the SoC manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 84bb76cad74f..6c89b0716bbd 100644
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
@@ -295,6 +290,11 @@ static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
 		      sun50i_codec_earpiece_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_earpiece_switch =
+	SOC_DAPM_SINGLE("Playback Switch",
+			SUN50I_ADDA_EARPIECE_CTRL1,
+			SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0);
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -341,6 +341,8 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 
 	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
+	SND_SOC_DAPM_SWITCH("Earpiece",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_earpiece_switch),
 	SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
 			     SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
@@ -462,7 +464,8 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Earpiece Source Playback Route", "DACR", "Right DAC" },
 	{ "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
 	{ "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
-	{ "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
+	{ "Earpiece", "Playback Switch", "Earpiece Source Playback Route" },
+	{ "Earpiece Amp", NULL, "Earpiece" },
 	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
-- 
2.24.1

