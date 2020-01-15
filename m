Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FAAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FE2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579106727;
	bh=Y4IYUVVjZSqNT4KHF506A9nSH7m+8bY0oPsOq9XflGA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GyyG6VVSZmOBLHTJu0FLtriNrUcItiHAqEapJ/sGlpVaKYR+ohT/K9AXOOgFLTNJC
	 3Q+yfDQlnhUKKO6UI+dZL7qNSnaaGpVGcRtHaGcVWJGcm6Mx+5cVnRICSfa/DSacE2
	 ky0PF3tTAutCRjcqgz11HJtzHFZCXkXcjmRNEP7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAOQpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:45:25 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:16849 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:45:25 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 00FGivO6011079;
        Thu, 16 Jan 2020 01:44:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 00FGivO6011079
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579106697;
        bh=SZOkYphT7E9GHjXKlgV0QDCeNekw7U6rZwFuYSvNizY=;
        h=From:To:Cc:Subject:Date:From;
        b=lx0ln1tP6OWFky+GojsB/NB82j+COpWI/RRYP8E8JvKhGC0+W3VmISGmKk0JzRu20
         6T5YjGFgNyG/mUf6BInQa2RW84MR/ix0cDo0fv9sN/IHYvDZuVnIDESalqMhOIGgcK
         YUzSoUmhVnwIE9KSNOsy/7h3rp2Y9jr9D62IKYFQCxRgSKgO36Q09hqtjEtJvDsvYJ
         n5AfMXRtb1cIVxujBoqX0bm8NJfXTZV+hnjHfD6CjU2dhOJLn+JgdvkATwbyIAI5cd
         J90vyX2mxOmWpHG3ge+atVdTS0YOxaXG5WpOygW17cpakQZrkaSWRmrLKUWefCcRlk
         qizmzh+kUmj2A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: most: remove header include path to drivers/staging
Date:   Thu, 16 Jan 2020 01:44:51 +0900
Message-Id: <20200115164451.13203-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to add "ccflags-y += -I $(srctree)/drivers/staging"
just for including <most/most.h>.

Use the #include "..." directive with the correct relative path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - rebase on linux-next

 drivers/staging/most/Makefile       | 1 -
 drivers/staging/most/cdev/Makefile  | 1 -
 drivers/staging/most/cdev/cdev.c    | 3 ++-
 drivers/staging/most/configfs.c     | 3 ++-
 drivers/staging/most/core.c         | 3 ++-
 drivers/staging/most/dim2/Makefile  | 1 -
 drivers/staging/most/dim2/dim2.c    | 2 +-
 drivers/staging/most/i2c/Makefile   | 1 -
 drivers/staging/most/i2c/i2c.c      | 2 +-
 drivers/staging/most/net/Makefile   | 1 -
 drivers/staging/most/net/net.c      | 3 ++-
 drivers/staging/most/sound/Makefile | 1 -
 drivers/staging/most/sound/sound.c  | 3 ++-
 drivers/staging/most/usb/Makefile   | 1 -
 drivers/staging/most/usb/usb.c      | 3 ++-
 drivers/staging/most/video/Makefile | 1 -
 drivers/staging/most/video/video.c  | 2 +-
 17 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
index 85ea5a434ced..20a99ecb37c4 100644
--- a/drivers/staging/most/Makefile
+++ b/drivers/staging/most/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_MOST) += most_core.o
 most_core-y := core.o
 most_core-y += configfs.o
-ccflags-y += -I $(srctree)/drivers/staging/
 
 obj-$(CONFIG_MOST_CDEV)	+= cdev/
 obj-$(CONFIG_MOST_NET)	+= net/
diff --git a/drivers/staging/most/cdev/Makefile b/drivers/staging/most/cdev/Makefile
index 9f4a8b8c9c27..ef90cd71994a 100644
--- a/drivers/staging/most/cdev/Makefile
+++ b/drivers/staging/most/cdev/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_CDEV) += most_cdev.o
 
 most_cdev-objs := cdev.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index 59f346d1f4af..71943d17f825 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -16,7 +16,8 @@
 #include <linux/kfifo.h>
 #include <linux/uaccess.h>
 #include <linux/idr.h>
-#include <most/most.h>
+
+#include "../most.h"
 
 #define CHRDEV_REGION_SIZE 50
 
