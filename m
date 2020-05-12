Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75807C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554EB206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgELOsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgELOsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:48:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1F6206A3;
        Tue, 12 May 2020 14:48:37 +0000 (UTC)
Date:   Tue, 12 May 2020 10:48:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes for v5.7 from previous fixes
Message-ID: <20200512104835.7a39586b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes to previous fixes:

Unfortunately, the last set of fixes introduced some minor bugs:

 - The bootconfig apply_xbc() leak fix caused the application to return
   a positive number on success, when it should have returned zero.

 - The preempt_irq_delay_thread fix to make the creation code
   wait for the kthread to finish to prevent it from executing after
   module unload, can now cause the kthread to exit before it even
   executes (preventing it to run its tests).

 - The fix to the bootconfig that fixed the initrd to remove the
   bootconfig from causing the kernel to panic, now prints a warning
   that the bootconfig is not found, even when bootconfig is not
   on the command line.


Please pull the latest trace-v5.7-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7-rc4

Tag SHA1: f20be960e5a570d22edb8b4b092fb79bb095710c
Head SHA1: 611d0a95d46b0977a530b4d538948c69d447b001


Masami Hiramatsu (1):
      bootconfig: Fix to prevent warning message if no bootconfig option

Steven Rostedt (VMware) (2):
      tools/bootconfig: Fix apply_xbc() to return zero on success
      tracing: Wait for preempt irq delay thread to execute

----
 init/main.c                          | 10 ++++++----
 kernel/trace/preemptirq_delay_test.c | 12 ++++++++++--
 tools/bootconfig/main.c              |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)
---------------------------
diff --git a/init/main.c b/init/main.c
index 1a5da2c2660c..5803ecb411ab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -400,9 +400,8 @@ static void __init setup_boot_config(const char *cmdline)
 	char *data, *copy;
 	int ret;
 
+	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size, &csum);
-	if (!data)
-		goto not_found;
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -411,6 +410,11 @@ static void __init setup_boot_config(const char *cmdline)
 	if (!bootconfig_found)
 		return;
 
+	if (!data) {
+		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
+		return;
+	}
+
 	if (size >= XBC_DATA_MAX) {
 		pr_err("bootconfig size %d greater than max size %d\n",
 			size, XBC_DATA_MAX);
@@ -446,8 +450,6 @@ static void __init setup_boot_config(const char *cmdline)
 		extra_init_args = xbc_make_cmdline("init");
 	}
 	return;
-not_found:
-	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 }
 
 #else
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index c4c86de63cf9..312d1a0ca3b6 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -16,6 +16,7 @@
 #include <linux/printk.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
+#include <linux/completion.h>
 
 static ulong delay = 100;
 static char test_mode[12] = "irq";
@@ -28,6 +29,8 @@ MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
 MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
 MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
 
+static struct completion done;
+
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
 static void busy_wait(ulong time)
@@ -114,6 +117,8 @@ static int preemptirq_delay_run(void *data)
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
 
+	complete(&done);
+
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
 		schedule();
@@ -128,15 +133,18 @@ static int preemptirq_delay_run(void *data)
 static int preemptirq_run_test(void)
 {
 	struct task_struct *task;
-
 	char task_name[50];
 
+	init_completion(&done);
+
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
 	task =  kthread_run(preemptirq_delay_run, NULL, task_name);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
-	if (task)
+	if (task) {
+		wait_for_completion(&done);
 		kthread_stop(task);
+	}
 	return 0;
 }
 
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 001076c51712..0efaf45f7367 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -337,6 +337,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
 		goto out;
 	}
+	ret = 0;
 out:
 	close(fd);
 	free(data);
