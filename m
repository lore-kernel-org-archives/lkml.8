Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E5C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708B5207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="truARi95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCUBBvrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGZB0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:26:05 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57475 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgGZB0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82165580161;
        Sat, 25 Jul 2020 21:26:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=92seWwiwyDFZb
        JFzQ9d3eHcie01wHXdtRt1sWd8bW4k=; b=truARi95xImcb2fRj1hjIyQrtpHZ3
        QKo8JEn5Cqwa6NnKOpf9QykGuRdWK9FvyMQHmgQDNui2PsinxXWnJbSubrQfmXbA
        VIW3Ug+OXmzHaaUDiK9/njsUSNWkSWcxGrNsyFY8H5S1de4rtyRoMqPCdXsjw1+S
        nQBvYFqVRMvkM4z6VMSJMW5f49oWxMNu+JemvgKGDhM3jro1rWu/rMJ8oQ6kZBn4
        Q2ggHplJ0nx2qSHB/mWbOafa7iR9pDIA48IV9R4o37xLuFZ6UAyrtbu9wtyhvGgv
        YaDXKzUbcntgpS7DkozmAqezMgK8nU3yHTheUK2+54PrTv30CL+COWuMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=92seWwiwyDFZbJFzQ9d3eHcie01wHXdtRt1sWd8bW4k=; b=kCUBBvrP
        QhlFnHL7qHPuSqsolAPjsgtU3XCNlst41eUmH9Y4hZRjodPS8i9n1Q4rcnOUq9h8
        pXZjPIwzVqQvwza0YZCauy6ABnqXV6Q67anCA2spT2dIlO7MUkHJDZjkLc2o6XIK
        HvdOqeYRMv4H8wl/E7ihYoLFAggph4WDFlP/e/SfLJ8lj9iEt56K3CmfPOL+laJ7
        19J8rn5Btz/FZxwAvuVvOV2llVMFjM5CZrl1qT+FQhbjVX4cEga7EIH946CU428a
        vfYgLyn9CyeaAXWejp1I5wne7bA5e2wD3qDFE4J+x+ywme9+4LIxXA2vBvacPgQF
        Q/h5iK6svL+obg==
X-ME-Sender: <xms:qdscX_RGSd0Bz5REcB0aynj5T25jXIrvgEsv9e57H56NKetIMONI2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:qdscXwyK2FYqLC728I9A31l-fcx0SvbDFgydDfGDzGhuJR2gX7fb-w>
    <xmx:qdscX03nqSjE-tG8K6ZphOnY5-A0k-HdDMpn6-klUmPABi4X_jTFcA>
    <xmx:qdscX_AVBjwSIo_TAmQSddIfRntZ7wvwu_tXu1_mlzuMZOcyeNxXDQ>
    <xmx:qdscX3p6dP340suJaeFCkfc0ZIuK_oIBhoRYN2WzQF1qtxiJNz6dMQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B65AC3060067;
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
Subject: [PATCH 4/7] ASoC: sun8i-codec: Add a quirk for LRCK inversion
Date:   Sat, 25 Jul 2020 20:25:54 -0500
Message-Id: <20200726012557.38282-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the A64, as tested using the PinePhone, the current code causes the
left/right channels to be swapped during I2S playback from the CPU on
AIF1, and breaks DSP_A communication with the modem on AIF2. Both of
these are fixed when LRCK is no longer inverted.

Trusting that the comment in the code is correct, the existing behavior
is kept for the A33.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index a75be9e82d22..304683a71acd 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -88,6 +88,7 @@
 
 struct sun8i_codec_quirks {
 	bool legacy_widgets	: 1;
+	bool lrck_inversion	: 1;
 };
 
 struct sun8i_codec {
@@ -215,18 +216,19 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
 
 	/*
-	 * It appears that the DAI and the codec don't share the same
-	 * polarity for the LRCK signal when they mean 'normal' and
-	 * 'inverted' in the datasheet.
+	 * It appears that the DAI and the codec in the A33 SoC don't
+	 * share the same polarity for the LRCK signal when they mean
+	 * 'normal' and 'inverted' in the datasheet.
 	 *
 	 * Since the DAI here is our regular i2s driver that have been
 	 * tested with way more codecs than just this one, it means
 	 * that the codec probably gets it backward, and we have to
 	 * invert the value here.
 	 */
+	value ^= scodec->quirks->lrck_inversion;
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
-			   !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
+			   value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
 
 	/* DAI format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -673,6 +675,7 @@ static int sun8i_codec_remove(struct platform_device *pdev)
 
 static const struct sun8i_codec_quirks sun8i_a33_quirks = {
 	.legacy_widgets	= true,
+	.lrck_inversion	= true,
 };
 
 static const struct sun8i_codec_quirks sun50i_a64_quirks = {
-- 
2.26.2

