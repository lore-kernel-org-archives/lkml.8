Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8356C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924E220720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="mlqoTRer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu5oDI6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgHaDtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59787 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgHaDs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CD773580558;
        Sun, 30 Aug 2020 23:48:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=NZapUfYA/Qz05
        eU6LA5tx5U02wk9kjpadYmiPX7qnRI=; b=mlqoTRerv6VOfCEWdjwZrK5aD2wWi
        iQOYZewHVIgNlheZNtyjnEzcSYOU1Z1E1ta8IYihmizrWKZHHrcJnAQE+1n6158S
        gkGkLSs0wUNe20r8ZC2zONG/cr0sil/MNxn7P1jZjP6bk3vGAgEzghlX6lJSaR+9
        YmSOpW3wIBWJESZBzj7ovXV6kKTnrzReZcwxDIgQ4m/1L5aWLGeif07W1jlPob+z
        LM5By3d0mgUECO5KVVPC1RIWI3Q2o2pXD5xYSS6Kn7dM34r19XMhfXhVvhWggSPN
        ZBHGXGzFrOSM211VVbXM8BxTJb+6i2GbZG3S3AtKWqFWDD1hA09HlKLww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NZapUfYA/Qz05eU6LA5tx5U02wk9kjpadYmiPX7qnRI=; b=fu5oDI6y
        m+EQ4EiZGzZqyBkTJlpHqN5Yy6hSIhrSHFrEZ6PUwemsu7NNxq00voRSnE7uJXCT
        ezTYIZB9UjsGkGoYHaqiHzSsyuMczHNtGxvUecnptzn6amyR/iOk3hSjsJvbamWF
        PW+tn01YZt+sEvGfGw6hGl4cT5u2rbLwgLJJ4AW0uepEgdjJiFpAKtyq2RoHthe/
        H6orlHnE99LltPeMR5/gYfIhuFuPQg4yZwnsTOnbbEfk3FcBZjtatu4/cKuooPLs
        z0FncuMRSTfCB3ySxuYGE9sYoqP4NGFVDmcl6/H+exTIsU7hIOr6LylEdEJoPLAj
        ZRo0LdgnGjgs4A==
X-ME-Sender: <xms:KHNMX7ESSoR15zDjL6jLIAMrxscHtKKCN3UZj1w7pEyobeabQhtJFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:KHNMX4UXd-HyaelcGF0jJMHEKckdFg9plR-EUFcnNvGAsjTC6siDtg>
    <xmx:KHNMX9LZ0vq8fssfBFc8pEZicsj8fwgBVSWWTR4Pdk5NnsXaUwRZSA>
    <xmx:KHNMX5HW9GmHpmk3H6GRnSFK2rPBB3NjZmRZln_6IKx09j5G74Xg0A>
    <xmx:KHNMXwGNGahwXukEh5iqL9Hjt6-PTeAKHLlVdqCJjHyxyJ7qkPJb6g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 397E2328005D;
        Sun, 30 Aug 2020 23:48:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 5/9] ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
Date:   Sun, 30 Aug 2020 22:48:48 -0500
Message-Id: <20200831034852.18841-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the enable bit for the "AD"C, not the "DA"C.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index def3a0059c3d..4218a00a9aba 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -64,7 +64,7 @@
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR		9
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL	8
 #define SUN8I_ADC_DIG_CTRL				0x100
-#define SUN8I_ADC_DIG_CTRL_ENDA			15
+#define SUN8I_ADC_DIG_CTRL_ENAD				15
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
 #define SUN8I_DAC_DIG_CTRL				0x120
@@ -393,7 +393,7 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	/* Digital parts of the DACs and ADC */
 	SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
 			    0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL, SUN8I_ADC_DIG_CTRL_ENDA,
+	SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL, SUN8I_ADC_DIG_CTRL_ENAD,
 			    0, NULL, 0),
 
 	/* AIF "DAC" Inputs */
-- 
2.26.2

