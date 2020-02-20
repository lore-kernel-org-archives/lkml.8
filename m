Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7575C11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997624673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duc5FrWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgBTSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:41:49 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37619 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:41:47 -0500
Received: by mail-yb1-f195.google.com with SMTP id k69so2636580ybk.4;
        Thu, 20 Feb 2020 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NY9ShIlwvZset8mCr07PoBF7G7HFqkX1s7O8GYTIHpM=;
        b=duc5FrWQAbEyPZxNTv6vkIS0Z0U6ANwkbUZqRheFTAZ23v8NCcOA7pEJIZKcxpZJoQ
         kBEDEQXDnysfrvbfd00uWWZyGD7G2iOOQb11jUDrt2Atl5daeJmOImvFV9M2iESXu5ra
         eR+rBRLLKBYOs+wPlMayx/KN8AWz1yR1avU5TYOpTjntsJjrIHE3QI8/jzcpFkeVCYku
         Lv6f5XUi+rDqSz4nhPk9NiEexJ0w8NhqHhIfg+uCIyS2Ktx+K7zTJGb/sXfHMUD5gK9m
         yRx4L4fLiR9XeJttbXKc5owCQoA+fG7NwJje7RGDT2DRvdbocEAl2awUaqsF3dofpj4c
         xxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NY9ShIlwvZset8mCr07PoBF7G7HFqkX1s7O8GYTIHpM=;
        b=G6OUuWQ/G3KAwyn2R4b/rVq+LXFLFUl+7+gN5MopipAZnuR8SUx02bzT8j0rqvLTKm
         iAiEfnm+nXYBH1SKin1u6GiMFUN9X5S+RQcobBSsOl7fDMuewzgC5aJ7+YXmj+oJG5sQ
         iXQg+95Xsvq0ie1kVbgxVEcKhcEReDxp4VZz8h7DhfjyS1KTbMWq4ga6GkHW/wExH+Mv
         1Vq730dqJzK2tSYnZ9RsXZWdJuKufMbBrnbxEKn48mqyqJfHd3YWL7Zo24E6buJdX5S0
         aNPHNsxwo76rq2sJJZyjSkUVO9FB3Dta5c9M4W9mx/aUw9OLf8X2o4qltLfVZPMW8XsA
         HIhg==
X-Gm-Message-State: APjAAAWkVCbXao/jqEHP/9/av8yZ8xT8IxQFdyWvjOF31u9h5pKmMSW6
        E15G2arQ6Jmfqo/COeug3FE=
X-Google-Smtp-Source: APXvYqy+k1s6H2TwWYRmsss3qtJeEGvHM4kRiuYE3WpyCmUioew5vuU2xad8x8Bi8BaeBfd4/bFaSw==
X-Received: by 2002:a05:6902:533:: with SMTP id y19mr28709882ybs.427.1582224105371;
        Thu, 20 Feb 2020 10:41:45 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a74sm206875ywe.42.2020.02.20.10.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 10:41:45 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 1/2] of: unittest: add overlay gpio test to catch gpio hog problem
Date:   Thu, 20 Feb 2020 12:40:20 -0600
Message-Id: <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
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

changes since v1:
  - base on 5.6-rc1
  - fixed node names in overlays
  - removed unused fields from struct unittest_gpio_dev
  - of_unittest_overlay_gpio() cleaned up comments
  - of_unittest_overlay_gpio() moved saving global values into
    probe_pass_count and chip_request_count more tightly around
    test code expected to trigger changes in the global values

