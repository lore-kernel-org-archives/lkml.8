Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1979EC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE4206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JsdZLFt3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJNaWC3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgBQGoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:44 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38951 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgBQGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 456AE546D;
        Mon, 17 Feb 2020 01:42:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zutLwkCFJwr4H
        OIeiYIfzlC7l/v47tnp9l6lYRGMDUc=; b=JsdZLFt3JUJzmrJ0rn6xzKBgrItg1
        gNspE5jw1f6wyXMVIHyaZ9OVQpeZjPfc2Je6iUi+G63uZMa7rCfk9q7OOQ0SK9tt
        Gti261rG31Z/4M5IVg2EHPcUN8khm4U48UUDVOtqfafsv6IqhkXBKhRNG9AnQpno
        AGGkeqPZFBlMk67DpzmKCafME7mg+lQFTv3T8bBqr7M0Zv2n6qfqisKHYciJCYbq
        6PvqHZ1MZ8GFDRmx4vdap9FqEX9tjiac2fvzQrf1lzlTdO6qYBvXNJuZ9kOtldaj
        izxfIl10lR3Jro93dx+lzfVxbXuOJN7zpZQJPQgiOdC5OLCS7aQQU7pxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zutLwkCFJwr4HOIeiYIfzlC7l/v47tnp9l6lYRGMDUc=; b=GJNaWC3w
        06NtYj84M01lqQA4XI+ArLdnf7e4BAuKkANxyEJkRBWeje2qkDdh+ZZW/50l1n/P
        5P55BcMAhPn6YSG28PnSlUp0+AHS4u2KxtG56wXCcOJ2wPlCd27bANF4qWOyFpNR
        nZE32oJ4lOv+EI/Rfkoz0NopbulvuM/se36d/eGutR0bgCBlrhg2wQqbGpLU9mNH
        RdDtygi9bhIbosZmsxOV1hVCJ0qPxEXTM+XGCHIAfXXXp3HeSYkSAnhHp/wEfiva
        HS2VtjdDk3ys6V39YyqtPMIXa/Z73tNFqmJtpYLNODjx5EBUDO+gwLq7vWybG3Mk
        u9kKNRRAW06LWQ==
X-ME-Sender: <xms:8DVKXg-y1ruVNvt3CXWNHiyu4rQ9nyYca3dpOBzsbZlRucChtHUt0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8DVKXq9OBQUgfvocvdlc9udwuoGMljBt1tOXxhOrhl2q8G1yOQYFOg>
    <xmx:8DVKXoSWix7WNAnQK-uFcAyZ7s1uf6UOJDTYqHXirHdM-55qXzNFzQ>
    <xmx:8DVKXmccCTNFmnwfzJPBT5I9SYGm-zfV8DQs544-aTLEWsiti3aBNg>
    <xmx:8DVKXjH-2Uwdtoy-ej-HycyT4dSmxyW41Zc_8KTMA6oOxOdvYJ_T5Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DB533280062;
        Mon, 17 Feb 2020 01:42:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>, stable@kernel.org
Subject: [RFC PATCH 08/34] ASoC: sun8i-codec: Fix direction of AIF1 outputs
Date:   Mon, 17 Feb 2020 00:42:24 -0600
Message-Id: <20200217064250.15516-9-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming convention for AIFs in this codec is to call the "DAC" the
path from the AIF into the codec, and the ADC the path from the codec
back to the AIF, regardless of if there is any analog path involved.

The output from AIF 1 used for capture should be declared as such.

Cc: stable@kernel.org
Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 0eca75d22f13..83c812742cc1 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -399,12 +399,12 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* Analog ADC AIF */
-	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left ADC", "Capture", 0,
-			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA, 0),
-	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right ADC", "Capture", 0,
-			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1 Slot 0 Left ADC", "Capture", 0,
+			     SUN8I_AIF1_ADCDAT_CTRL,
+			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1 Slot 0 Right ADC", "Capture", 0,
+			     SUN8I_AIF1_ADCDAT_CTRL,
+			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* DAC and ADC Mixers */
 	SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
-- 
2.24.1

