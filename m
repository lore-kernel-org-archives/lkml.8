Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6909320774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgFWO55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbgFWO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:57:55 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9EC061797
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:57:54 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:26:93a1:ff06:f8b0])
        by laurent.telenet-ops.be with bizsmtp
        id uexs2200Q4qCYS801exsSu; Tue, 23 Jun 2020 16:57:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jnkMy-0007VB-Li; Tue, 23 Jun 2020 16:57:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jnkMy-0007Wa-Kf; Tue, 23 Jun 2020 16:57:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] gpio: aggregator: Use bitmap_parselist() for parsing GPIO offsets
Date:   Tue, 23 Jun 2020 16:57:48 +0200
Message-Id: <20200623145748.28877-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623145748.28877-1-geert+renesas@glider.be>
References: <20200623145748.28877-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom code to parse GPIO offsets and/or GPIO offset ranges
by a call to bitmap_parselist(), and an iteration over the returned bit
mask.

This should have no impact on the format of the configuration parameters
written to the "new_device" virtual file in sysfs.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I'm not super happy with the mask[] array, which is on the stack.
But there is no real limit on the number of GPIO lines provided by a
single gpiochip, except for the global ARCH_NR_GPIOS.
---
 drivers/gpio/gpio-aggregator.c | 42 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 62a3fcbd4b4bb106..7b2e7abaece9cdb1 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -10,6 +10,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/ctype.h>
+#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
@@ -111,9 +112,10 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
 
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
-	unsigned int first_index, last_index, i, n = 0;
-	char *name, *offsets, *first, *last, *next;
+	DECLARE_BITMAP(mask, ARCH_NR_GPIOS);
 	char *args = aggr->args;
+	unsigned int i, n = 0;
+	char *name, *offsets;
 	int error;
 
 	for (name = get_arg(&args), offsets = get_arg(&args); name;
@@ -134,32 +136,16 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		/* GPIO chip + offset(s) */
-		for (first = offsets; *first; first = next) {
-			next = strchrnul(first, ',');
-			if (*next)
-				*next++ = '\0';
-
-			last = strchr(first, '-');
-			if (last)
-				*last++ = '\0';
-
-			if (kstrtouint(first, 10, &first_index)) {
-				pr_err("Cannot parse GPIO index %s\n", first);
-				return -EINVAL;
-			}
-
-			if (!last) {
-				last_index = first_index;
-			} else if (kstrtouint(last, 10, &last_index)) {
-				pr_err("Cannot parse GPIO index %s\n", last);
-				return -EINVAL;
-			}
-
-			for (i = first_index; i <= last_index; i++) {
-				error = aggr_add_gpio(aggr, name, i, &n);
-				if (error)
-					return error;
-			}
+		error = bitmap_parselist(offsets, mask, ARCH_NR_GPIOS);
+		if (error) {
+			pr_err("Cannot parse %s: %d\n", offsets, error);
+			return error;
+		}
+
+		for_each_set_bit(i, mask, ARCH_NR_GPIOS) {
+			error = aggr_add_gpio(aggr, name, i, &n);
+			if (error)
+				return error;
 		}
 
 		name = get_arg(&args);
-- 
2.17.1

