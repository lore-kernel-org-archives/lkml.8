Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E18C761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA01208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="AZW+oQc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIPCmFZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBQCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:18:28 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43431 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbgBQCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B79BA6D7E;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zYX2qLatCNdpd
        Bo0QvRl91j/VbKbgJTqwWqJS1iqsak=; b=AZW+oQc5nfwi2kgFo4CgjayWx9kbs
        MYgu22ULF5nRmT+lYBNF+F3jDpmpn6eaWsOV3tMZleMnK2SbcOTUGf+OikWXNtfq
        wbkEatGPM+aMJXu4gSQR2mz03rloKZRSLbcAyjz14z74vZPIDsGFnFLx06FfmBkL
        iwODOFQBq/ipv8dx+jvtpFb2f1q/6PVk3PlUaVP2CVd5K+/26p6n3bC8tAzoiDQY
        gNIjXDdWIdr4FoxTCcg3WcaxRfC6ZmuhNwby8de9/Tnc9/jEH/fmlKbfUUtKWfyt
        qHhyDaQzLie3mzkDP9bACnLsQLFrIHHqX4H0r4zRu1eS0+/kUn+ru7+Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zYX2qLatCNdpdBo0QvRl91j/VbKbgJTqwWqJS1iqsak=; b=BIPCmFZS
        XYN7h6H76LULXxcJByy9dkq0jKfRjPLAORsMawqpORc1dxwWcZVcA90DN1KjgDpo
        9C3D7JDM0mHSlFQ8+pHb3DfMWsI8pgkQMC9Y50Eo1CASuWj4NJoclClCISsb7OT0
        0g0HLz8tam/yfNjldwT/qmb4tYH53HJZ7XJAmr3UFD78tulUwXSAvvbEeYTLIPeC
        mpFP/RNUn857s4oX7fDpG7eNp7IAJNF/tLzea37KzPaZCtT/S7wDsheWYwstwj9t
        A5D8Q+GY0WclecNuBjbyaTe02aWt9N12D6IP8DqhHlk5Hqkd3DTw0XUen3/xHyvJ
        B9LQuxmfNHBK/w==
X-ME-Sender: <xms:5_dJXrnb5_XxFkxr4SQtji45JG1wPKYpXhqZeZfVggsckIoaxtUTIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5_dJXkrWBUVsDJ57evoxkFp8L4C5WxtNRIiKeEVUuQNLYoZ6Xw5NMg>
    <xmx:5_dJXm_zuqEYOMJOgklZOXR29zZvQl8HtWsKrEYpO7Lvm3EyEsTd4w>
    <xmx:5_dJXt6lfkJpmjcD2Jj0CzBdE8DKXDK5uQ0ULXgDerz2LBqL40SwXg>
    <xmx:6_dJXrQvgWei-xVhcM1pqr2CT0Sm4e1cLMMAKDfcdF2aEOHMmS5AzA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6BA73060EF5;
        Sun, 16 Feb 2020 21:18:14 -0500 (EST)
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH 1/8] ASoC: sun50i-codec-analog: Fix duplicate use of ADC enable bits
Date:   Sun, 16 Feb 2020 20:18:06 -0600
Message-Id: <20200217021813.53266-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
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
2.24.1

