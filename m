Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDDCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FAD206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0MQw1Qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGQMk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:40:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgGQMk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594989625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rttk+XtaMzhFwuc22uPWendfKEFz7sRFjPiSryu4BTU=;
        b=A0MQw1QvLzirihvGhclDrQddQf1TsZqHJsMPvTtwu4jXEYPE1wsDF2ZhaqsVshIzqu47jK
        7G2Kq4kBycuhIaPPLo6IaQSytzlc8X0YU8Sc5NuoCGW7MOlpb6K3e+sD3US4Pd4yF+LKBG
        eyJXjI3k0/hwKvNXbv+0J1mupfwprMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-V3DTRKEAOC6GeQp4geiNLw-1; Fri, 17 Jul 2020 08:40:21 -0400
X-MC-Unique: V3DTRKEAOC6GeQp4geiNLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F52D19200C0;
        Fri, 17 Jul 2020 12:40:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3114B19C58;
        Fri, 17 Jul 2020 12:40:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Jul 2020 14:40:20 +0200 (CEST)
Date:   Fri, 17 Jul 2020 14:40:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200717124017.GB6067@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717122651.GA6067@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17, Oleg Nesterov wrote:
>
> On 07/17, Jiri Slaby wrote:
> >
> > On 17. 07. 20, 12:45, Jiri Slaby wrote:
> > > Hi,
> > >
> > > the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
> > > and i586:
> >
> > make check needs -jsomething, running is sequentially (-j1) doesn't
> > trigger it. After the error, I cannot run anything. Like ps to find out
> > what test caused the crash...
>
> Strange... I'll try to reproduce but I can't do this till Monday.
>
> Meanwhile, could you try the patch below? It needs CONFIG_DEBUG_ATOMIC_SLEEP.

please see the updated patch below, lets check ptrace_unfreeze() too.

Oleg.

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..71c76bc7dec6 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -180,6 +180,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
+		task->task_state_change = _THIS_IP_;
 		task->state = __TASK_TRACED;
 		ret = true;
 	}
@@ -203,8 +204,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	if (task->state == __TASK_TRACED) {
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
-		else
+		else {
+			task->task_state_change = _THIS_IP_;
 			task->state = TASK_TRACED;
+		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index ee22ec78fd6d..ba4c4c9ed9b5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1914,7 +1914,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
- 	BUG_ON(task_is_stopped_or_traced(tsk));
+	WARN(task_is_stopped_or_traced(tsk),
+		"exist with state=%ld set at %pS",
+		tsk->state, (void*)tsk->task_state_change);
 
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
@@ -2214,6 +2216,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
+		WARN_ON(current->state);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
@@ -2393,6 +2396,7 @@ static bool do_signal_stop(int signr)
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		cgroup_enter_frozen();
 		freezable_schedule();
+		WARN_ON(current->state);
 		return true;
 	} else {
 		/*

