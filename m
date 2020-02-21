Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A497C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345F520722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvT2SFdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgBUW5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:57:17 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:57800 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBUW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:57:16 -0500
Received: by mail-wm1-f74.google.com with SMTP id t17so1192243wmi.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sP6Z7L3V8E82h2fwZqPlTVXoifzxjcYRadJI4ND9o7w=;
        b=VvT2SFdtez+dfsahMlQwosOokFTiFyQpGOTbDiOUipIrrmb7QWshLF7UMhTRrNkqEL
         M3Tvzn+C2yWZJIIpkmDCNU8d4P1Iu/RMawz2zeHyMxYFhEqqa5xRFwxsLQSRj2F7Z3/d
         uXtQwXAaG62y91ldWctAnwbYp85rtXmxB4Vh5oI4RjRFZjzU1krsa+J3tiWzR/hQnVV2
         y3bwD6ViovO4SXFuaHjhLkPWExQSQnfTOYLvairAKqnV4YTFdGn7mBRw3t7wdwQPkaWs
         yjoJGtX0rmLfpB/kTAfvtZpaJptXfQ1UYjr86pinTtv74XupvmdMGCryepG92CG/AbYd
         oWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sP6Z7L3V8E82h2fwZqPlTVXoifzxjcYRadJI4ND9o7w=;
        b=jYhjpWcXim2weYcuCqt5DbEVl6VSqXKrEDFhVMxpJpzuNY/lYkj8bLO0wYazEZR5XG
         rGv4DZ5/YNqG1ZFBFgepOUyYs8z41VfpjisqunAd91a5GFkd8MRcEbisvBHZoTZXJimI
         e8fy3NZMkrCKSLr8impAq2WD/YI3eM80CJNxxCfO5u/KXejSBHiJjSrgqFHy+QIucw7u
         DRD5PXJby1bO6oUZyDF8Hrj11OIbNpZDI1xmHArs8AJjqIljbAkVgQKeQM7GQ+6vHzZo
         HK1QYtqX9tz7X35ssqaKhOsDvFHmFTJqQT0sHiOw7YDqnLihp5xmkgLys0l4G4Tc6zQN
         b8MQ==
X-Gm-Message-State: APjAAAXVWen6X1tllTpeCTY05t+nr+qj78IDMMOgGQ8NT2l207mJs3DC
        iI3OphOtpY+JbQvtY5lVR4sF44tUNw==
X-Google-Smtp-Source: APXvYqzrWEreyoEuXpxMcP0PXV4NDJzk4erSyUDJOPe1FX0W+1WXgaPduqB42ZbnopNCvRycLIWiSIqVQA==
X-Received: by 2002:adf:f850:: with SMTP id d16mr49653895wrq.161.1582325833291;
 Fri, 21 Feb 2020 14:57:13 -0800 (PST)
Date:   Fri, 21 Feb 2020 23:56:35 +0100
Message-Id: <20200221225635.218857-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] kcsan: Add option for verbose reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
Currently information about the reporting task's held locks and IRQ
trace events are shown, if they are enabled.

Signed-off-by: Marco Elver <elver@google.com>
Suggested-by: Qian Cai <cai@lca.pw>
---
v2:
* Rework obtaining 'current' for the "other thread" -- it now passes
  'current' and ensures that we stall until the report was printed, so
  that the lockdep information contained in 'current' is accurate. This
  was non-trivial but testing so far leads me to conclude this now
  reliably prints the held locks for the "other thread" (please test
  more!).
---
 kernel/kcsan/core.c   |   4 +-
 kernel/kcsan/kcsan.h  |   3 ++
 kernel/kcsan/report.c | 103 +++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.kcsan     |  13 ++++++
 4 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e7387fec66795..065615df88eaa 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -18,8 +18,8 @@
 #include "kcsan.h"
 
 static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
-static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
-static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
+unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
+unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
 static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
 static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
 
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 892de5120c1b6..e282f8b5749e9 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -13,6 +13,9 @@
 /* The number of adjacent watchpoints to check. */
 #define KCSAN_CHECK_ADJACENT 1
 
+extern unsigned int kcsan_udelay_task;
+extern unsigned int kcsan_udelay_interrupt;
+
 /*
  * Globally enable and disable KCSAN.
  */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 11c791b886f3c..ee8f33d7405fb 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/debug_locks.h>
