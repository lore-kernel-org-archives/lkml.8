Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B820738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQWi1wEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgGMOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgGMOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:48:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7823C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so16813228wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0pmLFNlTduR63r2uQwnAiflSc4mar8B5juCZYmI/TOU=;
        b=bQWi1wEc5FDBMWDxLIkHdwqrGYPtQ7/vvgw5X7uJLJJQxH26B1y+f2/qOtDwzB19ho
         zG6Bj4uxl7wzXsCAxyElKLATjrtamS896ygsWAgZVMmVtx4VFnb6CMultbbwhkt8SySc
         D9dEWfBd0YUbq0ZaYG6PHF77gBQtHzFJqBGTSjIrW7Ae6hnfV6o9of+zreKLw17rWW0c
         Extf0aRdXlcE18rCLOQLF/mroGuAFd34xOYDYHxZGpN3CZu/910koIyqaHTWngMw/5k5
         Y7fDjpbZ0G4r51C8YzZRjc3hpE7yXjSp/k51p/McUSa8h4fVjCTzs4gzWIN4fTQ2nZ9S
         aFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0pmLFNlTduR63r2uQwnAiflSc4mar8B5juCZYmI/TOU=;
        b=gZ6yuX5SfsleqFSuZlfceSoaO2b2qzdxbx6FdLSFKkOCfcQ4+fH/2AoEmNPfmL1utq
         MuZVPAyK2S7WRMSRywM1kaJcLraE7ZJYSOxP460Gomn2+uBg9UwOgThhRgPcgurmw/bM
         inuXtjAKXnPsr8d6k5EdByWu5UdthXU0CrVbTsDjDVOg3d219bbJ4384qVaq7Grj6jxs
         wH4PqMOlJIczNUiUs8++FEiYOLIhUo3whBqXcYlQVbqEWNQJaHNTTugRFZ3gBa4ssIMW
         A+0uM9tgIB1z0ngZC2mmHbpxQHnvNoob0nCLkuc1yYQdi3W42dOVSYxn7Wq8wWnvzV+n
         QniA==
X-Gm-Message-State: AOAM532ShiH4kt6bIiFoZ+DqwsRqq5ET7pfCymdAF/7FlF4UTU7zpuLe
        iVkXYD5qUg4uMNAPWFuLQ078NNwg
X-Google-Smtp-Source: ABdhPJxTE1RX6MZfGR9uY5U5Rv6eya0OjSIBSUcYACgcIh98rEUxSBLbA8Tcf644ey5sZn0/ckGt8Q==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr82897915wrq.189.1594651689895;
        Mon, 13 Jul 2020 07:48:09 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id u17sm23369080wrp.70.2020.07.13.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:48:08 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/3] habanalabs: create common folder
Date:   Mon, 13 Jul 2020 18:54:23 +0300
Message-Id: <20200713155424.24721-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713155424.24721-1-oded.gabbay@gmail.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For internal needs of our CI we need to move all the common code into a
common folder instead of putting them in the root folder of the driver.

