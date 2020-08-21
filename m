Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EA020578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgHUQYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:24:22 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:59820 "EHLO
        5.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgHUQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:22:53 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 12:22:51 EDT
Received: from player687.ha.ovh.net (unknown [10.110.115.233])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id ABC2FAC5CD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:04:02 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id F334E1561EB26;
        Fri, 21 Aug 2020 16:03:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0060bc536b8-eaf8-41f7-b4a3-88bd76c57ad9,
                    20EB7F6BE0168D07063FB82D5C23839419BBC220) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] hwmon: use simple i2c probe function
Date:   Fri, 21 Aug 2020 18:03:54 +0200
Message-Id: <20200821160354.594715-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17325910717523709338
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many hwmon drivers don't use the id information provided by the old
i2c probe function, and the remainder can easily be adapted to the new
form ("probe_new") by calling i2c_match_id explicitly.

This avoids scanning the identifier tables during probes.

Drivers which didn't use the id are converted as-is; drivers which did
are modified to call i2c_match_id() with the same level of
error-handling (if any) as before.

This patch wraps up the transition for hwmon, with four stragglers not
included in the previous large patch.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/adc128d818.c | 5 ++---
 drivers/hwmon/ads7828.c    | 9 +++++----
 drivers/hwmon/lm87.c       | 4 ++--
 drivers/hwmon/w83795.c     | 9 +++++----
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index f9edec195c35..80511d316845 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -427,8 +427,7 @@ static int adc128_init_client(struct adc128_data *data)
 	return 0;
 }
 
-static int adc128_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int adc128_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct regulator *regulator;
@@ -524,7 +523,7 @@ static struct i2c_driver adc128_driver = {
 		.name	= "adc128d818",
 		.of_match_table = of_match_ptr(adc128_of_match),
 	},
-	.probe		= adc128_probe,
+	.probe_new	= adc128_probe,
 	.remove		= adc128_remove,
 	.id_table	= adc128_id,
 	.detect		= adc128_detect,
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index d895b73fde6f..7246198f0901 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -99,8 +99,9 @@ static const struct regmap_config ads2830_regmap_config = {
 	.val_bits = 8,
 };
 
-static int ads7828_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static const struct i2c_device_id ads7828_device_ids[];
+
+static int ads7828_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct ads7828_platform_data *pdata = dev_get_platdata(dev);
@@ -141,7 +142,7 @@ static int ads7828_probe(struct i2c_client *client,
 		chip = (enum ads7828_chips)
 			of_device_get_match_data(&client->dev);
 	else
-		chip = id->driver_data;
+		chip = i2c_match_id(ads7828_device_ids, client)->driver_data;
 
 	/* Bound Vref with min/max values */
 	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
@@ -207,7 +208,7 @@ static struct i2c_driver ads7828_driver = {
 	},
 
 	.id_table = ads7828_device_ids,
-	.probe = ads7828_probe,
+	.probe_new = ads7828_probe,
 };
 
 module_i2c_driver(ads7828_driver);
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index ad501ac4a594..24cb8a1c3381 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -912,7 +912,7 @@ static int lm87_init_client(struct i2c_client *client)
 	return 0;
 }
 
-static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int lm87_probe(struct i2c_client *client)
 {
 	struct lm87_data *data;
 	struct device *hwmon_dev;
@@ -994,7 +994,7 @@ static struct i2c_driver lm87_driver = {
 		.name	= "lm87",
 		.of_match_table = lm87_of_match,
 	},
-	.probe		= lm87_probe,
+	.probe_new	= lm87_probe,
 	.id_table	= lm87_id,
 	.detect		= lm87_detect,
 	.address_list	= normal_i2c,
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 44f68b965aec..9cff2e399f1d 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -2134,8 +2134,9 @@ static void w83795_apply_temp_config(struct w83795_data *data, u8 config,
 	}
 }
 
-static int w83795_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static const struct i2c_device_id w83795_id[];
+
+static int w83795_probe(struct i2c_client *client)
 {
 	int i;
 	u8 tmp;
@@ -2148,7 +2149,7 @@ static int w83795_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->chip_type = id->driver_data;
+	data->chip_type = i2c_match_id(w83795_id, client)->driver_data;
 	data->bank = i2c_smbus_read_byte_data(client, W83795_REG_BANKSEL);
 	mutex_init(&data->update_lock);
 
@@ -2256,7 +2257,7 @@ static struct i2c_driver w83795_driver = {
 	.driver = {
 		   .name = "w83795",
 	},
-	.probe		= w83795_probe,
+	.probe_new	= w83795_probe,
 	.remove		= w83795_remove,
 	.id_table	= w83795_id,
 
-- 
2.25.4

