Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE6C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A5D24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cW2cAcBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgBSPPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:15:45 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:49791 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBSPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:15:43 -0500
Received: by mail-wr1-f73.google.com with SMTP id w6so204503wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Byu8soxgkprIbakxZbQOBFe9yLNNMXZxXhnHj/Q3XIE=;
        b=cW2cAcBPaoRfi740A0YFL1zfRrWwQT3Ywad2o0tS1cjb3DWhwcokkOpkWIQVHOyuij
         Y9vktaPxXwfSZZm3OKWDkMNSP6w6IeDMe+Rx1UPkBMZOdd7hXHE2m6JrxXBX8ZdrrAsY
         Vi6M+PauJdkMZTMVfR62A965PBQ93m/Zl3MqSlBcp0SndV+8dVMqze7nCnc5TdYMYNsp
         U073aNUXW+L0Rfodeag1IePWwgMVdV/2SWiEYbTFe3oBVg4NllG4GVa8GpI56SL9/tRm
         ap4rV4BXKIOKcbdiGdz8BLtaMT4L94XMhsU7cqYBrnPkbU0YcVxUjjyA8XX0nj5s7LUu
         ETqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Byu8soxgkprIbakxZbQOBFe9yLNNMXZxXhnHj/Q3XIE=;
        b=ka29pDUuvN57zavjvLfE1uoY4CsFvS1rTxtkuQ618UZXst4TDzSonyUFS8UeTEdFEh
         cLBQOCBUuMn2Xuo4C4ZXOyvLpbf2eccCRex3O4EajHWXuLnhmLIg0K2Xa9XVXrNlp0Zl
         /fIiT9L2x3i6oDpXZWm085lZoi2lP7B7c7HCfxRks6pLqP56APoUPpHk1e7Hg8w10cUR
         kfsHzKMh7aqiMXllevtiqu0qR560KLlqUH3BaKLhcGkjAKTDyRqw1BAw/2Kki8a6HnFT
         HQ/qatrRfo9wLRnRqzYXXjy5nPpOBdQKMEU8G2ifXyIxsVJeUPszMJDc8b6sezqtneTe
         3tNA==
X-Gm-Message-State: APjAAAWkNnKf286RqimaAMZU95ohWbT/7F9Sph75mmOFQUO9CLgxUpFn
        34YbR3Uo3fXwduzdf+xaLk+0I3RQ8w==
X-Google-Smtp-Source: APXvYqzfKoU7MwR28IPVZkrEnceMYCpwrSoFkpv0xw1GtOH2qCPEW/pH2s1jHSsLXmvp21i0qSDZpjDpnQ==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr9741809wru.262.1582125340973;
 Wed, 19 Feb 2020 07:15:40 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:15:31 +0100
Message-Id: <20200219151531.161515-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] kcsan: Add option for verbose reporting
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
 kernel/kcsan/report.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan     | 13 ++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 11c791b886f3c..f14becb6f1537 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/debug_locks.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
+#include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/stacktrace.h>
@@ -245,6 +247,29 @@ static int sym_strcmp(void *addr1, void *addr2)
 	return strncmp(buf1, buf2, sizeof(buf1));
 }
 
+static void print_verbose_info(struct task_struct *task)
+{
+	if (!task)
+		return;
+
+	if (task != current && task->state == TASK_RUNNING)
+		/*
+		 * Showing held locks for a running task is unreliable, so just
+		 * skip this. The printed locks are very likely inconsistent,
+		 * since the stack trace was obtained when the actual race
+		 * occurred and the task has since continued execution. Since we
+		 * cannot display the below information from the racing thread,
+		 * but must print it all from the watcher thread, bail out.
+		 * Note: Even if the task is not running, there is a chance that
+		 * the locks held may be inconsistent.
+		 */
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
@@ -319,6 +344,26 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 				  other_info.num_stack_entries - other_skipnr,
 				  0);
 
+		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE) && other_info.task_pid != -1) {
+			struct task_struct *other_task;
+
+			/*
+			 * Rather than passing @current from the other task via
+			 * @other_info, obtain task_struct here. The problem
+			 * with passing @current via @other_info is that, we
+			 * would have to get_task_struct/put_task_struct, and if
+			 * we race with a task being released, we would have to
+			 * release it in release_report(). This may result in
+			 * deadlock if we want to use KCSAN on the allocators.
+			 * Instead, make this best-effort, and if the task was
+			 * already released, we just do not print anything here.
+			 */
+			rcu_read_lock();
+			other_task = find_task_by_pid_ns(other_info.task_pid, &init_pid_ns);
+			print_verbose_info(other_task);
+			rcu_read_unlock();
+		}
+
 		pr_err("\n");
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(access_type), ptr, size,
@@ -340,6 +385,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
 			  0);
 
+	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		print_verbose_info(current);
+
 	/* Print report footer. */
 	pr_err("\n");
 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index f0b791143c6ab..ba9268076cfbc 100644
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