v1 of this patch incorrectly reported that it had made changes
since the RFC version, but it was mistakenly created from the
wrong branch.

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


 drivers/of/unittest-data/Makefile             |   8 +-
 drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
 drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
 drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
 drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
 drivers/of/unittest.c                         | 253 ++++++++++++++++++++++++++
 8 files changed, 370 insertions(+), 1 deletion(-)
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
index 000000000000..699ff104ae10
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
+	gpio@0 {
+		compatible = "unittest-gpio";
+		reg = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B";
+
+		line-b {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "line-B-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_02a.dts b/drivers/of/unittest-data/overlay_gpio_02a.dts
new file mode 100644
index 000000000000..ec59aff6ed47
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
+	gpio@2 {
+		compatible = "unittest-gpio";
+		reg = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B";
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_02b.dts b/drivers/of/unittest-data/overlay_gpio_02b.dts
new file mode 100644
index 000000000000..43ce111d41ce
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
+	gpio@2 {
+		line-a {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "line-A-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_03.dts b/drivers/of/unittest-data/overlay_gpio_03.dts
new file mode 100644
index 000000000000..6e0312340a1b
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
+	gpio@3 {
+		compatible = "unittest-gpio";
+		reg = <3>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
+
+		line-d {
+			gpio-hog;
+			gpios = <4 0>;
+			input;
+			line-name = "line-D-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_04a.dts b/drivers/of/unittest-data/overlay_gpio_04a.dts
new file mode 100644
index 000000000000..7b1e04ebfa7a
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
+	gpio@4 {
+		compatible = "unittest-gpio";
+		reg = <4>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <2>;
+		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
+	};
+};
diff --git a/drivers/of/unittest-data/overlay_gpio_04b.dts b/drivers/of/unittest-data/overlay_gpio_04b.dts
new file mode 100644
index 000000000000..a14e95c6699a
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
+	gpio@4 {
+		line-c {
+			gpio-hog;
+			gpios = <3 0>;
+			input;
+			line-name = "line-C-input";
+		};
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 68b87587b2ef..6059bb363097 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -24,6 +24,7 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/gpio/driver.h>
 
 #include <linux/bitops.h>
 
@@ -46,6 +47,97 @@
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
+	struct gpio_chip chip;
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
@@ -2183,6 +2275,153 @@ static inline void of_unittest_overlay_i2c_15(void) { }
 
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
+	 */
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+	chip_request_count = unittest_gpio_chip_request_count;
+
+	/*
+	 * overlay_gpio_01 contains gpio node and child gpio hog node
+	 * overlay_gpio_02a contains gpio node
+	 * overlay_gpio_02b contains child gpio hog node
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
+	/*
+	 * messages are the result of the probes, after the
+	 * driver is registered
+	 */
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-B-input) hogged as input\n");
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-A-input) hogged as input\n");
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
+	 * overlay_gpio_03 contains gpio node and child gpio hog node
+	 *
+	 * - apply overlay_gpio_03
+	 *
+	 * apply overlay will result in
+	 *   - probe and processing gpio hog.
+	 */
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+	chip_request_count = unittest_gpio_chip_request_count;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-D-input) hogged as input\n");
+
+	/* overlay_gpio_03 contains gpio node and child gpio hog node */
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
+	 * overlay_gpio_04a contains gpio node
+	 *
+	 * - apply overlay_gpio_04a
+	 *
+	 * apply the overlay will result in
+	 *   - probe for overlay_gpio_04a
+	 */
+
+	probe_pass_count = unittest_gpio_probe_pass_count;
+	chip_request_count = unittest_gpio_chip_request_count;
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
+	 * overlay_gpio_04b contains child gpio hog node
+	 *
+	 * - apply overlay_gpio_04b
+	 *
+	 * apply the overlay will result in
+	 *   - processing gpio for overlay_gpio_04b
+	 */
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "GPIO line <<int>> (line-C-input) hogged as input\n");
+
+	/* overlay_gpio_04b contains child gpio hog node */
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
@@ -2242,6 +2481,8 @@ static void __init of_unittest_overlay(void)
 	of_unittest_overlay_i2c_cleanup();
 #endif
 
+	of_unittest_overlay_gpio();
+
 	of_unittest_destroy_tracked_overlays();
 
 out:
@@ -2295,6 +2536,12 @@ struct overlay_info {
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
@@ -2319,6 +2566,12 @@ struct overlay_info {
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

