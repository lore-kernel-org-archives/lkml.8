Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBC92076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Fia0eJvK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPUht6zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHaDts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35701 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgHaDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DC72C58054F;
        Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wD7ZfrlNaMxZt
        s/5UJZ3RuMQ+EnJabMvQzkgcOJiW2A=; b=Fia0eJvKRfDaz+g3P7iLlmuTAj8mK
        9fuqR0YfWAOarVXuiZuo3B+c7Tvk5IwSbLkd9jkY1Y3iECdiyK0KmdyHPM+Saq0q
        t/KvK0Yq4fsXAJ+6JSsv9pNm6S+JGEMVPpDq4A8rAOnUZQiggssVm91KyoRcSt3C
        O7J63OsSCzmtpAlmPX1n2Tgv5S/FmZ8eE59z3Kn49NzmHWeIKWbCblwW4Jj5vLn3
        YpVClQVnZi38zSMYuFI9X0T4P9H2TFMQJIGUrKv73JsIQ0U+y2ZTLeQQJMhY5p7h
        6CXGHXKMVJFSCF7EOVMaAu3VLXGJvzzitdulKAabX2hygJhnKJ7KuzZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wD7ZfrlNaMxZts/5UJZ3RuMQ+EnJabMvQzkgcOJiW2A=; b=MPUht6zR
        EgxQliNNuoYSlEhBvyrEy6TPSwYbQLT5TfPxTMVXx5ljNvwNl/Nb97RmelhH26je
        i5hnEXowAb8yseHVSEEX+FO5jcPhLDjMHFL5/JXJTNSbypRIQ74Ll+A8LVLy5gTb
        Cym6UZtv6Ik6K6rYLwDCw3Vvm322fE+EcWB2IbNq2kVy3Ceb540gzxia+j6JaP95
        GTlWEs4AqlwqiBu/ZVUrAmDFztpnfB3dXoZ918PTUasOYGX31LAduAeAmHR5f5sz
        6fhAZpwjfY5k6hh7IybaVYgTVtbcQ95a5ig2V22VeBu9hFTKas42Ro0HJkcTBceg
        roMj0lHiTxEv7w==
X-ME-Sender: <xms:J3NMX-iLpPkfzYu0ndT09Qyjzxj7aHdGVuWHJbcEBYtQwE8JmS-ShA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:J3NMX_AdmJJhOW2UdMYezQ_B_zagWBTUQa8w9jSBNxXJ9XG8ypHttA>
    <xmx:J3NMX2G3SsbwRYVostrkjHWNivNxKjGjYAMWPnfdnjgO5MNPMXc6DA>
    <xmx:J3NMX3Sm4P76JzyyF7igO7OtWyhqjiElS26bxHtDtwWgfMs2LG5nBQ>
    <xmx:J3NMXywEBewCBt7Vz7DA1yon8oCZ06s8KoqqcWiKDH0ynaXn77lVdA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D00A3280064;
        Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/9] ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
Date:   Sun, 30 Aug 2020 22:48:46 -0500
Message-Id: <20200831034852.18841-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are controlling "AD0" (AIF1 slot 0 ADC), not "DA0".

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 263c1e7c3cc2..68c8edae9084 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -49,8 +49,8 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
 #define SUN8I_AIF1_ADCDAT_CTRL				0x044
-#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA		15
-#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA		14
+#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA		15
+#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA		14
 #define SUN8I_AIF1_DACDAT_CTRL				0x048
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA		15
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
@@ -407,10 +407,10 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	/* AIF "ADC" Outputs */
 	SND_SOC_DAPM_AIF_IN("AIF1 AD0L", "Capture", 0,
 			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA, 0),
+			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA, 0),
 	SND_SOC_DAPM_AIF_IN("AIF1 AD0R", "Capture", 0,
 			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA, 0),
+			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA, 0),
 
 	/* ADC Inputs (connected to analog codec DAPM context) */
 	SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 0, 0),
-- 
2.26.2

