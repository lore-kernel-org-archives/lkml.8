Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC30C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EAF22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbCwKuR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgGTUOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbgGTUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:14:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D2C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w8so11083519plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WXyRYBH3lUh7Umxi2hQ4QtCTReXFYZYL0z8hscZP+wo=;
        b=AbCwKuR9T/1CW5k9yah+qNwtVfR+CZ+owvkLdgnoW02XcdReVJXFhxPJQdMZ6NBU9s
         6n/Xmm4xRpSFeYJr4hhWiGWItWb3wd0jIwPqWY7/npRaaL3gYa4mK2XwI2UBinbq0Q5j
         R6MCK0ksI09BwxZvNKp6JYUuQH5TiOC9nAXni7luaCYHXqYqIUhgatF6LgBbQjEx0S+l
         KIYRE6zTsmnxP1aODkjtTaoWBfsyoSoWVpzjoyXzEZfNVVhtW8vS6ex+d33sQhZuNNfG
         Bol7OHnyDRq4Ku5WBMfw+kVptxV/rgSFDOLx4ND/GNdcYuseULZwF0h59sswPV8fWcHD
         icDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WXyRYBH3lUh7Umxi2hQ4QtCTReXFYZYL0z8hscZP+wo=;
        b=EjesJkXy7RyxE0e4xJoiMIcRcGzq/+57GVia5/QqjZPTOUhRc5ZfqQ067g5v8d9mxY
         V9PKEJyhQhgADtSLpcKI6fAn8UQkyK6xXDU/YOv4mbDBe0upusOeJd+TETU8Z4S2tZTP
         CiMiIBlPAAbUedEYVjT5sGUJm4GSOKx7dHnYWwIKUby58CiCq9U3gXZhc/sYt0pMDpRs
         vntCcHv4G5OfIcRy2DHvMNcYv++GmlG2FskGkfXfveSxptpYcUmR2C0AFeUAISgsqvob
         hUWTJDiYKDipf0Fh6Iw/XVrneVnbqCF8B//4aZSQVYQNsNZ16f/UK/cDn/siVmDPKm31
         M58Q==
X-Gm-Message-State: AOAM533ChmPwcr5ssM/5iKxGh9M8IM9IojHPXEmkpEvkpkxohkJUCXee
        3Hf4imD7ooqSNCpRv/l1sFl+DyXgDd7v4X1f
X-Google-Smtp-Source: ABdhPJzJdB5vVYeTESa4TojPzKbv2IbuTs5hlhZh2o3UdEOdno8ALDzergtCvkt5KWEBkH+J0skw3c4y5QOgwm7Z
X-Received: by 2002:a17:90a:368c:: with SMTP id t12mr1111761pjb.90.1595276085336;
 Mon, 20 Jul 2020 13:14:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 20:14:41 +0000
Message-Id: <20200720201441.1871285-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] hwmon: adm1272: Enable temperature sampling for adm1272 adm1278
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     =belgaied@google.com, jasonling@google.com, linchuyuan@google.com,
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
	Introducing device tree binding analog-temperature1-enable. If the
flag is set, flip the temp1_en control bit on probing.

Testing:
1). iotools smbus_write16 35 0x10 0xd4 0x0037 // disable the temp1_en
2). recompile the dt to have  analog-temperature1-enable set
3). Probe the driver and make sure tempX shows up in hwmon

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 19317575d1c6..ae28820b3e31 100644
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
 
+	temp1_en = of_property_read_bool(client->dev.of_node, "analog-temperature1-enable") &&
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

