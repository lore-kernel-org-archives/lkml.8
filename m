Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B10C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14A920732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="V24crpU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIHIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:35:47 -0400
Received: from smtp1.axis.com ([195.60.68.17]:1668 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgIHIfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1856; q=dns/txt; s=axis-central1;
  t=1599554137; x=1631090137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xp2jtEwWlIVWqx9i65+JtXtOEPvP+lssrgvRxVi0wCI=;
  b=V24crpU+c1xlqJyJpoVKYrcp954FXp+zxM5BBBfhtgXlnmOBnu2LLq2s
   ZY50tN2wy7NwVfc0VszTRNhpXiWZELP5M9dv38ARY2zkA+rhbhRYLhiJk
   TjHiuV7MzejCgosVpfBA13qlrH62TjDVfmDQDeegQb6uSSYZq6HIhyQHK
   aaQvyLUMQJsE0utWo8JAAOZNCx6GudGB8csYECd/8QRQ81KO92syiMTkQ
   Eam+mA8nDB9DJ6NE9eVM5EXJSI3lO1BUD5ixgrZKtyIWcPJ3DAh697ZGm
   OmJUUQ44cRb/dUGE72BExwiomludkDOtHI1T00cRnXUfPJkgEML4UMQ6l
   Q==;
IronPort-SDR: SUM5QoENwhtyx2B6qE8P7GTzyoyjJY/j3tg8kW/LjcD9A9JjlDi8579OLER5ex99nYk/jFJQiZ
 71ngP+kiNNrKNgMVcvLmi2Q9teAg86SsJtZk7szJhtFQ6y7GuXbizqNStR5BLurjxR2VZLy1cN
 JOkQZma0/nTQuUC1vdIECEpZNKsXpLViSrZJcQ4XoyvCe6bAyHSvvFKe9Oa8I+DskxYlRFeE3k
 jDm19QdWRfM4un6np6SmHs0zXO7qHJaK/KwtAQzaCbnIH6pv8zotoXnBVsl+F4rgAJ36UMTkHq
 nr4=
X-IronPort-AV: E=Sophos;i="5.76,405,1592863200"; 
   d="scan'208";a="12651992"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH 2/2] ASoC: tlv320adcx140: Wake up codec before accessing register
Date:   Tue, 8 Sep 2020 10:35:21 +0200
Message-ID: <20200908083521.14105-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908083521.14105-1-camel.guo@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

According to its datasheet, after reset this codec goes into sleep
mode. In this mode, any register accessing should be avoided except for
exiting sleep mode. Hence this commit moves SLEEP_CFG access before any
register accessing.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 597dd1062943..6d456aa269ad 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -842,6 +842,18 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		goto out;
 
+	if (adcx140->supply_areg == NULL)
+		sleep_cfg_val |= ADCX140_AREG_INTERNAL;
+
+	ret = regmap_write(adcx140->regmap, ADCX140_SLEEP_CFG, sleep_cfg_val);
+	if (ret) {
+		dev_err(adcx140->dev, "setting sleep config failed %d\n", ret);
+		goto out;
+	}
+
+	/* 8.4.3: Wait >= 1ms after entering active mode. */
+	usleep_range(1000, 100000);
+
 	pdm_count = device_property_count_u32(adcx140->dev,
 					      "ti,pdm-edge-select");
 	if (pdm_count <= ADCX140_NUM_PDM_EDGES && pdm_count > 0) {
@@ -889,18 +901,6 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		goto out;
 
-	if (adcx140->supply_areg == NULL)
-		sleep_cfg_val |= ADCX140_AREG_INTERNAL;
-
-	ret = regmap_write(adcx140->regmap, ADCX140_SLEEP_CFG, sleep_cfg_val);
-	if (ret) {
-		dev_err(adcx140->dev, "setting sleep config failed %d\n", ret);
-		goto out;
-	}
-
-	/* 8.4.3: Wait >= 1ms after entering active mode. */
-	usleep_range(1000, 100000);
-
 	ret = regmap_update_bits(adcx140->regmap, ADCX140_BIAS_CFG,
 				ADCX140_MIC_BIAS_VAL_MSK |
 				ADCX140_MIC_BIAS_VREF_MSK, bias_cfg);
-- 
2.20.1

