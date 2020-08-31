Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD7C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0508B20720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="SLguCI3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gU/BQgUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHaDtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44707 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbgHaDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5FFAF580553;
        Sun, 30 Aug 2020 23:48:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Xd2DPB2xaaTmh
        zOiijGY8/Y+VdMv+lHjQmXSRZT+fzc=; b=SLguCI3syQvBkZHf0pZ2hbCMfkRq7
        VqaJgdbdi35W569DjXOMhsgW6Ktg0tSV0qIPNhKMUNBJe+18i3qgH0DsXS+veHLU
        GQNmTfC6LGuE+REfzjYrt1XSJJylpQnc5AH/PBFQiEK6gQWH3GqXSVCqXpRA4Tkh
        NfiOqJWTl/SEkfp8WzXLxCGhqi10aI3r6UGWvkcDtNP8vFTbA1zHzjg7DJToMzTb
        a9GikOnalwgBo20m6BXO6kTkchDgTeXJTi25Y6YFFe7um8efeyDKSP0wS1Ufjp8x
        k4S26GG0tqzAKjxjAywb8/NDNy8pg9jM4zd6imSG/I+50/HLU8tkR7k6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Xd2DPB2xaaTmhzOiijGY8/Y+VdMv+lHjQmXSRZT+fzc=; b=gU/BQgUj
        n922gJyWJaNDISucAfGPu/yc37Vewy59kgmvLw6XPeaB4HSjmPN3AWb0xWHlCi7X
        iy54P9oTm9UAyK+e1UHEK8PTeA8QQE48FFzFniC6yiDZwyteP01iw2O6un30N7Yh
        cG6HWRbeeaADewvF2eLCidcEdFk1yOSdAkB54/S5V7pk/LHSPOo7sgqq5mb97WKe
        I0XFGhE1jdMPtZjHGGI324uMIJIK7yVHAKpIKNCxWqxFqf00WHk3cbpGXvi6LQry
        N2a3ZEFZ+A0vFPZvAfGr4amdVszM/ON770Y2Qbnb2YN0hkScxNzSrLMuHRnSUqYN
        g02ensyrXmX/mg==
X-ME-Sender: <xms:KHNMX5JyUi6mp5fUhX1TlgqQOF6DnD1yk0d_fgs5V5xGnto_S1SlnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:KHNMX1IQmE7OCOBa70QCpDbzi9GoDP2kjG9TWiaUAg2WfM3Hnd6wRQ>
    <xmx:KHNMXxv3YDQA4QN6jUWrZPLjXDHN7zXTAZF8whe7c0DZM5q2qpVTeA>
    <xmx:KHNMX6bkEufJl5CJetpp9RsNZsfjiHf4yzdfajohWjpo4qo3DATeCQ>
    <xmx:KHNMXw5TTjwKH0dlM877NZ1Nwxc1_tuSR5oTVYk6m407Q-VvN_KhXg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC5403280065;
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
Subject: [PATCH 4/9] ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
Date:   Sun, 30 Aug 2020 22:48:47 -0500
Message-Id: <20200831034852.18841-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though they are for the left channel mixer, they are documented as
"MXR_SRC". This matches the naming scheme used for the main DAC. The "R"
is part of the abbreviation for "mixer", not a reference to the channel.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 68c8edae9084..def3a0059c3d 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -55,10 +55,10 @@
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA		15
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
 #define SUN8I_AIF1_MXR_SRC				0x04c
-#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L	15
-#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL	14
-#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL		13
-#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR	12
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF1DA0L	15
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF2DACL	14
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_ADCL		13
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF2DACR	12
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R	11
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR	10
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR		9
@@ -374,18 +374,18 @@ static const struct snd_kcontrol_new sun8i_dac_mixer_controls[] = {
 static const struct snd_kcontrol_new sun8i_input_mixer_controls[] = {
 	SOC_DAPM_DOUBLE("AIF1 Slot 0 Digital ADC Capture Switch",
 			SUN8I_AIF1_MXR_SRC,
-			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF1DA0L,
 			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R, 1, 0),
 	SOC_DAPM_DOUBLE("AIF2 Digital ADC Capture Switch", SUN8I_AIF1_MXR_SRC,
-			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF2DACL,
 			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR, 1, 0),
 	SOC_DAPM_DOUBLE("AIF1 Data Digital ADC Capture Switch",
 			SUN8I_AIF1_MXR_SRC,
-			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_ADCL,
 			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR, 1, 0),
 	SOC_DAPM_DOUBLE("AIF2 Inv Digital ADC Capture Switch",
 			SUN8I_AIF1_MXR_SRC,
-			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXR_SRC_AIF2DACR,
 			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL, 1, 0),
 };
 
-- 
2.26.2

