Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C77C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1637A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HCiTFjtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIDPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIDPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C946C0619D0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so6538223wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df1vNsIBtzMz3XaBeJ8Q2j/QYEAOiM6PlNqlmnkxGzE=;
        b=HCiTFjtPaoDptruE52sxg0PIrYN0fw4LxlnqDp18boSboMkoVyxeNy/lnftW/3B1VN
         St/clTzUXKDOHSQA056HKj7PuXF/g2RLwdgdIjLG4XG1olSqBHJaH7BtKBIH3CrBfDLT
         imWJKTRh52/m5EJlYTrb+CO3+4IWSd8rNuEeFqLMp3U8My502joushgdUehq4pMigYFC
         AOP5Kf5CVb4VXX4Kw1t81IoEzl31OBdvYQYB7fmnrbnAvsvNNTf6HUl/3korYBFLK59T
         FU4pltRDJrrAPTGx79VWKrY+5RNLNCdo1SqBKIuIwpwB5jdvB/+p+j5Z49o1MfvnBpS9
         J0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df1vNsIBtzMz3XaBeJ8Q2j/QYEAOiM6PlNqlmnkxGzE=;
        b=U8ZbNkDuY/1m0l8qo6xxoXssNWrohneh48Eqb71uBTitBIsAUFdkYbmD7wuLbyZ1nD
         pwF+Sg3B7UjfKlI3lKD9jk78ddNdwpUJ6Cwv9yA+4j8wBCFKxaUQ1s+EH08TIHalti9r
         O3rZSI1Q7MAQh/JrfwUrwme56mpfUGdc1+4cUdfCQjhMSJSFQzAekJPb0sEMwTsl2Hzy
         YMvpKHVx6RcDxhRwnqMaOveC1N+mPGl6Pd7svcLMOSyxA3f3bZIc+RP8/eS/26zqu7tz
         RilywCeL1iGxCyrjNuCwLu/UVYjnBlsVo+RxySG2obk+AOosjSPuZ7QeRbBRXVdA6rID
         dEjQ==
X-Gm-Message-State: AOAM5337GAueiL2M33kuRqLDfo/6WgiQ/no1tyf1GhI7bp/aOI7O0BSJ
        GaL1d3dxuoC6ikLZL0HH+Si8pw==
X-Google-Smtp-Source: ABdhPJwDF5h6MoCuJSLVRYN6V3SUPCfPtMhU02JacL8LUejcHJkWG2C2FBuxEHO5GQ0TLz1u4jgkzg==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr8004415wml.159.1599234412250;
        Fri, 04 Sep 2020 08:46:52 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 18/23] gpio: mockup: require debugfs to build
Date:   Fri,  4 Sep 2020 17:45:42 +0200
Message-Id: <20200904154547.3836-19-brgl@bgdev.pl>
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

Debugfs has become the standard way of interfacing with gpio-mockup to
the point where the module is not very useful without it anymore. Let's
make it a hard requirement to build gpio-mockup.

Let's also add error checks whenever calling debugfs routines as we now
don't expect them to fail.

The device sub-directories must now be removed when the device is
detached to correctly support dynamically created chips.

The call to debugfs_remove_recursive() in module exit must be moved to
the bottom or we'd risk to remove the root directory before devices can
unregister their own sub-directories.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Kconfig       |  1 +
 drivers/gpio/gpio-mockup.c | 41 ++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8030fd91a3cc..515f345757d8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1567,6 +1567,7 @@ config GPIO_AGGREGATOR
 
 config GPIO_MOCKUP
 	tristate "GPIO Testing Driver"
+	depends on DEBUG_FS
 	select IRQ_SIM
 	help
 	  This enables GPIO Testing driver, which provides a way to test GPIO
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 29fbf007ab26..7df990662c17 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -348,38 +348,55 @@ static const struct file_operations gpio_mockup_debugfs_ops = {
 	.release = single_release,
 };
 
-static void gpio_mockup_debugfs_setup(struct device *dev,
-				      struct gpio_mockup_chip *chip)
+static void gpio_mockup_remove_chip_debugfs_entry(void *data)
+{
+	struct dentry *entry = data;
+
+	debugfs_remove_recursive(entry);
+}
+
+static int gpio_mockup_debugfs_setup(struct device *dev,
+				     struct gpio_mockup_chip *chip)
 {
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_chip *gc;
+	struct dentry *attr;
 	const char *devname;
 	char *name;
-	int i;
+	int i, ret;
 
 	gc = &chip->gc;
 	devname = dev_name(&gc->gpiodev->dev);
 
 	chip->dbg_dir = debugfs_create_dir(devname, gpio_mockup_dbg_dir);
+	if (IS_ERR(chip->dbg_dir))
+		return PTR_ERR(chip->dbg_dir);
+
+	ret = devm_add_action_or_reset(dev,
+			gpio_mockup_remove_chip_debugfs_entry, chip->dbg_dir);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-			return;
+			return -ENOMEM;
 
 		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 		if (!priv)
-			return;
+			return -ENOMEM;
 
 		priv->chip = chip;
 		priv->offset = i;
 		priv->desc = &gc->gpiodev->descs[i];
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
-				    &gpio_mockup_debugfs_ops);
+		attr = debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+					   &gpio_mockup_debugfs_ops);
+		if (IS_ERR(attr))
+			return PTR_ERR(attr);
 	}
 
-	return;
+	return 0;
 }
 
 static void gpio_mockup_dispose_mappings(void *data)
@@ -462,7 +479,9 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (rv)
 		return rv;
 
-	gpio_mockup_debugfs_setup(dev, chip);
+	rv = gpio_mockup_debugfs_setup(dev, chip);
+	if (rv)
+		return rv;
 
 	return 0;
 }
@@ -629,6 +648,8 @@ static int __init gpio_mockup_init(void)
 	int ret;
 
 	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
+	if (IS_ERR(gpio_mockup_dbg_dir))
+		return PTR_ERR(gpio_mockup_dbg_dir);
 
 	ret = platform_driver_register(&gpio_mockup_driver);
 	if (ret) {
@@ -650,9 +671,9 @@ static int __init gpio_mockup_init(void)
 
 static void __exit gpio_mockup_exit(void)
 {
-	debugfs_remove_recursive(gpio_mockup_dbg_dir);
 	platform_driver_unregister(&gpio_mockup_driver);
 	gpio_mockup_unregister_devices();
+	debugfs_remove_recursive(gpio_mockup_dbg_dir);
 }
 
 module_init(gpio_mockup_init);
-- 
2.26.1

