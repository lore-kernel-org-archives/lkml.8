Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8AA214F1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VJ1FFaBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHHDi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:38:29 -0400
Received: from m12-15.163.com ([220.181.12.15]:54471 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHDi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 23:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=oSfvozyc7WeaEkyabb
        NkYFvPW4VQ5CKtVaQR9O+77CY=; b=VJ1FFaBKZnj1W+uBi8gA6LW1mhKDXJIFO2
        vGRL+PdRBW+SuyaiVjHU/fxcMBSmO1QkQAgRHxZEPzGPr0LUKdjrbaK1EHAloN6G
        EwvZJGqZn1GD7dEuvR9XR7cIHL8P8hW5DSXwGc+Txc/d47EEZhtYG5CugKtaOzje
        5XSSx4MjI=
Received: from localhost.localdomain (unknown [58.33.126.62])
        by smtp11 (Coremail) with SMTP id D8CowACnoqoHHi5fN_NeEw--.35350S2;
        Sat, 08 Aug 2020 11:37:48 +0800 (CST)
From:   Grant Feng <von81@163.com>
To:     von81@163.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] leds: is31fl319x: Add sdb pin and generate a 5ms low pulse when startup
Date:   Sat,  8 Aug 2020 11:37:30 +0800
Message-Id: <20200808033731.15695-1-von81@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowACnoqoHHi5fN_NeEw--.35350S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17try5XFWUArW5AF4xZwb_yoW8AFyxpF
        1qkFyFyFW3Jry7Kw12vFy7Za45t3W8tF4DArWxWayS93WvgFnagFyvvFnFv3ZxXFW8uFW5
        JwsIyFW8Gr48ZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOAwsUUUUU=
X-Originating-IP: [58.33.126.62]
X-CM-SenderInfo: xyrqmii6rwjhhfrp/1tbiUQx6OlWBQVR0fwAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generate a 5ms low pulse on sdb pin when startup, then the chip
becomes more stable in the complex EM environment.

Signed-off-by: Grant Feng <von81@163.com>
---
 drivers/leds/leds-is31fl319x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index ca6634b8683c..5c499a5895e0 100644
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
+	struct gpio_desc		*sdb_gpio;
 	struct regmap                   *regmap;
 	struct mutex                    lock;
 	u32                             audio_gain_db;
@@ -207,6 +210,15 @@ static int is31fl319x_parse_dt(struct device *dev,
 	if (!np)
 		return -ENODEV;
 
+	is31->sdb_gpio = devm_gpiod_get_optional(dev,
+						"sdb",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(is31->sdb_gpio)) {
+		ret = PTR_ERR(is31->sdb_gpio);
+		dev_err(dev, "Failed to get sdb gpio: %d\n", ret);
+		return ret;
+	}
+
 	of_dev_id = of_match_device(of_is31fl319x_match, dev);
 	if (!of_dev_id) {
 		dev_err(dev, "Failed to match device with supported chips\n");
@@ -350,6 +362,12 @@ static int is31fl319x_probe(struct i2c_client *client,
 	if (err)
 		goto free_mutex;
 
+	if (is31->sdb_gpio) {
+		gpiod_direction_output(is31->sdb_gpio, 0);
+		mdelay(5);
+		gpiod_direction_output(is31->sdb_gpio, 1);
+	}
+
 	is31->client = client;
 	is31->regmap = devm_regmap_init_i2c(client, &regmap_config);
 	if (IS_ERR(is31->regmap)) {
-- 
2.17.1


