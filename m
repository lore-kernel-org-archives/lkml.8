Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08250C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21652075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F8plumSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgH1POz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgH1POw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:14:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F15C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:14:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so1250472wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XO7ADdhJqpOQN7r6IzL9NHcOCfqqL0xalqP8Zr9AVw=;
        b=F8plumSakJirsH7lNu+Hn/G7X19AHjzTM5ONVDRwW97YDaWp3eg5szWB9CGtJhU1Vl
         xDFBvsnLlFHfbRlyNJtUC4tBi4s/mV1k4Rb02oFIBor+rPQeL/cg6t4Cew5Gn5mWJpIE
         Vt9KWC3iVYvkuyvrFRynD11z7LAMVPS+NI9tnBG14HFtnOHW6LVuCYnX33VWdWOsXr5e
         qFu28wlsnB7Y9L5unZLg6f+471jLdM9fe5jHwFkhnxxvaPAzYGZRjDgNUWQ6qtm+iBJt
         x/eqVD/jlV7ybQwhqzNXBTd6BUWYCR8zG7Co5wjqsfBCECYSt9kbIJ4zzWAjtCSaqkcb
         kGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XO7ADdhJqpOQN7r6IzL9NHcOCfqqL0xalqP8Zr9AVw=;
        b=fPTNgOzn99g8lcRhFS1c7hwJohen1uMMdlPXlCQ72Y490sexLg6yggOy1mVN260E2j
         X9lgS1ng0tgv3dMT4LChAlFKeh0aWt8wnHMf1u7RZZxI+aNp4P7hJVe7TXeMjF1vw5OE
         8MSnA955n+J+3Z0Sd9vIf8Om87flbuLASq69xaHWstQf44iaWHqEAzacYC3G1YAZz4t1
         lokvadyFOvAADqr9e5pbcXzW40zWVbEqtafoKZ42pNCnNxL4Pt4nN9akj5u/A53OPkg8
         WWvBYALe3frzALFQ1imCR0xTjJ8GVZIQ3anMNVKRvYHSsS8ho0lNEgN7oXDjlXO73MrF
         wBZA==
X-Gm-Message-State: AOAM532eyrGfOhnDEGoDd/LPdIfPfyGgE5OGDzSLhYIwzJ0GuTXpzNPM
        SVzFux27CDYxQNV7FWu9Y4Vrvw==
X-Google-Smtp-Source: ABdhPJxjB6+c5w8aI5zAeGsZDGu6H+RsO/PecnVXHIa5KCb0j3pXBs/KW6K15lIti3aH81H18eacBw==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr2039022wmc.156.1598627690389;
        Fri, 28 Aug 2020 08:14:50 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b8sm2877677wmh.48.2020.08.28.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:14:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-toddr: fix channel order on g12 platforms
Date:   Fri, 28 Aug 2020 17:14:38 +0200
Message-Id: <20200828151438.350974-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On g12 and following platforms, The first channel of record with more than
2 channels ends being placed randomly on an even channel of the output.

On these SoCs, a bit was added to force the first channel to be placed at
the beginning of the output. Apparently the behavior if the bit is not set
is not easily predictable. According to the documentation, this bit is not
present on the axg series.

Set the bit on g12 and fix the problem.

Fixes: a3c23a8ad4dc ("ASoC: meson: axg-toddr: add g12a support")
Reported-by: Nicolas Belin <nbelin@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-toddr.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index e711abcf8c12..d6adf7edea41 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -18,6 +18,7 @@
 #define CTRL0_TODDR_SEL_RESAMPLE	BIT(30)
 #define CTRL0_TODDR_EXT_SIGNED		BIT(29)
 #define CTRL0_TODDR_PP_MODE		BIT(28)
+#define CTRL0_TODDR_SYNC_CH		BIT(27)
 #define CTRL0_TODDR_TYPE_MASK		GENMASK(15, 13)
 #define CTRL0_TODDR_TYPE(x)		((x) << 13)
 #define CTRL0_TODDR_MSB_POS_MASK	GENMASK(12, 8)
@@ -189,10 +190,31 @@ static const struct axg_fifo_match_data axg_toddr_match_data = {
 	.dai_drv		= &axg_toddr_dai_drv
 };
 
+static int g12a_toddr_dai_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = axg_toddr_dai_startup(substream, dai);
+	if (ret)
+		return ret;
+
+	/*
+	 * Make sure the first channel ends up in the at beginning of the output
+	 * As weird as it looks, without this the first channel may be misplaced
+	 * in memory, with a random shift of 2 channels.
+	 */
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_TODDR_SYNC_CH,
+			   CTRL0_TODDR_SYNC_CH);
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops g12a_toddr_ops = {
 	.prepare	= g12a_toddr_dai_prepare,
 	.hw_params	= axg_toddr_dai_hw_params,
-	.startup	= axg_toddr_dai_startup,
+	.startup	= g12a_toddr_dai_startup,
 	.shutdown	= axg_toddr_dai_shutdown,
 };
 
-- 
2.25.4

