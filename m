Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32976C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07B20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTz/HXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCYRNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:13:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39158 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:13:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id m1so1046521pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+RdHKnxuRKGaNc/IMKbObzEso5RkYhkN6UcAO5EyiIM=;
        b=KHTz/HXXDk03sn4s/bpeC3pZURT0qn1+0dki+eCcdRQ3oiAGcJBPSkntl/6vs+KnzO
         hjXHFQ/AW3reOfasbPkVGzSEuBrAQM0kPpTAxshsSZNyw7y+P0hHNKwloMS39h9wJVGL
         Fx8i6PbtMnZ7NLCP04bSwA24a97joXRQiOCWTKXas1mkkKBK/+5UAQ9s2pZN8A0GnqSR
         t0bJqRzFpQLfuHB+sCOTt9iNQVF8HungD9oj9R+3qjEx4zqf6JRH42DT9sJYl1/J9ElB
         6PJqzCcgTY7Wwqt4cgc6MVZqknhcg77sMECRA+HCjYKYOXzafzHQiFfP5V0K/6yFSFmR
         KfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+RdHKnxuRKGaNc/IMKbObzEso5RkYhkN6UcAO5EyiIM=;
        b=WpAxvCgaDOpVP1sM80JBIdN4igExL3VTtrrp67Bc/qIPKe4EeaQvKaes87As9Kd5LA
         Q4oopxWlau3c7ETRZpaQ15FnBGXBUk/CPEMLPyiSFrq2eR9PDRjw/XK5kdBsj9L0iM1w
         S5et+E+On6A30IXv7O+WUt3SSMnhJwBsU4+bFu28IHaP/r1xg/2pgDpcY88nfZNBTcEW
         g12dLqsLqfX0zu/E2CZ7ZOZwqa7HxRn0ps0BDrsK0sNF2mrieXRPDGHb7uOTHlm7bkUC
         Pq6CMwbZVbEhNiyuD7x6r1xH99A/jh6G/wsCHWRU2DLpIkmWg5MCstN6K4/bdlyrqRHV
         UJ1A==
X-Gm-Message-State: ANhLgQ33+EiwnuucjJ/w7cJv1HfPKHIbrqIQJNlsl/sHmYZW5aLtgdCL
        wu3v2cM3yqxV0kCa0G0P5J05E+tw
X-Google-Smtp-Source: ADFU+vvlbSyoSA7Z5WtBRWaBmkLeYmkVsnWns3eCsj33XvSPQoIDaQKgpsv4A+wQP4++YJlDgZnEXg==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr4884991pjk.54.1585156384598;
        Wed, 25 Mar 2020 10:13:04 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h6sm4812892pjk.33.2020.03.25.10.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 10:13:03 -0700 (PDT)
From:   Orson Zhai <orson.unisoc@gmail.com>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>, joe@perches.com
Cc:     orsonzhai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Orson Zhai <orson.unisoc@gmail.com>
Subject: [RFC PATCH V2] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
Date:   Thu, 26 Mar 2020 01:12:27 +0800
Message-Id: <1585156347-8365-1-git-send-email-orson.unisoc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of enabling whole kernel with CONFIG_DYNAMIC_DEBUG, CONFIG_
DYNAMIC_DEBUG_CORE will only make the basic function definition and
exported symbols to be built without replacing pr_debug or dev_dbg
to dynamic version unless DEBUG is defined for any desired modules
together by users.

This is useful for people who only want to enable dynamic debug for some
specific kernel modules without worrying about whole kernel image size will
be significantly increased and more memory consumption caused by CONFIG_
DYNAMIC_DEBUG.

Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
---
Changes from V1:
- Rewrite commit message for more generic usage.
- Add combination use of CONFIG_DYNAMIC_DEBUG_CORE and DEBUG to enable
  dynamic debug seperately.
- Ignore empty _ddtable and return success when only the core is enabled. 
- Fix all typoes.

 include/linux/dev_printk.h    |  6 ++++--
 include/linux/dynamic_debug.h |  2 +-
 include/linux/printk.h        | 12 ++++++++----
 lib/Kconfig.debug             | 18 ++++++++++++++++++
 lib/Makefile                  |  2 +-
 lib/dynamic_debug.c           |  9 +++++++--
 6 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 5aad06b..ed40030 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 #define dev_info(dev, fmt, ...)						\
 	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
 #define dev_dbg(dev, fmt, ...)						\
 	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
@@ -181,7 +182,8 @@ do {									\
 	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
 #define dev_info_ratelimited(dev, fmt, ...)				\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4cf02ec..abcd5fd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -48,7 +48,7 @@ struct _ddebug {
 
 
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 1e6108b..44d5378 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -292,7 +292,8 @@ extern int kptr_restrict;
  * These can be used to print at the various log levels.
  * All of these will print unconditionally, although note that pr_debug()
  * and other debug macros are compiled out unless either DEBUG is defined
- * or CONFIG_DYNAMIC_DEBUG is set.
+ * or CONFIG_DYNAMIC_DEBUG is set, or both CONFIG_DYNAMIC_DEBUG_CORE and
+ * DEBUG is defined.
  */
 #define pr_emerg(fmt, ...) \
 	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
@@ -327,7 +328,8 @@ extern int kptr_restrict;
 
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
 #include <linux/dynamic_debug.h>
 
 /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
@@ -453,7 +455,8 @@ extern int kptr_restrict;
 #endif
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
 #define pr_debug_ratelimited(fmt, ...)					\
 do {									\
@@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 
 #endif
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,	\
 			     groupsize, buf, len, ascii)	\
 	dynamic_hex_dump(prefix_str, prefix_type, rowsize,	\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a..8381b19 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
 	default n
 	depends on PRINTK
 	depends on DEBUG_FS
+	select DYNAMIC_DEBUG_CORE
 	help
 
 	  Compiles debug level messages into the kernel, which would not
@@ -164,6 +165,23 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DYNAMIC_DEBUG_CORE
+	bool "Enable core functions of dynamic debug support"
+	depends on PRINTK
+	depends on DEBUG_FS
+	help
+	  Enable this option to build ddebug_* and __dynamic_* routines
+	  into kernel. If you want enable whole dynamic debug features,
+	  select CONFIG_DYNAMIC_DEBUG directly and this option will be
+	  automatically selected as well.
+
+	  This option can be selected with DEBUG together which could be
+	  defined for desired kernel modules to enable dynamic debug
+	  features instead for whole kernel. Especially being used in
+	  the case that kernel modules are built out of kernel tree to
+	  have dynamic debug capabilities without affecting the kernel
+	  base.
+
 config SYMBOLIC_ERRNAME
 	bool "Support symbolic error names in printf"
 	default y if PRINTK
diff --git a/lib/Makefile b/lib/Makefile
index 611872c..2096d83 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
-obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c604091..34f303a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1014,8 +1014,13 @@ static int __init dynamic_debug_init(void)
 	int verbose_bytes = 0;
 
 	if (__start___verbose == __stop___verbose) {
-		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
-		return 1;
+		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
+			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
+			return 1;
+		}
+		pr_info("Ignore empty _ddebug table in a core only build\n");
+		ddebug_init_success = 1;
+		return 0;
 	}
 	iter = __start___verbose;
 	modname = iter->modname;
-- 
2.7.4

