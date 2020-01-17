Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA41C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9265E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAQOjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:57388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgAQOjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 865EFABB1;
        Fri, 17 Jan 2020 14:39:00 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 01/15] Revert "drivers/hwtracing: make coresight-* explicitly non-modular"
Date:   Fri, 17 Jan 2020 15:39:56 +0100
Message-Id: <20200117144010.11149-2-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 941943cf519f7cacbbcecee5c4ef4b77b466bd5c.

Keep the descriptions in the driver headers. Also extend the same
changes to the drivers added after the reverted commit.

Prepare to make Coresight infrastructure modular.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-catu.c       |  5 ++++-
 drivers/hwtracing/coresight/coresight-etb10.c      |  7 ++++++-
 drivers/hwtracing/coresight/coresight-etm3x.c      | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm4x.c      |  7 +++++--
 drivers/hwtracing/coresight/coresight-funnel.c     |  6 +++++-
 drivers/hwtracing/coresight/coresight-replicator.c |  6 +++++-
 drivers/hwtracing/coresight/coresight-stm.c        |  4 +++-
 drivers/hwtracing/coresight/coresight-tmc.c        |  6 +++++-
 drivers/hwtracing/coresight/coresight-tpiu.c       |  6 +++++-
 include/linux/amba/bus.h                           |  9 ---------
 10 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 16ebf38a9f66..6fc76b776744 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -9,6 +9,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -584,5 +585,7 @@ static struct amba_driver catu_driver = {
 	.probe				= catu_probe,
 	.id_table			= catu_ids,
 };
+module_amba_driver(catu_driver);
 
-builtin_amba_driver(catu_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Coresight Address Translation Unit driver");
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 3810290e6d07..2d5a542e5464 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -7,6 +7,7 @@
 
 #include <linux/atomic.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -846,4 +847,8 @@ static struct amba_driver etb_driver = {
 	.probe		= etb_probe,
 	.id_table	= etb_ids,
 };
-builtin_amba_driver(etb_driver);
+
+module_amba_driver(etb_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Embedded Trace Buffer driver");
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index e2cb6873c3f2..8ee004ecaaa9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -33,10 +33,6 @@
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
 
-/*
- * Not really modular but using module_param is the easiest way to
- * remain consistent with existing use cases for now.
- */
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 
@@ -947,4 +943,8 @@ static struct amba_driver etm_driver = {
 	.probe		= etm_probe,
 	.id_table	= etm_ids,
 };
-builtin_amba_driver(etm_driver);
+
+module_amba_driver(etm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Program Flow Trace driver");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index a90d757f7043..c83fb4492282 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -1568,4 +1568,7 @@ static struct amba_driver etm4x_driver = {
 	.probe		= etm4_probe,
 	.id_table	= etm4_ids,
 };
-builtin_amba_driver(etm4x_driver);
+module_amba_driver(etm4x_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Program Flow Trace v4 driver");
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 900690a9f7f0..08d8f2b3565f 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -372,4 +373,7 @@ static struct amba_driver dynamic_funnel_driver = {
 	.probe		= dynamic_funnel_probe,
 	.id_table	= dynamic_funnel_ids,
 };
-builtin_amba_driver(dynamic_funnel_driver);
+module_amba_driver(dynamic_funnel_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Funnel driver");
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index e7dc1c31d20d..cc14c3696be0 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -369,4 +370,7 @@ static struct amba_driver dynamic_replicator_driver = {
 	.probe		= dynamic_replicator_probe,
 	.id_table	= dynamic_replicator_ids,
 };
-builtin_amba_driver(dynamic_replicator_driver);
+module_amba_driver(dynamic_replicator_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Replicator driver");
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index b908ca104645..1a641c803445 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -992,5 +992,7 @@ static struct amba_driver stm_driver = {
 	.probe          = stm_probe,
 	.id_table	= stm_ids,
 };
+module_amba_driver(stm_driver);
 
-builtin_amba_driver(stm_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight System Trace Macrocell driver");
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1cf82fa58289..5831c150034b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -558,4 +559,7 @@ static struct amba_driver tmc_driver = {
 	.probe		= tmc_probe,
 	.id_table	= tmc_ids,
 };
-builtin_amba_driver(tmc_driver);
+module_amba_driver(tmc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Trace Memory Controller driver");
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index f8583e4032a6..1f3c512fde2b 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -7,6 +7,7 @@
 
 #include <linux/atomic.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -226,4 +227,7 @@ static struct amba_driver tpiu_driver = {
 	.probe		= tpiu_probe,
 	.id_table	= tpiu_ids,
 };
-builtin_amba_driver(tpiu_driver);
+module_amba_driver(tpiu_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Trace Port Interface Unit driver");
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 26f0ecf401ea..5d53776ba4e0 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -205,13 +205,4 @@ struct amba_device name##_device = {				\
 #define module_amba_driver(__amba_drv) \
 	module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
 
-/*
- * builtin_amba_driver() - Helper macro for drivers that don't do anything
- * special in driver initcall.  This eliminates a lot of boilerplate.  Each
- * driver may only use this macro once, and calling it replaces the instance
- * device_initcall().
- */
-#define builtin_amba_driver(__amba_drv) \
-	builtin_driver(__amba_drv, amba_driver_register)
-
 #endif
-- 
2.16.4

