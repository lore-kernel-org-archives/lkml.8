Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48894C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1620F206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cvyMcRXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIDPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIDPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AEC061231
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so7191195wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cb3cnGs7j5WS2IcngwK5TKfzy31yqveiACoeOQ6PNok=;
        b=cvyMcRXDXhXJQxnzLheQiagZqk91Hq3/DSe9O6FVYKHP/1Z0rIZBkBb06Hc1ZOsmKC
         BJLw9+MREkwONtKQHHVg0Zm+VK+NwCmqrAtyqndwca00OEQJzmAH691WJ4BwomrC/lDi
         ueqFD5Xez3f5fWi8k6HnlpPnQcWdfbvIob4B7zrpeCwjM2jgfOb1nzFyOwbfHBV3uEok
         utKIZVZ1tu4QhZRdeHawOCIhgmXIbtxZfbIEhf8Sm9mHmscVLOsTww4QkVJrZeT8woTV
         AAn0VAiAYSyj/MEGJzBQvAE/pU/teeVk9dprJLAhzo9hik115rydBc26fBE5iuQHznMt
         WpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cb3cnGs7j5WS2IcngwK5TKfzy31yqveiACoeOQ6PNok=;
        b=s1LA/admCPSK0Nuqmyk611Owz5TU+YzuFXWtFJ5L3GewYPAw4I+jhJLe7loU9gd41/
         w28Fp7Xc+oxemwB4sXm9eIjOZlsabixYwltcXTSBlViMSJyaSNaMgk9pbh9e8KaN6tgB
         9aHdDdomWXqyocVnqp9mYK3lHQvJktOLFWsfbd/f5WaJVSjxEF162oDdVWoI5XokttSy
         sOo6NmARHuRneZgnceqf9qcAmMvpF2LlPEUARAEsuxN7QxDPf5uHtAfk8a22v5oENoDU
         4UFx5tldnaS/1KfurCwEVM+vegWfJCKGaJJPr5vshS6s9TenhkVADjJF8h+Ee6L+lUtL
         qljg==
X-Gm-Message-State: AOAM530ob92ZPTqJlmyD+DfDFSqJIim+pjN8l7DxrXa/nTXmCjMjzHDu
        /UqK0aHSCkQqUNo+ql1YlW3WOA==
X-Google-Smtp-Source: ABdhPJyCwJJId2FBp9EzeFlUcmTzo35MIF3b1AJLQnqt3x7RSOA5HXIN8vSfohQcUDDXbopw85qnBw==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr7909391wrs.28.1599234395939;
        Fri, 04 Sep 2020 08:46:35 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/23] gpiolib: generalize devprop_gpiochip_set_names() for device properties
Date:   Fri,  4 Sep 2020 17:45:28 +0200
Message-Id: <20200904154547.3836-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
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
---
 drivers/gpio/gpiolib-acpi.c    |  3 ---
 drivers/gpio/gpiolib-devprop.c | 19 ++++++++++---------
 drivers/gpio/gpiolib-of.c      |  5 -----
 drivers/gpio/gpiolib.c         |  8 ++++----
 include/linux/gpio/driver.h    |  3 +--
 5 files changed, 15 insertions(+), 23 deletions(-)

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
index 26741032fa9e..a28659b4f9c9 100644
--- a/drivers/gpio/gpiolib-devprop.c
+++ b/drivers/gpio/gpiolib-devprop.c
@@ -17,25 +17,24 @@
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
+	count = device_property_read_string_array(dev, "gpio-line-names",
 						  NULL, 0);
 	if (count < 0)
-		return;
+		return 0;
 
 	if (count > gdev->ngpio) {
 		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
@@ -45,19 +44,21 @@ void devprop_gpiochip_set_names(struct gpio_chip *chip,
 
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

