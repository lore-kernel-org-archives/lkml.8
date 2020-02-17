Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51FEC3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C1120857
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="kXVdPznz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4B7ifKsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBQCSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50507 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgBQCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9553E6D4D;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=TvxGeKL95DUEQ
        FtJT5t25lbcU/132qB0xo3CocqSt+0=; b=kXVdPznzFcExN/SIIPqeU92BqSWcu
        fYcOm++/hOCmqc6VKvjM33Hn5n8SZmnZt9V0KTuZz85eyA+lBGEBcZ05pgjyYba/
        waAAbfqp3BhAPx6Cj2hLONRkfpCu3TeGhnZ+wqmA5oSIQyc8iulyJ8fZO909d5a8
        6l4aLHwOKPqV0HJauTuBRP/gTaG+NX1ePj1VVg/1zLR9BjiDahE/U8c8zhzbztGA
        8PdMERYSPU9sxBaVMPTED2JqxxkhGpVIDkd3jIG+XWNoqALLWnD52InSvmm8hFla
        Pu7y+Jl8ACPeBFeYsgIuiRi4zbmNqso+m/xC66KERzfAfbC617jbtRlIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TvxGeKL95DUEQFtJT5t25lbcU/132qB0xo3CocqSt+0=; b=4B7ifKsN
        cTwfcy6VdxhutWRlhezhN1oOucwG+gGhJnIWjh4r1by44ClPxsuJZawvnL/GRzLx
        0P6HrZkug2ve8/YfgBaY8QG2J+i9pOAYX4WRpTNfEW818RkYWaPI5+E5beCcO9R6
        AJkAfp8rhCDIQqYqALRn2dCPmk0feudn6V5ZVTDqalZvI+1jTKJQTjIUfAZbkLGl
        2imNbes9Wn4VNBC2YluxjzjMjoyiBRqkE2fKB6uugeNprBY9j+ZNCgvDpgbi/vCn
        0FoEqeNiCyjQjZop8EIToLgO8U5Ozf3e2EX9Y/XX67+ln4MfQpbNZxhhnUsIMqAM
        DQUvz5Hz0nUCHA==
X-ME-Sender: <xms:6fdJXjkenJjPYb3qXX8a0yR3oCLWn8rrTYi1W8l0x21IFXdHi8sfXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6fdJXrEJUSmW8QlETiSnzzB3uuXI7TuvGLi6PUYlhTLIsLoQ9Z_Q0A>
    <xmx:6fdJXkoTDZWj53ml9iosylnncLSWGUQJZkvovKRMNsWqqwnn3RBb5w>
    <xmx:6fdJXv67HDkgq7Ox36kt3f2hBKw08N3zMkePhE8N0fAOiE-oJAVOjw>
    <xmx:6_dJXmX5XRlb6Zdz5tC8ZxP3gv-EVHrwLxYJ3IFSpRZ2iTPflDoK7g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A58203060F9B;
        Sun, 16 Feb 2020 21:18:16 -0500 (EST)
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
Subject: [PATCH 5/8] ASoC: sun50i-codec-analog: Enable DAPM for headphone switch
Date:   Sun, 16 Feb 2020 20:18:10 -0600
Message-Id: <20200217021813.53266-6-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By including the headphone mute switch to the DAPM graph, both the
headphone amplifier and the Mixer/DAC inputs can be powered off when
the headphones are muted.

The mute switch is between the source selection and the amplifier,
as per the diagram in the SoC manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index f98851067f97..176d6658d099 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -193,11 +193,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		       SUN50I_ADDA_HP_CTRL_HPVOL, 0x3f, 0,
 		       sun50i_codec_hp_vol_scale),
 
-	SOC_DOUBLE("Headphone Playback Switch",
-		   SUN50I_ADDA_MIX_DAC_CTRL,
-		   SUN50I_ADDA_MIX_DAC_CTRL_LHPPAMUTE,
-		   SUN50I_ADDA_MIX_DAC_CTRL_RHPPAMUTE, 1, 0),
-
 	/* Mixer pre-gain */
 	SOC_SINGLE_TLV("Mic1 Playback Volume", SUN50I_ADDA_MIC1_CTRL,
 		       SUN50I_ADDA_MIC1_CTRL_MIC1G,
@@ -264,6 +259,12 @@ static const struct snd_kcontrol_new sun50i_codec_hp_src[] = {
 		      sun50i_codec_hp_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_hp_switch =
+	SOC_DAPM_DOUBLE("Headphone Playback Switch",
+			SUN50I_ADDA_MIX_DAC_CTRL,
+			SUN50I_ADDA_MIX_DAC_CTRL_LHPPAMUTE,
+			SUN50I_ADDA_MIX_DAC_CTRL_RHPPAMUTE, 1, 0);
+
 static const char * const sun50i_codec_lineout_src_enum_text[] = {
 	"Stereo", "Mono Differential",
 };
@@ -315,6 +316,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_MUX("Right Headphone Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
+	SND_SOC_DAPM_SWITCH("Left Headphone Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_hp_switch),
+	SND_SOC_DAPM_SWITCH("Right Headphone Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_hp_switch),
 	SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
 			     SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
@@ -413,13 +418,15 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	/* Headphone Routes */
 	{ "Left Headphone Source", "DAC", "Left DAC" },
 	{ "Left Headphone Source", "Mixer", "Left Mixer" },
-	{ "Left Headphone Amp", NULL, "Left Headphone Source" },
+	{ "Left Headphone Switch", "Headphone Playback Switch", "Left Headphone Source" },
+	{ "Left Headphone Amp", NULL, "Left Headphone Switch" },
 	{ "Left Headphone Amp", NULL, "Headphone Amp" },
 	{ "HP", NULL, "Left Headphone Amp" },
 
 	{ "Right Headphone Source", "DAC", "Right DAC" },
 	{ "Right Headphone Source", "Mixer", "Right Mixer" },
-	{ "Right Headphone Amp", NULL, "Right Headphone Source" },
+	{ "Right Headphone Switch", "Headphone Playback Switch", "Right Headphone Source" },
+	{ "Right Headphone Amp", NULL, "Right Headphone Switch" },
 	{ "Right Headphone Amp", NULL, "Headphone Amp" },
 	{ "HP", NULL, "Right Headphone Amp" },
 
-- 
2.24.1

