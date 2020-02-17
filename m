Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC0FC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D38206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="u3/G47gG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5iBbcJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBQGoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:34 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41103 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgBQGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BA4DE5232;
        Mon, 17 Feb 2020 01:42:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gQog3OlsgbAsZ
        oLI+7srNygrqMavGsdiz3aPBAseJDU=; b=u3/G47gGQc2OcFGLR6Z943suj10dP
        2awt9rhUf0OXIvckkiO/1eKKXwIXwX4/a1sxwuPDLUCcvHjp/A/L8eBR0EJcrjyH
        V8Y/jWmeY6wQN3KYLpDnAVjjAJl0izK+CqcQToAEMEJiolkpztrh2GxheA/+Nv2n
        B3vQXz9hiUlt1SdwInsx4nALN4Php+jvqbZyQ/bWbCwIpYZbIgcXC2zD95gnB2en
        h2ZjQVlEM54Xv/Ip9plM0rKs+fqZ8NESeRgZMbyxN1sWSS6tGpgsm3e3Lt1APZ02
        1F6dGCDA2twKVw6WkWxPcV/PjrAQoaoviFw447Dm8Omy005SZmEp6y11Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gQog3OlsgbAsZoLI+7srNygrqMavGsdiz3aPBAseJDU=; b=e5iBbcJH
        IOAg9pVnocAPi6Sp8i0kx74fJsqeNs+m5vYL8YhdQkcT16sejyy/knoZ6jIjr6L9
        eStJA2Z8YsEU9M8sUbHD+uwFbamymGLKcDOnEwW+i6taWq5QPYpAOhG25YCLepia
        BMiVzqSwsbuf97uLJ9zwNuQep3NB3xMZOgHsmHDzFXJSjnhB4zz8xKyiZW5rQ0+U
        5eEjRWs8DMSFgJnHDNIlBHYftYq2dm0bp/oVon7466XcygsECgrAaAVpR2ON2Y/U
        5JXUPu3/BKDZkP3tGnwtDujxQTSm5/ZeQxMXgL53dHcCcuesp+q484kETOR5swJa
        ItoaAcLmkM0edQ==
X-ME-Sender: <xms:8jVKXuQmi8WsaVVubwPEj6CNm7lba6kG47PQZNxu5xekAssIY1l52g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8jVKXiOE8VBa7iCQyks4ezIEgJ92NqvqQLUwGH4OWim9WojisX2TpQ>
    <xmx:8jVKXudkoM3216rtbn1l4mHCP66Kqjl5arGzptKYw7a0QtABtVLeNg>
    <xmx:8jVKXlWWWwmoeg2LuRuTRzcSmVpQk79P1JBDLkLIUmccjXWLB6pTvA>
    <xmx:8jVKXvvOSXyCkl1AFqItQpJgmVl6iO9dLrau2FwI9-T0nBWus2w4MQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0985D328005A;
        Mon, 17 Feb 2020 01:42:58 -0500 (EST)
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
Subject: [RFC PATCH 12/34] ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
Date:   Mon, 17 Feb 2020 00:42:28 -0600
Message-Id: <20200217064250.15516-13-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be "AIF1", not "AFI1".

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 3d5ed2f4575a..03cfe4e17ff7 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -430,7 +430,7 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("ADC Right", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* Clocks */
-	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
+	SND_SOC_DAPM_SUPPLY("MODCLK AIF1", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MODCLK DAC", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_DAC, 0, NULL, 0),
@@ -461,9 +461,9 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "AIF1", NULL, "SYSCLK AIF1" },
 	{ "AIF1 PLL", NULL, "AIF1" },
 	{ "RST AIF1", NULL, "AIF1 PLL" },
-	{ "MODCLK AFI1", NULL, "RST AIF1" },
-	{ "DAC", NULL, "MODCLK AFI1" },
-	{ "ADC", NULL, "MODCLK AFI1" },
+	{ "MODCLK AIF1", NULL, "RST AIF1" },
+	{ "DAC", NULL, "MODCLK AIF1" },
+	{ "ADC", NULL, "MODCLK AIF1" },
 
 	{ "RST DAC", NULL, "SYSCLK" },
 	{ "MODCLK DAC", NULL, "RST DAC" },
-- 
2.24.1

