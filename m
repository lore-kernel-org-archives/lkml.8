Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD1C433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB82070E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="pfFh4ueo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+TZ/BQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGZCxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49205 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727803AbgGZCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A171B5804F6;
        Sat, 25 Jul 2020 22:53:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=R4wOLyBerCdsk
        WWpBq4a90wQHWbcAHkrC0l6Mao/Ahc=; b=pfFh4ueo3eQ97wv/M33CDFMLNvTXN
        sNsWRNnqcU6xA5BD/s4MJYSY0pamEMJcmicvBxiLczN90Z+J0QDVtqVXDCdaFDRR
        IGP7IciQXWA7zx8c6XMpp/wNAFqknPoOvTnQlczdTuSbPS5hHGmIlc549tV+2Av0
        TB/3bS9SjDHhuKtENIRKEuBCobwnCzlkNlT25tzP0ifNk36ZSSWYoqAu5uns4M6Q
        /403tUTIVILzKRNnpwGqEndxvVEb2Ctr2m5chiUscJJBple7zF7f+q9b4lXNbEgu
        vcGO664oBU6ThMHRZ1yGkZg1L7muWQx+inG2uiw0/nrOKKiMjS+cGFMpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=R4wOLyBerCdskWWpBq4a90wQHWbcAHkrC0l6Mao/Ahc=; b=h+TZ/BQh
        T+DEQnIuzPsLYxDDD82DlW3G5+cGHKgrK7HF9zZk7aSVEXRRZDENyi80UEQsrBfB
        8ohqznERdaKg9cFGLRrGrVJr2bSOS9yTNsjpP1YAbkcgYAiLUVsAdNwbxfUQZjth
        R7xiuWktV9zOTe3QdBRaJB0aqFTM5ypCW4pm34yAwRYB5KTaQBzRW2EG2dbOh7FZ
        cJ1lwsA1yhzric4njx7mBMBSuLTiD0A5hbMub03srVeuyhjteM01GBSM42ledXy4
        lQmhOghTfdjHTcMuIiSHVYj19CbaywjzMujHAiMjVlYJn9y2lEKYF9cPpKOicoyz
        rR51HhHFRE0s2A==
X-ME-Sender: <xms:L_AcX5cLYckrxRkVQV0p-8eoD466hk_aWtP5wuFZguZyLQExNthPPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:L_AcX3O15dfNRy7Evs61vTshyzGsa4swMkJljV18r4rdh-ZcQCOE-g>
    <xmx:L_AcXyjsN0Xwtwk8US6WQ3a9QgjqjyqY5srWuhqw_gHcPiZRtXwn4w>
    <xmx:L_AcXy_pvmDSXwTFP4mwTWhO7GbHtvAoABkJ3xlRJUx1_DRN9hhjDw>
    <xmx:MPAcX2-CQ-eBqOxhmggjIfET7yx0wmkUkPuIb_hjqMzsMmiUfJDbEA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58D9D3280060;
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
Subject: [PATCH v2 1/8] ASoC: sun50i-codec-analog: Fix duplicate use of ADC enable bits
Date:   Sat, 25 Jul 2020 21:53:27 -0500
Message-Id: <20200726025334.59931-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726025334.59931-1-samuel@sholland.org>
References: <20200726025334.59931-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same enable bits are currently used for both the "Left/Right ADC"
and the "Left/Right ADC Mixer" widgets. This happens to work in practice
because the widgets are always enabled/disabled at the same time, but
each register bit should only be associated with a single widget.

To keep symmetry with the DAC widgets, keep the bits on the ADC widgets,
and remove them from the ADC Mixer widgets.

Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
Reported-by: Ondrej Jirman <megous@megous.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index f5b7069bcca2..cbdb31c3b7bd 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -363,12 +363,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			   SUN50I_ADDA_MIX_DAC_CTRL_RMIXEN, 0,
 			   sun50i_a64_codec_mixer_controls,
 			   ARRAY_SIZE(sun50i_a64_codec_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Left ADC Mixer", SUN50I_ADDA_ADC_CTRL,
-			   SUN50I_ADDA_ADC_CTRL_ADCLEN, 0,
+	SND_SOC_DAPM_MIXER("Left ADC Mixer", SND_SOC_NOPM, 0, 0,
 			   sun50i_codec_adc_mixer_controls,
 			   ARRAY_SIZE(sun50i_codec_adc_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right ADC Mixer", SUN50I_ADDA_ADC_CTRL,
-			   SUN50I_ADDA_ADC_CTRL_ADCREN, 0,
+	SND_SOC_DAPM_MIXER("Right ADC Mixer", SND_SOC_NOPM, 0, 0,
 			   sun50i_codec_adc_mixer_controls,
 			   ARRAY_SIZE(sun50i_codec_adc_mixer_controls)),
 };
-- 
2.26.2

