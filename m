Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADA720836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzYEL5ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgFXIpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbgFXIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:45:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A0C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:45:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so874681pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcZNan/6AB/vkv3UghrQGStc0hQezRyCXEFFFLVApbU=;
        b=KzYEL5eiqFmI8xNDQbUVTPfw8BDN1Miyy92qy14LK5hNTHIUnPpKf1Wgr5G08a5jKc
         Sb+MkospilCJiPugr2/MAXO/SHai2vmKqJ56yQNANXYYZc36Y15qNKuEXGYoiSPF8lZZ
         TkAF3FtdlwUNOIclEovXph93py6BwmYGWMMew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcZNan/6AB/vkv3UghrQGStc0hQezRyCXEFFFLVApbU=;
        b=VSiaxS2q8pyj7viWkJxzOZzADLWABWjNOqq8xMD4iDaTssmWPEp8sFyGxSNIYcEN+L
         9EVTSwrHO+UYHg8Wx0vgQ7pluJC5//Y0jfuSOG1m7/9rbamR6jQWIHomfWQpQvCm/weY
         MbtiO/XNxZq29vfxoTdwPBw9fCVPLVWnP29oPmVpYzhzJMkzRaUarCeRuuk/t9yOPN4y
         DD0leLaJVtlsL33ONLe9cjYHPWiKpNbz3gncBnOWBmshhiE8Xc9JU3jegY1uySywS0Z8
         WyNI9g9ZbfKwhO7GDqlXESfITvYh7hDylMuc4IU8SVN4CLFa7qTo82AXr95mAf3QkeC2
         gNMg==
X-Gm-Message-State: AOAM532N1Ccz1BNv9I+8cyNW5FJfofAUULccVXBhKKSxddBBoLF7O076
        8M5rkRgUpzGLJx+dm5P1QDQXQ+YBIVmlNA==
X-Google-Smtp-Source: ABdhPJylNkGoBsHVex8XVqfyXcpNSEUnpUK2ENPnIrv6DpHeQbIg9ePMAJnoNkmXdQXVpdbpVjbpXA==
X-Received: by 2002:a63:1549:: with SMTP id 9mr20619084pgv.408.1592988336346;
        Wed, 24 Jun 2020 01:45:36 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id q16sm19404841pfg.49.2020.06.24.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:45:35 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>, dianders@chromium.org,
        groeck@chromium.org
Subject: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Date:   Wed, 24 Jun 2020 16:45:24 +0800
Message-Id: <20200624084524.259560-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_printk is only meant as a debugging tool, and should never be
compiled into production code without source code changes, as
indicated by the warning that shows up on boot if any trace_printk
is called:
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **

If this option is set to n, the kernel will generate a build-time
error if trace_printk is used.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 include/linux/kernel.h | 17 ++++++++++++++++-
 kernel/trace/Kconfig   |  9 +++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 196607aaf653082..b6addc6ba669e85 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -721,10 +721,15 @@ do {									\
 #define trace_printk(fmt, ...)				\
 do {							\
 	char _______STR[] = __stringify((__VA_ARGS__));	\
+							\
+	__static_assert(				\
+		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),\
+		"trace_printk called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
+							\
 	if (sizeof(_______STR) > 3)			\
 		do_trace_printk(fmt, ##__VA_ARGS__);	\
 	else						\
-		trace_puts(fmt);			\
+		do_trace_puts(fmt);			\
 } while (0)
 
 #define do_trace_printk(fmt, args...)					\
@@ -773,6 +778,13 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
  */
 
 #define trace_puts(str) ({						\
+	__static_assert(						\
+		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),		\
+		"trace_puts called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
+	do_trace_puts(str);						\
+})
+
+#define do_trace_puts(str) ({						\
 	static const char *trace_printk_fmt __used			\
 		__attribute__((section("__trace_printk_fmt"))) =	\
 		__builtin_constant_p(str) ? str : NULL;			\
@@ -794,6 +806,9 @@ extern void trace_dump_stack(int skip);
  */
 #define ftrace_vprintk(fmt, vargs)					\
 do {									\
+	__static_assert(						\
+		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),		\
+		"ftrace_vprintk called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
 	if (__builtin_constant_p(fmt)) {				\
 		static const char *trace_printk_fmt __used		\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508c99..89ffddebe1864aa 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -111,6 +111,15 @@ config GENERIC_TRACER
 	bool
 	select TRACING
 
+config TRACING_ALLOW_PRINTK
+	bool "Allow trace_printk"
+	default y if DEBUG_KERNEL
+	depends on TRACING
+	help
+	  trace_printk is only meant as a debugging tool. If this option is
+	  set to n, the kernel will generate a build-time error if trace_printk
+	  is used.
+
 #
 # Minimum requirements an architecture has to meet for us to
 # be able to offer generic tracing facilities:
-- 
2.27.0.111.gc72c7da667-goog

