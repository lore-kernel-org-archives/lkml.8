Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E688C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29ECA20663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mbO9Ho2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgGaMGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732734AbgGaMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:06:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C134BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:06:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so6285418wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPGbKdWpP4J/auHhQU9i6g+5dqKdyKhc2qV2F7IdWpw=;
        b=mbO9Ho2whEsjgCbIV1QWsFLUK2smi52qT7wWaKiW87L26VYF+z85RR6d4vFtQK4cLG
         aSVCGMxewoVtU32g0OBkWB1/uTt6ws+Jcj0zjKJg1cSz26Kl0NedCWAwx6l2I45fGQMB
         HpzupOvHluciFnutq5bdGPaIif0FrBawHZQZ/plVzeHiJygqe9zNxIbYLmj5yufRoBhb
         iDADif1cXGMb981LyLn70QSAar4rIG7O/6hHjtP1jgMcSZfdVXZ5MFhz6Y0elhl8S4QG
         PrkAuR0sOjA827BBKqfj/TGF5Iw15t+iawU9sqv7/VuVoSKfXEPyW0+hqoO8nG+m8M6H
         1v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPGbKdWpP4J/auHhQU9i6g+5dqKdyKhc2qV2F7IdWpw=;
        b=cR6VL7WJJDnU7FmaSFB0oIj4G9HTi2c3a2z8MkaG0qDB919sCL0QtAZCRBl7lBlUVj
         lZZ4kupsC+bNeZXRhZU10Vc+3f5C6NS2pCuusb/7q60WNRW/MEwudgeyZEBH4zm7CgOW
         Wn1kmb0X7rjteKxfnVaSo8TAapeQ0t90fq5+x9WUXuScn/zFyG0iQlypwW4L9vybn5MS
         Q8Jf7kKKaw6mA0giUZyhbQ/He2144ARCf1CrzdzbtlTG+H/I0uW1+snxqHyYpcbR87wm
         dtxDlCgBMoy5eDlX0qaFdy00hiA9ncZHtJzhWhZWq1fz4u0de+eTarmK698pdtQcTIZH
         lGdA==
X-Gm-Message-State: AOAM531I78Ov2RTcWgSD4/S/JmwgIzlfkvO9HBfDNOjUlBRxdw7qRpo0
        iVAg53Hb78t8i1svCvOPshvtCQ==
X-Google-Smtp-Source: ABdhPJykW4KqeQYC9r3oDy7vW1cPW/jfK2qRpSTFF8xJ+gqC4QgmMJ93gKPbRy305pn2zd/hqHZuCw==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr3855492wmc.49.1596197171510;
        Fri, 31 Jul 2020 05:06:11 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c135sm5438017wmd.31.2020.07.31.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:06:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>, zhangn1985@outlook.com
Subject: [PATCH] ASoC: meson: cards: deal dpcm flag change
Date:   Fri, 31 Jul 2020 14:06:03 +0200
Message-Id: <20200731120603.2243261-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b73287f0b074 ("ASoC: soc-pcm: dpcm: fix playback/capture checks")
changed the meaning of dpcm_playback/dpcm_capture and now requires the
CPU DAI BE to aligned with those flags.

This broke all Amlogic cards with uni-directional backends (All gx and
most axg cards).

While I'm still confused as to how this change is an improvement, those
cards can't remain broken forever. Hopefully, next time an API change is
done like that, all the users will be updated as part of the change, and
not left to fend for themselves.

Fixes: b73287f0b074 ("ASoC: soc-pcm: dpcm: fix playback/capture checks")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi,

 For the cards be actually fixed, change 'ASoC: core: use less strict tests for dailink capabilities'
 will need to merged as well. snd_soc_dai_link_set_capabilities() as
 implemented in 25612477d20b5 ('ASoC: soc-dai: set dai_link dpcm_ flags with a helper')
 does not support link with multiple codec with different direction
 capabilities. This quite a common case on these cards.

 sound/soc/meson/axg-card.c         | 18 ++++++++++--------
 sound/soc/meson/gx-card.c          | 18 +++++++++---------
 sound/soc/meson/meson-card-utils.c |  4 ----
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 5176be165210..2b77010c2c5c 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -327,20 +327,22 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		return ret;
 
 	if (axg_card_cpu_is_playback_fe(dai_link->cpus->of_node))