Same applies to the common header files under include/

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Makefile                      | 11 +++++------
 drivers/misc/habanalabs/common/Makefile               |  9 +++++++++
 drivers/misc/habanalabs/{ => common}/asid.c           |  0
 drivers/misc/habanalabs/{ => common}/command_buffer.c |  0
 .../misc/habanalabs/{ => common}/command_submission.c |  0
 drivers/misc/habanalabs/{ => common}/context.c        |  0
 drivers/misc/habanalabs/{ => common}/debugfs.c        |  0
 drivers/misc/habanalabs/{ => common}/device.c         |  0
 drivers/misc/habanalabs/{ => common}/firmware_if.c    |  2 +-
 drivers/misc/habanalabs/{ => common}/habanalabs.h     |  4 ++--
 drivers/misc/habanalabs/{ => common}/habanalabs_drv.c |  0
 .../misc/habanalabs/{ => common}/habanalabs_ioctl.c   |  0
 drivers/misc/habanalabs/{ => common}/hl_dma_fence.c   |  0
 drivers/misc/habanalabs/{ => common}/hl_dma_fence.h   |  0
 drivers/misc/habanalabs/{ => common}/hw_queue.c       |  0
 drivers/misc/habanalabs/{ => common}/hwmon.c          |  0
 drivers/misc/habanalabs/{ => common}/irq.c            |  0
 drivers/misc/habanalabs/{ => common}/memory.c         |  0
 drivers/misc/habanalabs/{ => common}/mmu.c            |  0
 drivers/misc/habanalabs/{ => common}/pci.c            |  0
 drivers/misc/habanalabs/{ => common}/sysfs.c          |  0
 drivers/misc/habanalabs/gaudi/Makefile                |  2 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h                |  2 +-
 drivers/misc/habanalabs/goya/goyaP.h                  |  2 +-
 .../misc/habanalabs/include/{ => common}/armcp_if.h   |  0
 .../misc/habanalabs/include/{ => common}/hl_boot_if.h |  0
 .../misc/habanalabs/include/{ => common}/qman_if.h    |  0
 27 files changed, 20 insertions(+), 12 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/Makefile
 rename drivers/misc/habanalabs/{ => common}/asid.c (100%)
 rename drivers/misc/habanalabs/{ => common}/command_buffer.c (100%)
 rename drivers/misc/habanalabs/{ => common}/command_submission.c (100%)
 rename drivers/misc/habanalabs/{ => common}/context.c (100%)
 rename drivers/misc/habanalabs/{ => common}/debugfs.c (100%)
 rename drivers/misc/habanalabs/{ => common}/device.c (100%)
 rename drivers/misc/habanalabs/{ => common}/firmware_if.c (99%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs.h (99%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_drv.c (100%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_ioctl.c (100%)
 rename drivers/misc/habanalabs/{ => common}/hl_dma_fence.c (100%)
 rename drivers/misc/habanalabs/{ => common}/hl_dma_fence.h (100%)
 rename drivers/misc/habanalabs/{ => common}/hw_queue.c (100%)
 rename drivers/misc/habanalabs/{ => common}/hwmon.c (100%)
 rename drivers/misc/habanalabs/{ => common}/irq.c (100%)
 rename drivers/misc/habanalabs/{ => common}/memory.c (100%)
 rename drivers/misc/habanalabs/{ => common}/mmu.c (100%)
 rename drivers/misc/habanalabs/{ => common}/pci.c (100%)
 rename drivers/misc/habanalabs/{ => common}/sysfs.c (100%)
 rename drivers/misc/habanalabs/include/{ => common}/armcp_if.h (100%)
 rename drivers/misc/habanalabs/include/{ => common}/hl_boot_if.h (100%)
 rename drivers/misc/habanalabs/include/{ => common}/qman_if.h (100%)

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 83b0e9ac35d6..a786c0a7de9a 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -3,16 +3,15 @@
 # Makefile for HabanaLabs AI accelerators driver
 #
 
-obj-m	:= habanalabs.o
+obj-$(CONFIG_HABANA_AI) := habanalabs.o
 
-habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
-		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
-		command_submission.o mmu.o firmware_if.o pci.o hl_dma_fence.o
-
-habanalabs-$(CONFIG_DEBUG_FS) += debugfs.o
+include $(src)/common/Makefile
+habanalabs-y += $(HL_COMMON_FILES)
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
 
 include $(src)/gaudi/Makefile
 habanalabs-y += $(HL_GAUDI_FILES)
+
+habanalabs-$(CONFIG_DEBUG_FS) += common/debugfs.o
diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
new file mode 100644
index 000000000000..1e149f5852c6
--- /dev/null
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+subdir-ccflags-y += -I$(src)/common
+
+HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
+		common/asid.o common/habanalabs_ioctl.o \
+		common/command_buffer.o common/hw_queue.o common/irq.o \
+		common/sysfs.o common/hwmon.o common/memory.o \
+		common/command_submission.o common/mmu.o common/firmware_if.o \
+		common/pci.o common/hl_dma_fence.o
diff --git a/drivers/misc/habanalabs/asid.c b/drivers/misc/habanalabs/common/asid.c
similarity index 100%
rename from drivers/misc/habanalabs/asid.c
rename to drivers/misc/habanalabs/common/asid.c
diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
similarity index 100%
rename from drivers/misc/habanalabs/command_buffer.c
rename to drivers/misc/habanalabs/common/command_buffer.c
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
similarity index 100%
rename from drivers/misc/habanalabs/command_submission.c
rename to drivers/misc/habanalabs/common/command_submission.c
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/common/context.c
similarity index 100%
rename from drivers/misc/habanalabs/context.c
rename to drivers/misc/habanalabs/common/context.c
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
similarity index 100%
rename from drivers/misc/habanalabs/debugfs.c
rename to drivers/misc/habanalabs/common/debugfs.c
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/common/device.c
similarity index 100%
rename from drivers/misc/habanalabs/device.c
rename to drivers/misc/habanalabs/common/device.c
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
similarity index 99%
rename from drivers/misc/habanalabs/firmware_if.c
rename to drivers/misc/habanalabs/common/firmware_if.c
index 3be1549cd137..b2b84510b932 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -6,7 +6,7 @@
  */
 
 #include "habanalabs.h"
-#include "include/hl_boot_if.h"
+#include "include/common/hl_boot_if.h"
 
 #include <linux/firmware.h>
 #include <linux/genalloc.h>
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
similarity index 99%
rename from drivers/misc/habanalabs/habanalabs.h
rename to drivers/misc/habanalabs/common/habanalabs.h
index 3f9270ace869..c362df319d17 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -8,8 +8,8 @@
 #ifndef HABANALABSP_H_
 #define HABANALABSP_H_
 
-#include "include/armcp_if.h"
-#include "include/qman_if.h"
+#include "include/common/armcp_if.h"
+#include "include/common/qman_if.h"
 #include <uapi/misc/habanalabs.h>
 
 #include <linux/cdev.h>
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
similarity index 100%
rename from drivers/misc/habanalabs/habanalabs_drv.c
rename to drivers/misc/habanalabs/common/habanalabs_drv.c
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
similarity index 100%
rename from drivers/misc/habanalabs/habanalabs_ioctl.c
rename to drivers/misc/habanalabs/common/habanalabs_ioctl.c
diff --git a/drivers/misc/habanalabs/hl_dma_fence.c b/drivers/misc/habanalabs/common/hl_dma_fence.c
similarity index 100%
rename from drivers/misc/habanalabs/hl_dma_fence.c
rename to drivers/misc/habanalabs/common/hl_dma_fence.c
diff --git a/drivers/misc/habanalabs/hl_dma_fence.h b/drivers/misc/habanalabs/common/hl_dma_fence.h
similarity index 100%
rename from drivers/misc/habanalabs/hl_dma_fence.h
rename to drivers/misc/habanalabs/common/hl_dma_fence.h
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
similarity index 100%
rename from drivers/misc/habanalabs/hw_queue.c
rename to drivers/misc/habanalabs/common/hw_queue.c
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
similarity index 100%
rename from drivers/misc/habanalabs/hwmon.c
rename to drivers/misc/habanalabs/common/hwmon.c
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/common/irq.c
similarity index 100%
rename from drivers/misc/habanalabs/irq.c
rename to drivers/misc/habanalabs/common/irq.c
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/common/memory.c
similarity index 100%
rename from drivers/misc/habanalabs/memory.c
rename to drivers/misc/habanalabs/common/memory.c
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/common/mmu.c
similarity index 100%
rename from drivers/misc/habanalabs/mmu.c
rename to drivers/misc/habanalabs/common/mmu.c
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/common/pci.c
similarity index 100%
rename from drivers/misc/habanalabs/pci.c
rename to drivers/misc/habanalabs/common/pci.c
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
similarity index 100%
rename from drivers/misc/habanalabs/sysfs.c
rename to drivers/misc/habanalabs/common/sysfs.c
diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index f802cdc980ca..75104ae74e2b 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-subdir-ccflags-y += -I$(src)
+subdir-ccflags-y += -I$(src)/common
 
 HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o \
 	gaudi/gaudi_coresight.o
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index bdc5f96085a7..a94ab6a180f0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -10,7 +10,7 @@
 
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
-#include "include/hl_boot_if.h"
+#include "include/common/hl_boot_if.h"
 #include "include/gaudi/gaudi_packets.h"
 #include "include/gaudi/gaudi.h"
 #include "include/gaudi/gaudi_async_events.h"
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 8265cc21b45a..9e674cf39fd9 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -10,7 +10,7 @@
 
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
-#include "include/hl_boot_if.h"
+#include "include/common/hl_boot_if.h"
 #include "include/goya/goya_packets.h"
 #include "include/goya/goya.h"
 #include "include/goya/goya_async_events.h"
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/common/armcp_if.h
similarity index 100%
rename from drivers/misc/habanalabs/include/armcp_if.h
rename to drivers/misc/habanalabs/include/common/armcp_if.h
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
similarity index 100%
rename from drivers/misc/habanalabs/include/hl_boot_if.h
rename to drivers/misc/habanalabs/include/common/hl_boot_if.h
diff --git a/drivers/misc/habanalabs/include/qman_if.h b/drivers/misc/habanalabs/include/common/qman_if.h
similarity index 100%
rename from drivers/misc/habanalabs/include/qman_if.h
rename to drivers/misc/habanalabs/include/common/qman_if.h
-- 
2.17.1

