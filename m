Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A78C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="RkZQd/pl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4A4KsHWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBQGpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:45:00 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60403 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgBQGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id AF91A52A0;
        Mon, 17 Feb 2020 01:42:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=/r22J9LyeZH3n
        hDCjpJzsr1zZdkXKV/PR9xsFs//i4A=; b=RkZQd/plZ75InhtalRrUTNzlvrQDI
        V+DjOl2jqUeIv08IGxLfhJIShJWcrP3UmUePGseFiLDSiGl/QhcfSP6v5qaUJwOU
        d/rXUJ9E63xRv/jtQPW0LNakay1bdxhGQYAAk9esejDaI+vNMDsPJAKxXP7SH83v
        VxwiWvMeSNUCmhCDrAHqGEFMVowC2EJxEqZZOWiGVpjyIDnZ0vOUHnt5z8XbFpIR
        II82yO3+Oyg6moAedc23v5V0ASV1VPz7udjRWPKR3YFgR9ZryNDPhO1JzgijSmKp
        4srOtYmjnSsCGTa4aWGhIQnPrNbd3fIqKN84tKPyf0v+ZM0fUIi47WK0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/r22J9LyeZH3nhDCjpJzsr1zZdkXKV/PR9xsFs//i4A=; b=4A4KsHWr
        AHjQVFafot3515noqJwL7Rxql6EXlbl/OxkAe9sV+KdoDL6lBiHXsys4AZGEHOTD
        jMK+buGerTqJ+SmtKrr02483bRKbGDQ5jUmLHz9pQg2hJeOaEWn4cq0NoCdVdhg3
        l96zT8Cbi6mrwW/5STuEtHHCZLYfXgemu3z76Qk3EbAFVjhYyjw2aFUwGaS0BQw7
        jKCCFTvrDD84K3R/Za6Upu7KWHbBMfa1nR/t9o84APO08ENHCWvXLVpo47tzMGIu
        MY92krHAC1T2b4haAiX/0Y23Zit6Dw29jUnhXm/HVwT8GLjy6TwMKmjAEUtLiEZM
        1+cj7wCWxgYQQQ==
X-ME-Sender: <xms:7TVKXr0-o8ELo-TzRnG8KnI9PRIms0MAh8frMdCinqciToHwnJK3hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7TVKXi0bmbe0A7Qb41GS_IeKJk8QLApCAXNV9R6vyb2LLQ_2QDVFPA>
    <xmx:7TVKXhUBYj158EV3ESNGss-OK29itzxpdMcwLR95RtAz_lvmqAc-ow>
    <xmx:7TVKXkjc94DvGv4d2-mwOCW7RIcdMSzjMTxe2j8s7ZQnAHYTp-2ZPQ>
    <xmx:7TVKXvBFR55WaXcyhc5tivgDJeGi5gSkxGgx23jagq6uviiWuCi2kg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2BFC3280062;
        Mon, 17 Feb 2020 01:42:52 -0500 (EST)
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
Subject: [RFC PATCH 04/34] ASoC: sun8i-codec: Remove unused dev from codec struct
Date:   Mon, 17 Feb 2020 00:42:20 -0600
Message-Id: <20200217064250.15516-5-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is not used anywhere in the driver, so remove it.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 14cf31f5c535..33ffbc2be47c 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -86,7 +86,6 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 
 struct sun8i_codec {
-	struct device	*dev;
 	struct regmap	*regmap;
 	struct clk	*clk_module;
 	struct clk	*clk_bus;
@@ -544,8 +543,6 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 	if (!scodec)
 		return -ENOMEM;
 
-	scodec->dev = &pdev->dev;
-
 	scodec->clk_module = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(scodec->clk_module)) {
 		dev_err(&pdev->dev, "Failed to get the module clock\n");
-- 
2.24.1

