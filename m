Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52446C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D72076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReI/5esu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgD3OH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgD3Nw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF1C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:52:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so6536935ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAtCOew/m4+u0IYYxmZif/ohnK/1bYIl1iw2On1jh0I=;
        b=ReI/5esuBIGl/2a42HwrgyHf767y1P4PRt1TCBPdZPyHfuQ6/jv0AxHlbckTLRjsyC
         wR9meYMzu2dCLFRExXl8SGt1k7u+q9NvnyYjbDRb83IlzZ95OyuTHbA8mOXYhyNfa06n
         EcEL34nP/7J8kIT6BOOiyfrISd71iIGH1ludWg4gdIPjHctoo58Af6UE6I0ZDMKmXzQH
         6ibMIntXqrGnxoCKwbdC8GE+OO2hY2Om2RIIzit+7uxUJQHXojHh9viHPTtYGpIfGCBD
         AWULSvzLd0vsE1gGz966HqvKo5MNmynNHXXMbHZCbajZLEA07cZlP8ku1i0iSc7QV+z6
         mnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LAtCOew/m4+u0IYYxmZif/ohnK/1bYIl1iw2On1jh0I=;
        b=uIjNOa0lf5Ve+QcBLKXSPSTbvhxysMAggZ7iCjYIlOsZcredVLaq7b+zVvv09QIbDk
         ZEBImxCRKGmf0YRPehlHlQPu34XNWl61bNCyTKZ0wo1NwetEE6Cuzp+ubekTkFD+PeMY
         vgp3keurMFmwVQb+qJslmi1ndmZpMXQW1rdAhzmunvqq9prnOZD+J1tX0j8io0Qj8cMA
         vJdl95SbHN0rYSZvuOPlfgoxw6/BVGTpWKuGOdmZaszHHhev5mKgiZmC8nX1YBM86DWg
         mVLAZoLZZ5rWwfkdvE6yYQkgGkIia75CGX4jkoyP9i8inQpdScl9Ue2+wYmJfDWesPm9
         Z2pg==
X-Gm-Message-State: AGi0PuYg88yjWn32tKoj/mjVrQfWf1DaLS5kW9ncpMgPRLwcOwP3vUw2
        IxiMdOf4o4A648O1H+wZR8c=
X-Google-Smtp-Source: APiQypIDH51l50C75VlRK3orT+fsbRDMyFcNTGaILWM1+LVmDctM+rhLdBWd55xGMGmNeYt09E6b9g==
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr2262695ljn.185.1588254746736;
        Thu, 30 Apr 2020 06:52:26 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id v3sm4922036lfo.62.2020.04.30.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:52:25 -0700 (PDT)
From:   Ricardo Ribalda <ricardo@ribalda.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH] mailmap: change email for Ricardo Ribalda
Date:   Thu, 30 Apr 2020 15:52:24 +0200
Message-Id: <20200430135224.362700-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ricardo@ribalda.com>

Modify  emails to ribalda@kernel.org and unify my surname in all the
files.

Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>
---
 .mailmap                             | 4 +++-
 CREDITS                              | 6 ++++--
 MAINTAINERS                          | 4 ++--
 drivers/iio/dac/ad5761.c             | 4 ++--
 drivers/iio/dac/ti-dac7612.c         | 4 ++--
 drivers/leds/leds-pca963x.c          | 2 +-
 drivers/media/i2c/imx214.c           | 4 ++--
 include/linux/platform_data/ad5761.h | 2 +-
 8 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/.mailmap b/.mailmap
index db3754a41018..3d274411fe36 100644
--- a/.mailmap
+++ b/.mailmap
@@ -234,7 +234,9 @@ Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
 Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
 Rémi Denis-Courmont <rdenis@simphalempin.com>
-Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
+Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
+Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
+Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
diff --git a/CREDITS b/CREDITS
index 032b5994f476..0787b5872906 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3104,14 +3104,16 @@ W: http://www.qsl.net/dl1bke/
 D: Generic Z8530 driver, AX.25 DAMA slave implementation
 D: Several AX.25 hacks
 
