Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F694C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1E32071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTNp2TLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgA2FrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:47:16 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38724 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgA2FrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:47:14 -0500
Received: by mail-qv1-f68.google.com with SMTP id g6so7175048qvy.5;
        Tue, 28 Jan 2020 21:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xfz6zEu269nO7TFXDejivUti4a8WtukAu+M7aAAzk9Y=;
        b=lTNp2TLzzRWn/0tcwTvaqlTGOFpqfVxPnDsJNMPkf4g4EeCQ7mXHMkM0SGw6n29ebf
         VEfn019QYCfFmRdiWtAA1ZRrkagTiSsYrwnxmewoI7456aJPTr+zR8jQUDq1OTM59G2X
         PjK0Y14drHGy5CvkwUkj3/boa0kxXHARSqQBKFed+HuuL3tyTFeed+MliIj0hRZhv3lS
         OlxoZNRB2e2atDA3mavw82eUWsfOlM+T1xVaQDU5XAo631iA+OY6zvf6Y4hk/OidAbtB
         JfvvnGdSfpKPKuU9LWzjUJ7gzyerM86+Py5pvLXuyyltu9oUfR0fBHCzjNXGSTKOeDP5
         vTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xfz6zEu269nO7TFXDejivUti4a8WtukAu+M7aAAzk9Y=;
        b=BHhrOUa+NykFkaQvYvueJXDsv8gK+0RPg6qH3UyhWLWxoFMXeAFoRc3CzOj5VoqcvD
         3XWJn3aULQNkRlfFnCXwER9WMlD2TO4WPZ0qaiWRTNKYhU+3eUdzbr/BkzpOhup54E+9
         tHD2q7UNUnAvAsdiUyNPSLXHi1JpGFE9/s7wdNRHJXfsbLls+aN9G0Hzwnkz4lq2eI3d
         QHqlwZhxerocu+uuT99ZDUy9YHlXZyWceXsauqDZ1Ie0IFGrEvjz4UWhRJ/F1kx1BESP
         67Jbwx9mrPZ4TMluF1ELm0H/3cYMORYICT5V9yObD8DNoqRZQkjmLrtQRVOJdqzpU6DS
         gNSQ==
X-Gm-Message-State: APjAAAUVvNEcKZZuIeyImOvFgSJQsl5gWoFHMyurCT+Ce7799K3VEb0e
        SqSYSvAIb/WoeMx8xKLxN/I=
X-Google-Smtp-Source: APXvYqxuYtGi39Fwxg8m+aST5/e5geBNG6IXu6XE4U5vXYNWPCO+/7KlVrkwmD6NeEloCBomHLnVKQ==
X-Received: by 2002:ad4:450a:: with SMTP id k10mr24669127qvu.136.1580276832511;
        Tue, 28 Jan 2020 21:47:12 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id r10sm472929qkm.23.2020.01.28.21.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 21:47:12 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] of: unittest: add overlay gpio test to catch gpio hog problem
Date:   Tue, 28 Jan 2020 23:46:04 -0600
Message-Id: <1580276765-29458-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580276765-29458-1-git-send-email-frowand.list@gmail.com>
References: <1580276765-29458-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Geert reports that gpio hog nodes are not properly processed when
the gpio hog node is added via an overlay reply and provides an
RFC patch to fix the problem [1].

Add a unittest that shows the problem.  Unittest will report "1 failed"
test before applying Geert's RFC patch and "0 failed" after applying
Geert's RFC patch.

