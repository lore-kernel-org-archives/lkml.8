Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A71C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC28E21556
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586442417;
	bh=sdgk72kM14HJd6CM3h63lLASwEe4OHW2+bpVN6JD/4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jL2/277xWwwA0faDmhPca9RyqznOQ5YGQ8s5s+t7iVQycsg7RarLXj1HQ+6LDNDse
	 1I8mmlAZ3ntrZnRnKu6dPnBIE3C8i7oFhxumVSEyYeXjD554ejxSlwygisWwjNWwPo
	 DgRh/ufg1UPHyxPbyDbq+3I9ClM9m+6pMkXmetvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgDIO04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbgDIO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:26:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBA3208FE;
        Thu,  9 Apr 2020 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586442415;
        bh=sdgk72kM14HJd6CM3h63lLASwEe4OHW2+bpVN6JD/4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XU8bfEao5BVoCCU+TbECtnW0ZAmPkU7BDcgS4gMjzJtOXR3CVU014Ft4Dle7HKSnj
         bYctT+aKE1jJDnJ2zsLtmzB2RtmpoaCwVPyxpOpDFRhToMLgX8rgXxvnlLLzXZH9MP
         Nb7kj8DFhykeWU401rIJ/XZQzzshuwKWkxbom8jA=
Date:   Thu, 9 Apr 2020 23:26:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "bibo,mao" <bibo.mao@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-Id: <20200409232650.c02678d2226f0d92fe8472ae@kernel.org>
In-Reply-To: <1586437540.j6vekko069.naveen@linux.ibm.com>
References: <20200408164641.3299633-1-jolsa@kernel.org>
        <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
        <1586437540.j6vekko069.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 09 Apr 2020 18:46:47 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Hi Masami,
> 
> Masami Hiramatsu wrote:
> > Hi Jiri,
> > 
> > On Wed,  8 Apr 2020 18:46:41 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> >> hi,
> >> Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
> > 
> > Hmm, kprobe is lockless, but kretprobe involves spinlock.
> > Thus, eventually, I will blacklist the _raw_spin_lock_irqsave()
> > for kretprobe.
> 
> As far as I can see, this is the only place where probing 
> _raw_spin_lock_irqsave() is an issue.  Should we blacklist all users for 
> this case alone?

Hrm, right. kretprobe is different from kprobe's case.

