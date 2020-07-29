Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79801C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576D92053B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zLTcc+Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG2PpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgG2PpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B8EC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so2229870wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFwWixal6bg6/yGBUeckQ8zNlylY1ZjbXYs/S0fdtuA=;
        b=zLTcc+HfVBRchrfIBW1jERIX0biVz9CZS/q5ReBKow+W3caoKQqKObHjtFUrUxj8c2
         xwYDvY0erPB/k5HObfYjFrjWXFf3xIgp4skpvwEhKdnWD4pvRG7mDcnMK7xXY/RLg0Q5
         K3K/UK7XjR0RwzpWZzGemhvur36OTxJZSTaGEacmgrpybzO0SQ/H6ly4coZCWfDqL1sZ
         iHGvPEtY37h0owml1JyQD2FxV5jkGh0MmFPmTNXfE4WbzYS1dLMIXDwJKQCTg/f+TeuA
         y4Za0NejtucqFd8pW6sexE2gwHte8Ksk4JOt6dmVBKrfIrlntfUV9npxZnOlQHsExRRY
         xiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFwWixal6bg6/yGBUeckQ8zNlylY1ZjbXYs/S0fdtuA=;
        b=BNqh/vuCeSNQz1c9vbQdMu0lUjeK7XLHQsI5XBjcjoPHLdx1iycDqmqYrMhx63+4xq
         2JGta4Vwl1Rcj8vUjWO6fqXp2pHkh83yqZDn2S2Znn1IexWjkR8UdiYLOLOQ3o2S9duj
         x7/C2+aCb0pfga33Qx7kiMFMkcqzt7vFj0g5M4IAZzUcPBuZaUtfgcYbYSWB/OtittCv
         PWfYkIuxFcEakm/cE8uTPS0Tc6xO3YBGoDIN5LMOAHn29zCByrv/d0ffQpMlLXHXpXes
         ECvF7xPGMre/te2f/I7tci4T3Eb9dv2FIdtxBT3Ahb+4iQovj38j4A3j5MtNe7LZLjN1
         ly/Q==
X-Gm-Message-State: AOAM531KExquUIdagr26ChNhEVnbT5WKffDh12aySEfrS6mDbbWZJUa/
        HAxAUEI/o4j57g1q1gkgo+n9kDrGyCP7Bw==
X-Google-Smtp-Source: ABdhPJy0qqcwBITavP16MW6ffF+xI8XGXN/tI7XsE9Z0703/iHSoM2qsfi/fgn4gRUXAFwua0XmGDg==
X-Received: by 2002:a1c:9914:: with SMTP id b20mr9098844wme.15.1596037514079;
        Wed, 29 Jul 2020 08:45:14 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm5950967wrm.74.2020.07.29.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:45:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/4] ASoC: meson: axg-tdm-interface: fix link fmt setup
Date:   Wed, 29 Jul 2020 17:44:53 +0200
Message-Id: <20200729154456.1983396-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729154456.1983396-1-jbrunet@baylibre.com>
References: <20200729154456.1983396-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .set_fmt() callback of the axg tdm interface incorrectly
test the content of SND_SOC_DAIFMT_MASTER_MASK as if it was a
bitfield, which it is not.

Implement the test correctly.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 6de27238e9df..36df30915378 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -119,18 +119,25 @@ static int axg_tdm_iface_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
 
-	/* These modes are not supported */
-	if (fmt & (SND_SOC_DAIFMT_CBS_CFM | SND_SOC_DAIFMT_CBM_CFS)) {
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		if (!iface->mclk) {
+			dev_err(dai->dev, "cpu clock master: mclk missing\n");
+			return -ENODEV;
+		}
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
 		dev_err(dai->dev, "only CBS_CFS and CBM_CFM are supported\n");
+		/* Fall-through */
+	default:
 		return -EINVAL;
 	}
 
-	/* If the TDM interface is the clock master, it requires mclk */
-	if (!iface->mclk && (fmt & SND_SOC_DAIFMT_CBS_CFS)) {
-		dev_err(dai->dev, "cpu clock master: mclk missing\n");
-		return -ENODEV;
-	}
-
 	iface->fmt = fmt;
 	return 0;
 }
@@ -319,7 +326,8 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	if (iface->fmt & SND_SOC_DAIFMT_CBS_CFS) {
+	if ((iface->fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+	    SND_SOC_DAIFMT_CBS_CFS) {
 		ret = axg_tdm_iface_set_sclk(dai, params);
 		if (ret)
 			return ret;
-- 
2.25.4

