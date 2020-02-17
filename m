Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C0FC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB20206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="R1ADsWhQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neEzQIWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBQGou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:50 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60403 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgBQGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 03161537E;
        Mon, 17 Feb 2020 01:42:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ijuXwZjdCzjoi
        Fk9M3o3Cb+h29NCqVUZXZzHgJRRplI=; b=R1ADsWhQSyvgkOpaH6PvX4LLq1DID
        +1PkIe0ueIMnb3e90XX+Bit989ONf5kAfy2rZM1n9jgXTtShfJlJIqAlrOSmcBZa
        B0NlnVDnbJrMyOyxQpfy02EiR9RfoNSpAqdlLaKrBFQIVS2dccEvYrampTn7Eu0T
        iTExLYS9s8XD+2DlOseKyH88JTiF1HqY+FSz2z4oXLfWJlFGc+Jor0sH5TzT8dpD
        hqLsck7pkN/9F8+OzNMne8ENI1Dz76azTUzFDY+5rCQU0DpI+78CwFm05cviAQYC
        FcfmC87DUEf2mkYnxrgu5zUH7YZDUz/qC04yo8kdwBq7PFk8vc83qpMrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ijuXwZjdCzjoiFk9M3o3Cb+h29NCqVUZXZzHgJRRplI=; b=neEzQIWl
        k4Mg6iMdCoHf7G1RfJWzmx/0WzH83GV5Ju9RATO830ZcWUsxlzNNWicFMBU9McUF
        9nd8SnpETMNSiukTKsZ8vakHBJk9Fqq8eewmsXdFRwoZvO2SbPcHtHak1tDqfwHj
        Ezj/1jf+J+ltApuI7Af5gdNICv5XXWXRPz1zxQhN76/ILHwgqnDcHJ+2Ne75AXVX
        yNPMgOm6UVTOauRmj9PZjci7iY+V4E61lIp7MciQQmxLxMXaCCDwYIDWX5py4+9T
        6dl39EDu5IF8BisxSof1soTMZ+fnKrD7M6ZrTxR6MNL9fKpVJJFUIoMSKk6IK8Ji
        EJUjJbjkHSbVaA==
X-ME-Sender: <xms:7jVKXlmRp5Uf3RuNr1-4QXcvEK_bezmmR3yp72lstXZ8yZ4_ookf6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7jVKXlHOHxKFP15X0p2WKTfP6GOwFJcwN12RFRFhCkjRCGNwnPX4wg>
    <xmx:7jVKXmqLPn0UUoVUmBYI8PAqid45svTo1S5EZW_KPZidYd3e4CKCXQ>
    <xmx:7jVKXp6hmQWLSvF1VCE-qum6q2jW0fGg6SPloV6zPsSLZaGOHk-U7Q>
    <xmx:7jVKXpP25F-DM9SwlLus5_SMjNfQK4RjdAtq50wP7jtXtW4aMt94pw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B37A328005D;
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
Subject: [RFC PATCH 06/34] ASoC: sun8i-codec: Fix setting DAI data format
Date:   Mon, 17 Feb 2020 00:42:22 -0600
Message-Id: <20200217064250.15516-7-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct mask for this two-bit field. This fixes setting the DAI
data format to RIGHT_J or DSP_A.

Cc: stable@kernel.org
Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 32b7410540c6..cb3867644363 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -81,6 +81,7 @@
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
+#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
@@ -242,7 +243,7 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT),
+			   SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK,
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
 
 	return 0;
-- 
2.24.1

