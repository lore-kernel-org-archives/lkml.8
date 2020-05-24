Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A86C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEA20823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEXOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 10:50:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57015 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEXOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 10:50:45 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04OEogE7084474;
        Sun, 24 May 2020 23:50:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Sun, 24 May 2020 23:50:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04OEobQA084119
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 May 2020 23:50:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] twist: allow converting pr_devel()/pr_debug() into printk(KERN_DEBUG)
Date:   Sun, 24 May 2020 23:50:34 +0900
Message-Id: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
because pr_debug() was no-op [1].

  pr_debug("fallback-read subflow=%p",
           mptcp_subflow_ctx(ssock->sk));
  copied = sock_recvmsg(ssock, msg, flags);

Since console loglevel used by syzkaller will not print KERN_DEBUG
messages to consoles, always evaluating pr_devel()/pr_debug() messages
will not cause too much console output. Thus, let's allow fuzzers to
always evaluate pr_devel()/pr_debug() messages.

[1] https://syzkaller.appspot.com/bug?id=12be9aa373be9d8727cdd172f190de39528a413a

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/printk.h | 25 ++++++++++++++++++-------
 lib/Kconfig.twist      | 10 ++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 38beb97e7018..2562ffb438ed 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -389,7 +389,7 @@ extern int kptr_restrict;
  *
  * It uses pr_fmt() to generate the format string.
  */
-#ifdef DEBUG
+#if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
 #define pr_devel(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
@@ -399,7 +399,10 @@ extern int kptr_restrict;
 
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
+#if defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
+#define pr_debug(fmt, ...) \
+	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#elif defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 #include <linux/dynamic_debug.h>
 
@@ -476,7 +479,7 @@ extern int kptr_restrict;
 #define pr_cont_once(fmt, ...)					\
 	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
 
-#if defined(DEBUG)
+#if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
 #define pr_devel_once(fmt, ...)					\
 	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
@@ -485,7 +488,7 @@ extern int kptr_restrict;
 #endif
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(DEBUG)
+#if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
 #define pr_debug_once(fmt, ...)					\
 	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
@@ -528,7 +531,7 @@ extern int kptr_restrict;
 	printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 /* no pr_cont_ratelimited, don't do that... */
 
-#if defined(DEBUG)
+#if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
 #define pr_devel_ratelimited(fmt, ...)					\
 	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
@@ -537,7 +540,10 @@ extern int kptr_restrict;
 #endif
 
 /* If you are writing a driver, please use dev_dbg instead */
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
+#if defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
+#define pr_debug_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#elif defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
 #define pr_debug_ratelimited(fmt, ...)					\
@@ -585,7 +591,12 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 
 #endif
 
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
+#if defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
+#define print_hex_dump_debug(prefix_str, prefix_type, rowsize,		\
+			     groupsize, buf, len, ascii)		\
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
+		       groupsize, buf, len, ascii)
+#elif defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,	\
 			     groupsize, buf, len, ascii)	\
diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
index f20e0d003581..710202f4b15d 100644
--- a/lib/Kconfig.twist
+++ b/lib/Kconfig.twist
@@ -12,10 +12,20 @@ if TWIST_KERNEL_BEHAVIOR
 
 config TWIST_FOR_SYZKALLER_TESTING
        bool "Select all twist options suitable for syzkaller testing"
+       select TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK
        select TWIST_DISABLE_KBD_K_SPEC_HANDLER
        help
 	 Say N unless you are building kernels for syzkaller's testing.
 
+config TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK
+       bool "Always evaluate pr_devel() and pr_debug()"
+       help
+	 When pr_devel()/pr_debug() are no-op, only format string is checked
+	 by compiler, and runtime bugs (such as NULL pointer dereference)
+	 cannot be reported by fuzz testing.
+	 This option will unconditionally convert pr_devel() and pr_debug()
+	 into printk(KERN_DEBUG) in order to evaluate printk() arguments.
+
 config TWIST_DISABLE_KBD_K_SPEC_HANDLER
        bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
        help
-- 
2.18.2

