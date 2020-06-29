Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C18C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDF120702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbgF2TVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:21:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbgF2TVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAF57AF8F;
        Mon, 29 Jun 2020 15:10:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 24/47] staging: vchiq: Get rid of vchiq_util.h
Date:   Mon, 29 Jun 2020 17:09:22 +0200
Message-Id: <20200629150945.10720-25-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file only provides other includes. Move the relevant includes
to their respective C files and delete it for good.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq.h |  1 -
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  1 +
 .../interface/vchiq_arm/vchiq_arm.c           |  2 ++
 .../interface/vchiq_arm/vchiq_core.c          |  9 +++++++
 .../interface/vchiq_arm/vchiq_shim.c          |  4 +--
 .../interface/vchiq_arm/vchiq_util.h          | 27 -------------------
 6 files changed, 14 insertions(+), 30 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 25af99a0f394..211b20705e36 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -5,7 +5,6 @@
 #define VCHIQ_VCHIQ_H
 
 #include "vchiq_if.h"
-#include "vchiq_util.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 46160139933e..5ed36d557014 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 355590f1e130..dddd5ea5d917 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -23,6 +23,8 @@
 #include <linux/compat.h>
 #include <linux/dma-mapping.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #include "vchiq_core.h"
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index fe8ce6880e49..2382dfb914ae 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1,8 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
 
+#include <linux/types.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/bitops.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 
 #include "vchiq_core.h"
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index fb6f3c052e11..d8329590b5b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -2,14 +2,14 @@
 /* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "vchiq_if.h"
 #include "../vchi/vchi.h"
 #include "vchiq.h"
 #include "vchiq_core.h"
 
-#include "vchiq_util.h"
-
 struct vchi_service {
 	unsigned int handle;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
deleted file mode 100644
index dcf081079c39..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#ifndef VCHIQ_UTIL_H
-#define VCHIQ_UTIL_H
-
-#include <linux/types.h>
-#include <linux/completion.h>
-#include <linux/mutex.h>
-#include <linux/bitops.h>
-#include <linux/kthread.h>
-#include <linux/wait.h>
-#include <linux/vmalloc.h>
-#include <linux/jiffies.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/interrupt.h>
-#include <linux/random.h>
-#include <linux/sched/signal.h>
-#include <linux/ctype.h>
-#include <linux/uaccess.h>
-#include <linux/time.h>  /* for time_t */
-#include <linux/slab.h>
-
-#include "vchiq_if.h"
-
-#endif
-- 
2.27.0

