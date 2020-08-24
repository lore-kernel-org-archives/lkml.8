Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C229C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CFF20774
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JqEFzT+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHXC7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXC7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:59:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E342BC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:59:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so4083080pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0QJF7R64/4u4uhxHk6Dr7vlf2Ftq1vVohINvK7KjUw=;
        b=JqEFzT+VIrXPJgvfKn25hZpiRIv3iN3PNq43FaH27IXe6EJqUKEJ26viipsh36y50V
         uSkKEVikNVONqsxlpDP3dmBRmy8sB/+SBJ/MFcTRzZZ/lj/1vAf0DG45BQHBgbeBNnqO
         73yyMkJDSNyv6LJa5ucmYhvqX4GZoqcOOnhDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0QJF7R64/4u4uhxHk6Dr7vlf2Ftq1vVohINvK7KjUw=;
        b=rSgI+iOJObF/FCp59lZgHFQQNdw2lQBlAFa4V7VCJb+CK4PREpomhexnf4WqsYtJbY
         dI0D9CXOE+cEw50n48sp+3l/TIRPgEVDjq/QbOhd1699JCKl15eISMPwm8PyFk1Qe8Tb
         393YEvWd/cUXUd6g1OkMVcO8+OG71ySATYFxY1c+uD6OyPeN8c9qYdQAL/wfzW7wdJuw
         DMwDr8QjfZuwWmFj54tKwmBXiKCkWoeZM89otISe7BnYK4jH4giHtc2W0IJxUK+u5btN
         8sgKhdS3/Xj3/I4fuex443aRa8u2zAB46yH4gvsXBittG4v4EeGC1jFWIBo8ngti7wxS
         6hyw==
X-Gm-Message-State: AOAM532CW54YIzseP0dwH6O3ak77Un/LA5ASPR3VqgivSVA0ug9VOpMz
        fUdOURfIvAPRvHkuW6RLCXWgCg==
X-Google-Smtp-Source: ABdhPJzJf6RfSrxJg8ML3dQRkPNgII4aES5+W4MBkDjynEWvNKUkwbGWmFwHh4+Ok7tSp18HA89X+Q==
X-Received: by 2002:a63:ee0d:: with SMTP id e13mr2136851pgi.337.1598237974042;
        Sun, 23 Aug 2020 19:59:34 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id 8sm8063058pjx.14.2020.08.23.19.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 19:59:33 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     dianders@chromium.org, groeck@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Will Deacon <will@kernel.org>, Yue Hu <huyue2@yulong.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] kernel/trace: Add DISALLOW_TRACE_PRINTK make option
Date:   Mon, 24 Aug 2020 10:59:13 +0800
Message-Id: <20200824105852.v5.1.I4feb11d34ce7a0dd5ee2c3327fb5a1a9a646be30@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
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

If DISALLOW_TRACE_PRINTK=1 is passed on the make command
line, the kernel will generate a build-time error if
trace_printk is used. We expect distributors to set this
option for their production kernels.

Note that the code to handle trace_printk is still present,
so this does not prevent people from compiling out-of-tree
kernel modules, or BPF programs.

Also, we are not making this a kernel config option as we
want the developer convenience of being able to reuse a
production kernel config, add trace_printk for debugging,
and rebuild, without any config changes.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v4:
 - Turns this into a make option, instead of a config
   option, as suggested by Steven Rostedt <rostedt@goodmis.org>.

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

 Makefile               | 14 ++++++++++++++
 include/linux/kernel.h | 17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c4470a4e131f2ce..fb8b0d7fb4b2df7 100644
--- a/Makefile
+++ b/Makefile
@@ -100,6 +100,16 @@ endif
 
 export quiet Q KBUILD_VERBOSE
 
+# Disallow use of trace_printk. Can be used by production kernels.
+ifeq ("$(origin DISALLOW_TRACE_PRINTK)", "command line")
+  KBUILD_DISALLOW_TRACE_PRINTK = $(DISALLOW_TRACE_PRINTK)
+endif
+ifndef KBUILD_DISALLOW_TRACE_PRINTK
+  KBUILD_DISALLOW_TRACE_PRINTK = 0
+endif
+
+export KBUILD_DISALLOW_TRACE_PRINTK
+
 # Kbuild will save output files in the current working directory.
 # This does not need to match to the root of the kernel source tree.
 #
@@ -838,6 +848,10 @@ KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 endif
 
+ifeq ($(KBUILD_DISALLOW_TRACE_PRINTK),1)
+KBUILD_CFLAGS += -DDISALLOW_TRACE_PRINTK
+endif
+
 KBUILD_CFLAGS += $(DEBUG_CFLAGS)
 export DEBUG_CFLAGS
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def620d8f493..7b533b0375596af 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -687,6 +687,12 @@ do {									\
 		____trace_printk_check_format(fmt, ##args);		\
 } while (0)
 
+#ifdef DISALLOW_TRACE_PRINTK
+#define ALLOW_TRACE_PRINTK 0
+#else
+#define ALLOW_TRACE_PRINTK 1
+#endif
+
 /**
  * trace_printk - printf formatting in the ftrace buffer
  * @fmt: the printf format for printing
@@ -720,10 +726,13 @@ do {									\
 #define trace_printk(fmt, ...)				\
 do {							\
 	char _______STR[] = __stringify((__VA_ARGS__));	\
+							\
+	static_assert(ALLOW_TRACE_PRINTK, "trace_printk called.");	\
+							\
 	if (sizeof(_______STR) > 3)			\
 		do_trace_printk(fmt, ##__VA_ARGS__);	\
 	else						\
-		trace_puts(fmt);			\
+		do_trace_puts(fmt);			\
 } while (0)
 
 #define do_trace_printk(fmt, args...)					\
@@ -772,6 +781,11 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
  */
 
 #define trace_puts(str) ({						\
+	static_assert(ALLOW_TRACE_PRINTK, "trace_puts called.");	\
+	do_trace_puts(str);						\
+})
+
+#define do_trace_puts(str) ({						\
 	static const char *trace_printk_fmt __used			\
 		__attribute__((section("__trace_printk_fmt"))) =	\
 		__builtin_constant_p(str) ? str : NULL;			\
@@ -793,6 +807,7 @@ extern void trace_dump_stack(int skip);
  */
 #define ftrace_vprintk(fmt, vargs)					\
 do {									\
+	static_assert(ALLOW_TRACE_PRINTK, "ftrace_vprintk called.");	\
 	if (__builtin_constant_p(fmt)) {				\
 		static const char *trace_printk_fmt __used		\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
-- 
2.28.0.297.g1956fa8f8d-goog