[1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

There are checkpatch warnings.
  - New files are in a directory already covered by MAINTAINERS
  - The undocumented compatibles are restricted to use by unittest
    and should not be documented under Documentation
  - The printk() KERN_<LEVEL> warnings are false positives.  The level
    is supplied by a define parameter instead of a hard coded constant
  - The lines over 80 characters are consistent with unittest.c style

This unittest was also valuable in that it allowed me to explore
possible issues related to the proposed solution to the gpio hog
problem.

changes since RFC:
  - fixed node names in overlays
  - removed unused fields from struct unittest_gpio_dev
  - of_unittest_overlay_gpio() cleaned up comments
  - of_unittest_overlay_gpio() moved saving global values into
    probe_pass_count and chip_request_count more tightly around
    test code expected to trigger changes in the global values

 drivers/of/unittest-data/Makefile             |   8 +-
 drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
 drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
 drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
 drivers/of/unittest.c                         | 255 ++++++++++++++++++++++++++
 8 files changed, 372 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 9b6807065827..009f4045c8e4 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -21,7 +21,13 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
-			    overlay_base.dtb.o
+			    overlay_base.dtb.o \
+			    overlay_gpio_01.dtb.o \
+			    overlay_gpio_02a.dtb.o \
+			    overlay_gpio_02b.dtb.o \
+			    overlay_gpio_03.dtb.o \
+			    overlay_gpio_04a.dtb.o \
+			    overlay_gpio_04b.dtb.o
 
 # enable creation of __symbols__ node
 DTC_FLAGS_overlay += -@
diff --git a/drivers/of/unittest-data/overlay_gpio_01.dts b/drivers/of/unittest-data/overlay_gpio_01.dts
new file mode 100644
index 000000000000..f039e8bce3b6
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_01.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_01 {
+		compatible = "unittest-gpio";
+		reg = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B";
+
+		line_b {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "line-B-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_02a.dts b/drivers/of/unittest-data/overlay_gpio_02a.dts
new file mode 100644
index 000000000000..cdafab604793
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_02a.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_02 {
+		compatible = "unittest-gpio";
+		reg = <1>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B";
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_02b.dts b/drivers/of/unittest-data/overlay_gpio_02b.dts
new file mode 100644
index 000000000000..0cea0dccafba
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_02b.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_02 {
+		line_a {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "line-A-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_03.dts b/drivers/of/unittest-data/overlay_gpio_03.dts
new file mode 100644
index 000000000000..1d5c680fa254
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_03.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_03 {
+		compatible = "unittest-gpio";
+		reg = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
+
+		line_d {
+			gpio-hog;
+			gpios = <4 0>;
+			input;
+			line-name = "line-D-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_04a.dts b/drivers/of/unittest-data/overlay_gpio_04a.dts
new file mode 100644
index 000000000000..d2482cde310e
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_04a.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_04 {
+		compatible = "unittest-gpio";
+		reg = <1>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_04b.dts b/drivers/of/unittest-data/overlay_gpio_04b.dts
new file mode 100644
index 000000000000..70ad05d759f9
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_gpio_04b.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&unittest_test_bus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_04 {
+		line_c {
+			gpio-hog;
+			gpios = <3 0>;
+			input;
+			line-name = "line-C-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 68b87587b2ef..b1cf9972d866 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -24,6 +24,7 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/gpio/driver.h>
 
 #include <linux/bitops.h>
 
@@ -46,6 +47,101 @@
 	failed; \
 })
 
+/*
+ * Expected message may have a message level other than KERN_INFO.
+ * Print the expected message only if the current loglevel will allow
+ * the actual message to print.
+ */
+#define EXPECT_BEGIN(level, fmt, ...) \
+	printk(level pr_fmt("EXPECT \\ : ") fmt, ##__VA_ARGS__)
+
+#define EXPECT_END(level, fmt, ...) \
+	printk(level pr_fmt("EXPECT / : ") fmt, ##__VA_ARGS__)
+
+struct unittest_gpio_dev {
+	void __iomem *base;
+	struct gpio_chip chip;
+	spinlock_t gpio_lock;
+};
+
+static int unittest_gpio_chip_request_count;
+static int unittest_gpio_probe_count;
+static int unittest_gpio_probe_pass_count;
+
+static int unittest_gpio_chip_request(struct gpio_chip *chip, unsigned int offset)
+{
+	unittest_gpio_chip_request_count++;
+
+	pr_debug("%s(): %s %d %d\n", __func__, chip->label, offset,
+		 unittest_gpio_chip_request_count);
+	return 0;
+}
+
+static int unittest_gpio_probe(struct platform_device *pdev)
+{
+	struct unittest_gpio_dev *devptr;
+	int ret;
+
+	unittest_gpio_probe_count++;
+
+	devptr = kzalloc(sizeof(*devptr), GFP_KERNEL);
+	if (!devptr)
+		return -ENOMEM;
+
+	spin_lock_init(&devptr->gpio_lock);
+
+	platform_set_drvdata(pdev, devptr);
+
+	devptr->chip.of_node = pdev->dev.of_node;
+	devptr->chip.label = "of-unittest-gpio";
+	devptr->chip.base = -1; /* dynamic allocation */
+	devptr->chip.ngpio = 5;
+	devptr->chip.request = unittest_gpio_chip_request;
+
+	ret = gpiochip_add_data(&devptr->chip, NULL);
+
+	unittest(!ret,
+		 "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
+
+	if (!ret)
+		unittest_gpio_probe_pass_count++;
+	return ret;
+}
+
+static int unittest_gpio_remove(struct platform_device *pdev)
+{
+	struct unittest_gpio_dev *gdev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+
+	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
+
+	if (!gdev)
+		return -EINVAL;
+
+	if (gdev->chip.base != -1)
+		gpiochip_remove(&gdev->chip);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id unittest_gpio_id[] = {
+	{ .compatible = "unittest-gpio", },
+	{}
+};
+
+static struct platform_driver unittest_gpio_driver = {
+	.probe	= unittest_gpio_probe,
+	.remove	= unittest_gpio_remove,
+	.driver	= {
+		.name		= "unittest-gpio",
+		.of_match_table	= of_match_ptr(unittest_gpio_id),
+	},
+};
+
 static void __init of_unittest_find_node_by_name(void)
 {
 	struct device_node *np;
@@ -2183,6 +2279,151 @@ static inline void of_unittest_overlay_i2c_15(void) { }
 
 #endif
 
+static void __init of_unittest_overlay_gpio(void)
+{
+	int chip_request_count;
+	int probe_pass_count;
+	int ret;
+
+	/*
+	 * tests: apply overlays before registering driver
+	 * Similar to installing a driver as a module, the
+	 * driver is registered after applying the overlays.
+	 *
+	 * - apply overlay_gpio_01
+	 * - apply overlay_gpio_02a
+	 * - apply overlay_gpio_02b
+	 * - register driver
+	 *
+	 * register driver will result in
+	 *   - probe and processing gpio hog for overlay_gpio_01
+	 *   - probe for overlay_gpio_02a
+	 *   - processing gpio for overlay_gpio_02b
+	 *
+	 * overlay_gpio_01 contains gpio node and child gpio hog node
+	 * overlay_gpio_02a contains gpio node
+	 * overlay_gpio_02b contains child gpio hog node
+	 *
+	 * "GPIO line <<int>> (line-*-input) hogged as input"
+	 * messages are the result of the gpio driver probe
+	 * finding the gpio hog node.
+	 */
+
+	unittest(overlay_data_apply("overlay_gpio_01", NULL),
+		 "Adding overlay 'overlay_gpio_01' failed\n");
+
+	unittest(overlay_data_apply("overlay_gpio_02a", NULL),
+		 "Adding overlay 'overlay_gpio_02a' failed\n");
+
+	unittest(overlay_data_apply("overlay_gpio_02b", NULL),
+		 "Adding overlay 'overlay_gpio_02b' failed\n");
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-B-input) hogged as input\n");
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-A-input) hogged as input\n");
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+	chip_request_count = unittest_gpio_chip_request_count;
+
+	ret = platform_driver_register(&unittest_gpio_driver);
+	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
+		return;
+
+	EXPECT_END(KERN_INFO,
+		   "GPIO line <<int>> (line-A-input) hogged as input\n");
+	EXPECT_END(KERN_INFO,
+		   "GPIO line <<int>> (line-B-input) hogged as input\n");
+
+	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
+		 "unittest_gpio_probe() failed or not called\n");
+
+	unittest(chip_request_count + 2 == unittest_gpio_chip_request_count,
+		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
+		 unittest_gpio_chip_request_count - chip_request_count);
+
+	/*
+	 * tests: apply overlays after registering driver
+	 *
+	 * Similar to a driver built-in to the kernel, the
+	 * driver is registered before applying the overlays.
+	 *
+	 * - apply overlay_gpio_03
+	 *
+	 * apply overlay will result in
+	 *   - probe and processing gpio hog.
+	 *
+	 * overlay_gpio_03 contains gpio node and child gpio hog node
+	 */
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-D-input) hogged as input\n");
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+	chip_request_count = unittest_gpio_chip_request_count;
+
+	unittest(overlay_data_apply("overlay_gpio_03", NULL),
+		 "Adding overlay 'overlay_gpio_03' failed\n");
+
+	EXPECT_END(KERN_INFO,
+		   "GPIO line <<int>> (line-D-input) hogged as input\n");
+
+	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
+		 "unittest_gpio_probe() failed or not called\n");
+
+	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
+		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
+		 unittest_gpio_chip_request_count - chip_request_count);
+
+	/*
+	 * tests: apply overlay containing gpio node but no gpio hog node
+	 *
+	 * - apply overlay_gpio_04a
+	 *
+	 * apply the overlay will result in
+	 *   - probe for overlay_gpio_04a
+	 *
+	 * overlay_gpio_04a contains gpio node
+	 */
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+
+	/* overlay_gpio_04a contains gpio node */
+
+	unittest(overlay_data_apply("overlay_gpio_04a", NULL),
+		 "Adding overlay 'overlay_gpio_04a' failed\n");
+
+	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
+		 "unittest_gpio_probe() failed or not called\n");
+
+	/*
+	 * tests: apply overlay containing the gpio hog node
+	 *
+	 * - apply overlay_gpio_04b
+	 *
+	 * apply the overlay will result in
+	 *   - processing gpio for overlay_gpio_04b
+	 *
+	 * overlay_gpio_04b contains child gpio hog node
+	 */
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-C-input) hogged as input\n");
+
+	chip_request_count = unittest_gpio_chip_request_count;
+
+	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
+		 "Adding overlay 'overlay_gpio_04b' failed\n");
+
+	EXPECT_END(KERN_INFO,
+		   "GPIO line <<int>> (line-C-input) hogged as input\n");
+
+	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
+		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
+		 unittest_gpio_chip_request_count - chip_request_count);
+}
+
 static void __init of_unittest_overlay(void)
 {
 	struct device_node *bus_np = NULL;
@@ -2242,6 +2483,8 @@ static void __init of_unittest_overlay(void)
 	of_unittest_overlay_i2c_cleanup();
 #endif
 
+	of_unittest_overlay_gpio();
+
 	of_unittest_destroy_tracked_overlays();
 
 out:
@@ -2295,6 +2538,12 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_12);
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
+OVERLAY_INFO_EXTERN(overlay_gpio_01);
+OVERLAY_INFO_EXTERN(overlay_gpio_02a);
+OVERLAY_INFO_EXTERN(overlay_gpio_02b);
+OVERLAY_INFO_EXTERN(overlay_gpio_03);
+OVERLAY_INFO_EXTERN(overlay_gpio_04a);
+OVERLAY_INFO_EXTERN(overlay_gpio_04b);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
@@ -2319,6 +2568,12 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_12, 0),
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
+	OVERLAY_INFO(overlay_gpio_01, 0),
+	OVERLAY_INFO(overlay_gpio_02a, 0),
+	OVERLAY_INFO(overlay_gpio_02b, 0),
+	OVERLAY_INFO(overlay_gpio_03, 0),
+	OVERLAY_INFO(overlay_gpio_04a, 0),
+	OVERLAY_INFO(overlay_gpio_04b, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
-- 
Frank Rowand <frank.rowand@sony.com>

