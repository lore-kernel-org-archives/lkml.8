Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGho0Tih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHTJPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgHTJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:14:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD2C061342
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:14:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so701887pfx.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dDRDonHJvato3rSg9EzeGb5bHUmhRkgiaRA89g5iRE=;
        b=aGho0TihztlVcEALtbGufzeFiAShov5uftycOlvLNPpkcGpNdWZYT33Pnog7KCSLuW
         vNDzkydjCfGTyTCD7mZdd7my/ngKd7SezM4jdEepImdhFEdeHZu5yGqhtkC/pZYgkGbO
         01O2UoZR0A9xRT1J/AXYE+olOJpU08TIxhb8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dDRDonHJvato3rSg9EzeGb5bHUmhRkgiaRA89g5iRE=;
        b=SNmjRTHgxIoy5+gP5q1kY/65La04TPE741BkqISZs6Fiw/+5A8Ii84bkkCJ3ulFgKC
         4Ok4tZR5Fp/jP855OZug6Pnpstpm33ixv9mZnWa0XwOioH9titYVTOVirFbgeEmQjBn4
         oPBOJTj2hyzkUupMTIud8qIMtmbqMe9lxP6mZwKY2jcAHY5ZrLH6KIEJpk5UDhbNwMy/
         XqDV9+jedDicpCEcKJOaKkliROFKMIOBv8wXKU+Ne522DeAdcH8OjNZ626D6MMzLyIf9
         Z4GF9IM9xhSme0mCuS8+0wf/LVtZGiOXyEi8k69poeBBffjXNdLWR/EKyyvVk/yCIRGU
         0oSg==
X-Gm-Message-State: AOAM532C9jLU5/q4hTAoOMy6V3xvT9CPOxRtUHrcfkt4IUB3YXnjCTbr
        UMUGC3TbjKQ8WMegvapB4vPINw==
X-Google-Smtp-Source: ABdhPJywcBmh6B4y9LTUDxLhg3ZqPWZTMIB/igrhz0htlivl62N0XB02hWgytplaluoU2tCo9+qCNw==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr1813230pgi.20.1597914864654;
        Thu, 20 Aug 2020 02:14:24 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o15sm1954448pfu.167.2020.08.20.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:14:23 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Chao Yu <chao@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Howells <dhowells@redhat.com>,
        Divya Indi <divya.indi@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Will Deacon <will@kernel.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Date:   Thu, 20 Aug 2020 17:14:11 +0800
Message-Id: <20200820170951.v4.2.I4feb11d34ce7a0dd5ee2c3327fb5a1a9a646be30@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
References: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_printk is meant as a debugging tool, and should not be
compiled into production code without specific debug Kconfig
options enabled, or source code changes, as indicated by the
warning that shows up on boot if any trace_printk is called:
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **

If this option is set to n, the kernel will generate a
build-time error if trace_printk is used.

Note that the code to handle trace_printk is still present,
so this does not prevent people from compiling out-of-tree
kernel modules with the option set to =y, or BPF programs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

Changes since v2/v3:
 - Rebase only, v3 didn't exist as I just split out the other
   necessary patches.
 - Added patch 3/3 to fix atomisp_compat_css20.c

Changes since v1:
 - Use static_assert instead of __static_assert (Jason Gunthorpe)
 - Fix issues that can be detected by this patch (running some
   randconfig in a loop, kernel test robot, or manual inspection),
   by:
   - Making some debug config options that use trace_printk depend
     on the new config option.
   - Adding 3 patches before this one.

There is a question from Alexei whether the warning is warranted,
and it's possibly too strongly worded, but the fact is, we do
not want trace_printk to be sprinkled in kernel code by default,
unless a very specific Kconfig command is enabled (or preprocessor
macro).