-N: Ricardo Ribalda Delgado
-E: ricardo.ribalda@gmail.com
+N: Ricardo Ribalda
+E: ribalda@kernel.org
 W: http://ribalda.com
 D: PLX USB338x driver
 D: PCA9634 driver
 D: Option GTM671WFS
 D: Fintek F81216A
 D: AD5761 iio driver
+D: TI DAC7612 driver
+D: Sony IMX214 driver
 D: Various kernel hacks
 S: Qtechnology A/S
 S: Valby Langgade 142
diff --git a/MAINTAINERS b/MAINTAINERS
index 26f281d9f32a..385f8f9207ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15650,7 +15650,7 @@ F:	drivers/ssb/
 F:	include/linux/ssb/
 
 SONY IMX214 SENSOR DRIVER
-M:	Ricardo Ribalda <ricardo.ribalda@gmail.com>
+M:	Ricardo Ribalda <ribalda@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
@@ -16637,7 +16637,7 @@ S:	Maintained
 F:	sound/soc/ti/
 
 TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
-M:	Ricardo Ribalda <ricardo@ribalda.com>
+M:	Ricardo Ribalda <ribalda@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 4fb42b743f0f..7468fbd11684 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -3,7 +3,7 @@
  * AD5721, AD5721R, AD5761, AD5761R, Voltage Output Digital to Analog Converter
  *
  * Copyright 2016 Qtechnology A/S
- * 2016 Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ * 2016 Ricardo Ribalda <ribalda@kernel.org>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -423,6 +423,6 @@ static struct spi_driver ad5761_driver = {
 };
 module_spi_driver(ad5761_driver);
 
-MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
+MODULE_AUTHOR("Ricardo Ribalda <ribalda@kernel.org>");
 MODULE_DESCRIPTION("Analog Devices AD5721, AD5721R, AD5761, AD5761R driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index c46805144dd4..de0c6573cd97 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -3,7 +3,7 @@
  * DAC7612 Dual, 12-Bit Serial input Digital-to-Analog Converter
  *
  * Copyright 2019 Qtechnology A/S
- * 2019 Ricardo Ribalda <ricardo@ribalda.com>
+ * 2019 Ricardo Ribalda <ribalda@kernel.org>
  *
  * Licensed under the GPL-2.
  */
@@ -179,6 +179,6 @@ static struct spi_driver dac7612_driver = {
 };
 module_spi_driver(dac7612_driver);
 
-MODULE_AUTHOR("Ricardo Ribalda <ricardo@ribalda.com>");
+MODULE_AUTHOR("Ricardo Ribalda <ribalda@kernel.org>");
 MODULE_DESCRIPTION("Texas Instruments DAC7612 DAC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 66cdc003b8f4..d288acbc99c7 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -4,7 +4,7 @@
  * Copyright 2013 Qtechnology/AS
  *
  * Author: Peter Meerwald <p.meerwald@bct-electronic.com>
- * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ * Author: Ricardo Ribalda <ribalda@kernel.org>
  *
  * Based on leds-pca955x.c
  *
diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 4175d06ffd47..1ef5af9a8c8b 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2018 Qtechnology A/S
  *
- * Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ * Ricardo Ribalda <ribalda@kernel.org>
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -1120,5 +1120,5 @@ static struct i2c_driver imx214_i2c_driver = {
 module_i2c_driver(imx214_i2c_driver);
 
 MODULE_DESCRIPTION("Sony IMX214 Camera driver");
-MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
+MODULE_AUTHOR("Ricardo Ribalda <ribalda@kernel.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/ad5761.h b/include/linux/platform_data/ad5761.h
index 02bef5177ff5..69e261e2ca14 100644
--- a/include/linux/platform_data/ad5761.h
+++ b/include/linux/platform_data/ad5761.h
@@ -3,7 +3,7 @@
  * AD5721, AD5721R, AD5761, AD5761R, Voltage Output Digital to Analog Converter
  *
  * Copyright 2016 Qtechnology A/S
- * 2016 Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ * 2016 Ricardo Ribalda <ribalda@kernel.org>
  */
 #ifndef __LINUX_PLATFORM_DATA_AD5761_H__
 #define __LINUX_PLATFORM_DATA_AD5761_H__
-- 
2.26.2

