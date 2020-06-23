Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA24220724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895492;
	bh=nkbj0ETn6qYoQ+M5v/6Z4kM7I83RYcIQaSHye1nFH4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0V+KQhaEmk/SwNkDkJRfVYvrRRXJ/1ZcD9PJs02qepFFsdxqnLRFjTPUYNtKXhpkg
	 egnKcvXJiTo6o3MZzungn/6w8zWigL0rsXjTcs7lEYGRncac/SIgRJ9upoD1xCZXo1
	 xb1OYCD+UBgzCOB7jdCFn/7fSRFf1MAd391ubWgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgFWG6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbgFWG6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:05 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51AD42078B;
        Tue, 23 Jun 2020 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895484;
        bh=nkbj0ETn6qYoQ+M5v/6Z4kM7I83RYcIQaSHye1nFH4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOhGXj1AIjee64oxlBT3oLVo6D/MBHn6syASjXjOZJnIgf1ZQv3UmWKFz5hFSU5wd
         7YlKjU5R2WWzOnb4UuSTAk2G5oBQD2zkge98AW3W6v0cXNEalNXv3rU08fXreHoSsi
         /uqy4DVX+WKJ1pMbDdzyKlHVvSQZeTzzjeidMFZ4=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 4/8] input: i8042: remove support for 8042-unicore32io
Date:   Tue, 23 Jun 2020 09:57:40 +0300
Message-Id: <20200623065744.18393-5-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
References: <20200623065744.18393-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The unicore32 port is removed from the kernel.
There is no point to keep stale definitions to support this architecture.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 MAINTAINERS                             |  1 -
 drivers/input/serio/i8042-unicore32io.h | 70 -------------------------
 drivers/input/serio/i8042.h             |  2 -
 3 files changed, 73 deletions(-)
 delete mode 100644 drivers/input/serio/i8042-unicore32io.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f36380d13014..33db62d2daf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13585,7 +13585,6 @@ M:	Guan Xuetao <gxt@pku.edu.cn>
 S:	Maintained
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 T:	git git://github.com/gxt/linux.git
-F:	drivers/input/serio/i8042-unicore32io.h
 F:	drivers/rtc/rtc-puv3.c
 F:	drivers/video/fbdev/fb-puv3.c
 
diff --git a/drivers/input/serio/i8042-unicore32io.h b/drivers/input/serio/i8042-unicore32io.h
deleted file mode 100644
index 50bb3ed94b56..000000000000
--- a/drivers/input/serio/i8042-unicore32io.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Code specific to PKUnity SoC and UniCore ISA
- *
- *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
- *	Copyright (C) 2001-2011 Guan Xuetao
- */
-#ifndef _I8042_UNICORE32_H
-#define _I8042_UNICORE32_H
-
-#include <mach/hardware.h>
-
-/*
- * Names.
- */
-#define I8042_KBD_PHYS_DESC "isa0060/serio0"
-#define I8042_AUX_PHYS_DESC "isa0060/serio1"
-#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
-
-/*
- * IRQs.
- */
-#define I8042_KBD_IRQ           IRQ_PS2_KBD
-#define I8042_AUX_IRQ           IRQ_PS2_AUX
-
-/*
- * Register numbers.
- */
-#define I8042_COMMAND_REG	PS2_COMMAND
-#define I8042_STATUS_REG	PS2_STATUS
-#define I8042_DATA_REG		PS2_DATA
-
-#define I8042_REGION_START	(resource_size_t)(PS2_DATA)
-#define I8042_REGION_SIZE	(resource_size_t)(16)
-
-static inline int i8042_read_data(void)
-{
-	return readb(I8042_DATA_REG);
-}
-
-static inline int i8042_read_status(void)
-{
-	return readb(I8042_STATUS_REG);
-}
-
-static inline void i8042_write_data(int val)
-{
-	writeb(val, I8042_DATA_REG);
-}
-
-static inline void i8042_write_command(int val)
-{
-	writeb(val, I8042_COMMAND_REG);
-}
-
-static inline int i8042_platform_init(void)
-{
-	if (!request_mem_region(I8042_REGION_START, I8042_REGION_SIZE, "i8042"))
-		return -EBUSY;
-
-	i8042_reset = I8042_RESET_ALWAYS;
-	return 0;
-}
-
-static inline void i8042_platform_exit(void)
-{
-	release_mem_region(I8042_REGION_START, I8042_REGION_SIZE);
-}
-
-#endif /* _I8042_UNICORE32_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index eb376700dfff..55381783dc82 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -21,8 +21,6 @@
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
 #include "i8042-x86ia64io.h"
-#elif defined(CONFIG_UNICORE32)
-#include "i8042-unicore32io.h"
 #else
 #include "i8042-io.h"
 #endif
-- 
2.26.2

