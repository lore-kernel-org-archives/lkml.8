Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB1A206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbgFYREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406524AbgFYREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:04:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:04:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 28B682A5736
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
Date:   Thu, 25 Jun 2020 19:03:56 +0200
Message-Id: <20200625170356.225136-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
tag.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/Makefile                 | 2 +-
 drivers/platform/chrome/chromeos_pstore.c        | 2 +-
 drivers/platform/chrome/chromeos_tbmc.c          | 2 +-
 drivers/platform/chrome/cros_ec_chardev.c        | 2 +-
 drivers/platform/chrome/cros_ec_i2c.c            | 2 +-
 drivers/platform/chrome/cros_ec_ishtp.c          | 2 +-
 drivers/platform/chrome/cros_ec_lpc.c            | 2 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c        | 2 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h        | 2 +-
 drivers/platform/chrome/cros_ec_proto.c          | 2 +-
 drivers/platform/chrome/cros_ec_rpmsg.c          | 2 +-
 drivers/platform/chrome/cros_ec_sensorhub.c      | 2 +-
 drivers/platform/chrome/cros_ec_spi.c            | 2 +-
 drivers/platform/chrome/cros_ec_trace.c          | 2 +-
 drivers/platform/chrome/cros_ec_trace.h          | 2 +-
 drivers/platform/chrome/cros_usbpd_logger.c      | 2 +-
 drivers/platform/chrome/wilco_ec/Makefile        | 2 +-
 drivers/platform/chrome/wilco_ec/core.c          | 2 +-
 drivers/platform/chrome/wilco_ec/debugfs.c       | 2 +-
 drivers/platform/chrome/wilco_ec/event.c         | 2 +-
 drivers/platform/chrome/wilco_ec/keyboard_leds.c | 2 +-
 drivers/platform/chrome/wilco_ec/mailbox.c       | 2 +-
 drivers/platform/chrome/wilco_ec/properties.c    | 2 +-
 drivers/platform/chrome/wilco_ec/sysfs.c         | 2 +-
 drivers/platform/chrome/wilco_ec/telemetry.c     | 2 +-
 include/linux/platform_data/cros_ec_chardev.h    | 2 +-
 include/linux/platform_data/cros_ec_proto.h      | 2 +-
 include/linux/platform_data/cros_ec_sensorhub.h  | 2 +-
 28 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 41baccba033f7..b3242f7007886 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 # tell define_trace.h where to find the cros ec trace header
 CFLAGS_cros_ec_trace.o:=		-I$(src)
diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index f37c0ef4af1fd..664ffda570386 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // Driver to instantiate Chromebook ramoops device.
 //
 // Copyright (C) 2013 Google, Inc.
diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index d1cf8f3463ce3..8b3583814cffd 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // Driver to detect Tablet Mode for ChromeOS convertible.
 //
 // Copyright (C) 2017 Google, Inc.
diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index e0bce869c49a9..a92c4f4ff4a5b 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Miscellaneous character driver for ChromeOS Embedded Controller
  *
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 30c8938c27d54..89316cfb45463 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // I2C interface for ChromeOS Embedded Controller
 //
 // Copyright (C) 2012 Google, Inc
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index ed794a7ddba9b..bbb1e17abd6c9 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // ISHTP interface for ChromeOS Embedded Controller
 //
 // Copyright (c) 2019, Intel Corporation.
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 1f78619440448..67b17333acd04 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // LPC interface for ChromeOS Embedded Controller
 //
 // Copyright (C) 2012-2015 Google, Inc
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 9035b17e8c869..fe364e224a533 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // LPC variant I/O for Microchip EC
 //
 // Copyright (C) 2016 Google, Inc
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index aa1018f6b0f24..09dc6c6385d2b 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * LPC variant I/O for Microchip EC
  *
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092c..a7c94500624ee 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // ChromeOS EC communication protocol helper functions
 //
 // Copyright (C) 2015 Google, Inc
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 7e8629e3db746..ff08c3d12873a 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Copyright 2018 Google LLC.
 
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 9c4af76a9956e..d627b3f967d12 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Sensor HUB driver that discovers sensors behind a ChromeOS Embedded
  * Controller.
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index debea5c4c8293..f7cf7c6a04507 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // SPI interface for ChromeOS Embedded Controller
 //
 // Copyright (C) 2012 Google, Inc
diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 523a39bd0ff67..ad88542b2e252 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // Trace events for the ChromeOS Embedded Controller
 //
 // Copyright 2019 Google LLC.
diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index e9fb05f89ef07..6c2e23d88502b 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Trace events for the ChromeOS Embedded Controller
  *
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index d16931203d821..53639f9d9bfd5 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Logging driver for ChromeOS EC based USBPD Charger.
  *
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index ecb3145cab187..ea483068a907e 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 wilco_ec-objs				:= core.o keyboard_leds.o mailbox.o \
 					   properties.o sysfs.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 5b42992bff386..a0ac1268018f1 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Core driver for Wilco Embedded Controller
  *
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index a812788a0bdcc..c7a69fadf336e 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * debugfs attributes for Wilco EC
  *
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 814518509739d..0b6aa67ed7ab5 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ACPI event handling for Wilco Embedded Controller
  *
diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
index 6ce9c67820652..4fe80daf7eb45 100644
--- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
+++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Keyboard backlight LED driver for the Wilco Embedded Controller
  *
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index 0f98358ea824c..094de754fa4d3 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Mailbox interface for Wilco Embedded Controller
  *
diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
index c2bf4c95c5d2c..9f7e7083a240c 100644
--- a/drivers/platform/chrome/wilco_ec/properties.c
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2019 Google LLC
  */
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 3c587b4054a54..488671644f010 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2019 Google LLC
  *
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index e06d96fb94265..b7a2d6101fc9b 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Telemetry communication for Wilco EC
  *
diff --git a/include/linux/platform_data/cros_ec_chardev.h b/include/linux/platform_data/cros_ec_chardev.h
index 7de8faaf77df8..0284cde753bee 100644
--- a/include/linux/platform_data/cros_ec_chardev.h
+++ b/include/linux/platform_data/cros_ec_chardev.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * ChromeOS EC device interface.
  *
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 3832433266762..95427b03ddb5e 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * ChromeOS Embedded Controller protocol interface.
  *
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index 0ecce6aa69d5e..7d00138c1e292 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Chrome OS EC MEMS Sensor Hub driver.
  *
-- 
2.27.0

