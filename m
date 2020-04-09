Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6147C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D55208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586435894;
	bh=WARbwZGnUZV2UnK9Vejh4wss2lITzfHqNzx1x0ZnRIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LFLoLIbsa3QejAi2bzL41dll0zblZ/uHUyd2d49k3KA9QCF7l2MrWZavU9M4cq+fz
	 edzhoVYibGa2cijBIgkZQn8UaOn9yTiWrQ3gCl8/y/OjGyBiZnCyrzhAnUCyt4q2zF
	 16eVTcLn03SqBG5HJ66+PW8VsVL44NQmpaDPgefw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDIMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIMiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:38:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF682078E;
        Thu,  9 Apr 2020 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586435892;
        bh=WARbwZGnUZV2UnK9Vejh4wss2lITzfHqNzx1x0ZnRIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRBW2/AFGuzYC27wZRpNJxuLpZcvmamSLi8xTBrmfGTW/VHHGTuNRYnjX/TDoVsC3
         hdSQDu38KHTMS6fjLPT0j+mcYbHpwQddILv8v1hWocS6Pu3W0ya3HJAc3Jk0KywbBB
         150KxrFUbK1j4cIG0WpZRnKg1SWYhOaS8AMPD3Es=
Date:   Thu, 9 Apr 2020 21:38:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-Id: <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
In-Reply-To: <20200408164641.3299633-1-jolsa@kernel.org>
References: <20200408164641.3299633-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed,  8 Apr 2020 18:46:41 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.

Hmm, kprobe is lockless, but kretprobe involves spinlock.
Thus, eventually, I will blacklist the _raw_spin_lock_irqsave()
for kretprobe.
If you need to trace spinlock return, please consider to putting
kprobe at "ret" instruction.

> My test was also able to trigger lockdep output:
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  5.6.0-rc6+ #6 Not tainted
>  --------------------------------------------
>  sched-messaging/2767 is trying to acquire lock:
>  ffffffff9a492798 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_hash_lock+0x52/0xa0
> 
>  but task is already holding lock:
>  ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&(kretprobe_table_locks[i].lock));
>    lock(&(kretprobe_table_locks[i].lock));
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  1 lock held by sched-messaging/2767:
>   #0: ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> 
>  stack backtrace:
>  CPU: 3 PID: 2767 Comm: sched-messaging Not tainted 5.6.0-rc6+ #6
>  Call Trace:
>   dump_stack+0x96/0xe0
>   __lock_acquire.cold.57+0x173/0x2b7
>   ? native_queued_spin_lock_slowpath+0x42b/0x9e0
>   ? lockdep_hardirqs_on+0x590/0x590
>   ? __lock_acquire+0xf63/0x4030
>   lock_acquire+0x15a/0x3d0
>   ? kretprobe_hash_lock+0x52/0xa0
>   _raw_spin_lock_irqsave+0x36/0x70
>   ? kretprobe_hash_lock+0x52/0xa0
>   kretprobe_hash_lock+0x52/0xa0
>   trampoline_handler+0xf8/0x940
>   ? kprobe_fault_handler+0x380/0x380
>   ? find_held_lock+0x3a/0x1c0
>   kretprobe_trampoline+0x25/0x50
>   ? lock_acquired+0x392/0xbc0
>   ? _raw_spin_lock_irqsave+0x50/0x70
>   ? __get_valid_kprobe+0x1f0/0x1f0
>   ? _raw_spin_unlock_irqrestore+0x3b/0x40
>   ? finish_task_switch+0x4b9/0x6d0
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
> 
> The code within the kretprobe handler checks for probe reentrancy,
> so we won't trigger any _raw_spin_lock_irqsave probe in there.
> 
> The problem is in outside kprobe_flush_task, where we call:
> 
>   kprobe_flush_task
>     kretprobe_table_lock
>       raw_spin_lock_irqsave
>         _raw_spin_lock_irqsave
> 
> where _raw_spin_lock_irqsave triggers the kretprobe and installs
> kretprobe_trampoline handler on _raw_spin_lock_irqsave return.

Hmm, OK. In this case, I think we should mark this process is
going to die and never try to kretprobe on it.

> 
> The kretprobe_trampoline handler is then executed with already
> locked kretprobe_table_locks, and first thing it does is to
> lock kretprobe_table_locks ;-) the whole lockup path like:
> 
>   kprobe_flush_task
>     kretprobe_table_lock
>       raw_spin_lock_irqsave
>         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> 
>         ---> kretprobe_table_locks locked
> 
>         kretprobe_trampoline
>           trampoline_handler
>             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> 
> The change below sets current_kprobe in kprobe_flush_task, so the probe
> recursion protection check is hit and the probe is never set. It seems
> to fix the deadlock.
> 
> I'm not sure this is the best fix, any ideas are welcome ;-)

Hmm, this is a bit tricky to fix this issue. Of course, temporary disable
kprobes (and kretprobe) on an area by filling current_kprobe might
be a good idea, but it also involves other kprobes.

How about let kretprobe skip the task which state == TASK_DEAD ?

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 627fc1b7011a..3f207d2e0afb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1874,9 +1874,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	 * To avoid deadlocks, prohibit return probing in NMI contexts,
 	 * just skip the probe and increase the (inexact) 'nmissed'
 	 * statistical counter, so that the user is informed that
-	 * something happened:
+	 * something happened.
+	 * Also, if the current task is dead, we will already in the process
+	 * to reclaim kretprobe instances from hash list. To avoid memory
+	 * leak, skip to run the kretprobe on such task.
 	 */
-	if (unlikely(in_nmi())) {
+	if (unlikely(in_nmi()) || current->state == TASK_DEAD) {
 		rp->nmissed++;
 		return 0;
 	}

-- 
Masami Hiramatsu <mhiramat@kernel.org>
