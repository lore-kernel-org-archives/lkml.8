Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAF020732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="LHWjvoQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgIHIft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:35:49 -0400
Received: from smtp1.axis.com ([195.60.68.17]:1668 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbgIHIfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1085; q=dns/txt; s=axis-central1;
  t=1599554142; x=1631090142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gTwpcPl1kFBU+63Hn6Z1DD9u9CbnXsIkdWpPX9XgDYw=;
  b=LHWjvoQUotg/cbuEkbUiCPvR3N6r+x3AD4OM6qeqigim5J8SKEDrwQvv
   64vIDOMEwarQI2I+ckDGZirF0ZWM5wa442O7NEeKaGPaYCUbfuDF/Gnmw
   KV7eviTO3f+uDaQrm6GtACOdOfVG8WtSz11fjKqlFwDye0/AbHQhDh+rQ
   bHnrr3tA2E9122sJs+7/kc/99ROEsHFkH+3/eeqHTKI9r/0ARhlJ4Y4HM
   ds1O7F9YauR6qidF5EYA9KNQScau4GU0YaudEdRiIz2OfNwjQCXZTAQAp
   kTlJ9kGYnWQHT/ipRvqky+GeoUf++O0HMn9QtIJOKlmA7nDvzTZujWh9z
   A==;
IronPort-SDR: A7seHGq6UizqtY69aiZX4KZ3Zu6mGxvUchvWKDjdzIPhdJ9OtVV/8Ul2TCAIemDAi/3aWCFDLh
 u2WJSVdU7ksbuH0Z3i/gSLQdZ3NQrh2zZRK3dElRCbP5PXWYdr0QWbATS+ihsP5DuwsXg7+JhW
 Aq7xV2pNpFWph5pzc8D9HbXOhAaj49SFJVdkBi4iYjP5/DbCOtIGQbBygKYNNPWOoBk6y1U5Hb
 kYjQBabhRKBIKtZ0+39/YVXRJgHV4pLGM1c/BoYuzVoVjoFWDitPWb8zjvqMK7Bwrz1ZZ+lm7c
 0lo=
X-IronPort-AV: E=Sophos;i="5.76,405,1592863200"; 
   d="scan'208";a="12651999"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid gpio_reset
Date:   Tue, 8 Sep 2020 10:35:20 +0200
Message-ID: <20200908083521.14105-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

When gpio_reset is not well defined in devicetree, the
adcx140->gpio_reset is an error code instead of NULL. In this case,
adcx140->gpio_reset should not be used by adcx140_reset. This commit
sets it NULL to avoid accessing an invalid variable.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 7ae6ec374be3..597dd1062943 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -984,8 +984,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(adcx140->gpio_reset))
+	if (IS_ERR(adcx140->gpio_reset) || adcx140->gpio_reset == NULL) {
 		dev_info(&i2c->dev, "Reset GPIO not defined\n");
+		adcx140->gpio_reset = NULL;
+	}
 
 	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
 							   "areg");
-- 
2.20.1

