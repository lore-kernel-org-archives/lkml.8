Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1870C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC271206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="csu6giCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0Uqd2BR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgGZCxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:39 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41487 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbgGZCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A0985580449;
        Sat, 25 Jul 2020 22:53:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=UYJXF3xSl7ipV
        0HUn2XdFBiDjB2DIQJX8lpSmrLgaWI=; b=csu6giCgLI37nW7y5wp5bo0lnQyLz
        /2LXD/sziBdl5MzMFK9kp3/OdjEcfoB6Mivanl5lVtODvuyN1Fm3+FqG4V1y9RFW
        jdcC+0gsQqYuqW7WqqlUeehGwpQHCkMyfFvuxAuiwdnb6GNmOb6KLIGw+ltE0R27
        e2i6I1T4+avr7TDGaCnhPPV798ZlnyF0qDrcRvro/uW6GTcuUwgxBVH8RJtkMSuO
        JR+h2fbiyIg2w0o5pHEyLf5r+HvlCkFkGRj/Gd8ZFAGaqYlTa3kzrK9W+kjaQ2VN
        /K4htkZxX7YaSIntm0sZJnA3jwcpLa8T/I7ZXjnqflY03GAHs4sbIgldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UYJXF3xSl7ipV0HUn2XdFBiDjB2DIQJX8lpSmrLgaWI=; b=p0Uqd2BR
        /L1EKqjGApnXl0vJon5q8YE3Ci8ORRowLJPl2M79vRKklqVyOtd9RvMLT6ZcEKvh
        MSuSJzSH1NCZEc5LSyTTwY7ear5OdQtTT7cn/J7AHGJ0GhlKUd7yqMMavVRdyYoj
        b5siLmaO2ehi/sI4ZLm/nUQhyN3a6/5kAfsKo5mSVLG3/kLjCW0e76jqBQLdRfP3
        jRKfqzpUiyzIMNTT/VAyE0Ms+huZqdUiIVuDtssxVovTE1irur4nHMKi0bv5bqLj
        CIZXxT2Bw4qZKn4wVncCkpHy4ScfgeULNQMpyA4otBbU8mb2zLZAkhYcwWKKGs0z
        QN36aXOPmDwT2Q==
X-ME-Sender: <xms:MPAcX7tj0HDGaitZrEgscfX36mdDi4-Lg0kxsfZT4Ctk49OxmwwMYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:MPAcX8eUrqTBJuXIioab-8NVccQlwhqM_Ry8D0bPsJdi-5VnUG89FA>
    <xmx:MPAcX-x61KhOaOeZ5vMC1mACA2RvklxaB4DqLWR3fTECE9bmil_xOQ>
    <xmx:MPAcX6PKWwf8zXyzLLvTEzn9hnI-jLpkZJRmZLwgvZXSQ5l6M2XbhQ>
    <xmx:MPAcX8PeEirb3iRscPekq7tURSU5nFIyJ8YE-sYx9xbrBpNAVcJGqg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFB23328005A;
        Sat, 25 Jul 2020 22:53:35 -0400 (EDT)
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
Subject: [PATCH v2 2/8] ASoC: sun50i-codec-analog: Gate the amplifier clock during suspend
Date:   Sat, 25 Jul 2020 21:53:28 -0500
Message-Id: <20200726025334.59931-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock must be running for the zero-crossing mute functionality.
However, it must be gated for VDD-SYS to be turned off during system
suspend. Disable it in the suspend callback, after everything has
already been muted, to avoid pops when muting/unmuting outputs.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index cbdb31c3b7bd..4ad262c2e59b 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -438,6 +438,19 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
+static int sun50i_a64_codec_suspend(struct snd_soc_component *component)
+{
+	return regmap_update_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
+				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE),
+				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
+}
+
+static int sun50i_a64_codec_resume(struct snd_soc_component *component)
+{
+	return regmap_update_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
+				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE), 0);
+}
+
 static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
 	.controls		= sun50i_a64_codec_controls,
 	.num_controls		= ARRAY_SIZE(sun50i_a64_codec_controls),
@@ -445,6 +458,8 @@ static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
 	.num_dapm_widgets	= ARRAY_SIZE(sun50i_a64_codec_widgets),
 	.dapm_routes		= sun50i_a64_codec_routes,
 	.num_dapm_routes	= ARRAY_SIZE(sun50i_a64_codec_routes),
+	.suspend		= sun50i_a64_codec_suspend,
+	.resume			= sun50i_a64_codec_resume,
 };
 
 static const struct of_device_id sun50i_codec_analog_of_match[] = {
-- 
2.26.2

