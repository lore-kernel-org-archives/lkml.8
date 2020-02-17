Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A787AC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA972072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="muGhFo1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="22Y80l+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgBQGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:12 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38951 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgBQGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C5F0C51E0;
        Mon, 17 Feb 2020 01:43:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=3lDAjzOIj+9xl
        0Uviyyg4YICTqjd5DlgZCmlDUQ+E0U=; b=muGhFo1eJt2pej7+zET/+0V+tEhsk
        MuVyrWdcsln5GkdE/PLf/tgcU/CebUwLDeiAjUBaaLbWOi4OVPrGASDdJuvgUj5S
        u3wzagc5P/nm3t/tC6XdwZlQad3TJUD1k/1623eqGYIw1w++XKeXVvYQGWGjLidT
        VMf+x9IoYcUELe5d3v5BwUr/sgvmLqc4ZBSXQKXDBzkovGH57M9T2A7/WMp/eYVb
        rK5GgqA4ILWDLTXRjGjld/B5GppeDdMjAJXZ1B0KvM/chgY7P+FsaNNhKvqg5s79
        7Mm/4PzGgspiBWK150QU8u7IjCxBsJckWAAu25WvTTSRIM3JxR/3tzPSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3lDAjzOIj+9xl0Uviyyg4YICTqjd5DlgZCmlDUQ+E0U=; b=22Y80l+Q
        E0uwP3twi0LKdVtRVWQ49nfiYYHvVfLQzkhLX8D7T09hSqfMq87I414dcAJPyZiQ
        N79w1AeHRPj+ahC1DR81tMUlrzPkWUzdlzIi8MfrmCYcn2wPaaJ1g2IGgwlD5NRM
        vSs7NeMR+FmXAzhSBr/ooUBD+H2ix7ZjZLyCQCeflyhKTQ7YQ4WqESMUq8LCwQbH
        55yiSj2okBaSe+imPd59B/Wn1Q7Drqn2TuJG5OMT36Vj6L3NRZYhxmgguwYw4Dch
        nYIubWoLRcdTbltLxeQbKxIl5lC1Crnx5YKCm2v2qjhcguqG9e7Ec4aGkrPkBFF+
        v+01DFcTmnIZoQ==
X-ME-Sender: <xms:9TVKXk3qxGth5nybN9EX70iuIOHgtOLf6Mu95OY65LG1bkoQWvz1pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9TVKXuzF3Mi1YJsdi1u6pdJ-n7oSC5M_td8BL3y1Jiwptqfm50UlAw>
    <xmx:9TVKXnuTPFDSFpTgS2uu5PVuHHtw7kFUW_hDFUizCWAMvgBZQElCng>
    <xmx:9TVKXgQJAFSfshpb0Jx1uWNqntb_7IkTnwGmeHnotgwYRz-537wuhg>
    <xmx:9TVKXoGc2jg4pO8XJ-cMKCgUVVNw67m8V9DvwhzxkRN1Ffvmoz8_Xg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 117C13280059;
        Mon, 17 Feb 2020 01:43:01 -0500 (EST)
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
Subject: [RFC PATCH 17/34] ASoC: sun8i-codec: Sort masks in a consistent order
Date:   Mon, 17 Feb 2020 00:42:33 -0600
Message-Id: <20200217064250.15516-18-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other definitions are sorted from largest to smallest bit number.
This makes the AIF1CLK_CTRL mask constants consistent with them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 559dec719956..36ce281286b5 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -81,10 +81,10 @@
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
-#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
-#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
-#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
+#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
+#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
+#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 
 #define SUN8I_AIF_PCM_RATES (SNDRV_PCM_RATE_8000_48000|\
 			     SNDRV_PCM_RATE_96000|\
-- 
2.24.1

