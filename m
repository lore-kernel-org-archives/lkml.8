Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3013FC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F82520769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363719;
	bh=34m/alNxLbIOqK6f0xzzYeLyfyK6oFVxVodhSqz5tdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foIqu59SqWiIJEduhXqoqQwL6iBPb7cPIlu5To/ZIf2NsHCS6zFNWZ+sfTVK34jKn
	 BYfz8mZa/7i2ts3Mf9LCqMywz4AdQrBEkbQ+fJwOhpc3ce9JDp1/7INvT41jE/wdSq
	 vJ1ao9LFgDAaZKpMgf6YR7HmHRqrkOI9ax9jkN28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgEMJzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387729AbgEMJzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:55:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A302520575;
        Wed, 13 May 2020 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363710;
        bh=34m/alNxLbIOqK6f0xzzYeLyfyK6oFVxVodhSqz5tdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIG5ptX8f+/FDyuFSSXmtdWPBY6gL3I7Qwq7xcHySYi2iFbJ8RAkj9vQJcsbAqCA7
         IaFdfqU6TLlqI+OWEK6y/wi87Xg5Hg7Unreapp4YEqf/6Fw5HpQSCeMp6j6n6LEd9p
         2rPrd0fTFSXHmFG2awCpNsAbtpPRcgwgW2N73qWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.6 067/118] tracing: Wait for preempt irq delay thread to finish
Date:   Wed, 13 May 2020 11:44:46 +0200
Message-Id: <20200513094423.748971097@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit d16a8c31077e75ecb9427fbfea59b74eed00f698 upstream.

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
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/preemptirq_delay_test.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -113,22 +113,42 @@ static int preemptirq_delay_run(void *da
 
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
 
@@ -148,11 +168,9 @@ static struct kobject *preemptirq_delay_
 
 static int __init preemptirq_delay_init(void)
 {
-	struct task_struct *test_task;
 	int retval;
 
-	test_task = preemptirq_start_test();
-	retval = PTR_ERR_OR_ZERO(test_task);
+	retval = preemptirq_run_test();
 	if (retval != 0)
 		return retval;
 


