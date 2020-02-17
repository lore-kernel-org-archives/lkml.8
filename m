Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E6C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0470206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KutxqOI2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJLHeIeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBQGos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:48 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40587 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgBQGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E80353C8;
        Mon, 17 Feb 2020 01:42:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4oosZxTt0fEhw
        STmSYl/k9XHF9CYNsoiHSHZf3lt07Q=; b=KutxqOI2gtyYxbFsVOgHWlx2v9cmo
        BpFrEABQgpDfbqZyHiDLWIom96ahWk4e5WdCMw5dEAeWf8RSAJHUJpLr6v6tMBVD
        aEWui8VNH0fTv7WI8Zyo7nXXIzkQ0S3aslvUixhct5UpOdmCvYDrD+o14UHRrF8/
        1mby+g9uNvncxRhavhv/oUkNuz+Ogo3/6gC/tTrvXD+81ZZpd6obyAZs+oV1fSYK
        +IHc2X0C+kYPvI36QpznniVIDjZ1Yht0WZjRZ1ynG3qDjoJ7d4449EPK0fMpY+OC
        9XdLT1JNPL4AvPt+R2ALyLXImveGHzw0buip3kN7vu9OtRY4jhg+FWkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4oosZxTt0fEhwSTmSYl/k9XHF9CYNsoiHSHZf3lt07Q=; b=kJLHeIeK
        WA2mLG2C2mgX6ZDGh1f8gCQb0jnh8mCvanXsgorKFkr58AYTexH2m6nim8A6kzNQ
        AzVbfFQjr8dNLchrVlantceTauO7hWTHl406KNAoeFOsmG7Yei4yCB/BZ+lDXxSb
        +U5nsSUuiIt1/qRqZKo5agBaEoJc+ipKYJl3sZZnuxaZuFXrYdN8wgpX4jaK5mbi
        9TQrNNytPMPfz4hVgpXMZ20Rm5nE9nIg0FkFJEvMpPJQOAMBWHu6d/KjlRnGEleM
        gcYk6WH/yQhzeRDoXUK5Z5a07gyN3YeSuHYyMf+thFeYIYTFkpz5egeuEh0I6f3d
        Nb9mhXcU+pDtQQ==
X-ME-Sender: <xms:7zVKXtxAOZORVKqyIycYBsYoZmo3x8DLue4BMkpx06iGcUpdVKUHag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7zVKXjYpAbDpyKYoH52pGJQ1K-0RBvLVy6NqAbqVtir0aE2s8wwThw>
    <xmx:7zVKXt3BfpcTWrZSblEV3aa98g9kymKemgU4pWTiqJADvEt1ZcajHw>
    <xmx:7zVKXpiueZEVCBUR9R_HT0YExyrLcSoaI1Hp2-WZDqe_cafH_8JxeQ>
    <xmx:7zVKXp_QzYTIEtGNdgHO5jFYO9kTsJtRKPps1BB_ADuk3MJS4sGpkw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D68C63280059;
        Mon, 17 Feb 2020 01:42:54 -0500 (EST)
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
Subject: [RFC PATCH 07/34] ASoC: sun8i-codec: Remove extraneous widgets
Date:   Mon, 17 Feb 2020 00:42:23 -0600
Message-Id: <20200217064250.15516-8-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for the digital part of the codec, which has no
microphone input. These widgets look like they were copied from
sun4i-codec. Since they do not belong here, remove them.

Cc: stable@kernel.org
Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index cb3867644363..0eca75d22f13 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -441,10 +441,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST ADC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_ADC, 0, NULL, 0),
-
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Mic", NULL),
-
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
-- 
2.24.1

