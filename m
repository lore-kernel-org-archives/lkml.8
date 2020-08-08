Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA37C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7472086A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jLtnGLs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHHCF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:05:27 -0400
Received: from m12-18.163.com ([220.181.12.18]:40749 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgHHCF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Gb0pBNIbxVgER6Rf+Z
        y6U/sqmQxqWtz3oTW0SExtfAM=; b=jLtnGLs3TQSirkWdlava4EV/UbcnqH4a91
        cLkFtBRch1z7Z8YAH6YB0F7fKnTnB/XV4lENhAoxJJdtdQUmwfQY7VhVKvMsWUVc
        DJuxyqm0D5wTGo6yy9YFvO+C7PLurdV1Yb3qstqAFRaIMj3gWhM18m6IOocfwsX+
        CIzTapVyw=
Received: from localhost.localdomain (unknown [58.33.79.182])
        by smtp14 (Coremail) with SMTP id EsCowABnvrJDCC5fRqxLIA--.16258S2;
        Sat, 08 Aug 2020 10:04:56 +0800 (CST)
From:   Grant Feng <von81@163.com>
To:     von81@163.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] leds: is31fl32xx: Add sdb pin and generate a 5ms low pulse when startup
Date:   Sat,  8 Aug 2020 10:04:38 +0800
Message-Id: <20200808020439.20606-1-von81@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowABnvrJDCC5fRqxLIA--.16258S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17trWUCr1rGF4xtF4UXFb_yoW8Kry7pr
        4DCFy5JF45ZrWfKwnFkF4UZFy3A348JF4DtFWxC343t3W2kFnYqFy0yFyqv3Z8XFZ5uay5
        Ar4qkFn8Cr4kAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrhL8UUUUU=
X-Originating-IP: [58.33.79.182]
X-CM-SenderInfo: xyrqmii6rwjhhfrp/1tbiRAh6OlSIgbuJSgAAsp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generate a 5ms low pulse on sdb pin when startup, then the chip
becomes more stable in the complex EM environment.

Signed-off-by: Grant Feng <von81@163.com>
---
 drivers/leds/leds-is31fl32xx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index cd768f991da1..07b543120e06 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 /* Used to indicate a device has no such register */
 #define IS31FL32XX_REG_NONE 0xFF
@@ -43,6 +45,7 @@ struct is31fl32xx_led_data {
 struct is31fl32xx_priv {
 	const struct is31fl32xx_chipdef *cdef;
 	struct i2c_client *client;
+	struct gpio_desc *sdb_gpio;
 	unsigned int num_leds;
 	struct is31fl32xx_led_data leds[];
 };
@@ -282,11 +285,17 @@ static int is31fl32xx_software_shutdown(struct is31fl32xx_priv *priv,
 	return 0;
 }
 
-static int is31fl32xx_init_regs(struct is31fl32xx_priv *priv)
+static int is31fl32xx_init(struct is31fl32xx_priv *priv)
 {
 	const struct is31fl32xx_chipdef *cdef = priv->cdef;
 	int ret;
 
+	if (priv->sdb_gpio) {
+		gpiod_direction_output(priv->sdb_gpio, 0);
+		mdelay(5);
+		gpiod_direction_output(priv->sdb_gpio, 1);
+	}
+
 	ret = is31fl32xx_reset_regs(priv);
 	if (ret)
 		return ret;
@@ -372,6 +381,15 @@ static int is31fl32xx_parse_dt(struct device *dev,
 	struct device_node *child;
 	int ret = 0;
 
+	priv->sdb_gpio = devm_gpiod_get_optional(dev,
+						"sdb",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->sdb_gpio)) {
+		ret = PTR_ERR(priv->sdb_gpio);
+		dev_err(dev, "Failed to get sdb gpio: %d\n", ret);
+		return ret;
+	}
+
 	for_each_child_of_node(dev->of_node, child) {
 		struct is31fl32xx_led_data *led_data =
 			&priv->leds[priv->num_leds];
@@ -453,11 +471,11 @@ static int is31fl32xx_probe(struct i2c_client *client,
 	priv->cdef = cdef;
 	i2c_set_clientdata(client, priv);
 
-	ret = is31fl32xx_init_regs(priv);
+	ret = is31fl32xx_parse_dt(dev, priv);
 	if (ret)
 		return ret;
 
-	ret = is31fl32xx_parse_dt(dev, priv);
+	ret = is31fl32xx_init(priv);
 	if (ret)
 		return ret;
 
-- 
2.17.1


