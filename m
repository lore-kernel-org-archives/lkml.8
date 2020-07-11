Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E354C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3F52076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Dzt/iMd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGKD7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGKD7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:59:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F167C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so3424784pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=wantLvKFQ7sTWJpeW6b72Xahd71W/Sz84V8SEQBvlmI=;
        b=Dzt/iMd0Hum1aoS+SHRvQmVGrLKShehT79ai0Ryv1Ow+zSH+jbU0jjwYtZpVk67aiV
         1HiQkGeRmLeAWouzpK1njvMU2hi9+aOIhncWTl6oQ+CiXqBFME3Tc+7U9VAWwS72ayBO
         i4/YP6ES0V92NTI30DjTMpG9aSkH+3JhVVkmxvDnnaNIIPtpvjyArJAnu4W+RkJ4veM8
         PIn/5mchWUuc/cp8woLUw2vYx4IlJ21mUQrd3f74UNhii/G8w9nQ90zOGCgF8ZZJLRaW
         116tQlsVrG9tfuLFIQGA+Kt9aGH+2nCXkDBm44G01dcOxh5CZ4GyVHQ6fAxIVPBEg+qo
         Icug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=wantLvKFQ7sTWJpeW6b72Xahd71W/Sz84V8SEQBvlmI=;
        b=mqsjL5tjWE++KHfDCqg3DZWpvkhdIxCtAXSxpgVckx5+9g4QKK6RIfoKWazLDNLE5f
         +KD96sdRyYGNZo5HqepstceSeeI9skvyVjEt52NMeuK7BET01ammrJJVu1fEKZWwHS/2
         tks/dgiJeSCKDA4mHfclOD+PL8jNDwb0VCZoO2IduP1qvWeM4bcgkVX1KBlK95gSC2Iv
         NjBST4vJr9WbVbXpCPonNHppQLXffYQc7ztRC4YuzxJGS9FPqsAUaZJmtO+mH9eruigC
         pe4uv4rH5eEg9fJ1aVvtTPkQOLnwv6H9Qd6SKepbRrOTmuTvC/RhHq+fyYzurjO64yUJ
         s3tw==
X-Gm-Message-State: AOAM5327mTtPonZVNMwo3U8Gxryc/dxWw2MJrJUzGq7ueAaLVNqTodK+
        uOcFK31DwcuGV60NzC6AK3Bdlg==
X-Google-Smtp-Source: ABdhPJx/QGm0euUPP1vS4ZGSr12gxaH7Z/02J8eMRGjwMOHJlhMMz4ZQIbxP9ubJpQt+MkD/3WtArg==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr5383732pls.6.1594439961667;
        Fri, 10 Jul 2020 20:59:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q24sm7718285pfg.34.2020.07.10.20.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:59:21 -0700 (PDT)
Subject: [PATCH 2/3] arm: Use the new generic copy_oldmem_page()
Date:   Fri, 10 Jul 2020 20:55:43 -0700
Message-Id: <20200711035544.2832154-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200711035544.2832154-1-palmer@dabbelt.com>
References: <20200711035544.2832154-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rppt@linux.ibm.com,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com,
        Palmer Dabbelt <palmerdabbelt@google.com>, mingo@kernel.org,
        ben-linux@fluff.org, peterz@infradead.org, broonie@kernel.org,
        davem@davemloft.net, rdunlap@infradead.org, uwe@kleine-koenig.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        willy@infradead.org, krzk@kernel.org, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, keescook@chromium.org,
        glider@google.com, elver@google.com, davidgow@google.com,
        mark.rutland@arm.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is exactly the same as the arm64 code, which I just into lib/ to
avoid copying it into the RISC-V port.  This builds with defconfig and with
CRASH_DUMP=y.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/kernel/Makefile     |  1 -
 arch/arm/kernel/crash_dump.c | 54 ------------------------------------
 3 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 arch/arm/kernel/crash_dump.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..dfbeb14e9673 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1933,6 +1933,7 @@ config ATAGS_PROC
 
 config CRASH_DUMP
 	bool "Build kdump crash kernel (EXPERIMENTAL)"
+	select GENERIC_LIB_COPY_OLDMEM_PAGE
 	help
 	  Generate crash dump after being started by kexec. This should
 	  be normally only set in special crash dump kernels which are
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89e5d864e923..b5310a90dfe4 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -65,7 +65,6 @@ obj-$(CONFIG_KGDB)		+= kgdb.o patch.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
-obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
deleted file mode 100644
index 53cb92435392..000000000000
--- a/arch/arm/kernel/crash_dump.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/kernel/crash_dump.c
- *
- * Copyright (C) 2010 Nokia Corporation.
- * Author: Mika Westerberg
- *
- * This code is taken from arch/x86/kernel/crash_dump_64.c
- *   Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
- *   Copyright (C) IBM Corporation, 2004. All rights reserved
- */
-
-#include <linux/errno.h>
-#include <linux/crash_dump.h>
-#include <linux/uaccess.h>
-#include <linux/io.h>
-
-/**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is int he user address space
- *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
-{
-	void *vaddr;
-
-	if (!csize)
-		return 0;
-
-	vaddr = ioremap(__pfn_to_phys(pfn), PAGE_SIZE);
-	if (!vaddr)
-		return -ENOMEM;
-
-	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
-
-	iounmap(vaddr);
-	return csize;
-}
-- 
2.27.0.383.g050319c2ae-goog

