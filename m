Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C52C7619E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F092922522
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="b6SQ2nVC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akmZViRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBQCSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:18:40 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59265 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgBQCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 91033666A;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=qsy1olLBe7as5
        13jXbvPlPLSJ8oPCY+55e5kCL9aFBc=; b=b6SQ2nVCdAGXiW9y+9JCfTj61yzof
        BsdKnBMclrlZ5LSBO4XaXN/X1IjCaGmQ9zuLWRorE0e0dwaUWdQ/RfBHXYw+ePry
        nVOWXzlRZD4qJ2sBfLd8L0VbzydYjZAdIk+M/xorMfU0o+zIpk3Qnc0DgPzTIdzv
        OfaQZUaYfqruMVPSQjLKKmF2CY/AjinLZSpIvnBPaiai4FDRJ5xG/GuK2uZfM0lC
        +I6ukiOUnGmrBRoB82qZ6En9LIkUKRXZcGDhRgpuFNBNazN1lzsUlyCuA8BJTg92
        l198Cr5p2fN3jZhsKP5WVUUF+jEY5Qh/ZfUYAwL9OyEAEgXlUe+i7XSHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=qsy1olLBe7as513jXbvPlPLSJ8oPCY+55e5kCL9aFBc=; b=akmZViRe
        8jfrq4bo6xVnqId4t5uIT65xVV0DUY2n714c4Ts1gpt8Eru5mAG2/xsqVHVekON3
        mW5RrZnwe7LtLSXEpla4zRuPEa+QmT/N9fzJbKSQ36hAqmX6ccuMUG7z4yds1plM
        +m/fdKDOhY7nWPddfC2HUbIJa4O/6BSXzPhfcA01TI1Hp1VaiFPQz9+YCs0zWi9z
        p4so3aI8avmrMr9Fw4xNA/LdGuKC4NqbRk4J939Oo/0UtI/xoA5rCFDsL78sSiaP
        A434Feysq4wF0RaO2ezTNqMaxlmZmZZ7smgdl9jKiz91ywKqXSfWrrelCihiIm3W
        mpL5YayWwnWwZA==
X-ME-Sender: <xms:5_dJXgpeghBmR5hz0Lamkv6wJoOeDT-Uo6jdiKmB0Xjy28Sias-gEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5_dJXt4PFp13T5qT4SZP7sk8J3KGMXb6xlrCaw3CC6HiOKZbZYvpCA>
    <xmx:5_dJXp60Va8uiVJyYeQw0oF_GdMcdL6Ugr9pbBNJ4V0LkukmtcgyHA>
    <xmx:5_dJXkm7x9YpN_FvZ6UtWtsYTDR7tjlgu5e3OJvHtdUbxPjSym2_IQ>
    <xmx:6_dJXrTcF6Hpa9dByCpIsLqOSwsmdI11lKAz088JzSbuzt0SPTCc4A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 315413060EF2;
        Sun, 16 Feb 2020 21:18:15 -0500 (EST)
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
Subject: [PATCH 2/8] ASoC: sun50i-codec-analog: Gate the amplifier clock during suspend
Date:   Sun, 16 Feb 2020 20:18:07 -0600
Message-Id: <20200217021813.53266-3-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
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
2.24.1

