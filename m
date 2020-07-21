Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A6A2176B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNxrJ+Kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgGUDtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgGUDtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:49:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCACC0619D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:49:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g16so1264872pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QiCOPTdHtVnOLm15Y/Cz20pA21X9TMtA2pR2z4md9lo=;
        b=tNxrJ+KllDNXwxWQ2HoyP2KxFE/BSEI/v7hxga99iGHXZK16YqgkA8pcbVj1dR9giu
         C9HrKLiUgebouTwhY8JXIRWV80P++OU4qe/b/GOWUn3ACTXmsERsf10B7Z4uyMIA0CAC
         /QAAR+vkMWE2FiYIdcW7Clyiz206mMm3UQjFANrBh1oXQKF0EwrDYnEv3mYnf/kwjDwE
         KDvYmnKa6T7LeVonZtcqdFcRKb7PXlBV+7UUhyGjxDREMKGecAclR0AYXkguPw4jrDoB
         rVBol/7DRB53X82zJ1zfOGA4R11UtKsM5Nx3fd4MbChLagkuXvVq/0msgJzSZ5zhwgYF
         Ao+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QiCOPTdHtVnOLm15Y/Cz20pA21X9TMtA2pR2z4md9lo=;
        b=t1SId2k9PDu/oGbX1mP0UURYA6/ErfdB43meROf1DskAynAr7R4xWrkYPVqyVbVU3w
         RwAC/Z5G25ukqbCXOeaTJnBm7kVQJXpqRRjAiWM3uvJdRIAb0L6+6AFMn16DJ77Yi0cL
         MiTSa0kOpjDL70b04NFcSyrmZ5sbjNJ0oVzdiJaOmEYbE/09MUFlelAWj3xiRt6UQdM3
         LSU113p1veZ08uYPFd+3SRUN9sKy68s36mR/692/nhdhXz3yJpJzUoW8bbJiU1oiv+/p
         bqi7fA5QK7asEbvxXNXN3P6mVdH/W/svg9WMf2/1alyVv8pL0qotVSY4pHouaVc+ihix
         KLnw==
X-Gm-Message-State: AOAM530+zIBNesd0LmwoDPrJYsBxWYfU3efnbrqHOZVuEM9R9eEM+51B
        bpI55xaqlI4FDVp3/6Atu4t/hk+cZlAjMOpz
X-Google-Smtp-Source: ABdhPJxJoUCRL6gWg6LmKT6xovHFcxogZjFxn8JTOUkAXawpuLN2UVPWIOz/CCCKWeObinh+IyDQ0da0+i/ORVzj
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr2383575pjx.169.1595303343349;
 Mon, 20 Jul 2020 20:49:03 -0700 (PDT)
Date:   Tue, 21 Jul 2020 03:49:00 +0000
Message-Id: <20200721034900.2055889-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3] hwmon: adm1272: Enable temperature sampling for adm1272 adm1278
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     belgaied@google.com, jasonling@google.com, linchuyuan@google.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
	adm1272 and adm1278 supports temperature sampling. The
current way of enabling it requires the user manually unbind the device
from the driver, flip the temperature sampling control bit and then bind
the device back to the driver. It would be nice if we can control this in a
better way by reading the dt.

Solution:
	Introducing device tree binding analog,temp1-enable. If the
flag is set, flip the temp1_en control bit on probing.

Testing:
1). iotools smbus_write16 35 0x10 0xd4 0x0037 // disable the temp1_en
2). recompile the dt to have  analog,temp1-enable set
3). Probe the driver and make sure tempX shows up in hwmon

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
ChangeLog v1->v2:
 - Rename adm1272-adm1278-temp1-en to analog-temperature1-enable

ChangeLog v2->v3:
 - Rename analog-temperature1-enable analog,temp1-enable

 drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 19317575d1c6..0482670281bd 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client,
 	const struct coefficients *coefficients;
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
+	bool temp1_en;
 	u32 shunt;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -536,6 +537,9 @@ static int adm1275_probe(struct i2c_client *client,
 	if (shunt == 0)
 		return -EINVAL;
 
+	temp1_en = of_property_read_bool(client->dev.of_node, "analog,temp1-enable") &&
+		(mid->driver_data == adm1272 || mid->driver_data == adm1278);
+
 	data->id = mid->driver_data;
 
 	info = &data->info;
@@ -614,16 +618,18 @@ static int adm1275_probe(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+		ret = config;
+		/* Enable temp if it is instructed by dt (it is disabled by default) */
+		if (temp1_en && !(config & ADM1278_TEMP1_EN))
+			config |= ADM1278_TEMP1_EN;
 		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
+		if (!(config & ADM1278_VOUT_EN))
 			config |= ADM1278_VOUT_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
+		if (ret != config) {
+			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
 			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
+				dev_err(&client->dev, "Failed to enable config control bits");
+				return ret;
 			}
 		}
 
@@ -685,16 +691,18 @@ static int adm1275_probe(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+		ret = config;
+		/* Enable temp if it is instructed by dt (it is disabled by default) */
+		if (temp1_en && !(config & ADM1278_TEMP1_EN))
+			config |= ADM1278_TEMP1_EN;
 		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
+		if (!(config & ADM1278_VOUT_EN))
 			config |= ADM1278_VOUT_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
+		if (ret != config) {
+			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
 			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
+				dev_err(&client->dev, "Failed to enable config control bits");
+				return ret;
 			}
 		}
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

