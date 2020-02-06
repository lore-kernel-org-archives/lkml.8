Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE8BC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14620838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBFQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:39:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:25965 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgBFQjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:39:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="232097014"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 08:39:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56892373; Thu,  6 Feb 2020 18:39:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/4] kernel.h: Split out might_sleep() and friends
Date:   Thu,  6 Feb 2020 18:39:39 +0200
Message-Id: <20200206163940.1940-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
References: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out might_sleep()
and friends.

At the same time convert users in header and crypto folder to use new header.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 crypto/asymmetric_keys/pkcs7_trust.c |  3 +-
 include/linux/kernel.h               | 67 +------------------------
 include/linux/might_sleep.h          | 73 ++++++++++++++++++++++++++++
 include/linux/percpu-rwsem.h         |  1 +
 include/linux/sched.h                |  1 +
 include/linux/wait_bit.h             |  1 +
 6 files changed, 79 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/might_sleep.h

diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 61af3c4d82cc..9a3f0c3cafa2 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -6,8 +6,9 @@
  */
 
 #define pr_fmt(fmt) "PKCS7: "fmt
-#include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/might_sleep.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/asn1.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3ca18547af01..d9ce634457cb 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/math.h>
+#include <linux/might_sleep.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
 #include <linux/printk.h>
@@ -77,72 +78,6 @@
 
 struct completion;
 struct pt_regs;
-struct user;
-
-#ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
-#else
-# define might_resched() do { } while (0)
-#endif
-
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void ___might_sleep(const char *file, int line, int preempt_offset);
-extern void __might_sleep(const char *file, int line, int preempt_offset);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
-
-/**
- * might_sleep - annotation for functions that can sleep
- *
- * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...). Additional sections where blocking is
- * not allowed can be annotated with non_block_start() and non_block_end()
- * pairs.
- *
- * This is a useful debugging help to be able to catch problems early and not
- * be bitten later when the calling function happens to sleep when it is not
- * supposed to.
- */
-# define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
-/**
- * cant_sleep - annotation for functions that cannot sleep
- *
- * this macro will print a stack trace if it is executed with preemption enabled
- */
-# define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
-# define sched_annotate_sleep()	(current->task_state_change = 0)
-/**
- * non_block_start - annotate the start of section where sleeping is prohibited
- *
- * This is on behalf of the oom reaper, specifically when it is calling the mmu
- * notifiers. The problem is that if the notifier were to block on, for example,
- * mutex_lock() and if the process which holds that mutex were to perform a
- * sleeping memory allocation, the oom reaper is now blocked on completion of
- * that memory allocation. Other blocking calls like wait_event() pose similar
- * issues.
- */
-# define non_block_start() (current->non_block_count++)
-/**
- * non_block_end - annotate the end of section where sleeping is prohibited
- *
- * Closes a section opened by non_block_start().
- */
-# define non_block_end() WARN_ON(current->non_block_count-- == 0)
-#else
-  static inline void ___might_sleep(const char *file, int line,
-				   int preempt_offset) { }
-  static inline void __might_sleep(const char *file, int line,
-				   int preempt_offset) { }
-# define might_sleep() do { might_resched(); } while (0)
-# define cant_sleep() do { } while (0)
-# define sched_annotate_sleep() do { } while (0)
-# define non_block_start() do { } while (0)
-# define non_block_end() do { } while (0)
-#endif
-
-#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
 #if defined(CONFIG_MMU) && \
 	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
diff --git a/include/linux/might_sleep.h b/include/linux/might_sleep.h
new file mode 100644
index 000000000000..dbf009711333
--- /dev/null
+++ b/include/linux/might_sleep.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MIGHT_SLEEP_H
+#define _LINUX_MIGHT_SLEEP_H
+
+#include <asm/bug.h>
+#include <asm/current.h>
+
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+extern int _cond_resched(void);
+# define might_resched() _cond_resched()
+#else
+# define might_resched() do { } while (0)
+#endif
+
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+extern void ___might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_sleep(const char *file, int line, int preempt_offset);
+
+/**
+ * might_sleep - annotation for functions that can sleep
+ *
+ * this macro will print a stack trace if it is executed in an atomic
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
+ *
+ * This is a useful debugging help to be able to catch problems early and not
+ * be bitten later when the calling function happens to sleep when it is not
+ * supposed to.
+ */
+# define might_sleep() \
+	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+/**
+ * cant_sleep - annotation for functions that cannot sleep
+ *
+ * this macro will print a stack trace if it is executed with preemption enabled
+ */
+# define cant_sleep() \
+	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+# define sched_annotate_sleep()	(current->task_state_change = 0)
+/**
+ * non_block_start - annotate the start of section where sleeping is prohibited
+ *
+ * This is on behalf of the oom reaper, specifically when it is calling the mmu
+ * notifiers. The problem is that if the notifier were to block on, for example,
+ * mutex_lock() and if the process which holds that mutex were to perform a
+ * sleeping memory allocation, the oom reaper is now blocked on completion of
+ * that memory allocation. Other blocking calls like wait_event() pose similar
+ * issues.
+ */
+# define non_block_start() (current->non_block_count++)
+/**
+ * non_block_end - annotate the end of section where sleeping is prohibited
+ *
+ * Closes a section opened by non_block_start().
+ */
+# define non_block_end() WARN_ON(current->non_block_count-- == 0)
+#else
+  static inline void ___might_sleep(const char *file, int line,
+				   int preempt_offset) { }
+  static inline void __might_sleep(const char *file, int line,
+				   int preempt_offset) { }
+# define might_sleep() do { might_resched(); } while (0)
+# define cant_sleep() do { } while (0)
+# define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
+#endif
+
+#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
+
+#endif	/* _LINUX_MIGHT_SLEEP_H */
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index ad2ca2a89d5b..15c3b3a9f509 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -3,6 +3,7 @@
 #define _LINUX_PERCPU_RWSEM_H
 
 #include <linux/atomic.h>
+#include <linux/might_sleep.h>
 #include <linux/rwsem.h>
 #include <linux/percpu.h>
 #include <linux/rcuwait.h>
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f314790cb527..77698948308a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -15,6 +15,7 @@
 #include <linux/sem.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/might_sleep.h>
 #include <linux/mutex.h>
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7dec36aecbd9..324cdbf5b4a4 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -5,6 +5,7 @@
 /*
  * Linux wait-bit related types and methods:
  */
+#include <linux/might_sleep.h>
 #include <linux/wait.h>
 
 struct wait_bit_key {
-- 
2.24.1

