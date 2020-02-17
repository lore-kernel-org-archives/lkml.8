Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619FC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E456206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wSVgzTK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgBQTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42392 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgBQTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so21184833wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6usHAmM/tR1NKSe7ERsXJJ85CdMUxDouW36IMeIpPc=;
        b=wSVgzTK6HYqnvIH30T0/Plu/iTE9+fXiAC1ZolWfS+DwZfVQb9FKUv/6zIiyKmNora
         QxYdgNKCdsM3P5dVwwznjeg4kdr3jQ4OAnDdP+fXYwx/umaI2MITR1/ACKA/ajPf8Sr5
         xVgP9ZzC4nlgxEPjQPgfIW54a4jlsqOKkt3c6hvpDLsiJu9jnxTqkbRJNrxoY821jQvf
         XfTTiAdAxMvzHxQ+M7Tc3nGVXv1v9e/8qMwFO1gklj2H2dl3oyjtMs5jCFHgvdldFBLU
         5fpSRq9HgEpCChnYJKjMbOcZ+dTLoR69OvHOyqYgwBDx1650LY6DDzhzmfYH3im3/lqq
         071w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6usHAmM/tR1NKSe7ERsXJJ85CdMUxDouW36IMeIpPc=;
        b=LBKBoi/b1K1Up5IWEgUoGi1SszGr3Y0b1pM2zb8P7uooSsf9VaYTTznhxtcr22645Y
         jrlG0Ii2bbrziYakiuKvn66w/hVfMEOE5OZi16MUCz2JOFpHrI42vBgy44ogJKyNKqq7
         2++QowNRbeiA9uHkbe8KoIQwSSfwO5sSV0KxXOAOC+QzXSrqZVBY3KpIvbILfvom2v5W
         fxz1bnER0B8IB0eeuy7vlNwk9ba25AV28OOBTdwJTWGf7uZD+b+0lgXEKVZVbOSO4mrE
         CK3eXVSt/53bgI9ZSvMzxf3xK+Zf4PkxK0qRNambAkqyddfQmtxBuoDvtzwbl7wp7iBk
         IQvw==
X-Gm-Message-State: APjAAAVC0EGD94PhCq0e0VbZetcZOKsUw/j9P1l1U/I9BwRBb/ziEJ3t
        WdotGHHbY6VwncQ8V4KPb5LwVw==
X-Google-Smtp-Source: APXvYqzN+aH7ss4CRCso05uviGcmNd0mlhFjxAFlhCrMb02hfYJnGZDhWu8xq8nlz/swjAqd5cmjRA==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr22981757wrw.31.1581969280760;
        Mon, 17 Feb 2020 11:54:40 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/6] gpiolib: use kref in gpio_desc
Date:   Mon, 17 Feb 2020 20:54:30 +0100
Message-Id: <20200217195435.9309-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217195435.9309-1-brgl@bgdev.pl>
References: <20200217195435.9309-1-brgl@bgdev.pl>
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
 drivers/gpio/gpiolib.c        | 26 +++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4d0106ceeba7..1f781cb97437 100644
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
@@ -2933,6 +2935,13 @@ void gpiod_free(struct gpio_desc *desc)
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
@@ -5067,18 +5076,29 @@ struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
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
 	if (desc)
-		gpiod_free(desc);
+		kref_put(&desc->ref, gpiod_free_kref);
 }
 EXPORT_SYMBOL_GPL(gpiod_put);
 
+/**
+ * gpiod_ref - increase the reference count of a GPIO descriptor
+ * @desc:	GPIO descriptor to reference
+ */
+void gpiod_ref(struct gpio_desc *desc)
+{
+	if (desc)
+		kref_get(&desc->ref);
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
index bf2d017dd7b7..b12bbd511c6e 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -81,6 +81,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 							const char *con_id,
 							enum gpiod_flags flags);
+void gpiod_ref(struct gpio_desc *desc);
 void gpiod_put(struct gpio_desc *desc);
 void gpiod_put_array(struct gpio_descs *descs);
 
-- 
2.25.0