There's at least 3 reasons that I can come up with:
 1. trace_printk introduces some overhead.
 2. If the kernel keeps adding always-enabled trace_printk, it will
    be much harder for developers to make use of trace_printk for
    debugging.
 3. People may assume that trace_printk is for debugging only, and
    may accidentally output sensitive data (theoritical at this
    stage).

 drivers/gpu/drm/i915/Kconfig.debug |  4 ++--
 fs/f2fs/Kconfig                    |  1 +
 include/linux/kernel.h             | 17 ++++++++++++++++-
 kernel/trace/Kconfig               | 10 ++++++++++
 samples/Kconfig                    |  2 ++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 1cb28c20807c59d..fa30f9bdc82311f 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -84,7 +84,7 @@ config DRM_I915_ERRLOG_GEM
 config DRM_I915_TRACE_GEM
 	bool "Insert extra ftrace output from the GEM internals"
 	depends on DRM_I915_DEBUG_GEM
-	select TRACING
+	depends on TRACING_ALLOW_PRINTK
 	default n
 	help
 	  Enable additional and verbose debugging output that will spam
@@ -98,7 +98,7 @@ config DRM_I915_TRACE_GEM
 config DRM_I915_TRACE_GTT
 	bool "Insert extra ftrace output from the GTT internals"
 	depends on DRM_I915_DEBUG_GEM
-	select TRACING
+	depends on TRACING_ALLOW_PRINTK
 	default n
 	help
 	  Enable additional and verbose debugging output that will spam
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index d13c5c6a978769b..d161d96cc1b7418 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -80,6 +80,7 @@ config F2FS_IO_TRACE
 	bool "F2FS IO tracer"
 	depends on F2FS_FS
 	depends on FUNCTION_TRACER
+	depends on TRACING_ALLOW_PRINTK
 	help
 	  F2FS IO trace is based on a function trace, which gathers process
 	  information and block IO patterns in the filesystem level.
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def620d8f493..7cf24fa16a479ed 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -720,10 +720,15 @@ do {									\
 #define trace_printk(fmt, ...)				\
 do {							\
 	char _______STR[] = __stringify((__VA_ARGS__));	\
+							\
+	static_assert(					\
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
@@ -772,6 +777,13 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
  */
 
 #define trace_puts(str) ({						\
+	static_assert(							\
+		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),		\
+		"trace_puts called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
+	do_trace_puts(str);						\
+})
+
+#define do_trace_puts(str) ({						\
 	static const char *trace_printk_fmt __used			\
 		__attribute__((section("__trace_printk_fmt"))) =	\
 		__builtin_constant_p(str) ? str : NULL;			\
@@ -793,6 +805,9 @@ extern void trace_dump_stack(int skip);
  */
 #define ftrace_vprintk(fmt, vargs)					\
 do {									\
+	static_assert(							\
+		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),		\
+		"ftrace_vprintk called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
 	if (__builtin_constant_p(fmt)) {				\
 		static const char *trace_printk_fmt __used		\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508c99..971b6035b197823 100644
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
@@ -686,6 +695,7 @@ config TRACEPOINT_BENCHMARK
 config RING_BUFFER_BENCHMARK
 	tristate "Ring buffer benchmark stress tester"
 	depends on RING_BUFFER
+	depends on TRACING_ALLOW_PRINTK
 	help
 	  This option creates a test to stress the ring buffer and benchmark it.
 	  It creates its own ring buffer such that it will not interfere with
diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d71d87b16..6b1ade57f00dd5d 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -19,6 +19,7 @@ config SAMPLE_TRACE_EVENTS
 config SAMPLE_TRACE_PRINTK
         tristate "Build trace_printk module - tests various trace_printk formats"
 	depends on EVENT_TRACING && m
+	depends on TRACING_ALLOW_PRINTK
 	help
 	 This builds a module that calls trace_printk() and can be used to
 	 test various trace_printk() calls from a module.
@@ -26,6 +27,7 @@ config SAMPLE_TRACE_PRINTK
 config SAMPLE_FTRACE_DIRECT
 	tristate "Build register_ftrace_direct() example"
 	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
+	depends on TRACING_ALLOW_PRINTK
 	depends on X86_64 # has x86_64 inlined asm
 	help
 	  This builds an ftrace direct function example
-- 
2.28.0.220.ged08abb693-goog