+#include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
@@ -31,7 +33,26 @@ static struct {
 	int			cpu_id;
 	unsigned long		stack_entries[NUM_STACK_ENTRIES];
 	int			num_stack_entries;
-} other_info = { .ptr = NULL };
+
+	/*
+	 * Optionally pass @current. Typically we do not need to pass @current
+	 * via @other_info since just @task_pid is sufficient. Passing @current
+	 * has additional overhead.
+	 *
+	 * To safely pass @current, we must either use get_task_struct/
+	 * put_task_struct, or stall the thread that populated @other_info.
+	 *
+	 * We cannot rely on get_task_struct/put_task_struct in case
+	 * release_report() races with a task being released, and would have to
+	 * free it in release_report(). This may result in deadlock if we want
+	 * to use KCSAN on the allocators.
+	 *
+	 * Since we also want to reliably print held locks for
+	 * CONFIG_KCSAN_VERBOSE, the current implementation stalls the thread
+	 * that populated @other_info until it has been consumed.
+	 */
+	struct task_struct	*task;
+} other_info;
 
 /*
  * Information about reported races; used to rate limit reporting.
@@ -245,6 +266,16 @@ static int sym_strcmp(void *addr1, void *addr2)
 	return strncmp(buf1, buf2, sizeof(buf1));
 }
 
+static void print_verbose_info(struct task_struct *task)
+{
+	if (!task)
+		return;
+
+	pr_err("\n");
+	debug_show_held_locks(task);
+	print_irqtrace_events(task);
+}
+
 /*
  * Returns true if a report was generated, false otherwise.
  */
@@ -319,6 +350,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 				  other_info.num_stack_entries - other_skipnr,
 				  0);
 
+		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		    print_verbose_info(other_info.task);
+
 		pr_err("\n");
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(access_type), ptr, size,
@@ -340,6 +374,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
 			  0);
 
+	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		print_verbose_info(current);
+
 	/* Print report footer. */
 	pr_err("\n");
 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
@@ -357,6 +394,67 @@ static void release_report(unsigned long *flags, enum kcsan_report_type type)
 	spin_unlock_irqrestore(&report_lock, *flags);
 }
 
+/*
+ * Sets @other_info.task and awaits consumption of @other_info.
+ *
+ * Precondition: report_lock is held.
+ * Postcontiion: report_lock is held.
+ */
+static void
+set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
+{
+	/*
+	 * We may be instrumenting a code-path where current->state is already
+	 * something other than TASK_RUNNING.
+	 */
+	const bool is_running = current->state == TASK_RUNNING;
+	/*
+	 * To avoid deadlock in case we are in an interrupt here and this is a
+	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
+	 * timeout to ensure this works in all contexts.
+	 *
+	 * Await approximately the worst case delay of the reporting thread (if
+	 * we are not interrupted).
+	 */
+	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
+
+	other_info.task = current;
+	do {
+		if (is_running) {
+			/*
+			 * Let lockdep know the real task is sleeping, to print
+			 * the held locks (recall we turned lockdep off, so
+			 * locking/unlocking @report_lock won't be recorded).
+			 */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+		}
+		spin_unlock_irqrestore(&report_lock, *flags);
+		/*
+		 * We cannot call schedule() since we also cannot reliably
+		 * determine if sleeping here is permitted -- see in_atomic().
+		 */
+
+		udelay(1);
+		spin_lock_irqsave(&report_lock, *flags);
+		if (timeout-- < 0) {
+			/*
+			 * Abort. Reset other_info.task to NULL, since it
+			 * appears the other thread is still going to consume
+			 * it. It will result in no verbose info printed for
+			 * this task.
+			 */
+			other_info.task = NULL;
+			break;
+		}
+		/*
+		 * If @ptr nor @current matches, then our information has been
+		 * consumed and we may continue. If not, retry.
+		 */
+	} while (other_info.ptr == ptr && other_info.task == current);
+	if (is_running)
+		set_current_state(TASK_RUNNING);
+}
+
 /*
  * Depending on the report type either sets other_info and returns false, or
  * acquires the matching other_info and returns true. If other_info is not
@@ -388,6 +486,9 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 		other_info.cpu_id		= cpu_id;
 		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
 
+		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+			set_other_info_task_blocking(flags, ptr);
+
 		spin_unlock_irqrestore(&report_lock, *flags);
 
 		/*
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 081ed2e1bf7b1..0f1447ff8f558 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -20,6 +20,19 @@ menuconfig KCSAN
 
 if KCSAN
 
+config KCSAN_VERBOSE
+	bool "Show verbose reports with more information about system state"
+	depends on PROVE_LOCKING
+	help
+	  If enabled, reports show more information about the system state that
+	  may help better analyze and debug races. This includes held locks and
+	  IRQ trace events.
+
+	  While this option should generally be benign, we call into more
+	  external functions on report generation; if a race report is
+	  generated from any one of them, system stability may suffer due to
+	  deadlocks or recursion.  If in doubt, say N.
+
 config KCSAN_DEBUG
 	bool "Debugging of KCSAN internals"
 
-- 
2.25.0.265.gbab2e86ba0-goog

