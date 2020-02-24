Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE8C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC14A20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MR4PxrVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgBXJmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:42:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33247 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgBXJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:42:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so9558166wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neyVk7RV4OtR4xz1BjORPRhapgH6pG8UY6Ux3fjGOFc=;
        b=MR4PxrVDnc11dgXc3VKdsrLqF9uj/yQxIojpZo+q77djYlG4zSeosEurwIhQWSE35B
         nylE3fSNnevJfrjvHDqkg4vBdRlsrPMcFA/qDcKdfOwjhEzcScdcl9yrMkikDlu4vREi
         H3sQWPNWfo/4/Gr1sMR7gfXYUGYyCSyIa32ZBVhJsH78gnq5Q9qSJysaeKV8whGAgpgx
         Pb0eHwyIdjlP3fiu/2TU7izxtZIA0lajVoR93lEWMsBPeGRjVeVOeCVmZ6vPLwvyzw7o
         h2WzV40No0uYN/ec/HB5E8HdS4w8IoVCK94AuO17SCplfuxnh64cbOF3kqkD/v3bo3Ww
         gY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neyVk7RV4OtR4xz1BjORPRhapgH6pG8UY6Ux3fjGOFc=;
        b=rGMbB9Zyd2IFSic0ZTC/Ex7niCOdBQ8wXKZcrceX+JwGWOhn3RhzeTJqxQ/zMrrxuC
         UlEXejFVCWLzefHUCJpDTHjtYRu7bbCz6vxgGKKtd1Wctjh+IY2dt0njxhoHjRhOL2SC
         zll3Qg0iZlZOJlcd4Ls/TP1J+TCykwzB8mtVfdbhrVRZZHOFzaQUPQPTgSsISmDL7p2l
         vFCuusexQ+j3zJpsV2eD7UZRGgyICAfbmqQd/0xMoXOkKGtcjSfjaJG2uyd8BNOVUeua
         Y71J+tOZQP5IvsI02kOUoZ1Lp64b83tUXnz7jYBOW/ScQ1vLGYYLbRUX+I5s1Y4ZSiI6
         UGUA==
X-Gm-Message-State: APjAAAU4/2gnw8e67rKcM17kX+RlRFzqEiAnEo8WrunIJnFvjxxxPPlM
        wHlHuT9hwV//oisTv2ZXgwpiZQ==
X-Google-Smtp-Source: APXvYqxL+aCG2wMJPp+XrNvvfAKcfdqb0x0Dm729ywFQYAHCElqUCZQkzGYMYSOnlsA0AlTLZqOS9g==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr71182804wrw.60.1582537324674;
        Mon, 24 Feb 2020 01:42:04 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id t10sm16920730wmi.40.2020.02.24.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 01:42:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] gpiolib: use kref in gpio_desc
Date:   Mon, 24 Feb 2020 10:41:57 +0100
Message-Id: <20200224094158.28761-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224094158.28761-1-brgl@bgdev.pl>
References: <20200224094158.28761-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

GPIO descriptors are freed by consumers using gpiod_put(). The name of
this function suggests some reference counting is going on but it's not
true.

Use kref to actually introduce reference counting for gpio_desc objects.
Add a corresponding gpiod_get() helper for increasing the reference count.

This doesn't change anything for already existing (correct) drivers but
allows us to keep track of GPIO descs used by multiple users.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c        | 40 +++++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h |  9 ++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index da8ffd40aa97..e97ea1e113a1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2798,6 +2798,8 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		goto done;
 	}
 
+	kref_init(&desc->ref);
+
 	if (chip->request) {
 		/* chip->request may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2941,6 +2943,13 @@ void gpiod_free(struct gpio_desc *desc)
 	}
 }
 
+static void gpiod_free_kref(struct kref *ref)
+{
+	struct gpio_desc *desc = container_of(ref, struct gpio_desc, ref);
+
+	gpiod_free(desc);
+}
+
 /**
  * gpiochip_is_requested - return string iff signal was requested
  * @chip: controller managing the signal
@@ -5075,18 +5084,41 @@ struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 EXPORT_SYMBOL_GPL(gpiod_get_array_optional);
 
 /**
- * gpiod_put - dispose of a GPIO descriptor
- * @desc:	GPIO descriptor to dispose of
+ * gpiod_put - decrease the reference count of a GPIO descriptor
+ * @desc:	GPIO descriptor to unref
  *
  * No descriptor can be used after gpiod_put() has been called on it.
  */
 void gpiod_put(struct gpio_desc *desc)
 {
-	if (desc)
-		gpiod_free(desc);
+	might_sleep();
+
+	VALIDATE_DESC_VOID(desc);
+
+	kref_put(&desc->ref, gpiod_free_kref);
 }
 EXPORT_SYMBOL_GPL(gpiod_put);
 
+/**
+ * gpiod_ref - increase the reference count of a GPIO descriptor
+ * @desc:	GPIO descriptor to reference
+ *
+ * Returns the same gpio_desc after increasing the reference count.
+ */
+struct gpio_desc *gpiod_ref(struct gpio_desc *desc)
+{
+	VALIDATE_DESC_PTR(desc);
+
+	if (!test_bit(FLAG_REQUESTED, &desc->flags)) {
+		pr_warn("gpiolib: unable to increase the reference count of unrequested GPIO descriptor\n");
+		return desc;
+	}
+
+	kref_get(&desc->ref);
+	return desc;
+}
+EXPORT_SYMBOL_GPL(gpiod_ref);
+
 /**
  * gpiod_put_array - dispose of multiple GPIO descriptors
  * @descs:	struct gpio_descs containing an array of descriptors
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3e0aab2945d8..51a92c43dd55 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -119,6 +119,7 @@ struct gpio_desc {
 	const char		*label;
 	/* Name of the GPIO */
 	const char		*name;
+	struct kref		ref;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index bf2d017dd7b7..02b136884923 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -81,6 +81,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 							const char *con_id,
 							enum gpiod_flags flags);
+struct gpio_desc *gpiod_ref(struct gpio_desc *desc);
 void gpiod_put(struct gpio_desc *desc);
 void gpiod_put_array(struct gpio_descs *descs);
 
@@ -237,6 +238,14 @@ gpiod_get_array_optional(struct device *dev, const char *con_id,
 	return NULL;
 }
 
+static inline struct gpio_desc *gpiod_ref(struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+
+	return NULL;
+}
+
 static inline void gpiod_put(struct gpio_desc *desc)
 {
 	might_sleep();
-- 
2.25.0

