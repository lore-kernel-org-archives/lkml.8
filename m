Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF62C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0862078E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgEFOaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgEFOaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:30:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B77820769;
        Wed,  6 May 2020 14:30:19 +0000 (UTC)
Date:   Wed, 6 May 2020 10:30:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] tracing: Wait for preempt irq delay thread to finish
Message-ID: <20200506103017.72abd2cd@gandalf.local.home>
In-Reply-To: <20200506093805.1f86f3f0@gandalf.local.home>
References: <20200424223630.224895-1-joel@joelfernandes.org>
        <5EA80319.7080005@cn.fujitsu.com>
        <20200428104409.0995ceb0@gandalf.local.home>
        <20200428104543.3926eaaf@gandalf.local.home>
        <5EA96AE8.6000707@cn.fujitsu.com>
        <20200429123141.580f89ce@gandalf.local.home>
        <20200429191224.GA75562@google.com>
        <20200506093805.1f86f3f0@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Running on a slower machine, it is possible that the preempt delay kernel
thread may still be executing if the module was immediately removed after
added, and this can cause the kernel to crash as the kernel thread might be
executing after its code has been removed.

There's no reason that the caller of the code shouldn't just wait for the
delay thread to finish, as the thread can also be created by a trigger in
the sysfs code, which also has the same issues.

Link: http://lore.kernel.org/r/5EA2B0C8.2080706@cn.fujitsu.com

Cc: stable@vger.kernel.org
Fixes: 793937236d1ee ("lib: Add module for testing preemptoff/irqsoff latency tracers")
Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/preemptirq_delay_test.c | 30 ++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 31c0fad4cb9e..c4c86de63cf9 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -113,22 +113,42 @@ static int preemptirq_delay_run(void *data)
 
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+
+	__set_current_state(TASK_RUNNING);
+
 	return 0;
 }
 
-static struct task_struct *preemptirq_start_test(void)
+static int preemptirq_run_test(void)
 {
+	struct task_struct *task;
+
 	char task_name[50];
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
-	return kthread_run(preemptirq_delay_run, NULL, task_name);
+	task =  kthread_run(preemptirq_delay_run, NULL, task_name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	if (task)
+		kthread_stop(task);
+	return 0;
 }
 
 
 static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
 			 const char *buf, size_t count)
 {
-	preemptirq_start_test();
+	ssize_t ret;
+
+	ret = preemptirq_run_test();
+	if (ret)
+		return ret;
 	return count;
 }
 
@@ -148,11 +168,9 @@ static struct kobject *preemptirq_delay_kobj;
 
 static int __init preemptirq_delay_init(void)
 {
-	struct task_struct *test_task;
 	int retval;
 
-	test_task = preemptirq_start_test();
-	retval = PTR_ERR_OR_ZERO(test_task);
+	retval = preemptirq_run_test();
 	if (retval != 0)
 		return retval;
 
-- 
2.20.1

