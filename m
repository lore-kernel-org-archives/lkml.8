Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD5C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC8206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard-ru.20150623.gappssmtp.com header.i=@wirenboard-ru.20150623.gappssmtp.com header.b="N3cEfvno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgIDQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgIDQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:00:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691CC06124F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:00:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y2so4086518lfy.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AW56wQccikiQIcO5sZ4HiDLru8/jPcKFLtXsv2mxXg=;
        b=N3cEfvnogvWOuPypdwn+TWu8S4oojW+RuOQunVMldLHX9R0EdJEj+69a0cJtTHF+9Q
         iDb3SE+FOQeZnskbGQQXAciVCkldblv+GO6n7uLOyf4rVabb39w53Yppult+F+rFDhb+
         lB4vwErxHRdKtMJcyoxyMhSl2+P+NPZ28xORd/mBCbN2wOlKam44gD+DfKYD5LFNgIE5
         nawc3Is3iJ89DggKqvrmNJJrQ54nY/43QU3YG5L9wcdUgSch/oxNBz5wv+S6HQcqLhOF
         LrEjtLpr3ZsIMnw9iI6i0bHp7sgQqwTArdHBJeB7i6YsS2HBfFLpuVQoY7qbHWhge3za
         2s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AW56wQccikiQIcO5sZ4HiDLru8/jPcKFLtXsv2mxXg=;
        b=RUQfGrMcFl+bCMZBi0TWBdIXeagOw0P7elsmZWpqZsfDBF2S7jZf3er7h1QvUt+YEG
         4es8wX/Y+qWrOXJdb0iIGlc9oq9tMNfECBk5GXHquTbBijNSfR3yJGyLNLZTRUV8Nwdj
         LfmsTMTr+KHYyy/YsNA3s7s79DtfQWkGWjDL2yFIY5Q5hfHhF2YyEGEtZDh8A7aZEGJi
         TiJwlOIPPXDWPWybtZePS2AIrh80TKvSUlly66Plh0CjN/IGrUinYR+VLxyly5S5+XvX
         /8QyVkWVPfp+QeCibYytCfoEBLYwkJbO0J3757H5lAOyg2gK8SQSVmPgD2LyEUJadWkK
         LciQ==
X-Gm-Message-State: AOAM531KwBWbtu4OQ2ue7R7Y0yxtsWQcdCkCYGBq08qAxLtbXzfbR+F0
        6gWGWr1O+AIglm6yFE8WA92cvQ==
X-Google-Smtp-Source: ABdhPJxwUVVVg/TWVpQPFxhnTsLcgr/Qstfi3xg5zuzTZWnddRhmgm+juf5hM44O1xd1FbDhz26uGA==
X-Received: by 2002:a19:cb96:: with SMTP id b144mr4196111lfg.143.1599235223235;
        Fri, 04 Sep 2020 09:00:23 -0700 (PDT)
Received: from localhost.localdomain ([176.59.72.156])
        by smtp.googlemail.com with ESMTPSA id 68sm1358114ljj.135.2020.09.04.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:00:22 -0700 (PDT)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Subject: [PATCH 2/2] w1: w1_therm: Add support for GXCAS GX20MH01 device.
Date:   Fri,  4 Sep 2020 19:00:04 +0300
Message-Id: <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GX20MH01 device shares family number 0x28 with DS18B20. The device
is generally compatible with DS18B20. Added are the lowest 2^-5, 2^-6
temperature bits in Config register; R2 bit in Config register
enabling 13 and 14 bit resolutions. It is powered up in 14 bit mode.

Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
---
 .../ABI/testing/sysfs-driver-w1_therm         |   4 +-
 Documentation/w1/slaves/w1_therm.rst          |  15 ++-
 drivers/w1/slaves/w1_therm.c                  | 106 +++++++++++++-----
 3 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index b44b51a88c5e..9f05bcdcd762 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -49,7 +49,7 @@ Description:
 		will be changed only in device RAM, so it will be cleared when
 		power is lost. Trigger a 'save' to EEPROM command to keep
 		values after power-on. Read or write are :
-			* '9..12': device resolution in bit
+			* '9..14': device resolution in bit
 			or resolution to set in bit
 			* '-xx': xx is kernel error when reading the resolution
 			* Anything else: do nothing
@@ -89,7 +89,7 @@ Description:
 		*write* :
 			* '0' : save the 2 or 3 bytes to the device EEPROM
 			(i.e. TH, TL and config register)
