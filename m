Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1181CC433ED
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2BD206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TpRjCvli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7dfIRQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGZB0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:26:03 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53081 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgGZB0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D362658015F;
        Sat, 25 Jul 2020 21:26:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gSnOotan3Mg6t
        HwoG/CYRCC0umOjvwli6asaDlT/n70=; b=TpRjCvlist/PVLSxjSy+81brTc8pP
        sg3I7eIVGbBHDsgGXUCTZDqAlsFCNv4vngP0jwLTN019NEDXwo3dPWUR1fQ9IK+o
        ymcYlyTv/iw3nVaFx7NhMUCFqKcxAw0/CzKU7IV4PewJ9iyQo1hyFTCuSmDFDWrF
        A3YLrtCEN/297KwB0ynTev6+SMkDvhB8pucWAFKnyTvBvEabN8kQwVut2plgR/9j
        wbU/17hSJ0jTv98achQ5DjVDdnleDIZe4SoYx1FPYGRSadPv3HubWgSQvG3ea6Gm
        Yt1zkV3uBdgi6+DQq73RKrmxV7akajuzM1xX2Fk9PIUNglXI4VRdnDTrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=gSnOotan3Mg6tHwoG/CYRCC0umOjvwli6asaDlT/n70=; b=o7dfIRQp
        u8vKykFQlz7ln0Y1PNLSOPMzRBr4szk/m1y8Z++7ojssOMc4FUeoFDOTW5qlSqyt
        IWYpumqlwNX92lUJK75jPLDzPFXkeVFYJP2+1WmZJ8rreX8TMcTl3KHDrED1qkmi
        gvWMcxyF36Y6YPG2TYklDaxwsDa2iiCP5t+rsKLJKYn0rYX5sE/yIipMRqk4XM91
        xfQXvViJaY7kmMCl9ZPD8U5xZqlbtrGRV3jOIs5Y4C4FHxskBGUykMCzuwTk7FGn
        qB1iLpRApUYWtanP3lDo6+KShrRhZMyrGxMIz7VlDw32/4SH4y4GFgbTwTBdmk2H
        X/UpHDHZ5MsbcA==
X-ME-Sender: <xms:qNscX8Lfq9K3NwYbTUuA7ZNAnLG60Koq-vNBX5c0XTQrYznKN5vviQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:qNscX8KtBOlNaKLWzHIWKEY2DUd5cqZHk0sDPMdiDk_mPoG0K1P3vQ>
    <xmx:qNscX8ufUs0kGI_sthDKn65juHJmJ0N1hsp4LzsRZtVB3jA56nDNVw>
    <xmx:qNscX5bXxUVwe_EfpABwUeNHX4YcFTpa4fr7Eq1bh9sxz2uUu9GiDQ>
    <xmx:qNscXxDVb3rKkV6ku7rgf5J8RpA7eIoTUnSRoTw9cmK9uncA78FBfA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 17B4F30600A3;
        Sat, 25 Jul 2020 21:26:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/7] ASoC: sun8i-codec: Add missing mixer routes
Date:   Sat, 25 Jul 2020 20:25:53 -0500
Message-Id: <20200726012557.38282-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun8i-codec driver provides ALSA controls for enabling/disabling
each of the inputs to the AIF1 Slot 0 and DAC mixers. For two of these
inputs (ADC->DAC and AIF1 DA0->AIF1 AD0), the audio source is
implemented, so the mixer inputs can be used.

However, because the DAPM routes are missing, these mixer inputs only
work when both the source and the mixer happen to be part of other
active audio paths. Adding the appropriate routes makes these ALSA
controls function all of the time.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index ffeac150c086..a75be9e82d22 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -490,14 +490,20 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 
 	/* DAC Mixer Routes */
 	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0L" },
+	{ "Left Digital DAC Mixer", "ADC Digital DAC Playback Switch", "ADCL" },
+
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch", "AIF1 DA0R" },
+	{ "Right Digital DAC Mixer", "ADC Digital DAC Playback Switch", "ADCR" },
 
 	/* ADC Routes */
 	{ "AIF1 AD0L", NULL, "Left Digital ADC Mixer" },
 	{ "AIF1 AD0R", NULL, "Right Digital ADC Mixer" },
 
 	/* ADC Mixer Routes */
+	{ "Left Digital ADC Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0L" },
 	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCL" },
+
+	{ "Right Digital ADC Mixer", "AIF1 Slot 0 Digital ADC Capture Switch", "AIF1 DA0R" },
 	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch", "ADCR" },
 };
 
-- 
2.26.2

