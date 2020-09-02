Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78384208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NqUyei0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgIBPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:37 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:55958 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgIBNb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:56 -0400
IronPort-SDR: ynhBwUvpTDAdxSmhtK0/tq1se06C30r7rSzdg+m1Dczrxvhg6XmwcqpywYWKHseuZyuwsGLGcR
 /NlMEV59mcXRomai5W34hck4enUyq1HQNOTBa63VpRqUvksGnCVhVz5hOsuPYx8XKwrUGVkmk+
 CzcYtsGqAK17X2hO+72ulHQSUy8ycgCoF9CdbSjbgRZO+A8yw3F0/+a+2dGKOt+BOdZFOGWaqA
 69eQOY+2frKVsx8W9tim6HbdhsUTebtWQamrh+30j/7lhwNB8bAdAogIQBh1f5ZsNNcP6FgtEl
 04c=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="13702691"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Sep 2020 15:30:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 02 Sep 2020 15:30:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 02 Sep 2020 15:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599053459; x=1630589459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PAWy/HPTCyiBJJXehMsiFyv52ASflEFQdfpXpet28Os=;
  b=NqUyei0uz8oLf9ls68yFwPth03LLEbAkbI3FiUA02HLIOz+TiKPj5r3i
   FbWMYFnPm/ory+OGOZpVLoSKMV6TnUEErbpnI6GM9+IRiNBrcL4/MKgwh
   g0D9+I/NiMyfoPbr/KdrQ2Fl9+ibCfnGulYJ26gkJGuTl40zHaCUDK1xX
   FHmb7xdFQ4K+U1LdDfmzWy5ToI1ddNGcHcJDruuul0YXBJHgNr+siVUH5
   NiNhUzl0I4YsMUwVRIvi2GNnVx7EOcl6BMsnkxhP0IXOMY371mHLBt4/B
   9SwlcPHnVf1kxw8AT2cRmrLbqbI2PZWtddhfteW8o2WPlTtp/t4YoUgYr
   g==;
IronPort-SDR: rWvoANrAZeIWQdiwCcblue0yI4e69UUmziRI7o7snFdUsgH1nSIycvETIf39GW6hBfLsZ3qlVQ
 bVYBQFfU5xw/f/ahP82HTYq8rzXJwzcRixKrMTUQ87/OL3gydHh/koOuM32nDiMKD6szZQjoja
 F1TbeFqK63RGbC76gImMYscHjVR1qXygpoJb3MPG8MssHpSQTwmSOmC3WDf0ISIXIy1ZqmgINS
 pZ7gKl1UbSVw7NIn/XKHZAic8C28AbaJUht0hvoq1CBXHx5ybGKlElLXcgqAl40sdOv8JJSg20
 m0E=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="13702689"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Sep 2020 15:30:59 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2FB3D280070;
        Wed,  2 Sep 2020 15:30:59 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] ASoC: codec: tlv320aic32x4: do software reset before clock registration
Date:   Wed,  2 Sep 2020 15:30:43 +0200
Message-Id: <20200902133043.19504-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902133043.19504-1-matthias.schiffer@ew.tq-group.com>
References: <20200902133043.19504-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the actual PLL settings to differ from the state expected by
the clock driver, the codec should only be fully reset before the clocks
are registered. But we also need to ensure that the software reset
happens at all before clock registration, as not all boards have a reset
GPIO.

Move the software reset from aic32x4_component_probe() to
aic32x4_probe() and reorder the reset and registration sequence:

1. Reset via GPIO (if available)
2. Reset via software
3. Register component
4. Register clocks

Note that aic32x4_component_probe() is only called after aic32x4_probe()
has finished, so the reset in aic32x4_component_probe() was happening too
late.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index a45fb496082c..470dc0ef0359 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -981,8 +981,6 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	if (ret)
 		return ret;
 
-	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
-
 	if (aic32x4->setup)
 		aic32x4_setup_gpios(component);
 
@@ -1226,6 +1224,16 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	if (gpio_is_valid(aic32x4->rstn_gpio)) {
+		ndelay(10);
+		gpio_set_value_cansleep(aic32x4->rstn_gpio, 1);
+		mdelay(1);
+	}
+
+	ret = regmap_write(regmap, AIC32X4_RESET, 0x01);
+	if (ret)
+		goto err_disable_regulators;
+
 	ret = devm_snd_soc_register_component(dev,
 			&soc_component_dev_aic32x4, &aic32x4_dai, 1);
 	if (ret) {
@@ -1233,12 +1241,6 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		goto err_disable_regulators;
 	}
 
-	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-		ndelay(10);
-		gpio_set_value_cansleep(aic32x4->rstn_gpio, 1);
-		mdelay(1);
-	}
-
 	ret = aic32x4_register_clocks(dev, aic32x4->mclk_name);
 	if (ret)
 		goto err_disable_regulators;
-- 
2.17.1

