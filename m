Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70DC433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D886E206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UPc74rNY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIvw+fvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGZCyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:54:02 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36223 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727861AbgGZCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 634E85804FE;
        Sat, 25 Jul 2020 22:53:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=o4vewBk05R45o
        M+OvTaQj/HGmu35Pzpji2XDJh8Je4Y=; b=UPc74rNYonRFihpEhI/SoPPoE2OLf
        3AOMXp57DIeOVPYCX1WlM6gRAbVqx482EFpKwuLQnkEPg1Q8sCLVh6wBtvL1IX7p
        8CbK2M9oTbaKvPYj8ihWdZJDDtH6Hv16i3JKDz6EYQ6ZTWsPNo7UO915I2Ipasl8
        8coU1Md4Vs4WaF8FhUbDYPCp7TjxxKD/DLzAyweVtvD6QWYnT0dBL9VG5MD5AXPk
        rcwfDN/NphKNy7elFheXhBe8mL8dr6WXk3qxB0wMqIyFqNVbl0bkRz01QfFsipxA
        CF4C3uKShZwtGQkkH4Z4HkmklBe47fVwZ65kg8Bn79dpop7UymuuAMH+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=o4vewBk05R45oM+OvTaQj/HGmu35Pzpji2XDJh8Je4Y=; b=bIvw+fvT
        AVF01DPo42q4U6Z1YHQipuXJnLaKpINLoBkHu9xurylnZ3lf1hMsJSgRgWi4HHQ0
        2zUz+DdJ3kMjdePz+Roc1526vPYlW1oQbAfnT2oAJmWiIk2GXvqgkvtmK6tHEPMi
        9CQYp5O0R/ZjStagw6nj8kqe00hKokFHHLCeZBmqeufBXXLOxgN5MZSC2cDsKS/U
        oELJu8UepEySMo0I3Qu7TC2gcvYoZ3IN60qJKvPN01wqEn8hAvQ2GdpfeNGzZoq/
        WZfQWHb8WWn74+bRCcDGM/RxYOtDRz7XReBNZ32oj8ZYc/+Julj0xLlgH7+hiUUF
        jBq8+tPG5T7yvg==
X-ME-Sender: <xms:MfAcX5MXasn16JIcM4KEI_ovjZw-Wu3Fz1zHGNQUkkmccC93jp6n4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:MfAcX7831JAwFG5oi6PRXaNtG3NV3hrkzo1aMnn2oFHstkrSLtx0vw>
    <xmx:MfAcX4Su5VHXbtv8y43oph__249XTC9PPBdcVTcQDu1JJemabgvo9w>
    <xmx:MfAcX1tSKdhcZatclbPDREhdkeeEmOVfRZPtW2NzAsca-X7Dpvq7pA>
    <xmx:MfAcX7svR0O5hB8tv9GJHLAH9qVg6dsKCT1o8dzmAWMLExLjYD11iQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C357C328005A;
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
Subject: [PATCH v2 4/8] ASoC: sun50i-codec-analog: Make headphone routes stereo
Date:   Sat, 25 Jul 2020 21:53:30 -0500
Message-Id: <20200726025334.59931-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the hardware more accurately, and is necessary for
including the (stereo) headphone mute switch in the DAPM graph.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 17165f1ddb63..f98851067f97 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 */
 
 	SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
-	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+	SND_SOC_DAPM_MUX("Left Headphone Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
-	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
+	SND_SOC_DAPM_MUX("Right Headphone Source",
+			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
+	SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
+			     SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
+			     SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Headphone Amp", SUN50I_ADDA_HP_CTRL,
 			     SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("HP"),
 
@@ -405,13 +411,19 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Right ADC", NULL, "Right ADC Mixer" },
 
 	/* Headphone Routes */
-	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
-	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
-	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
-	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
-	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "Left Headphone Source", "DAC", "Left DAC" },
+	{ "Left Headphone Source", "Mixer", "Left Mixer" },
+	{ "Left Headphone Amp", NULL, "Left Headphone Source" },
+	{ "Left Headphone Amp", NULL, "Headphone Amp" },
+	{ "HP", NULL, "Left Headphone Amp" },
+
+	{ "Right Headphone Source", "DAC", "Right DAC" },
+	{ "Right Headphone Source", "Mixer", "Right Mixer" },
+	{ "Right Headphone Amp", NULL, "Right Headphone Source" },
+	{ "Right Headphone Amp", NULL, "Headphone Amp" },
+	{ "HP", NULL, "Right Headphone Amp" },
+
 	{ "Headphone Amp", NULL, "cpvdd" },
-	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
 	{ "Mic1 Amplifier", NULL, "MIC1"},
-- 
2.26.2

