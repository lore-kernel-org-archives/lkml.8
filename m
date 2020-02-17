Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8895DC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C54D206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="oDmFapVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gfk6BOFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBQGoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:30 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60403 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgBQGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 86F9A5529;
        Mon, 17 Feb 2020 01:43:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bWdMIahH29yFf
        zqwPIeEk1em2GgGUD8m6unCtTeCgqs=; b=oDmFapVanONA3Slt7PN7tEJnclOhm
        tdlQ6XiGyxMevoxHuUMikFZhHM6eywY8irIudalh+02wtXA1Mzr5UN6cKLFAUPsp
        baeBXslamCMNxmfCZgnFougtNU1LtRN+OI5BySI+w7eLGIwL5S+C+locXD1AwdGy
        kWc7GNCwfq/EHLWnkGcoyYVnDEQ7P28HIfzPQvkPeuHNXpfRSQ9oX5za1zfn+auU
        7odde6VyrqIPfqU7xwbGUXUx+7dw/BoyBhmroyGAganlcZ4nCitS2BGXdULF+AR4
        +Du2J9jvDUVUTt/HYBIG9/iHM072/J4nwPD5gx00oZioQSpD1Lc9NYvUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bWdMIahH29yFfzqwPIeEk1em2GgGUD8m6unCtTeCgqs=; b=Gfk6BOFV
        5zfCdamui7/Aovbs/sbmd47cRRRmgFhF/gIHUSVoSxFKpHwNjdk6w1jInKl7lXT4
        P8FhmCZfU55lJ8IXOTsqMzeI1j3FTfLn4Cu2gDW7LJFEARStHOY99OMdnzdHbbHZ
        kveQSffYUBaNAvzd5aMLFg1XZgYNeMsQ92V1RvM/emc9bbYjoAQsUmuE1D6gc91o
        WfaWxrgOBp9UMl3EpQuNMvG1XSvYS42xKnw3iegogqY4YUkTWmW2eaiiybIHS+IU
        zxqCS9xa9eNNHFiC91UaCKLSudxCD995iWU1d42Rb++VjWzjYX2vvexn//xqr61n
        qy28BIysxXMygg==
X-ME-Sender: <xms:9DVKXv2Oybe4YvNfBc8OTA-hrH5ArG7P98gJQG0rOiTKtxMs3imlPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9DVKXssjNf9P2VJhB7qaCyD2XDPjjoQo2YTXkrrdVBzymNRvqVJzmw>
    <xmx:9DVKXvgup7UmBZHeFUDXzqBgUpXELuWbWNToAkLRd4nhBpIg7jFkPw>
    <xmx:9DVKXrAwi2k8dWc3qso-tuKpuJG87IWiZlI4Ye_slPFXdBA487TOKw>
    <xmx:9DVKXnhyvJdLZiM8CNr_S3RxUz0AEGUa-R_6pGaS3vjB-rIaPPVnZA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1AD63280059;
        Mon, 17 Feb 2020 01:42:59 -0500 (EST)
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
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 15/34] ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
Date:   Mon, 17 Feb 2020 00:42:31 -0600
Message-Id: <20200217064250.15516-16-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the enable bit for the "AD"C, no the "DA"C.

Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 6c2fe8549668..0063fa301fab 100644
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
@@ -392,7 +392,7 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	/* Digital parts of the DACs and ADC */
 	SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
 			    0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL, SUN8I_ADC_DIG_CTRL_ENDA,
+	SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL, SUN8I_ADC_DIG_CTRL_ENAD,
 			    0, NULL, 0),
 
 	/* Analog DAC AIF */
-- 
2.24.1

