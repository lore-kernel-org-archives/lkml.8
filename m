Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84FFC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C0B2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgEJPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgEJPmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:42:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D39420736;
        Sun, 10 May 2020 15:42:12 +0000 (UTC)
Date:   Sun, 10 May 2020 11:42:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] tracing: Wait for preempt irq delay thread to execute
Message-ID: <20200510114210.15d9e4af@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

\From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A bug report was posted that running the preempt irq delay module on a slow
machine, and removing it quickly could lead to the thread created by the
modlue to execute after the module is removed, and this could cause the
kernel to crash. The fix for this was to call kthread_stop() after creating
the thread to make sure it finishes before allowing the module to be
removed.

Now this caused the opposite problem on fast machines. What now happens is
the kthread_stop() can cause the kthread never to execute and the test never
to run. To fix this, add a completion and wait for the kthread to execute,
then wait for it to end.

This issue caused the ftracetest selftests to fail on the preemptirq tests.

Cc: stable@vger.kernel.org
Fixes: d16a8c31077e ("tracing: Wait for preempt irq delay thread to finish")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/preemptirq_delay_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

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
 
-- 
2.20.1

