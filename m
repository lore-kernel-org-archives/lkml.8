Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD51204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="jrIs1fMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMHSF8yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHSDkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:40:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49895 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgHSDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:40:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 820C65C0160;
        Tue, 18 Aug 2020 23:40:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Aug 2020 23:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=cFbQAyHKdEjiz
        x/TGUVffQEsSKzIcSYC8XWfKh++Cms=; b=jrIs1fMhRS3ANrl/84y7S+6R6bhbw
        EHONtY51mC79KBKGz1wFzDqdDfM++CT8Nf9KYxoX7GwCyAofeOSQLuMsyRT+BfWQ
        ma88WnbHspl6ulxSfF57jswtlVamWakiCA/TwUoVPNJVviwz5e5A10cG3+QVKqZy
        e8og9AUl2B01aI4oD4mhuIy2RHU/0fcLxM7hLXzdJdlbpU2beZOcGqIuTeyn9WH1
        zF3iiLHsV9LOqRt8nr7FLFVK2xdtPm8q5hJc3ZFX9q+tOJh6EXcLfcPEvl6YHMxX
        uFqPkS4pOijwwu6/QZBOPXkxMXjm/qsNnI7YTVmB1SLhywm4tKZC7qwzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cFbQAyHKdEjizx/TGUVffQEsSKzIcSYC8XWfKh++Cms=; b=hMHSF8yf
        MWNa4Y86naet22fSCbSu6bmtjUK+kr1pUOhg3i2nDPRAHQaToVIoXQLT5VDe+TRA
        MQcBq8+qqmelqnQOZlz59FKtNMTjqYkSlsmsoCaZ8urLdIMMZAjB1F21vqtvLWyx
        ZyrNH5OOip6s1pBO6dJUVQylD4dgP1szmXcpMYEVGuqm4X/qCp9S7manFLHFmsR5
        CJYpsCqZ6xe7Sq6Tf2QUWhYjNdlH1sYy12eDJzRRpilg3gtP5+Q8dzqm2eufCA25
        kw1QizyDhCBly+rnh9Dkhp6IvFXLAO8EJq+tDfajZzYJzfadmHbttcx5wEefoykQ
        yXUQ+6cAD6XVIw==
X-ME-Sender: <xms:N588X8KwWFC_U57RE3oCuumqKNEYqG2vsPBa59U_GMDeUp8FIfnZ0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:N588X8KqX1v6vj5FhmS5MLOGPvTe_eJAogOJN1eLopydltvl_cYRGA>
    <xmx:N588X8tYXnmwDT_5TT21SWG-W8K-G_M8nrBTaKMVxJhC2rmckoRkIg>
    <xmx:N588X5ac-ZoU_UMa7vUNGg_QpK3F-MXI4s_I_OVCCUwh9isWSLPz9A>
    <xmx:OZ88X-xJaIMI8woR2nE5VF7K6IZbcSseR5PD3hoaHGEwukn_ufhXBQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E17830600A9;
        Tue, 18 Aug 2020 23:40:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] ASoC: sun8i-codec: Hook up component probe function
Date:   Tue, 18 Aug 2020 22:40:38 -0500
Message-Id: <20200819034038.46418-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819113405.55582925@canb.auug.org.au>
References: <20200819113405.55582925@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a mistake made while reordering patches, commit 90cac932976e
("ASoC: sun8i-codec: Fix DAPM to match the hardware topology") added
the sun8i_codec_component_probe function without referencing it from
the component definition. Add the reference so the probe function gets
called as expected.

Fixes: 90cac932976e ("ASoC: sun8i-codec: Fix DAPM to match the hardware topology")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 304683a71acd..e3a1347d7ecd 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -584,6 +584,7 @@ static const struct snd_soc_component_driver sun8i_soc_component = {
 	.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
 	.dapm_routes		= sun8i_codec_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
+	.probe			= sun8i_codec_component_probe,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.26.2

