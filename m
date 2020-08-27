Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E952DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AF022BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554812;
	bh=AUHZeGZQ1QvvZ/NYV0F6hVwKHpi1jDQ3ZUVwX6+r8bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cptkCNUFYSEaEMNkgMrfk5HiVa34LxvNMrqgZ3721g52KCR/VobbaEaxLgXgnmmtP
	 +Q1nshFJB70Kff2W08+O4RRgTE4tXyH6vP+oUjRWgwk7NqRydCu9ucxooirh1PBHKd
	 ey1er9VLHOiD3bisQwbkEOOZSTbNA0vlNhx0GJT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgH0TAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgH0TAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:00:06 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4F922CBE;
        Thu, 27 Aug 2020 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554806;
        bh=AUHZeGZQ1QvvZ/NYV0F6hVwKHpi1jDQ3ZUVwX6+r8bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkF6n24lTgHqUVxU+PDGf00J7EB+I7AhGFYaUwlB4dHFu8cDAHSMJRo+YS6mG0Tbe
         KvRCoLchHn1quvZXYJAGypeGfXcAJJJpx6WOoLO95JIidHjm+SP93NL5rIDfgLOw44
         z/bzXV7k+O56zTRMvRwHr5EbU5VMdXTRAmgckP10=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 25/27] Input: gpio_keys - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:27 +0200
Message-Id: <20200827185829.30096-26-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827185829.30096-1-krzk@kernel.org>
References: <20200827185829.30096-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe() and devm_fwnode_gpiod_get_optional().   Less code and
the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changes since v2:
1. Preserve comment,
2. Include <device.h> to fix warning on clang (reported by kbuild),
3. Fix use of uninitialized "error" variable.

Changes since v1:
1. Use devm_fwnode_gpiod_get_optional
---
 drivers/input/keyboard/gpio_keys.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f2d4e4daa818..160d94b1c2c0 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -18,6 +18,7 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
@@ -494,23 +495,13 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	spin_lock_init(&bdata->lock);
 
 	if (child) {
-		bdata->gpiod = devm_fwnode_gpiod_get(dev, child,
-						     NULL, GPIOD_IN, desc);
-		if (IS_ERR(bdata->gpiod)) {
-			error = PTR_ERR(bdata->gpiod);
-			if (error == -ENOENT) {
-				/*
-				 * GPIO is optional, we may be dealing with
-				 * purely interrupt-driven setup.
-				 */
-				bdata->gpiod = NULL;
-			} else {
-				if (error != -EPROBE_DEFER)
-					dev_err(dev, "failed to get gpio: %d\n",
-						error);
-				return error;
-			}
-		}
+		/*
+		 * GPIO is optional, we may be dealing with purely
+		 * interrupt-driven setup.
+		 */
+		bdata->gpiod = devm_fwnode_gpiod_get_optional(dev, child, NULL, GPIOD_IN, desc);
+		if (IS_ERR(bdata->gpiod))
+			return dev_err_probe(dev, PTR_ERR(bdata->gpiod), "failed to get gpio\n");
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
-- 
2.17.1

