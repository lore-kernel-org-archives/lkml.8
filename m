Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1637C207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="OCGtNKv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGKD7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGKD7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:59:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A28C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so3441742pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=P9MdyjVmHGjCLFd0myvGNT7BnRX3ygM0xdoKm/Ke/yY=;
        b=OCGtNKv0K4oDex1LzcuU+H5ZX76sTLShGnUcL9b36TQHeg3xbV6WkQgdMY9YVcpQ5i
         M8uXX+kjRjByWZNr8CgbQkEvnu3xP9SjNb5qMqTnjgiynqfGtrHJKMTGWTp4WZiYZ8Um
         zfwDpSnA6sFHCy6wMJYCreoMknhufE+qPeTdXneRp1mUWyOtqrofcJf/ZJrlTvBJ5LE/
         vuV9MfwJ+USJ8aIBta8yKYbf/tC02W3Eho0XKDqWMgqgxgSS2N3uwcKPFFJLC/TFLKGt
         lv4cVafzWSoDTps9H7QoWxLaxybqJJxK1KnfFQwN+tG/gvV7wCENPgacFK/3lUfb6Sq4
         UUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=P9MdyjVmHGjCLFd0myvGNT7BnRX3ygM0xdoKm/Ke/yY=;
        b=WuohAvYZP5+6rtvcJlYIsn1Uk6dZThB4BcM25qYCogNBY6X3SrP21tlM1xHtJYA/FV
         w5T/1vV2N1qjs/1NlZZqSBWn0UexSZAd6wn7D3+nLX1boTd3UbdMbuJNuDOiXRjiuZ4P
         ogRLBbJmtW5FFQKQRwmd/BRasIzcDaBdlqNvCb7NdoEKPBNbP1e7QDw3JgDePBfKEYf1
         0W8Wo4KwT0uld/ougbg7k6R9gdUKrkdnWRADa1iFgPt6NsF0+KpiTAdnm6TkGZCYQnLT
         4l9C6HcOwk4NavPCnmn5WdviWVv9ohY/JD1TIXkLthnIPBpeIkhVR6mNoYlnQBcDERnz
         CtDQ==
X-Gm-Message-State: AOAM531LEh+9uezQJ+I92I8FlzwRPpxJ/vx2ye4cqLLs4w5EdmhzUI1/
        6PIJr1P/GL1icy1TOnJ3E6N7Ow==
X-Google-Smtp-Source: ABdhPJwxW+RayJdKkQ+JS7dT23gKNMK/oVXiknZXTWv/h3U+LQOqYbYRHyKYc4j42/P36M4Hzv2Mdg==
X-Received: by 2002:a17:902:b084:: with SMTP id p4mr37584442plr.58.1594439960312;
        Fri, 10 Jul 2020 20:59:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bx18sm7168249pjb.49.2020.07.10.20.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:59:19 -0700 (PDT)
Subject: [PATCH 1/3] lib: Add a generic copy_oldmem_page()
Date:   Fri, 10 Jul 2020 20:55:42 -0700
Message-Id: <20200711035544.2832154-2-palmer@dabbelt.com>
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

A version of this that is identical to the arm64 version was recently
copied into the RISC-V port while adding kexec() support.  Instead I'd
like to put a shared copy in lib/ and use it from the various ports.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 lib/Kconfig            |  3 +++
 lib/Makefile           |  2 ++
 lib/copy_oldmem_page.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 lib/copy_oldmem_page.c

diff --git a/lib/Kconfig b/lib/Kconfig
index df3f3da95990..25544abc9547 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -676,3 +676,6 @@ config GENERIC_LIB_CMPDI2
 
 config GENERIC_LIB_UCMPDI2
 	bool
+
+config GENERIC_LIB_COPY_OLDMEM_PAGE
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..30d57d8b32b1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -318,3 +318,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+
+obj-$(CONFIG_GENERIC_LIB_COPY_OLDMEM_PAGE) += copy_oldmem_page.o
diff --git a/lib/copy_oldmem_page.c b/lib/copy_oldmem_page.c
new file mode 100644
index 000000000000..f0090027218a
--- /dev/null
+++ b/lib/copy_oldmem_page.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Routines for doing kexec-based kdump
+ *
+ * Originally part of arch/arm64/kernel/crash_dump.c
+ * Copyright (C) 2017 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+/**
+ * copy_oldmem_page() - copy one page from old kernel memory
+ * @pfn: page frame number to be copied
+ * @buf: buffer where the copied page is placed
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page
+ * @userbuf: if set, @buf is in a user address space
+ *
+ * This function copies one page from old kernel memory into buffer pointed by
+ * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
+ * copied or negative error in case of failure.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+			 size_t csize, unsigned long offset,
+			 int userbuf)
+{
+	void *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
+			memunmap(vaddr);
+			return -EFAULT;
+		}
+	} else {
+		memcpy(buf, vaddr + offset, csize);
+	}
+
+	memunmap(vaddr);
+
+	return csize;
+}
-- 
2.27.0.383.g050319c2ae-goog

