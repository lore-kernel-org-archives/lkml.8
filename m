Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F80C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582BE206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=izotope.com header.i=@izotope.com header.b="BQrRD6cM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbgDAUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:55:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41707 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgDAUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:55:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so1605074qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=izotope.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g4kk6wwdY8yrihIPw6mOhLzUhNs3dsF0WNszM6fL+OE=;
        b=BQrRD6cMScOAE7orufyNWIAP8Aoz3NlnWbGUl0U3jbUYe05UY+WIdK55hedussU3FZ
         B9++uLspCP+usWvmQoGI8GWgXL7T7Hm/cnkUAyPN7g0wRWz4onaw2Nc11GhSvc+BSKcX
         HpXy0fUmRJhK3J8jklPmUzsjhzhNq+JjLhOOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g4kk6wwdY8yrihIPw6mOhLzUhNs3dsF0WNszM6fL+OE=;
        b=cyHu58I8aBUabv7XW4dv7kG8RF5CXryerClh4g81g2hB7G29VZBE7QLe1Z241ZEV9H
         XY4fZvqqAVXG0A7zHN3Jyq2jKk3ajnABhMwZCJ11Tp/GxknoWLUfmTRbm1WY1ANr89Wn
         5/DjZV/sdfDMa4TBKXtz+K2HzT4/2wDCk93Vs0BSwkZuDNEFU7vuli/giwDvR9c4G8zf
         iSw8CX6jwXLLgJooFH428l0fCFLPH7zz+BSqfHMwKnR1x3hFHh9mdgwIvbM2LB4HQuck
         V+kZC6MQZzKt5CNT2umsvP18EuvVYPl8NawkFygN1biJVB3uxiKol8uzlpshiTmeQ7jB
         0jYg==
X-Gm-Message-State: AGi0PuZ/beWrt3WeKFGr5iHQlD0ruYzlKLKf32mUN7D6GbaaWrenXF2q
        gV0q8aBk/8UyszCf+BWhxBClwQ==
X-Google-Smtp-Source: APiQypLWPhzlA+PB0a2CXGRt1T1qFtY0r63L2T6hl8lIyR+BDFBhk6djKQYvV6iwp8k8XMNeHOwuSw==
X-Received: by 2002:a37:9ac6:: with SMTP id c189mr215593qke.214.1585774507223;
        Wed, 01 Apr 2020 13:55:07 -0700 (PDT)
Received: from localhost.localdomain (pool-71-184-149-228.bstnma.fios.verizon.net. [71.184.149.228])
        by smtp.gmail.com with ESMTPSA id c12sm2330202qtb.49.2020.04.01.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:55:06 -0700 (PDT)
From:   Mike Willard <mwillard@izotope.com>
To:     mwillard@izotope.com
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs4270: pull reset GPIO low then high
Date:   Wed,  1 Apr 2020 20:54:54 +0000
Message-Id: <20200401205454.79792-1-mwillard@izotope.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the RST line low then high when initializing the driver,
in order to force a reset of the chip.
Previously, the line was not pulled low, which could result in
the chip registers not resetting to their default values on boot.

Signed-off-by: Mike Willard <mwillard@izotope.com>
---
 sound/soc/codecs/cs4270.c | 40 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5f25b9f872bd..8a02791e44ad 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -137,6 +137,9 @@ struct cs4270_private {
 
 	/* power domain regulators */
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+
+	/* reset gpio */
+	struct gpio_desc *reset_gpio;
 };
 
 static const struct snd_soc_dapm_widget cs4270_dapm_widgets[] = {
@@ -648,6 +651,22 @@ static const struct regmap_config cs4270_regmap = {
 	.volatile_reg =		cs4270_reg_is_volatile,
 };
 
+/**
+ * cs4270_i2c_remove - deinitialize the I2C interface of the CS4270
+ * @i2c_client: the I2C client object
+ *
+ * This function puts the chip into low power mode when the i2c device
+ * is removed.
+ */
+static int cs4270_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
+
+	gpiod_set_value_cansleep(cs4270->reset_gpio, 0);
+
+	return 0;
+}
+
 /**
  * cs4270_i2c_probe - initialize the I2C interface of the CS4270
  * @i2c_client: the I2C client object
@@ -660,7 +679,6 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
 	struct cs4270_private *cs4270;
-	struct gpio_desc *reset_gpiod;
 	unsigned int val;
 	int ret, i;
 
@@ -679,10 +697,21 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	if (ret < 0)
 		return ret;
 
-	reset_gpiod = devm_gpiod_get_optional(&i2c_client->dev, "reset",
-					      GPIOD_OUT_HIGH);
-	if (PTR_ERR(reset_gpiod) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	/* reset the device */
+	cs4270->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(cs4270->reset_gpio)) {
+		dev_dbg(&i2c_client->dev, "Error getting CS4270 reset GPIO\n");
+		return PTR_ERR(cs4270->reset_gpio);
+	}
+
+	if (cs4270->reset_gpio) {
+		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
+		gpiod_set_value_cansleep(cs4270->reset_gpio, 1);
+	}
+
+	/* Sleep 500ns before i2c communications */
+	ndelay(500);
 
 	cs4270->regmap = devm_regmap_init_i2c(i2c_client, &cs4270_regmap);
 	if (IS_ERR(cs4270->regmap))
@@ -735,6 +764,7 @@ static struct i2c_driver cs4270_i2c_driver = {
 	},
 	.id_table = cs4270_id,
 	.probe = cs4270_i2c_probe,
+	.remove = cs4270_i2c_remove,
 };
 
 module_i2c_driver(cs4270_i2c_driver);
-- 
2.17.1

