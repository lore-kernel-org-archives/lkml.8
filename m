Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55010C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EB920639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IDKv9EHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgHYIXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:23:19 -0400
Received: from m12-18.163.com ([220.181.12.18]:45409 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHYIXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6TbjWjz/T5CmZA6u71
        mDuio88nMrkLsUiCb9hwSiQ+A=; b=IDKv9EHCpoQeXW8znfv6O/TaklFB45m18L
        9C7BG/RQxFe1BUuzO0UZx8FtG2pGCOlDgF0YHXE24RSA9aK0LK+Kg/eaM993KNda
        SGnS1zkH083M3DiTm3VyjMcyH5VfQtXPhlRJ+Fj5iY/gfewTyfxZGDC42t7BdI85
        VZ3IGcNek=
Received: from localhost.localdomain (unknown [58.33.102.45])
        by smtp14 (Coremail) with SMTP id EsCowADn7pY5ykRf0ZtgKw--.56943S2;
        Tue, 25 Aug 2020 16:22:22 +0800 (CST)
From:   Grant Feng <von81@163.com>
To:     von81@163.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] leds: is31fl319x: Add shutdown pin and generate a 5ms low pulse when startup
Date:   Tue, 25 Aug 2020 16:22:05 +0800
Message-Id: <20200825082206.26575-1-von81@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowADn7pY5ykRf0ZtgKw--.56943S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17try5XFWUWr1rAw15twb_yoW8Cr4xpF
        1q9F1FyFW3tFW7K3W3ZFy7ZFy5t3W8tF4DArWxuayS93Wvgrn0gFn0qFnFvF17XFZ5uayU
        Jw4Dtay8Gr48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwhL8UUUUU=
X-Originating-IP: [58.33.102.45]
X-CM-SenderInfo: xyrqmii6rwjhhfrp/xtbB0B6LOlUMN0n7hAAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generate a 5ms low pulse on shutdown pin when startup, then the chip
becomes more stable in the complex EM environment.

Signed-off-by: Grant Feng <von81@163.com>
---
 drivers/leds/leds-is31fl319x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index ca6634b8683c..54ac50740d43 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -16,6 +16,8 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 /* register numbers */
 #define IS31FL319X_SHUTDOWN		0x00
@@ -61,6 +63,7 @@
 struct is31fl319x_chip {
 	const struct is31fl319x_chipdef *cdef;
 	struct i2c_client               *client;
+	struct gpio_desc		*shutdown_gpio;
 	struct regmap                   *regmap;
 	struct mutex                    lock;
 	u32                             audio_gain_db;
@@ -207,6 +210,15 @@ static int is31fl319x_parse_dt(struct device *dev,
 	if (!np)
 		return -ENODEV;
 
+	is31->shutdown_gpio = devm_gpiod_get_optional(dev,
+						"shutdown",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(is31->shutdown_gpio)) {
+		ret = PTR_ERR(is31->shutdown_gpio);
+		dev_err(dev, "Failed to get shutdown gpio: %d\n", ret);
+		return ret;
+	}
+
 	of_dev_id = of_match_device(of_is31fl319x_match, dev);
 	if (!of_dev_id) {
 		dev_err(dev, "Failed to match device with supported chips\n");
@@ -350,6 +362,12 @@ static int is31fl319x_probe(struct i2c_client *client,
 	if (err)
 		goto free_mutex;
 
+	if (is31->shutdown_gpio) {
+		gpiod_direction_output(is31->shutdown_gpio, 0);
+		mdelay(5);
+		gpiod_direction_output(is31->shutdown_gpio, 1);
+	}
+
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, &regmap_config);
 	if (IS_ERR(is31->regmap)) {
-- 
2.17.1


