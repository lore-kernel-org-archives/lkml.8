Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7074520B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgE1G4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:56:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57122 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1G4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:56:13 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04S6u9NH057422;
        Thu, 28 May 2020 15:56:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Thu, 28 May 2020 15:56:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04S6u4t0057399
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 May 2020 15:56:09 +0900 (JST)
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
Subject: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
Date:   Thu, 28 May 2020 15:56:03 +0900
Message-Id: <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
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

Thus, let's allow fuzzers to always evaluate pr_devel()/pr_debug()
messages, by redirecting no-op pr_devel()/pr_debug() calls to snprintf().

[1] https://syzkaller.appspot.com/bug?id=12be9aa373be9d8727cdd172f190de39528a413a

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/dev_printk.h    | 16 ++++++++++++++++
 include/linux/dynamic_debug.h | 14 ++++++++++++--
 include/linux/printk.h        | 10 ++++++++++
 lib/Kconfig.twist             | 12 ++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 3028b644b4fb..ed5d5bb3b5b6 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -121,6 +121,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 ({									\
 	if (0)								\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, dev_fmt(fmt), ##__VA_ARGS__);		\
 })
 #endif
 
@@ -133,12 +135,16 @@ do {									\
 		__print_once = true;					\
 		dev_level(dev, fmt, ##__VA_ARGS__);			\
 	}								\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);			\
 } while (0)
 #else
 #define dev_level_once(dev_level, dev, fmt, ...)			\
 do {									\
 	if (0)								\
 		dev_level(dev, fmt, ##__VA_ARGS__);			\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);			\
 } while (0)
 #endif
 
@@ -166,6 +172,8 @@ do {									\
 				      DEFAULT_RATELIMIT_BURST);		\
 	if (__ratelimit(&_rs))						\
 		dev_level(dev, fmt, ##__VA_ARGS__);			\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);			\
 } while (0)
 
 #define dev_emerg_ratelimited(dev, fmt, ...)				\
@@ -195,6 +203,8 @@ do {									\
 	    __ratelimit(&_rs))						\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, dev_fmt(fmt), ##__VA_ARGS__);		\
 } while (0)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
@@ -204,12 +214,16 @@ do {									\
 				      DEFAULT_RATELIMIT_BURST);		\
 	if (__ratelimit(&_rs))						\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, dev_fmt(fmt), ##__VA_ARGS__);		\
 } while (0)
 #else
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
 	if (0)								\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, dev_fmt(fmt), ##__VA_ARGS__);		\
 } while (0)
 #endif
 
@@ -220,6 +234,8 @@ do {									\
 ({									\
 	if (0)								\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, dev_fmt(fmt), ##__VA_ARGS__);		\
 })
 #endif
 
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fde30eb..ede42ebb38e5 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -201,9 +201,19 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 }
 
 #define dynamic_pr_debug(fmt, ...)					\
-	do { if (0) printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); } while (0)
+	do {								\
+		if (0)							\
+			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
+		else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+			snprintf(NULL, 0, pr_fmt(fmt), ##__VA_ARGS__);	\
+	} while (0)
 #define dynamic_dev_dbg(dev, fmt, ...)					\
-	do { if (0) dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__); } while (0)
+	do {								\
+		if (0)							\
+			dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__); \
+		else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+			snprintf(NULL, 0, fmt, ##__VA_ARGS__);		\
+	} while (0)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
 	do { if (0)							\
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fc8f03c54543..517c7cdec265 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -135,6 +135,8 @@ struct va_format {
 ({							\
 	if (0)						\
 		printk(fmt, ##__VA_ARGS__);		\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);	\
 	0;						\
 })
 
@@ -439,6 +441,8 @@ extern int kptr_restrict;
 		__print_once = true;				\
 		printk(fmt, ##__VA_ARGS__);			\
 	}							\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);		\
 	unlikely(__ret_print_once);				\
 })
 #define printk_deferred_once(fmt, ...)				\
@@ -450,6 +454,8 @@ extern int kptr_restrict;
 		__print_once = true;				\
 		printk_deferred(fmt, ##__VA_ARGS__);		\
 	}							\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);		\
 	unlikely(__ret_print_once);				\
 })
 #else
@@ -505,6 +511,8 @@ extern int kptr_restrict;
 									\
 	if (__ratelimit(&_rs))						\
 		printk(fmt, ##__VA_ARGS__);				\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, fmt, ##__VA_ARGS__);			\
 })
 #else
 #define printk_ratelimited(fmt, ...)					\
@@ -548,6 +556,8 @@ do {									\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
+	else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS)) \
+		snprintf(NULL, 0, pr_fmt(fmt), ##__VA_ARGS__);		\
 } while (0)
 #elif defined(DEBUG)
 #define pr_debug_ratelimited(fmt, ...)					\
diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
index f20e0d003581..a45a631819c3 100644
--- a/lib/Kconfig.twist
+++ b/lib/Kconfig.twist
@@ -12,10 +12,22 @@ if TWIST_KERNEL_BEHAVIOR
 
 config TWIST_FOR_SYZKALLER_TESTING
        bool "Select all twist options suitable for syzkaller testing"
+       select TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS
        select TWIST_DISABLE_KBD_K_SPEC_HANDLER
        help
 	 Say N unless you are building kernels for syzkaller's testing.
 
+config TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS
+       bool "Always evaluate printk() arguments"
+       help
+	 Currently, only format string of printk() arguments is checked
+	 by compiler if pr_devel()/pr_debug() are disabled. Therefore,
+	 fuzz testing cannot catch runtime bugs (e.g. NULL pointer
+	 dereference, use-after-free/out-of-bounds/uninitialized read)
+	 in disabled printk() calls. This option redirects disabled
+	 printk(...) to snprintf(NULL, 0, ...) in order to evaluate
+	 arguments without printing.
+
 config TWIST_DISABLE_KBD_K_SPEC_HANDLER
        bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
        help
-- 
2.18.2