diff --git a/drivers/staging/most/configfs.c b/drivers/staging/most/configfs.c
index 9818f6c8b22a..034ab96ef69e 100644
--- a/drivers/staging/most/configfs.c
+++ b/drivers/staging/most/configfs.c
@@ -10,7 +10,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/configfs.h>
-#include <most/most.h>
+
+#include "most.h"
 
 #define MAX_STRING_SIZE 80
 
diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index af542ed6c7f0..4958921f3bb3 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -21,7 +21,8 @@
 #include <linux/kthread.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
-#include <most/most.h>
+
+#include "most.h"
 
 #define MAX_CHANNELS	64
 #define STRING_SIZE	80
diff --git a/drivers/staging/most/dim2/Makefile b/drivers/staging/most/dim2/Makefile
index 116f04d69244..861adacf6c72 100644
--- a/drivers/staging/most/dim2/Makefile
+++ b/drivers/staging/most/dim2/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_DIM2) += most_dim2.o
 
 most_dim2-objs := dim2.o hal.o sysfs.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 9eb10fc0903e..15c6aa8fa1ea 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -21,7 +21,7 @@
 #include <linux/sched.h>
 #include <linux/kthread.h>
 
-#include <most/most.h>
+#include "../most.h"
 #include "hal.h"
 #include "errors.h"
 #include "sysfs.h"
diff --git a/drivers/staging/most/i2c/Makefile b/drivers/staging/most/i2c/Makefile
index 2b3769dc19e7..71099dd0f85b 100644
--- a/drivers/staging/most/i2c/Makefile
+++ b/drivers/staging/most/i2c/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_I2C) += most_i2c.o
 
 most_i2c-objs := i2c.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index d07719c38fc9..2980f7065846 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 
-#include <most/most.h>
+#include "../most.h"
 
 enum { CH_RX, CH_TX, NUM_CHANNELS };
 
diff --git a/drivers/staging/most/net/Makefile b/drivers/staging/most/net/Makefile
index f0ac64dee71b..1582c97eb204 100644
--- a/drivers/staging/most/net/Makefile
+++ b/drivers/staging/most/net/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_NET) += most_net.o
 
 most_net-objs := net.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index db4273256ce8..8218c9a06cb5 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -15,7 +15,8 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/kobject.h>
-#include <most/most.h>
+
+#include "../most.h"
 
 #define MEP_HDR_LEN 8
 #define MDP_HDR_LEN 16
diff --git a/drivers/staging/most/sound/Makefile b/drivers/staging/most/sound/Makefile
index a3d086c6ca70..f0cd9d8d213e 100644
--- a/drivers/staging/most/sound/Makefile
+++ b/drivers/staging/most/sound/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_SOUND) += most_sound.o
 
 most_sound-objs := sound.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 23baf4bd7c12..44cf2334834f 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -17,7 +17,8 @@
 #include <sound/pcm_params.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
-#include <most/most.h>
+
+#include "../most.h"
 
 #define DRIVER_NAME "sound"
 #define STRING_SIZE	80
diff --git a/drivers/staging/most/usb/Makefile b/drivers/staging/most/usb/Makefile
index 83cf2ead7122..c2b207339aec 100644
--- a/drivers/staging/most/usb/Makefile
+++ b/drivers/staging/most/usb/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_USB) += most_usb.o
 
 most_usb-objs := usb.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
index 491b38e91e9d..35217ca65cbb 100644
--- a/drivers/staging/most/usb/usb.c
+++ b/drivers/staging/most/usb/usb.c
@@ -23,7 +23,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/uaccess.h>
-#include <most/most.h>
+
+#include "../most.h"
 
 #define USB_MTU			512
 #define NO_ISOCHRONOUS_URB	0
diff --git a/drivers/staging/most/video/Makefile b/drivers/staging/most/video/Makefile
index 2d857d3cbcc8..856175fec8b6 100644
--- a/drivers/staging/most/video/Makefile
+++ b/drivers/staging/most/video/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_VIDEO) += most_video.o
 
 most_video-objs := video.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 9e9e45ac386e..d32ae49d617b 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -21,7 +21,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fh.h>
 
-#include <most/most.h>
+#include "../most.h"
 
 #define V4L2_CMP_MAX_INPUT  1
 
-- 
2.17.1

