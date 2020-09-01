Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5212CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190E7206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="SD848XAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIAHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:34:32 -0400
Received: from smtp2.axis.com ([195.60.68.18]:33014 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgIAHec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:34:32 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 03:34:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=995; q=dns/txt; s=axis-central1;
  t=1598945671; x=1630481671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ShxaEFx48sdlmYl8Cn29yMPtphJjPlK3B3A8bgDbuVQ=;
  b=SD848XAEIwsawHwHgmSaK2V3yHxC7f9vUZn5nqbMQfNED8DIXEU+xwje
   ckE9MhOWa/7xs7jdH/czBgrDLnksZwCE+MQRfVWNeCANMb/DRKIcMWHco
   tbZUyHmQLGXRG+oQu7gjID0PKS5LcEClkE7m8GlaiLC5HpIGig3jV7iOP
   NQgXnIfEoWZlxhngFIMH+f/5Vfy5Op5mUM7jk4fDVYwWBDFYzr5DMQCQr
   8t3XtiYU2HYQSZTMVHC8Web0dpt17Go/bpDvlroecdqAQJf+bOtE8mqZC
   /XfmypUX8SydYmdntIVOch2CbjtAxuA+NcUa4c5afqCqQDexVgSqcHh+0
   w==;
IronPort-SDR: 6wvZqcrh8ZvNMxqhgd4/XGbB+UlSLzwDBAWg/RS3zxVpQu80m5TPFiDIX2iMUBowe98gnwm//z
 8VJnQFFVcQZgKFAlO0NK3/issBqDOp0IpfG7EMJdVaKWuW7qCpsO/T/3+Cyv7wcZ+pX6a1O4f7
 P6CIfANY+XDAcnHaHxzBTfTOo/w+hqD0FgaGvjEbsanfOI9mH1KMTXpf3XgoC2vKf9ugoEx5EG
 9zepESA3jj9btI5RD2ktpSnvPEB9ddQ09a40wwGEL9ADjXChE7nX6iv29iCGO1keMGecn1cC7R
 xJE=
X-IronPort-AV: E=Sophos;i="5.76,378,1592863200"; 
   d="scan'208";a="12070617"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        Camel Guo <camel.guo@axis.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix accessing uninitialized abcx140->dev
Date:   Tue, 1 Sep 2020 09:27:10 +0200
Message-ID: <20200901072710.2031-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

in adcx140_i2c_probe, adcx140->dev is accessed before its
initialization. This commit fixes this bug.

Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 5cd50d841177..7ae6ec374be3 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -980,6 +980,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 	if (!adcx140)
 		return -ENOMEM;
 
+	adcx140->dev = &i2c->dev;
+
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))
@@ -1007,7 +1009,7 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
-	adcx140->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, adcx140);
 
 	return devm_snd_soc_register_component(&i2c->dev,
-- 
2.20.1

