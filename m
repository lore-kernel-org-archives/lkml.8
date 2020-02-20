Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4422FC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CF424670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBTNCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:02:01 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:53472 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgBTNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:02:00 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 511u220065USYZQ0111uY3; Thu, 20 Feb 2020 14:01:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j4lSj-000564-VF; Thu, 20 Feb 2020 14:01:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j4lSj-0007Lh-To; Thu, 20 Feb 2020 14:01:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] gpio: of: Extract of_gpiochip_add_hog()
Date:   Thu, 20 Feb 2020 14:01:48 +0100
Message-Id: <20200220130149.26283-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220130149.26283-1-geert+renesas@glider.be>
References: <20200220130149.26283-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the code to add all GPIO hogs of a gpio-hog node into its own
function, so it can be reused.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/gpio/gpiolib-of.c | 49 ++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index c6d30f73df078e0b..2b47f93886075294 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -604,6 +604,35 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	return desc;
 }
 
+/**
+ * of_gpiochip_add_hog - Add all hogs in a hog device node
+ * @chip:	gpio chip to act on
+ * @hog:	device node describing the hogs
+ *
+ * Returns error if it fails otherwise 0 on success.
+ */
+static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
+{
+	enum gpiod_flags dflags;
+	struct gpio_desc *desc;
+	unsigned long lflags;
+	const char *name;
+	unsigned int i;
+	int ret;
+
+	for (i = 0;; i++) {
+		desc = of_parse_own_gpio(hog, chip, i, &name, &lflags, &dflags);
+		if (IS_ERR(desc))
+			break;
+
+		ret = gpiod_hog(desc, name, lflags, dflags);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
  * @chip:	gpio chip to act on
@@ -614,29 +643,17 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
  */
 static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
-	struct gpio_desc *desc = NULL;
 	struct device_node *np;
-	const char *name;
-	unsigned long lflags;
-	enum gpiod_flags dflags;
-	unsigned int i;
 	int ret;
 
 	for_each_available_child_of_node(chip->of_node, np) {
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
-		for (i = 0;; i++) {
-			desc = of_parse_own_gpio(np, chip, i, &name, &lflags,
-						 &dflags);
-			if (IS_ERR(desc))
-				break;
-
-			ret = gpiod_hog(desc, name, lflags, dflags);
-			if (ret < 0) {
-				of_node_put(np);
-				return ret;
-			}
+		ret = of_gpiochip_add_hog(chip, np);
+		if (ret < 0) {
+			of_node_put(np);
+			return ret;
 		}
 	}
 
-- 
2.17.1

