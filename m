Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505AC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF74520769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk0N1VVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:33:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37844 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:33:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id m16so632929pls.4;
        Fri, 10 Apr 2020 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pWsVtiX3GcZdmQwIjIqPKgDlzG51z14PXOFcpgZ+Gls=;
        b=Hk0N1VVyVk0vO2+KZPmKog1WqA/kVBuXWsht2i+GedjJ3voxVsNpmqfsPqHZwrF1xN
         zUfHUqHOpnbsgnc+zPORTUqCF428YBV8PaAnJZBEWXh472a3xXPgU5M3fBqzQ/KGr6s5
         RCLEJ26e/Hv/x1g5Illn0sa7c4TuRtqy88z/rXFeygUkqaMVal/8nWJ/eqA+XR+aNGsM
         SEnJtNU6iGnr6xTv5XH3EAGo3r7mbF4LpzN6GbjYGOjSbLktXBWCZI4CEbefEoXX5RJe
         u3cVXlqVB3L1ookceXrvz3GV7QXw5mw1wc/kqRTlLikJABLtah12ZqgN8bNTS5l8PazW
         eAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pWsVtiX3GcZdmQwIjIqPKgDlzG51z14PXOFcpgZ+Gls=;
        b=EDrL1D15+mqSqYmIvJJ0w7bJ+j5qZI5wu/+vQrTCeQbqdNVhBzAWqF33HSq1asN43A
         SOnuTZX4AKELCTuwroHtTF7KFUV8npRvam4bWpN351BXJc24xNh2PauSEcpTXzsxVCs3
         qnD7wtrPJ7T6zhj4hM7NCauy5PFI9J+bnnZT+EFQdl8TEfewCz5w5EFQV3FL9dLSPAXp
         9IAcNBZ3pSPCIccAax6sWfe10LiXPV5YtXWZjQ1Bwj1LZ0bbfF1hQA2WLwNDkUsqfEe3
         /OgSyLiVrbeD7/IGtfMxLyTVyabWhIP5aWMOjTKLmajjgpnbe1pgbd9PkWCghMB4KTXr
         7yew==
X-Gm-Message-State: AGi0PuYGuJYdkSRHE/CeTs6DZ5wqGrKBQE6813qzlrVKHdMf5Wrw35V5
        QQoBfYahy3xgV9HZqUYNx9s=
X-Google-Smtp-Source: APiQypLMlGjsFy5wQ+LNyOT69dUGo4Xi82hEbLXMtDUVK6nxDmncRaAeHGKK/WlZTjSD7oHOCFrIfA==
X-Received: by 2002:a17:902:7082:: with SMTP id z2mr4528018plk.43.1586522035384;
        Fri, 10 Apr 2020 05:33:55 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a3sm1689018pfg.172.2020.04.10.05.33.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:33:54 -0700 (PDT)
From:   Orson Zhai <orson.unisoc@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     orsonzhai@gmail.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@android.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH] dynamic_debug: Add an option to enable dynamic debug for modules only
Date:   Fri, 10 Apr 2020 20:33:04 +0800
Message-Id: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
debug. With the DEBUG_MODULE defined for any modules, dynamic debug
will be tied to them.

This is useful for people who only want to enable dynamic debug for
kernel modules without worrying about kernel image size and memory
consumption is increasing too much.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
 include/linux/dev_printk.h                        |  6 ++++--
 include/linux/dynamic_debug.h                     |  2 +-
 include/linux/printk.h                            | 14 +++++++++-----
 lib/Kconfig.debug                                 | 12 ++++++++++++
 lib/Makefile                                      |  2 +-
 lib/dynamic_debug.c                               |  9 +++++++--
 7 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0dc2eb8..fa5b8d4 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -13,8 +13,11 @@ kernel code to obtain additional kernel information.  Currently, if
 ``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
 enabled per-callsite.
 
-If ``CONFIG_DYNAMIC_DEBUG`` is not set, ``print_hex_dump_debug()`` is just
-shortcut for ``print_hex_dump(KERN_DEBUG)``.
+If ``CONFIG_DYNAMIC_DEBUG_CORE`` is set, only the modules with ``DEBUG_MODULE``
+defined will be tied into dynamic debug.
+
+If ``CONFIG_DYNAMIC_DEBUG`` or ``CONFIG_DYNAMIC_DEBUG_CORE`` is not set,
+``print_hex_dump_debug()`` is just shortcut for ``print_hex_dump(KERN_DEBUG)``.
 
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 5aad06b..2fb0671 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 #define dev_info(dev, fmt, ...)						\
 	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
 #define dev_dbg(dev, fmt, ...)						\
 	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
@@ -181,7 +182,8 @@ do {									\
 	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
 #define dev_info_ratelimited(dev, fmt, ...)				\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
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
index 1e6108b..77fab5b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -291,8 +291,9 @@ extern int kptr_restrict;
 /*
  * These can be used to print at the various log levels.
  * All of these will print unconditionally, although note that pr_debug()
- * and other debug macros are compiled out unless either DEBUG is defined
- * or CONFIG_DYNAMIC_DEBUG is set.
+ * and other debug macros are compiled out unless either DEBUG is defined,
+ * CONFIG_DYNAMIC_DEBUG is set, or CONFIG_DYNAMIC_DEBUG_CORE is set when
+ * DEBUG_MODULE being defined for any modules.
  */
 #define pr_emerg(fmt, ...) \
 	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
@@ -327,7 +328,8 @@ extern int kptr_restrict;
 
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
 #include <linux/dynamic_debug.h>
 
 /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
@@ -453,7 +455,8 @@ extern int kptr_restrict;
 #endif
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
 #define pr_debug_ratelimited(fmt, ...)					\
 do {									\
@@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 
 #endif
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,	\
 			     groupsize, buf, len, ascii)	\
 	dynamic_hex_dump(prefix_str, prefix_type, rowsize,	\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 50c1f5f..25a1b9de 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
 	default n
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	select DYNAMIC_DEBUG_CORE
 	help
 
 	  Compiles debug level messages into the kernel, which would not
@@ -165,6 +166,17 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DYNAMIC_DEBUG_CORE
+	bool "Enable core function of dynamic debug support"
+	depends on PRINTK
+	depends on (DEBUG_FS || PROC_FS)
+	help
+	  Enable core functional support of dynamic debug. It is useful
+	  when you want to tie dynamic debug to your kernel modules with
+	  DEBUG_MODULE defined for each of them, especially for the case
+	  of embedded system where the kernel image size is sensitive for
+	  people.
+
 config SYMBOLIC_ERRNAME
 	bool "Support symbolic error names in printf"
 	default y if PRINTK
diff --git a/lib/Makefile b/lib/Makefile
index 685aee6..8952772 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -186,7 +186,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
-obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8f199f4..321437b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1032,8 +1032,13 @@ static int __init dynamic_debug_init(void)
 	int verbose_bytes = 0;
 
 	if (&__start___verbose == &__stop___verbose) {
-		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
-		return 1;
+		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
+			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
+			return 1;
+		}
+		pr_info("Ignore empty _ddebug table in a CONFIG_DYNAMIC_DEBUG_CORE build\n");
+		ddebug_init_success = 1;
+		return 0;
 	}
 	iter = __start___verbose;
 	modname = iter->modname;
-- 
2.7.4

