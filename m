Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D4C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69ECD20644
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD0Lyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:54:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42240 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Lyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:54:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2LN-00056H-AR; Mon, 27 Apr 2020 05:54:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2LM-0007g2-Ct; Mon, 27 Apr 2020 05:54:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
        <20200426172207.GA30118@redhat.com>
Date:   Mon, 27 Apr 2020 06:51:23 -0500
In-Reply-To: <20200426172207.GA30118@redhat.com> (Oleg Nesterov's message of
        "Sun, 26 Apr 2020 19:22:07 +0200")
Message-ID: <878sihjgec.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT2LM-0007g2-Ct;;;mid=<878sihjgec.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Hy5/LYsdoQjtguvFKGpsNQj0NXSTcRnw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify the logic in lookup_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Eric,
>
> I am sick today and can't read the code, but I feel this patch is not
> right ... please correct me.


> So, iiuc when posix_cpu_timer_create() is called and CPUCLOCK_PERTHREAD
> is false we roughly have
>
> 	task = pid_task(pid, PIDTYPE_TGID);			// lookup_task()
>
> 	/* WINDOW */
>
> 	timer->it.cpu.pid = = get_task_pid(task, PIDTYPE_TGID)	// posix_cpu_timer_create()
>
> Now suppose that we race with mt-exec and this "task" is the old leader;
> it can be release_task()'ed in the WINDOW above and then get_task_pid()
> will return NULL.

Except it is asking for PIDTYPE_TGID.

task->signal even if it is freed (which it won't be in a mt-exec)
is valid until after an rcu window.

release_task()
   put_task_struct_rcu_user()
      call_rcu(..., delayed_put_task_struct())
... rcu delay ...
delayed_put_task_struct()
   put_task_struct()
      __put_task_struct()
         put_signal_struct()
            free_signal_struct()

Which means that task->signal->pids[PIDTYPE_TGID] will remain valid even
across mt-exec.

Further the only change I have introduced is to perform this work under
rcu_read_lock vs taking a reference to task_struct.  As the reference to
task_struct does not prevent release_task, the situation with respect
to races in the rest of the code does not change.

Hmm....

If the case instead is:
> 	timer->it.cpu.pid = get_task_pid(task, PIDTYPE_PID)	// posix_cpu_timer_create()

Which can also happen for threads in the same thread group.
I have to agree that we can wind up with a NULL pid.

And that is a brand new bug, because we didn't use to use pids.
Sigh.


> That is why I suggested to change lookup_task() to return "struct pid*"
> to eliminate the pid -> task -> pid transition.

Yes.  I have to agree.  Getting rid of the pid -> task -> pid transition
looks important to close bugs like that.

> Apart from the same_thread_group() check for the "thread" case we do not
> need task_struct at all, lookup_task() can do
>
> 	if (thread) {
> 		p = pid_task(pid, PIDTYPE_PID);
> 		if (p && !same_thread_group(p, current))
> 			pid = NULL;
> 	} else {
> 		... gettime check ...
>
> 		if (!pid_has_task(pid, PIDTYPE_TGID))
> 			pid = NULL;
> 	}
>
> 	return pid;
>
> No?

There is also the posix_cpu_clock_get, where we immediately use the
clock instead of create something we can use later.

I want to say the gettime case is another reason to go through the whole
transition but the code can just as easily say "pid = task_tgid(current)"
as it can "p = current";

Eric

