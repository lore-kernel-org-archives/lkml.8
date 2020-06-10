Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C382064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFJKZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:25:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C6C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:25:16 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jixv0-0001Vl-Fr; Wed, 10 Jun 2020 12:25:14 +0200
Date:   Wed, 10 Jun 2020 12:25:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
References: <87bln7ves7.fsf@gmx.net>
 <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
 <87v9l65d2y.fsf@gmx.net>
 <20200513220428.4nksinis2qs5dtmh@linutronix.de>
 <87mu6aurfn.fsf@gmx.net>
 <20200522164012.ynyvrjompv42jtmx@linutronix.de>
 <87y2owwo2o.fsf@rub.de>
 <20200609202339.cgy57twm2zdtjhje@linutronix.de>
 <87tuzjcovq.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuzjcovq.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-10 10:21:29 [+0200], Stephen Berman wrote:
> (GMX put your email into my spam folder, so I didn't see it before I
> sent my followup about removing the wifi firmware.)

okay.

> On Tue, 9 Jun 2020 22:23:39 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   scripts/decode_stacktrace.sh vmlinux $(pwd)/ kernel_power_off+0x3d/0x70
> >
> > should reveal that.
> 
> I saved the call trace lines to a file and did this (with `$(pwd)/' the
> script did not run):
> 
> steve [ /sources/linux-5.6.4 ]$ ./scripts/decode_stacktrace.sh vmlinux . kernel_power_off+0x3d/0x70 < /home/steve/temp/call_trace 
> [1352.***] Call Trace:
> [1352.***] ? __schedule (core.c:?) 
> [1352.***] schedule (??:?) 
> [1352.***] schedule_timeout (??:?) 
> [1352.***] ? acpi_os_release_object (??:?) 
> [1352.***] ? acpi_ut_update_object_reference (??:?) 
> [1352.***] wait_for_completion (??:?) 
> [1352.***] ? wake_up_q (??:?) 
> [1352.***] flush_workqueue (??:?) 
> [1352.***] kernel_power_off (??:?) 
> [1352.***] __do_sys_reboot (reboot.c:?) 
> [1352.***] ? do_send_sig_info (??:?) 
> [1352.***] ? kill_pid_info (??:?) 
> [1352.***] ? kill_something_info (signal.c:?) 
> [1352.***] ? __x64_sys_kill (??:?) 
> [1352.***] do_syscall_64 (??:?) 
> [1352.***] entry_SYSCALL_64_after_hwframe (??:?) 
> [1352.***] RIP: 0033:0x7f95dd6992c3
> [1352.***] Code: Bad RIP value.
> objdump: '/tmp/tmp.BlpNDdSQpG.o': No such file
> 
> Did I do something wrong or do I need to pass certain compiler flags
> when building the kernel (when I build Emacs I pass CFLAGS='-Og -g3')?

the arguments last argument should not be kernel_power_off+0x3d/0x70. I
should have been entered after "enter" but you can also pipe the whole
file as you did.
If it gives you the ?? then might need
  CONFIG_DEBUG_INFO

> > The system shutdowns. So you are facing something different. I am
> > surprised that the workqueue stall detector did not yell here. The patch
> > at the bottom should get rid of the sr warnings.
> 
> But the cdrom seems to have nothing to do with power-off failing, since
> it happens even when the cdrom is detached (and hence there were no sr
> warnings in the log output), or am I misunderstanding you?

Yes. I think it has nothing todo with it, it is just something
irrelevant that I do understand now. Before that trace it looked like
AHCI is failing to continue.

> By the other patch do you mean the following?  (This email was also put
> into my spam by GMX and AFAICT has not yet shown up on the vger list.)

Yes. But now that I played a little with it, I made dis:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4e01c448b4b48..e09fc41e99fc3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2777,6 +2777,8 @@ void flush_workqueue(struct workqueue_struct *wq)
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
 
+	if (system_state > SYSTEM_RUNNING)
+		pr_err("Flushing %s\n", wq->name);
 	mutex_lock(&wq->mutex);
 
 	/*
@@ -2826,7 +2828,18 @@ void flush_workqueue(struct workqueue_struct *wq)
 
 	mutex_unlock(&wq->mutex);
 
-	wait_for_completion(&this_flusher.done);
+	if (system_state > SYSTEM_RUNNING) {
+		int ret;
+try_again:
+		ret = wait_for_completion_timeout(&this_flusher.done, 3 * HZ);
+		pr_err("Flushing %s over, %d\n", wq->name, ret);
+		if (!ret) {
+			show_workqueue_state();
+			goto try_again;
+		}
+	} else {
+		wait_for_completion(&this_flusher.done);
+	}
 
 	/*
 	 * Wake-up-and-cascade phase
@@ -3039,11 +3052,18 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 		lock_map_release(&work->lockdep_map);
 	}
 
+	if (system_state > SYSTEM_RUNNING)
+		pr_err("Flush %pS\n", work->func);
+
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
+		if (system_state > SYSTEM_RUNNING)
+			pr_err("Flush %pS done\n", work->func);
 		return true;
 	} else {
+		if (system_state > SYSTEM_RUNNING)
+			pr_err("Flush %pS done\n", work->func);
 		return false;
 	}
 }

So you should have output like:
|[   14.131696] Flushing events_freezable_power_
the flush that hangs

|[   17.203246] Flushing events_freezable_power_ over, 0
It has been noticed (0 at the end)

|[   17.203849] Showing busy workqueues and worker pools:
|[   17.204400] workqueue events_freezable_power_: flags=0x84
|[   17.205009]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
|[   17.205774]     in-flight: 2147:disk_events_workfn
|[   17.206268] workqueue kblockd: flags=0x18
|[   17.206682]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
|[   17.207428]     pending: blk_mq_requeue_work
|[   17.207958] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=2s workers=3 idle: 535 42

A dump of all pending worqueue items.

|[   20.275239] Flushing events_freezable_power_ over, 0
|[   20.275812] Showing busy workqueues and worker pools:
|[   20.276385] workqueue events_freezable_power_: flags=0x84
|[   20.276972]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
|[   20.277712]     in-flight: 2147:disk_events_workfn
|[   20.278245] workqueue kblockd: flags=0x18
|[   20.278685]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
|[   20.279471]     pending: blk_mq_requeue_work
|[   20.279989] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=5s workers=3 idle: 535 42

Another atempt. As you see `blk_mq_requeue_work' is references in both
outputs but it makes progress (it is scheduled multiple times). The item
`disk_events_workfn' stucks.

Sebastian
