Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F69C433EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD49320700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UCMep3/v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jl1VQu+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgGZCxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:55 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52961 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728292AbgGZCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5B0A4580500;
        Sat, 25 Jul 2020 22:53:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ERAIJp5xBaLI/
        ZcZmq1IesLhocpBhAj61ykp0NYJOa4=; b=UCMep3/vYhc63V/s/TI9Js1vSx2DE
        wRutsQ8k4Uwx39LHKb6utjKHql8UEPM+E/T4iA9/xprafe3lel9+ZWVSTGLov8KW
        6sBV8N5dWpqprIhBo8XCzlJkDCzppVyIa81GTu6A5lxPnLGBldivEolU1TezY/At
        4F7w4DLP6D81KXnBhpXMM12WRkCrvzDYrczmsi9jSk6RKR008kbL9hCIfUTGaOOz
        R8knBzMu7DDzTeC+NxQ0cdiWKYou5Dz3JALjrw/oSWe0lfx01vpCFVmOK5bGQIuq
        cfnX9fc7LUEq31oquqcClhFZVrweE+HYBnvBxcyppFF8cMo1hEVdqdT/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ERAIJp5xBaLI/ZcZmq1IesLhocpBhAj61ykp0NYJOa4=; b=jl1VQu+F
        6eC4RDrWGnfpzVg8Z+3kTTJKelnwKTyk2gdQbqsfpPTAKFgm8A3dr8f5Zg4CC9Ko
        kOHHONqtcweYl4JkYVs4AyGQg3M0WBE2W0vrOVShy+ikuiELow6+l0PbP/RseI3d
        n2C28Tm0OjgsW2wibPbgzUlS9A2cllBkwgVfNfj2JAdTFXKva49AQL2ThKbQsnJS
        8pcy/B1/HZk9B51bvaDL5wwKESJp1+swLrjrD5HCaKpr4gnhbjk5lW7B9DZw9Jqk
        usiOyiKtCHDimxRlbv80XEWmJ2zCEHusb51w/aQvoXra11S73mgW/4Ljf3gMViL7
        mAPp8i1pNiKvHA==
X-ME-Sender: <xms:MvAcX6DsMRJEbHu-tG6j_cJONnfTqptWihe_N7yD_iXrJze5h0SxLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:MvAcX0icT8X4aSilTgKNJP4MYWPk4I_-JkqFhoXghFaz9jTS4HgxyA>
    <xmx:MvAcX9mSDgMFEyP5y5EKbgiapmBSFmj-jy9aqG1-_pgEjvG5LjgW9A>
    <xmx:MvAcX4zoEjj547Zps2EmhjB3F2NxztkHst2FskU2A1_yjcEffGZssw>
    <xmx:MvAcX4TIeHuMtIr86JYcNuPfnHKIB7sXCxu-DIF9M9Jgjsxft2qvmA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA55F328005A;
        Sat, 25 Jul 2020 22:53:37 -0400 (EDT)
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
Subject: [PATCH v2 6/8] ASoC: sun50i-codec-analog: Make line out routes stereo
Date:   Sat, 25 Jul 2020 21:53:32 -0500
Message-Id: <20200726025334.59931-7-samuel@sholland.org>
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
including the (stereo) line out mute switch in the DAPM graph.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 176d6658d099..df39f6ffe25a 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -328,7 +328,9 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			     SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("HP"),
 
-	SND_SOC_DAPM_MUX("Line Out Source Playback Route",
+	SND_SOC_DAPM_MUX("Left Line Out Source",
+			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
+	SND_SOC_DAPM_MUX("Right Line Out Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
 	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 
@@ -439,12 +441,14 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Mic2 Amplifier", NULL, "MIC2"},
 
 	/* Line-out Routes */
-	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
-	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
-	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
-	{ "Line Out Source Playback Route", "Mono Differential",
-		"Right Mixer" },
-	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+	{ "Left Line Out Source", "Stereo", "Left Mixer" },
+	{ "Left Line Out Source", "Mono Differential", "Left Mixer" },
+	{ "Left Line Out Source", "Mono Differential", "Right Mixer" },
+	{ "LINEOUT", NULL, "Left Line Out Source" },
+
+	{ "Right Line Out Source", "Stereo", "Right Mixer" },
+	{ "Right Line Out Source", "Mono Differential", "Left Line Out Source" },
+	{ "LINEOUT", NULL, "Right Line Out Source" },
 
 	/* Earpiece Routes */
 	{ "Earpiece Source Playback Route", "DACL", "Left DAC" },
-- 
2.26.2