-		ret = meson_card_set_fe_link(card, dai_link, np, true);
+		return meson_card_set_fe_link(card, dai_link, np, true);
 	else if (axg_card_cpu_is_capture_fe(dai_link->cpus->of_node))
-		ret = meson_card_set_fe_link(card, dai_link, np, false);
-	else
-		ret = meson_card_set_be_link(card, dai_link, np);
+		return meson_card_set_fe_link(card, dai_link, np, false);
 
+
+	ret = meson_card_set_be_link(card, dai_link, np);
 	if (ret)
 		return ret;
 
-	if (axg_card_cpu_is_tdm_iface(dai_link->cpus->of_node))
-		ret = axg_card_parse_tdm(card, np, index);
-	else if (axg_card_cpu_is_codec(dai_link->cpus->of_node)) {
+	if (axg_card_cpu_is_codec(dai_link->cpus->of_node)) {
 		dai_link->params = &codec_params;
-		dai_link->no_pcm = 0; /* link is not a DPCM BE */
+	} else {
+		dai_link->no_pcm = 1;
+		snd_soc_dai_link_set_capabilities(dai_link);
+		if (axg_card_cpu_is_tdm_iface(dai_link->cpus->of_node))
+			ret = axg_card_parse_tdm(card, np, index);
 	}
 
 	return ret;
diff --git a/sound/soc/meson/gx-card.c b/sound/soc/meson/gx-card.c
index 6da8535f4dd2..5119434a81c4 100644
--- a/sound/soc/meson/gx-card.c
+++ b/sound/soc/meson/gx-card.c
@@ -96,21 +96,21 @@ static int gx_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		return ret;
 
 	if (gx_card_cpu_identify(dai_link->cpus, "FIFO"))
-		ret = meson_card_set_fe_link(card, dai_link, np, true);
-	else
-		ret = meson_card_set_be_link(card, dai_link, np);
+		return  meson_card_set_fe_link(card, dai_link, np, true);
 
+	ret = meson_card_set_be_link(card, dai_link, np);
 	if (ret)
 		return ret;
 
-	/* Check if the cpu is the i2s encoder and parse i2s data */
-	if (gx_card_cpu_identify(dai_link->cpus, "I2S Encoder"))
-		ret = gx_card_parse_i2s(card, np, index);
-
 	/* Or apply codec to codec params if necessary */
-	else if (gx_card_cpu_identify(dai_link->cpus, "CODEC CTRL")) {
+	if (gx_card_cpu_identify(dai_link->cpus, "CODEC CTRL")) {
 		dai_link->params = &codec_params;
-		dai_link->no_pcm = 0; /* link is not a DPCM BE */
+	} else {
+		dai_link->no_pcm = 1;
+		snd_soc_dai_link_set_capabilities(dai_link);
+		/* Check if the cpu is the i2s encoder and parse i2s data */
+		if (gx_card_cpu_identify(dai_link->cpus, "I2S Encoder"))
+			ret = gx_card_parse_i2s(card, np, index);
 	}
 
 	return ret;
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index f9ce03f3921f..6a64ac01b5ca 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -147,10 +147,6 @@ int meson_card_set_be_link(struct snd_soc_card *card,
 	struct device_node *np;
 	int ret, num_codecs;
 
-	link->no_pcm = 1;
-	link->dpcm_playback = 1;
-	link->dpcm_capture = 1;
-
 	num_codecs = of_get_child_count(node);
 	if (!num_codecs) {
 		dev_err(card->dev, "be link %s has no codec\n",
-- 
2.25.4

