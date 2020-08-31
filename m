Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8FDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4934120720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LiyCbH3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c5uHtCGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHaDtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:49:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33809 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgHaDtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:49:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B55BD58055D;
        Sun, 30 Aug 2020 23:48:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=IZc2IStvr+AnR
        7eauS4CeBaKA3UMEQWja2HUN/Gwnuk=; b=LiyCbH3YYEvxEnMZgbuR9NAgF1dq7
        f4ZxGdQ6McOGgY/irALiEv7N9OAw+6zgCI5zr4b/xtOs6vBReFk+jOGFHl4+Fo7f
        B2TpXN7pFpRP48/r3bHXaXrwJUyFTXWA6/JaDVbaXJdd9MbDKpC3KqclPXJ84O5G
        ypY3M6Rrwzjlzs+P2xe0NzCR9UOeMzc+DhBUM1yn6toz+BqMBxWmq0ZxxxIvKl/5
        EhqsaFBDEQZ9dafSEMVMpUO/vZc1NgJ1cXZRZArYRoJD/4GW13kJaCDA5+idltOQ
        5z6dfZ6nkYaqMl1ZS3x77bQ7NhdW79UQc3hXdr/AoAtE93s6EVV6QMBLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IZc2IStvr+AnR7eauS4CeBaKA3UMEQWja2HUN/Gwnuk=; b=c5uHtCGS
        rnLqnXnjwuA766oPIi3d/Nu8GNOW2PW6O+lpkcu4IiNGRTGWFbBcf+TqKRTHWgbh
        Ey+hrpZARrOJUwGez4SkkHFSyxdvKg1PXlitRPgffcXL0+rxVxKv14ydgAB64+az
        k0g8Xj9CCGYcXDKTUkNu0mn7tVynCHYuvIANr0FRFMIlVXUbSj1RCJymTi8xZtCW
        OhuP1hkVqDuuRS+7HYn1FMD9zCWaqrTUODRf2qWEWdgaoucahXKZuzwBo0J4VXyr
        zSbwpU00nUwynyWEBnpNha1mnVaDnuO9aCERLL30O2Lu0iNb5hx3HXhK7DyBGPyf
        LF3t4ZzqOLaTUw==
X-ME-Sender: <xms:KXNMX2QhieCG8GV0bOl8O_qm72Y1-_KrNpnozTCyQO1rv0cwLQ80wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:KXNMX7wriZbvv7elfYlTelNYz7CmFF82LbcSFdogI3XkZuFIviIq5Q>
    <xmx:KXNMXz3fYqZyyrb6wYSvgXCBnyX8S99MUsR_EAfXg-LcbNkCnT9slg>
    <xmx:KXNMXyBHyaO_OsmrCJlKCX1kR3wzUNnbvyDn_SzBBqRVvjZbGlZOAw>
    <xmx:KXNMX_gcxY5kO-R8RYkKaiSNMguX43Deesgw7Tnb2VlB_IGRrz56_g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2601C328005D;
        Sun, 30 Aug 2020 23:48:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/9] ASoC: sun8i-codec: Sort masks in a consistent order
Date:   Sun, 30 Aug 2020 22:48:50 -0500
Message-Id: <20200831034852.18841-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other definitions are sorted from largest to smallest bit number.
This makes the AIF1CLK_CTRL mask constants consistent with them.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 62d4b1b44e76..c25cdd3f3057 100644
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
 
 struct sun8i_codec_quirks {
 	bool legacy_widgets	: 1;
-- 
2.26.2