-			* '9..12' : set the device resolution in RAM
+			* '9..14' : set the device resolution in RAM
 			(if supported)
 			* Anything else: do nothing
 		refer to Documentation/w1/slaves/w1_therm.rst for detailed
diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index f1148181f53e..00376501a5ef 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -6,6 +6,7 @@ Supported chips:
 
   * Maxim ds18*20 based temperature sensors.
   * Maxim ds1825 based temperature sensors.
+  * GXCAS GC20MH01 temperature sensor.
 
 Author: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 
@@ -13,8 +14,8 @@ Author: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 Description
 -----------
 
-w1_therm provides basic temperature conversion for ds18*20 devices, and the
-ds28ea00 device.
+w1_therm provides basic temperature conversion for ds18*20, ds28ea00, GX20MH01
+devices.
 
 Supported family codes:
 
@@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
 power), the driver returns a conversion error. Bit mask ``2`` enables poll for
 conversion completion (normal power only) by generating read cycles on the bus
 after conversion starts. In parasite power mode this feature is not available.
-Feature bit masks may be combined (OR).
+Feature bit masks may be combined (OR). See accompanying sysfs documentation:
+:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
+
+GX20MH01 device shares family number 0x28 with DS18*20. The device is generally
+compatible with DS18B20. Added are lowest 2^-5, 2^-6 temperature bits in Config
+register; R2 bit in Config register enabling 13 and 14 bit resolutions. The
+device is powered up in 14-bit resolution mode. The conversion times specified
+in the datasheet are too low and have to be increased. The device supports
+driver features ``1`` and ``2``.
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9b2d96335a70..f6b0e0320ffc 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -80,6 +80,18 @@ static u16 bulk_read_device_counter; /* =0 as per C standard */
 #define W1_POLL_CONVERT_TEMP 2000	/* Timeout for W1_CONVERT_TEMP, ms */
 #define W1_POLL_RECALL_EEPROM 500	/* Timeout for W1_RECALL_EEPROM, ms*/
 
+/* Masks for resolution functions, work with all devices */
+/* Bit mask for config register for all devices, bits 7,6,5 */
+#define W1_THERM_RESOLUTION_MASK 0xE0
+/* Bit offset of resolution in config register for all devices */
+#define W1_THERM_RESOLUTION_SHIFT 5
+/* Bit offset of resolution in config register for all devices */
+#define W1_THERM_RESOLUTION_SHIFT 5
+/* Add this to bit value to get resolution */
+#define W1_THERM_RESOLUTION_MIN 9
+/* Maximum allowed value */
+#define W1_THERM_RESOLUTION_MAX 14
+
 /* Helpers Macros */
 
 /*
@@ -523,7 +535,9 @@ static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 	if (SLAVE_CONV_TIME_OVERRIDE(sl) != CONV_TIME_DEFAULT)
 		return SLAVE_CONV_TIME_OVERRIDE(sl);
 
-	/* Return the conversion time from datasheet, depending on resolution */
+	/* Return the conversion time, depending on resolution,
+	 * select maximum conversion time among all compatible devices
+	 */
 	switch (SLAVE_RESOLUTION(sl)) {
 	case 9:
 		ret = 95;
@@ -535,6 +549,14 @@ static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 		ret = 375;
 		break;
 	case 12:
+		ret = 750;
+		break;
+	case 13:
+		ret = 850;  /* GX20MH01 only. Datasheet says 500ms, but that's not enough. */
+		break;
+	case 14:
+		ret = 1600; /* GX20MH01 only. Datasheet says 1000ms - not enough */
+		break;
 	default:
 		ret = 750;
 	}
