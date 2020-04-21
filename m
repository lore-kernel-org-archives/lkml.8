Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC17C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F52721473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgDUIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:30:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgDUIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:30:36 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQoIa-0005tG-OY; Tue, 21 Apr 2020 08:30:32 +0000
Date:   Tue, 21 Apr 2020 10:30:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421083031.5wapruzncjkagvhf@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sggyytnh.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:05:38PM -0500, Eric W. Biederman wrote:
> 
> Christof Meerwald <cmeerw@cmeerw.org> writes:
> > Hi,
> >
> > this is probably related to commit
> > 7a0cf094944e2540758b7f957eb6846d5126f535 (signal: Correct namespace
> > fixups of si_pid and si_uid).
> >
> > With a 5.6.5 kernel I am seeing SIGCHLD signals that don't include a
> > properly set si_pid field - this seems to happen for multi-threaded
> > child processes.
> >
> > A simple test program (based on the sample from the signalfd man page):
> >
> > #include <sys/signalfd.h>
> > #include <signal.h>
> > #include <unistd.h>
> > #include <spawn.h>
> > #include <stdlib.h>
> > #include <stdio.h>
> >
> > #define handle_error(msg) \
> >     do { perror(msg); exit(EXIT_FAILURE); } while (0)
> >
> > int main(int argc, char *argv[])
> > {
> >   sigset_t mask;
> >   int sfd;
> >   struct signalfd_siginfo fdsi;
> >   ssize_t s;
> >
> >   sigemptyset(&mask);
> >   sigaddset(&mask, SIGCHLD);
> >
> >   if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
> >     handle_error("sigprocmask");
> >
> >   pid_t chldpid;
> >   char *chldargv[] = { "./sfdclient", NULL };
> >   posix_spawn(&chldpid, "./sfdclient", NULL, NULL, chldargv, NULL);
> >
> >   sfd = signalfd(-1, &mask, 0);
> >   if (sfd == -1)
> >     handle_error("signalfd");
> >
> >   for (;;) {
> >     s = read(sfd, &fdsi, sizeof(struct signalfd_siginfo));
> >     if (s != sizeof(struct signalfd_siginfo))
> >       handle_error("read");
> >
> >     if (fdsi.ssi_signo == SIGCHLD) {
> >       printf("Got SIGCHLD %d %d %d %d\n",
> >           fdsi.ssi_status, fdsi.ssi_code,
> >           fdsi.ssi_uid, fdsi.ssi_pid);
> >       return 0;
> >     } else {
> >       printf("Read unexpected signal\n");
> >     }
> >   }
> > }
> >
> >
> > and a multi-threaded client to test with:
> >
> > #include <unistd.h>
> > #include <pthread.h>
> >
> > void *f(void *arg)
> > {
> >   sleep(100);
> > }
> >
> > int main()
> > {
> >   pthread_t t[8];
> >
> >   for (int i = 0; i != 8; ++i)
> >   {
> >     pthread_create(&t[i], NULL, f, NULL);
> >   }
> > }
> >
> > I tried to do a bit of debugging and what seems to be happening is
> > that
> >
> >   /* From an ancestor pid namespace? */
> >   if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
> >
> > fails inside task_pid_nr_ns because the check for "pid_alive" fails.
> >
> > This code seems to be called from do_notify_parent and there we
> > actually have "tsk != current" (I am assuming both are threads of the
> > current process?)
> 
> I instrumented the code with a warning and received the following backtrace:
> > WARNING: CPU: 0 PID: 777 at kernel/pid.c:501 __task_pid_nr_ns.cold.6+0xc/0x15
> > Modules linked in:
> > CPU: 0 PID: 777 Comm: sfdclient Not tainted 5.7.0-rc1userns+ #2924
> > Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > RIP: 0010:__task_pid_nr_ns.cold.6+0xc/0x15
> > Code: ff 66 90 48 83 ec 08 89 7c 24 04 48 8d 7e 08 48 8d 74 24 04 e8 9a b6 44 00 48 83 c4 08 c3 48 c7 c7 59 9f ac 82 e8 c2 c4 04 00 <0f> 0b e9 3fd
> > RSP: 0018:ffffc9000042fbf8 EFLAGS: 00010046
> > RAX: 000000000000000c RBX: 0000000000000000 RCX: ffffc9000042faf4
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81193d29
> > RBP: ffffc9000042fc18 R08: 0000000000000000 R09: 0000000000000001
> > R10: 000000100f938416 R11: 0000000000000309 R12: ffff8880b941c140
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880b941c140
> > FS:  0000000000000000(0000) GS:ffff8880bca00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f2e8c0a32e0 CR3: 0000000002e10000 CR4: 00000000000006f0
> > Call Trace:
> >  send_signal+0x1c8/0x310
> >  do_notify_parent+0x50f/0x550
> >  release_task.part.21+0x4fd/0x620
> >  do_exit+0x6f6/0xaf0
> >  do_group_exit+0x42/0xb0
> >  get_signal+0x13b/0xbb0
> >  do_signal+0x2b/0x670
> >  ? __audit_syscall_exit+0x24d/0x2b0
> >  ? rcu_read_lock_sched_held+0x4d/0x60
> >  ? kfree+0x24c/0x2b0
> >  do_syscall_64+0x176/0x640
> >  ? trace_hardirqs_off_thunk+0x1a/0x1c
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> The immediate problem is as Christof noticed that "pid_alive(current) == false".
> This happens because do_notify_parent is called from the last thread to exit
> in a process after that thread has been reaped.
> 
> The bigger issue is that do_notify_parent can be called from any
> process that manages to wait on a thread of a multi-threaded process
> from wait_task_zombie.  So any logic based upon current for
> do_notify_parent is just nonsense, as current can be pretty much
> anything.
> 
> So change do_notify_parent to call __send_signal directly.
> 
> Inspecting the code it appears this problem has existed since the pid
> namespace support started handling this case in 2.6.30.  This fix only
> backports to 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
> where the problem logic was moved out of __send_signal and into send_signal.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6588c1e3ff01 ("signals: SI_USER: Masquerade si_pid when crossing pid ns boundary
> Ref: 921cf9f63089 ("signals: protect cinit from unblocked SIG_DFL signals")
> Link: https://lore.kernel.org/lkml/20200419201336.GI22017@edge.cmeerw.net/
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Unless someone has an objection I will apply this one and send it to
> Linus.
> 
>  kernel/signal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9899c5f91ee1..a88a89422227 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1993,8 +1993,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
>  			sig = 0;
>  	}
> +	/*
> +	 * Bypass send_signal as the si_pid and si_uid values have
> +	 * been generated in the parent's namespaces.
> +	 */

