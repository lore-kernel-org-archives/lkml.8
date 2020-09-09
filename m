Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB25C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035FE21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p4MUG4M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIIIyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgIIIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37124C061795
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:54:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so1989698wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apIbSsxgZ3NvYShmhAM+VYa5iL4D093LfOrEXyfUml0=;
        b=p4MUG4M2XdBlzabakblhZUYnvPy0A6xxOG3JsXgWOADWrqUClY8fmjeIrCUCprQ7GG
         bb3EE+6VAi6L9wF+wroA1J8ovJqHafMlCeqlZGtrsYq5+EIRYSoJkXVUfO2I8X4C/wRC
         4Ki5zMK30W/x8pZLWVYBcRDU0j03j50BNuPYiM6arniagLqofm42K+jj1POFFJs2A5LW
         pGZ+4trgD3jAY7hxZnqsrEvndw9VT47fBzUs+mtjINjb8WRppjGiOMrShDavUCf49alo
         yfgiOa/QO+Up4wHeAVj9j8fSbcnwS2Qc9aSSzlt7rknW5WV6e8GzJ6cpKWUKYmbD2OY6
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apIbSsxgZ3NvYShmhAM+VYa5iL4D093LfOrEXyfUml0=;
        b=KliVp40G2/5Dmz/H5c1cpv7W6vbQ+j/bUxXDdxmOzINztOtzKQRSaZmT4WCewcAaxa
         8DxRqlmQKaI7+6/M1dO1O0W+pys5XqO7YHL5humyuzRO71JhWLaElE9n4BGuy8Zp/Uhd
         DmY0R3QRLhUVOe12vUffO/HYPnEWA6g5wHj2w15Z9gikkP9vvcgBwHhPIuQ/V1ysWVEo
         o7p9Mu+fGoVn0UVz2EnPMN0C/BXLdvCf1X9NGo2SnHmZ6/TqIH9uSE0AdjXnOnPGG4HI
         IihxtvrnbMQIrRAZyrmODmEvBwOovdXM+p8JWAoLWd3R7MJVpEYRk656M9e9GNSmM1lj
         GovQ==
X-Gm-Message-State: AOAM532QNunS7sKQwbYqPSTn6Wp9l8yy49h4EFtccnhFfR5r3Y1hYCen
        SZjI7lhUrJBxNfDg1ISJgf1AeQ==
X-Google-Smtp-Source: ABdhPJw8r23Zd9WJ0lZ/NbQON8+zBEaKodj2Fba4mT+MKk3C/AH7xF2QEYr1fuoGXOWvIDUohTQ8Og==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr2926512wrm.229.1599641675594;
        Wed, 09 Sep 2020 01:54:35 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/3] gpiolib: unexport devprop_gpiochip_set_names()
Date:   Wed,  9 Sep 2020 10:54:26 +0200
Message-Id: <20200909085426.19862-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
References: <20200909085426.19862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that devprop_gpiochip_set_names() is only used in a single place
inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
exported or to even live in its own source file. Pull this function into
the core source file for gpiolib.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-devprop.c | 63 ----------------------------------
 drivers/gpio/gpiolib.c         | 47 +++++++++++++++++++++++++
 include/linux/gpio/driver.h    |  2 --
 4 files changed, 47 insertions(+), 66 deletions(-)
 delete mode 100644 drivers/gpio/gpiolib-devprop.c

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4f9abff4f2dc..639275eb4e4d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -6,7 +6,6 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-devres.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
-obj-$(CONFIG_GPIOLIB)		+= gpiolib-devprop.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-cdev.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
deleted file mode 100644
index 31599d89a85d..000000000000
--- a/drivers/gpio/gpiolib-devprop.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device property helpers for GPIO chips.
- *
- * Copyright (C) 2016, Intel Corporation
- * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#include <linux/property.h>
-#include <linux/slab.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/driver.h>
-#include <linux/export.h>
-
-#include "gpiolib.h"
-
-/**
- * devprop_gpiochip_set_names - Set GPIO line names using device properties
- * @chip: GPIO chip whose lines should be named, if possible
- *
- * Looks for device property "gpio-line-names" and if it exists assigns
- * GPIO line names for the chip. The memory allocated for the assigned
- * names belong to the underlying software node and should not be released
- * by the caller.
- */
-int devprop_gpiochip_set_names(struct gpio_chip *chip)
-{
-	struct gpio_device *gdev = chip->gpiodev;
-	struct device *dev = chip->parent;
-	const char **names;
-	int ret, i;
-	int count;
-
-	count = device_property_string_array_count(dev, "gpio-line-names");
-	if (count < 0)
-		return 0;
-
-	if (count > gdev->ngpio) {
-		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
-			 count, gdev->ngpio);
-		count = gdev->ngpio;
-	}
-
-	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
-	if (!names)
-		return -ENOMEM;
-
-	ret = device_property_read_string_array(dev, "gpio-line-names",
-						names, count);
-	if (ret < 0) {
-		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
-		kfree(names);
-		return ret;
-	}
-
-	for (i = 0; i < count; i++)
-		gdev->descs[i].name = names[i];
-
-	kfree(names);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devprop_gpiochip_set_names);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d390f0ec32c..943a2de340d8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -358,6 +358,53 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	return 0;
 }
 
+/*
+ * devprop_gpiochip_set_names - Set GPIO line names using device properties
+ * @chip: GPIO chip whose lines should be named, if possible
+ *
+ * Looks for device property "gpio-line-names" and if it exists assigns
+ * GPIO line names for the chip. The memory allocated for the assigned
+ * names belong to the underlying software node and should not be released
+ * by the caller.
+ */
+static int devprop_gpiochip_set_names(struct gpio_chip *chip)
+{
+	struct gpio_device *gdev = chip->gpiodev;
+	struct device *dev = chip->parent;
+	const char **names;
+	int ret, i;
+	int count;
+
+	count = device_property_string_array_count(dev, "gpio-line-names");
+	if (count < 0)
+		return 0;
+
+	if (count > gdev->ngpio) {
+		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
+			 count, gdev->ngpio);
+		count = gdev->ngpio;
+	}
+
+	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev, "gpio-line-names",
+						names, count);
+	if (ret < 0) {
+		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
+		kfree(names);
+		return ret;
+	}
+
+	for (i = 0; i < count; i++)
+		gdev->descs[i].name = names[i];
+
+	kfree(names);
+
+	return 0;
+}
+
 static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
 {
 	unsigned long *p;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 56485a040b82..4a7e295c3640 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -756,8 +756,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
-int devprop_gpiochip_set_names(struct gpio_chip *gc);
-
 #ifdef CONFIG_GPIOLIB
 
 /* lock/unlock as IRQ */
-- 
2.26.1

