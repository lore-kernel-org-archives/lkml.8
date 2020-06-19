Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D791C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE8320720
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgFSAHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:07:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57062 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFSAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:07:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jm4Yr-0005eM-GX; Thu, 18 Jun 2020 18:07:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jm4Ym-0006Uh-Qy; Thu, 18 Jun 2020 18:07:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
Date:   Thu, 18 Jun 2020 19:02:51 -0500
In-Reply-To: <20200618233958.GV8681@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 18 Jun 2020 16:39:58 -0700")
Message-ID: <877dw3apn8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jm4Ym-0006Uh-Qy;;;mid=<877dw3apn8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NVkE1QwlpS7bOnHbUSF8lVHt7TQQejhQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: severe proc dentry lock contention
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Jun 18, 2020 at 03:17:33PM -0700, Junxiao Bi wrote:
>> When debugging some performance issue, i found that thousands of threads
>> exit around same time could cause a severe spin lock contention on proc
>> dentry "/proc/$parent_process_pid/task/", that's because threads needs to
>> clean up their pid file from that dir when exit. Check the following
>> standalone test case that simulated the case and perf top result on v5.7
>> kernel. Any idea on how to fix this?

>
> Thanks, Junxiao.
>
> We've looked at a few different ways of fixing this problem.
>
> Even though the contention is within the dcache, it seems like a usecase
> that the dcache shouldn't be optimised for -- generally we do not have
> hundreds of CPUs removing dentries from a single directory in parallel.
>
> We could fix this within procfs.  We don't have a great patch yet, but
> the current approach we're looking at allows only one thread at a time
> to call dput() on any /proc/*/task directory.
>
> We could also look at fixing this within the scheduler.  Only allowing
> one CPU to run the threads of an exiting process would fix this particular
> problem, but might have other consequences.
>
> I was hoping that 7bc3e6e55acf would fix this, but that patch is in 5.7,
> so that hope is ruled out.

Does anyone know if problem new in v5.7?  I am wondering if I introduced
this problem when I refactored the code or if I simply churned the code
but the issue remains effectively the same.

Can you try only flushing entries when the last thread of the process is
reaped?  I think in practice we would want to be a little more
sophisticated but it is a good test case to see if it solves the issue.

diff --git a/kernel/exit.c b/kernel/exit.c
index cebae77a9664..d56e4eb60bdd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -152,7 +152,7 @@ void put_task_struct_rcu_user(struct task_struct *task)
 void release_task(struct task_struct *p)
 {
 	struct task_struct *leader;
-	struct pid *thread_pid;
+	struct pid *thread_pid = NULL;
 	int zap_leader;
 repeat:
 	/* don't need to get the RCU readlock here - the process is dead and
@@ -165,7 +165,8 @@ void release_task(struct task_struct *p)
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
-	thread_pid = get_pid(p->thread_pid);
+	if (p == p->group_leader)
+		thread_pid = get_pid(p->thread_pid);
 	__exit_signal(p);
 
 	/*
@@ -188,8 +189,10 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	proc_flush_pid(thread_pid);
-	put_pid(thread_pid);
+	if (thread_pid) {
+		proc_flush_pid(thread_pid);
+		put_pid(thread_pid);
+	}
 	release_thread(p);
 	put_task_struct_rcu_user(p);
 
