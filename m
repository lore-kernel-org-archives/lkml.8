Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEABC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C8320748
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="QIHl7zMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGIUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgGIUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:08:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:08:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so1255382ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=IQHnIdNal54sm3+jz3EltBqGOpDb3rbWGPv97/p+Pks=;
        b=QIHl7zMIw3dGasAbWEpkiyTYrYO/wW+l27wwB2XS1xUbnpHgx9zs6JtenqDqkpFTuq
         eCkf3uIP50+24+GxlZMW2r/IL4C8lmNDNgpgQHKbEYpia+1x2q4JN22cCh/q8nXMXf0c
         bfBKLWiVEqeplwEg2MJFhCy+LGqQxDsSaGtdlvfSZQLOoHU/T57UWg358fw2aWi+k2PR
         AfBBxfay/L20rPj575Em3qZoddhy8cgVjGtIDXokMV8CYV+3PVPSVQ1O13LYohVu3Q+1
         xw1fGKsO5788ubA6PWyHLy4K+K1g36JOri9y/1vX4o+bBywOQVgLBRxlb3/hcPTuAmlt
         U2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=IQHnIdNal54sm3+jz3EltBqGOpDb3rbWGPv97/p+Pks=;
        b=D7tyVyPtv8f6yzUCJbw8j1Mc4v43q/DSds0dJJEPXEWbeb4lWc+JfBcMZbEPBJX016
         5gwPKyjB5Erto6aA73DEKGq6vVPZjC/nNeYQMRxniktHU5y13OdnZM8PXP+yO0Zu0IMs
         P8liyO7MbqL1xv71FJnwEf5/aE7/L2fFEaXKSFRxI+Og/hy6WFximjpyevwg+vCh+Ylu
         T6G+qqHq4VWd8aFV5uwB/OqTORL02Zy39V/g06hjhpUlXPUWtt5o9/tSLbA2vvIF1KYH
         vIVpJRwaF9aKVY3AH95UWLv2Pms6SROT4z18jL52CBjMmvAc/k7V+cgrpJGMeAJmpTn2
         J6sg==
X-Gm-Message-State: AOAM532SbPyUI8xJMgsA11iomP4fyx+BL+2dktGTsAvTtYYAr56KMFD+
        S+GTYt5DDkk0LD7wP3QbT6BBeg==
X-Google-Smtp-Source: ABdhPJwd1DAa2K1UIdVt7iL6iamwAYF1TNfLnv3LuSla0FowJ3LMBrvCDu1SaUFZ2GKjnTk7/YE82w==
X-Received: by 2002:a17:902:c405:: with SMTP id k5mr40035169plk.233.1594325293632;
        Thu, 09 Jul 2020 13:08:13 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m3sm4030032pfk.171.2020.07.09.13.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:13 -0700 (PDT)
Subject: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:48 -0700
Message-Id: <20200709200552.1910298-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, zong.li@sifive.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

As part of adding support for STRICT_DEVMEM to the RISC-V port, Zong
provided a devmem_is_allowed() implementation that's exactly the same as
all the others I checked.  Instead I'm adding a generic version, which
will soon be used.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 include/asm-generic/io.h |  4 ++++
 lib/Kconfig              |  4 ++++
 lib/Makefile             |  2 ++
 lib/devmem_is_allowed.c  | 27 +++++++++++++++++++++++++++
 4 files changed, 37 insertions(+)
 create mode 100644 lib/devmem_is_allowed.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 8b1e020e9a03..69e3db65fba0 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1122,6 +1122,10 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
+extern int devmem_is_allowed(unsigned long pfn);
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_GENERIC_IO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index df3f3da95990..3b1b6481e073 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -676,3 +676,7 @@ config GENERIC_LIB_CMPDI2
 
 config GENERIC_LIB_UCMPDI2
 	bool
+
+config GENERIC_LIB_DEVMEM_IS_ALLOWED
+	bool
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..554ef14f9be5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -318,3 +318,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+
+obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
new file mode 100644
index 000000000000..c0d67c541849
--- /dev/null
+++ b/lib/devmem_is_allowed.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A generic version of devmem_is_allowed.
+ *
+ * Based on arch/arm64/mm/mmap.c
+ *
+ * Copyright (C) 2020 Google, Inc.
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/mm.h>
+#include <linux/ioport.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.  We mimic x86 here by
+ * disallowing access to system RAM as well as device-exclusive MMIO regions.
+ * This effectively disable read()/write() on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
-- 
2.27.0.383.g050319c2ae-goog