> 
> > If you need to trace spinlock return, please consider to putting
> > kprobe at "ret" instruction.
> > 
> >> My test was also able to trigger lockdep output:
> >> 
> >>  ============================================
> >>  WARNING: possible recursive locking detected
> >>  5.6.0-rc6+ #6 Not tainted
> >>  --------------------------------------------
> >>  sched-messaging/2767 is trying to acquire lock:
> >>  ffffffff9a492798 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_hash_lock+0x52/0xa0
> >> 
> >>  but task is already holding lock:
> >>  ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> >> 
> >>  other info that might help us debug this:
> >>   Possible unsafe locking scenario:
> >> 
> >>         CPU0
> >>         ----
> >>    lock(&(kretprobe_table_locks[i].lock));
> >>    lock(&(kretprobe_table_locks[i].lock));
> >> 
> >>   *** DEADLOCK ***
> >> 
> >>   May be due to missing lock nesting notation
> >> 
> >>  1 lock held by sched-messaging/2767:
> >>   #0: ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> >> 
> >>  stack backtrace:
> >>  CPU: 3 PID: 2767 Comm: sched-messaging Not tainted 5.6.0-rc6+ #6
> >>  Call Trace:
> >>   dump_stack+0x96/0xe0
> >>   __lock_acquire.cold.57+0x173/0x2b7
> >>   ? native_queued_spin_lock_slowpath+0x42b/0x9e0
> >>   ? lockdep_hardirqs_on+0x590/0x590
> >>   ? __lock_acquire+0xf63/0x4030
> >>   lock_acquire+0x15a/0x3d0
> >>   ? kretprobe_hash_lock+0x52/0xa0
> >>   _raw_spin_lock_irqsave+0x36/0x70
> >>   ? kretprobe_hash_lock+0x52/0xa0
> >>   kretprobe_hash_lock+0x52/0xa0
> >>   trampoline_handler+0xf8/0x940
> >>   ? kprobe_fault_handler+0x380/0x380
> >>   ? find_held_lock+0x3a/0x1c0
> >>   kretprobe_trampoline+0x25/0x50
> >>   ? lock_acquired+0x392/0xbc0
> >>   ? _raw_spin_lock_irqsave+0x50/0x70
> >>   ? __get_valid_kprobe+0x1f0/0x1f0
> >>   ? _raw_spin_unlock_irqrestore+0x3b/0x40
> >>   ? finish_task_switch+0x4b9/0x6d0
> >>   ? __switch_to_asm+0x34/0x70
> >>   ? __switch_to_asm+0x40/0x70
> >> 
> >> The code within the kretprobe handler checks for probe reentrancy,
> >> so we won't trigger any _raw_spin_lock_irqsave probe in there.
> >> 
> >> The problem is in outside kprobe_flush_task, where we call:
> >> 
> >>   kprobe_flush_task
> >>     kretprobe_table_lock
> >>       raw_spin_lock_irqsave
> >>         _raw_spin_lock_irqsave
> >> 
> >> where _raw_spin_lock_irqsave triggers the kretprobe and installs
> >> kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> > 
> > Hmm, OK. In this case, I think we should mark this process is
> > going to die and never try to kretprobe on it.
> > 
> >> 
> >> The kretprobe_trampoline handler is then executed with already
> >> locked kretprobe_table_locks, and first thing it does is to
> >> lock kretprobe_table_locks ;-) the whole lockup path like:
> >> 
> >>   kprobe_flush_task
> >>     kretprobe_table_lock
> >>       raw_spin_lock_irqsave
> >>         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> >> 
> >>         ---> kretprobe_table_locks locked
> >> 
> >>         kretprobe_trampoline
> >>           trampoline_handler
> >>             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> >> 
> >> The change below sets current_kprobe in kprobe_flush_task, so the probe
> >> recursion protection check is hit and the probe is never set. It seems
> >> to fix the deadlock.
> >> 
> >> I'm not sure this is the best fix, any ideas are welcome ;-)
> > 
> > Hmm, this is a bit tricky to fix this issue. Of course, temporary disable
> > kprobes (and kretprobe) on an area by filling current_kprobe might
> > be a good idea, but it also involves other kprobes.
> 
> Not sure how you mean that. Jiri's RFC patch would be disabling 
> k[ret]probes within kprobe_flush_task(), which is only ever invoked from 
> finish_task_switch(). I only see calls to spin locks and kfree() from 
> here. Besides, kprobe_flush_task() itself is NOKPROBE, so we would 
> ideally want to not trace/probe other functions it calls.

Ah, good point. I forgot that has been blacklisted. OK. then I accept
the Jiri's RFC. 

Thank you,


> 
> > 
> > How about let kretprobe skip the task which state == TASK_DEAD ?
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 627fc1b7011a..3f207d2e0afb 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1874,9 +1874,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
> >  	 * To avoid deadlocks, prohibit return probing in NMI contexts,
> >  	 * just skip the probe and increase the (inexact) 'nmissed'
> >  	 * statistical counter, so that the user is informed that
> > -	 * something happened:
> > +	 * something happened.
> > +	 * Also, if the current task is dead, we will already in the process
> > +	 * to reclaim kretprobe instances from hash list. To avoid memory
> > +	 * leak, skip to run the kretprobe on such task.
> >  	 */
> > -	if (unlikely(in_nmi())) {
> > +	if (unlikely(in_nmi()) || current->state == TASK_DEAD) {
> 
> I'm wondering if this actually works. kprobe_flush_task() seems to be 
> called from finish_task_switch(), after the task switch is complete. So, 
> current task won't actually be dead here.



> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