At first I misread that comment as saying that we're skipping sending a
signal not that it relates to a specific function (and I won't admit that
I wrote a whole long paragraph on why I'm confused we're skipping
sending signals on invalid si_pid and si_uid...).

I think it would be worth to say something that simply states the facts
such as:
"If we're not autoreaping, send a signal with si_pid and si_uid set
 as generated in the parent's namespaces."
which imho is way clearer then pointing to out that we're skipping
send_signal(). The logic here and the comment in its current form are
hard to correlate, especially since send_signal() was never called
directly here but is rather called by __group_send_sig_info().
The details of why we switched from __group_send_sign_info() to
__send_signal() could just go into the commit message. It's more
confusing in the code.

>  	if (valid_signal(sig) && sig)

(Not related to you patch but odd ordering of the if-branch here. I
would've expected this to read

if (sig && valid_signal(sig))

especially since "sig" can be set to 0 right before.

> -		__group_send_sig_info(sig, &info, tsk->parent);
> +		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);

So below you switch to __send_signal() but set the "force" argument to
to "false". Before that, if the signal was generated from another pid
namespace and we fixed up si_pid and si_uid the "force" argument was set
to "true", i.e.  __send_signal(..., ..., ..., ..., true) Even though
from reading through the code I think that change is safe to make let me
verify that this was an intentional change?

Thanks!
Christian
