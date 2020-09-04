Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5850CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BA22074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RrJg++r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIDPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgIDPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42948C061231
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so6523219wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXNzTcdhYOLT/AXbUue/WL7HnvjNCgkZ3cLbmDzVGrc=;
        b=RrJg++r4d2sHRcNO3FHpdXscTwZC2S1z6mTa4gXaNzK1juMkhcaKgspDfWpLneE8ew
         tHNr9Istt1yOiqL4bpXNH0QTSrkeP/0+Sm0lWzrBSnNzA8Ipt1xnsSsJLqMRrfXfgPdL
         ByP89m21osn8Id9E+Wyld2kuBz/37527FByOq0o3H71SYeQv7QKjZwhPK8OLk7ZZ1+ln
         E6BINQjI5QOfdhbly6Mg+N5QR3sey2pYn/ItHPnMoSmlC2iJkFNPzpvM5K7zwL6RYcjj
         gqdPy1/YiAdUWwlNY/7Qrbz14NPumdr00luxiTymMknoqxMZo8w0KTk1eN2juH0xrC0s
         99hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXNzTcdhYOLT/AXbUue/WL7HnvjNCgkZ3cLbmDzVGrc=;
        b=SwWLAJBrD4UkIi6ue2ib4PiyMzFo0fp0ExSM4T2dd/PZcSBnOGgr1+bBuLiJV4MgQY
         xZoKcxXnN1wGiKYYnG3a+8QnPtYpNiCGoi0ArUABm4r8I52VKAacu2hsjR8RPY6xwg+g
         Ct00qD1JNcWDnxFwI7yvmICiCur9CcwVqxOOgkQeryfhZbLBz5AvyiUvdrCZXbP3hBf3
         b0dZ42hqWvFJ2608vwWgBekxi367HSryI5cWa7BC+MKHLvp5PUza6pK0Zsqdu+BF662C
         fK0W42o1lRx5kSr/LGa5Zd7egHy9LYXc/yW1EEzl3OfWy8mu6Aqbs9Vdbw6VsCpxE9qw
         SSIA==
X-Gm-Message-State: AOAM530DqPQXFxQLLycGEbzeTFN68CkEUpJtBkKN3hqMzSpuzP4Ya2rU
        Th81xFKOaxI5bt6ZhJGALWvIkw==
X-Google-Smtp-Source: ABdhPJxbT8FJfkefQNct8r1fnLwo5GotdwatKA46ZNCj44Ghck2jGtAw2L6A6tWWrFk0Rc/2fDW1Jg==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr8253559wmc.188.1599234408930;
        Fri, 04 Sep 2020 08:46:48 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 15/23] gpio: mockup: use dynamic device IDs
Date:   Fri,  4 Sep 2020 17:45:39 +0200
Message-Id: <20200904154547.3836-16-brgl@bgdev.pl>
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

We're currently creating chips at module init time only so using a
static index for dummy devices is fine. We want to support dynamically
created chips however so we need to switch to dynamic device IDs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 96976ba66598..995e37fef9c5 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -9,6 +9,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/gpio/driver.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
@@ -70,6 +71,8 @@ module_param_named(gpio_mockup_named_lines,
 
 static struct dentry *gpio_mockup_dbg_dir;
 
+static DEFINE_IDA(gpio_mockup_ida);
+
 static int gpio_mockup_range_base(unsigned int index)
 {
 	return gpio_mockup_ranges[index * 2];
@@ -480,8 +483,12 @@ static LIST_HEAD(gpio_mockup_devices);
 
 static void gpio_mockup_unregister_one_device(struct gpio_mockup_device *dev)
 {
+	int id;
+
 	list_del(&dev->list);
+	id = dev->pdev->id;
 	platform_device_unregister(dev->pdev);
+	ida_free(&gpio_mockup_ida, id);
 	kfree(dev);
 }
 
@@ -587,12 +594,19 @@ static int __init gpio_mockup_init(void)
 		}
 
 		pdevinfo.name = "gpio-mockup";
-		pdevinfo.id = i;
 		pdevinfo.properties = properties;
 
+		pdevinfo.id = ida_alloc(&gpio_mockup_ida, GFP_KERNEL);
+		if (pdevinfo.id < 0) {
+			kfree_strarray(line_names, ngpio);
+			err = pdevinfo.id;
+			goto err_out;
+		}
+
 		mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
 		if (!mockup_dev) {
 			kfree_strarray(line_names, ngpio);
+			ida_free(&gpio_mockup_ida, pdevinfo.id);
 			err = -ENOMEM;
 			goto err_out;
 		}
@@ -601,6 +615,7 @@ static int __init gpio_mockup_init(void)
 		kfree_strarray(line_names, ngpio);
 		if (IS_ERR(mockup_dev->pdev)) {
 			pr_err("error registering device");
+			ida_free(&gpio_mockup_ida, pdevinfo.id);
 			kfree(mockup_dev);
 			err = PTR_ERR(mockup_dev->pdev);
 			goto err_out;
-- 
2.26.1

