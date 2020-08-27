Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16A22087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/poDNVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgH0Oo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgH0ODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:03:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB7C0611E1;
        Thu, 27 Aug 2020 07:01:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t9so3568937pfq.8;
        Thu, 27 Aug 2020 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NSQWGG4Dd/lyfNZqBtWl2adXGHauiXHc+m8VldHKpo=;
        b=Q/poDNVum56M1D4JtTfEW96M6P1lqZC+eM7OReHNWgYsQTkcoJxm6fij5Ed2tNphfb
         BWRcHhd05tZgmivp58QcT97v3RmUMjEj43LY/eupdErLzfkDlUienXkPT0I26XSAMWQe
         ZUf3ZOWvV5lEl8JIO+aZPOO7DX5G517/IFa8KzQJHnM45iJQUR7mRJC0srjs1KQZDNrU
         ZXCkMviXWJAeYW5Iaqxv8TGPy1q1iB7/zIVq1uQFQcH+nUdyhscz6D+36mMBXRLSi15F
         JR6KJZX2+PJqI4uXJUIqiIun7pIVDNrLnMQIIiMh5gasVnrsa8oPRf/4gyedqY4v2E6C
         V9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NSQWGG4Dd/lyfNZqBtWl2adXGHauiXHc+m8VldHKpo=;
        b=WSBGJiA9ILNT3FcK6AjOlDwBJcajvFXeqYCcw2/YJqhezGiQtYdeCw29GNyyGwSGPZ
         5IXNhPK9hyBJRuWawJRyr1/N0TdrDpKQgQhgwVZGDvurBkww5KR0XCc4FVxo4eOoJDSN
         IbBF+EQmi15Qd2OREIBTwu2znNR5sttoGcsP+UwiQzSvX6LaoVbBjtdde/2f+gCc37HD
         T24eN+aIGc0Kg6yqCfqaTzbihVZgSnfNNNsdttJhSBGazMPHM8O45Oxa/28ooKKNS8gn
         54dLlIvOzwIpD08hOmzguNZ6vhk7naeqLjfmBMs8amZ7u+vSY/6LD5orMUweZT9lMJmt
         UQcg==
X-Gm-Message-State: AOAM533GDkMnh/oKnf13nrEWTa9VpCneLa1UQ46jRQ0afP+KSavZN7LZ
        /6BAE7WpKzkDRzcyJvSO+s7m5+PrZWg=
X-Google-Smtp-Source: ABdhPJwDrjKE73x/7b0LeUfXIR6oqA0Xmbrt+jQ+dSmTyLQCytJ1sLonVkj8J1aMDoIcZUiyN5Vhmw==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr14546485pgc.191.1598536915157;
        Thu, 27 Aug 2020 07:01:55 -0700 (PDT)
Received: from sol.lan (106-69-184-100.dyn.iinet.net.au. [106.69.184.100])
        by smtp.gmail.com with ESMTPSA id fs12sm2371092pjb.21.2020.08.27.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:01:54 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 05/20] gpiolib: make cdev a build option
Date:   Thu, 27 Aug 2020 22:00:05 +0800
Message-Id: <20200827140020.159627-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827140020.159627-1-warthog618@gmail.com>
References: <20200827140020.159627-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the gpiolib-cdev module a build option.  This allows the CDEV
interface to be removed from the kernel to reduce kernel size in
applications where is it not required, and provides the parent for
other other CDEV interface specific build options to follow.

Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/Kconfig        | 17 +++++++++++++++--
 drivers/gpio/Makefile       |  2 +-
 drivers/gpio/gpiolib-cdev.h | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8030fd91a3cc..8e409b9c33dc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -66,8 +66,21 @@ config GPIO_SYSFS
 
 	  This ABI is deprecated. If you want to use GPIO from userspace,
 	  use the character device /dev/gpiochipN with the appropriate
-	  ioctl() operations instead. The character device is always
-	  available.
+	  ioctl() operations instead.
+
+config GPIO_CDEV
+	bool
+	prompt "Character device (/dev/gpiochipN) support" if EXPERT
+	default y
+	help
+	  Say Y here to add the character device /dev/gpiochipN interface
+	  for GPIOs. The character device allows userspace to control GPIOs
+	  using ioctl() operations.
+
+	  Only say N if you are sure that the GPIO character device is not
+	  required.
+
+	  If unsure, say Y.
 
 config GPIO_GENERIC
 	depends on HAS_IOMEM # Only for IOMEM drivers
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4f9abff4f2dc..7c24c8d77068 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-devres.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-devprop.o
-obj-$(CONFIG_GPIOLIB)		+= gpiolib-cdev.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
+obj-$(CONFIG_GPIO_CDEV)		+= gpiolib-cdev.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
 
diff --git a/drivers/gpio/gpiolib-cdev.h b/drivers/gpio/gpiolib-cdev.h
index 973578e7ad10..19a4e3d57120 100644
--- a/drivers/gpio/gpiolib-cdev.h
+++ b/drivers/gpio/gpiolib-cdev.h
@@ -5,7 +5,22 @@
 
 #include <linux/device.h>
 
+#ifdef CONFIG_GPIO_CDEV
+
 int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt);
 void gpiolib_cdev_unregister(struct gpio_device *gdev);
 
+#else
+
+static inline int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
+{
+	return 0;
+}
+
+static inline void gpiolib_cdev_unregister(struct gpio_device *gdev)
+{
+}
+
+#endif /* CONFIG_GPIO_CDEV */
+
 #endif /* GPIOLIB_CDEV_H */
-- 
2.28.0

