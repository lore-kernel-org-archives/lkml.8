Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F91C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3258206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgD1OoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgD1OoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:44:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B23E206C0;
        Tue, 28 Apr 2020 14:44:11 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:44:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200428104409.0995ceb0@gandalf.local.home>
In-Reply-To: <5EA80319.7080005@cn.fujitsu.com>
References: <20200424223630.224895-1-joel@joelfernandes.org>
        <5EA80319.7080005@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 18:19:05 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Hi Joel,
> 
> Thanks for your quick fix.
> 
> Unfortunately, it fixes my original panic but introduces other
> issues(two wanings and one panic) on my arm64 vm, as below:
>

Does the following on top of Joel's patch fix it?

-- Steve

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 1c28ca20e30b..6d9131ae7e8c 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -113,15 +113,27 @@ static int preemptirq_delay_run(void *data)
 
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
+
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+
+	__set_current_state(TASK_RUNNING);
+
 	return 0;
 }
 
 static struct task_struct *preemptirq_start_test(void)
 {
+	struct task_struct *task;
 	char task_name[50];
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
-	return kthread_run(preemptirq_delay_run, NULL, task_name);
+	task = kthread_run(preemptirq_delay_run, NULL, task_name);
+	if (IS_ERR(task))
+		return NULL;
+	return task;
 }
 
 
 