@@ -568,62 +590,71 @@ static inline int w1_DS18S20_write_data(struct w1_slave *sl,
 static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 {
 	int ret;
-	u8 new_config_register[3];	/* array of data to be written */
 	struct therm_info info, info2;
 
-	/* resolution of DS18B20 is in the range [9..12] bits */
-	if (val < 9 || val > 12)
+	/* DS18B20 resolution is 9 to 12 bits */
+	/* GX20MH01 resolution is 9 to 14 bits */
+	if (val < W1_THERM_RESOLUTION_MIN || val > W1_THERM_RESOLUTION_MAX)
 		return -EINVAL;
 
-	val -= 9; /* soustract 9 the lowest resolution in bit */
-	val = (val << 5); /* shift to position bit 5 & bit 6 */
+	/* Calc bit value from resolution */
+	val = (val - W1_THERM_RESOLUTION_MIN) << W1_THERM_RESOLUTION_SHIFT;
 
 	/*
 	 * Read the scratchpad to change only the required bits
 	 * (bit5 & bit 6 from byte 4)
 	 */
 	ret = read_scratchpad(sl, &info);
-	if (!ret) {
-		new_config_register[0] = info.rom[2];
-		new_config_register[1] = info.rom[3];
-		/* config register is byte 4 & mask 0b10011111*/
-		new_config_register[2] = (info.rom[4] & 0x9F) |
-					(u8) val;
-	} else
+
+	if (ret)
 		return ret;
 
+
+	info.rom[4] &= ~W1_THERM_RESOLUTION_MASK;
+	info.rom[4] |= val;
+
 	/* Write data in the device RAM */
-	ret = w1_DS18B20_write_data(sl, new_config_register);
+	ret = w1_DS18B20_write_data(sl, info.rom + 2);
 	if (ret)
 		return ret;
 
-	/* Some DS18B20 clones don't support resolution change, read back to verify */
+	/* Have to read back the resolution to verify an actual value
+	 * GX20MH01 and DS18B20 are indistinguishable by family number, but resolutions differ
+	 * Some DS18B20 clones don't support resolution change
+	 */
 	ret = read_scratchpad(sl, &info2);
 	if (ret)
+		/* Scratchpad read fail */
 		return ret;
 
-	if ((info2.rom[4] & 0x9F) == (info.rom[4] & 0x9F))
+	if ((info2.rom[4] & W1_THERM_RESOLUTION_MASK) == (info.rom[4] & W1_THERM_RESOLUTION_MASK))
 		return 0;
-	else
-		return -EIO;
+
+	/* Resolution verify error */
+	return -EIO;
 }
 
 static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
 {
 	int ret;
-	u8 config_register;
+	int resolution;
 	struct therm_info info;
 
 	ret = read_scratchpad(sl, &info);
 
-	if (!ret)	{
-		config_register = info.rom[4]; /* config register is byte 4 */
-		config_register &= 0x60; /* 0b01100000 keep only bit 5 & 6 */
-		config_register = (config_register >> 5);	/* shift */
-		config_register += 9; /* add 9 the lowest resolution in bit */
-		ret = (int) config_register;
-	}
-	return ret;
+	if (ret)
+		return ret;
+
+	resolution = ((info.rom[4] & W1_THERM_RESOLUTION_MASK) >> W1_THERM_RESOLUTION_SHIFT)
+		+ W1_THERM_RESOLUTION_MIN;
+	/* GX20MH01 has one special case:
+	 *   >=14 means 14 bits when getting resolution from bit value.
+	 * Other devices have no more then 12 bits.
+	 */
+	if (resolution > W1_THERM_RESOLUTION_MAX)
+		resolution = W1_THERM_RESOLUTION_MAX;
+
+	return resolution;
 }
 
 /**
@@ -636,11 +667,28 @@ static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
  */
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
-	s16 t = le16_to_cpup((__le16 *)rom);
+	int t;
+	u32 bv;
+
+	/* Config register bit R2 = 1 - GX20MH01 in 13 or 14 bit resolution mode */
+	if (rom[4] & 0x80) {
+		/* Signed 16-bit value to unsigned, cpu order */
+		bv = le16_to_cpup((__le16 *)rom);
+
+		/* Insert two temperature bits from config register */
+		/* Avoid arithmetic shift of signed value */
+		bv = (bv << 2) | (rom[4] & 3);
 
+		t = (int) sign_extend32(bv, 17); /* Degrees, lowest bit is 2^-6 */
+		return (t*1000)/64;  /* Millidegrees */
+	}
+
+	t = (int)le16_to_cpup((__le16 *)rom);
 	return t*1000/16;
 }
 
+
+
 /**
  * w1_DS18S20_convert_temp() - temperature computation for DS18S20
  * @rom: data read from device RAM (8 data bytes + 1 CRC byte)
@@ -672,6 +720,7 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 }
 
 /* Device capability description */
+/* GX20MH01 device shares family number and structure with DS18B20 */
 
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
@@ -693,6 +742,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.bulk_read			= true
 	},
 	{
+		/* Also used for GX20MH01 */
 		.f				= &w1_therm_family_DS18B20,
 		.convert			= w1_DS18B20_convert_temp,
 		.get_conversion_time	= w1_DS18B20_convert_time,
-- 
2.25.1

