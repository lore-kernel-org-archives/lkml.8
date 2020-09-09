Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C57EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49ED21D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="otUwM2M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgIIIzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9271C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:54:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so1995135wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPMxGpr+QGmkhggb489uiTdIfshLbRulDWZhsNIiQQ0=;
        b=otUwM2M8fg6sUNUlUOQv2teY8eBLuSSXPA1O+KLiU8GAIx0C5oyXwzkSp1hAEbXzrh
         wR77Nc+iTZTHpu+qsEOLbTBoEctRA8jwCZa0/+PsOBgdW3urGYxTxwTDv3aFQXEHay4R
         VG4t1r3jJYZudV92WuzFRg6I4FceUgjC31gcI8yAZoewULhbriw3gv0kpZkMo4KXdChd
         1iitu6J8QtcsZq0qp28TDTwjWDaq6hoH0+OVOaGBqyg/b4dbD0QDavtNI5NXFFGq1E1v
         guSMKpgxPCnGeFw3iDTZ9G36vajzgeEDz/oTfgzC+nu2gQFF1YRhyznQDS7jTCfqlaNo
         TmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPMxGpr+QGmkhggb489uiTdIfshLbRulDWZhsNIiQQ0=;
        b=AZLACESkOmoyZQbdZre1V+gu7d7k12KHvdNeNSOQUcW5o9HxX06fJSBphOGzKRW7P4
         L7hxwjjF1FNjfygfHZzyEtHS0A1OYpkYL5TFtm3H0zHD1Twv/pmzGX6MV1NmZY46K7lk
         KCB6RAjGpLepQkm3Pi/4U/qOq6dxOMYToqetkVBpOJoEK2UEjsbvMa9AOQlUyJS/syLv
         Cr3yBEbWv+QbbuSVrQl/wV7zK0t/s4YEA+mMllA3RrOiRrAKKoUEGTO668j90BupFmsu
         +8NxOAmWz8YEMIsVV3vNxN5R9mbUQhv1Gpd6ktntCOq1dgTbEd5mWy//s6X6MuwWCRCD
         Sh+w==
X-Gm-Message-State: AOAM532t+aHQPKuoNL2++hg+QJb3XOMaMZEcdDlv31puU6z5qP4uWw6d
        va/UOAVAvUlTVYCAImhbs8t4Ww==
X-Google-Smtp-Source: ABdhPJyjCMVwPB9EVQf6t5VG8C1T/fmtpLMTR9b7o4akg5vT15n4K/Us+Gh0Xbin7xbSiUnFFIYs7A==
X-Received: by 2002:adf:8342:: with SMTP id 60mr3177139wrd.158.1599641674463;
        Wed, 09 Sep 2020 01:54:34 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/3] gpiolib: generalize devprop_gpiochip_set_names() for device properties
Date:   Wed,  9 Sep 2020 10:54:25 +0200
Message-Id: <20200909085426.19862-3-brgl@bgdev.pl>
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

devprop_gpiochip_set_names() is overly complicated with taking the
fwnode argument (which requires using dev_fwnode() & of_fwnode_handle()
in ACPI and OF GPIO code respectively). Let's just switch to using the
generic device properties.

This allows us to pull the code setting line names directly into
gpiochip_add_data_with_key() instead of handling it separately for
ACPI and OF.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c    |  3 ---
 drivers/gpio/gpiolib-devprop.c | 20 ++++++++++----------
 drivers/gpio/gpiolib-of.c      |  5 -----
 drivers/gpio/gpiolib.c         |  8 ++++----
 include/linux/gpio/driver.h    |  3 +--
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 54ca3c18b291..834a12f3219e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1221,9 +1221,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 		return;
 	}
 
-	if (!chip->names)
-		devprop_gpiochip_set_names(chip, dev_fwnode(chip->parent));
-
 	acpi_gpiochip_request_regions(acpi_gpio);
 	acpi_gpiochip_scan_gpios(acpi_gpio);
 	acpi_walk_dep_device_list(handle);
diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
index 26741032fa9e..31599d89a85d 100644
--- a/drivers/gpio/gpiolib-devprop.c
+++ b/drivers/gpio/gpiolib-devprop.c
@@ -17,25 +17,23 @@
 /**
  * devprop_gpiochip_set_names - Set GPIO line names using device properties
  * @chip: GPIO chip whose lines should be named, if possible
- * @fwnode: Property Node containing the gpio-line-names property
  *
  * Looks for device property "gpio-line-names" and if it exists assigns
  * GPIO line names for the chip. The memory allocated for the assigned
- * names belong to the underlying firmware node and should not be released
+ * names belong to the underlying software node and should not be released
  * by the caller.
  */
-void devprop_gpiochip_set_names(struct gpio_chip *chip,
-				const struct fwnode_handle *fwnode)
+int devprop_gpiochip_set_names(struct gpio_chip *chip)
 {
 	struct gpio_device *gdev = chip->gpiodev;
+	struct device *dev = chip->parent;
 	const char **names;
 	int ret, i;
 	int count;
 
-	count = fwnode_property_read_string_array(fwnode, "gpio-line-names",
-						  NULL, 0);
+	count = device_property_string_array_count(dev, "gpio-line-names");
 	if (count < 0)
-		return;
+		return 0;
 
 	if (count > gdev->ngpio) {
 		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
@@ -45,19 +43,21 @@ void devprop_gpiochip_set_names(struct gpio_chip *chip,
 
 	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
 	if (!names)
-		return;
+		return -ENOMEM;
 
-	ret = fwnode_property_read_string_array(fwnode, "gpio-line-names",
+	ret = device_property_read_string_array(dev, "gpio-line-names",
 						names, count);
 	if (ret < 0) {
 		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
 		kfree(names);
-		return;
+		return ret;
 	}
 
 	for (i = 0; i < count; i++)
 		gdev->descs[i].name = names[i];
 
 	kfree(names);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devprop_gpiochip_set_names);
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index bd31dd3b6a75..2f895a2b8411 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1026,11 +1026,6 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (ret)
 		return ret;
 
-	/* If the chip defines names itself, these take precedence */
-	if (!chip->names)
-		devprop_gpiochip_set_names(chip,
-					   of_fwnode_handle(chip->of_node));
-
 	of_node_get(chip->of_node);
 
 	ret = of_gpiochip_scan_gpios(chip);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 80137c1b3cdc..0d390f0ec32c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -340,9 +340,6 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	struct gpio_device *gdev = gc->gpiodev;
 	int i;
 
-	if (!gc->names)
-		return 0;
-
 	/* First check all names if they are unique */
 	for (i = 0; i != gc->ngpio; ++i) {
 		struct gpio_desc *gpio;
@@ -621,7 +618,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
 
-	ret = gpiochip_set_desc_names(gc);
+	if (gc->names)
+		ret = gpiochip_set_desc_names(gc);
+	else
+		ret = devprop_gpiochip_set_names(gc);
 	if (ret)
 		goto err_remove_from_list;
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index d1cef5c2715c..56485a040b82 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -756,8 +756,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
-void devprop_gpiochip_set_names(struct gpio_chip *gc,
-				const struct fwnode_handle *fwnode);
+int devprop_gpiochip_set_names(struct gpio_chip *gc);
 
 #ifdef CONFIG_GPIOLIB
 
-- 
2.26.1

