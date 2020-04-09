Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E142083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586443268;
	bh=ubVb0I2ai8nKLC8GF70Hzzlt+BYOLspkiVSoi7kI8V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CJ3dvWrZ2KJCjN2YhfypZSOecRdiXASKu55CFpbWqda4JzzH/lKk4nJ0b+7u5q3xD
	 PXkl+NJkThiVjCMzwp7F4eO7gYExw81ahWe3SaT6aAU4BNGewIT0HWQlOyze/es1Jt
	 rGQYAOjxHxgk1gkN6uaFQlE/uwow20RH9DUm0nhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDIOlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbgDIOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:41:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429C42078E;
        Thu,  9 Apr 2020 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586443266;
        bh=ubVb0I2ai8nKLC8GF70Hzzlt+BYOLspkiVSoi7kI8V0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I6kL4V8jneQArdv0/VR5+Ajsnrqdl4EeY07NFGAr9eIvOnksVtB7e4t4p1znNEEgf
         pkKJm8Xmn04IxwMUK5zcvFi61+79ueFvIgMCnV3cBx5KljLtN1cwTESlAzRPN6dwbQ
         bF5+ivv/pC1cBKmPfMj13/q6+9T8thU4gHtISoc0=
Date:   Thu, 9 Apr 2020 23:41:01 +0900
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
Message-Id: <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
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

On Wed,  8 Apr 2020 18:46:41 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
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

OK, I just have 1 comment. :)

> 
> thanks,
> jirka
> 
> 
> ---
>  kernel/kprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00..b13247cae752 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_unlock);
>  
> +static struct kprobe kretprobe_dummy = {
> +        .addr = (void *)kretprobe_trampoline,
> +};
> +
>  /*
>   * This function is called from finish_task_switch when task tk becomes dead,
>   * so that we can recycle any function-return probe instances associated
> @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
>  	INIT_HLIST_HEAD(&empty_rp);
>  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>  	head = &kretprobe_inst_table[hash];
> +	__this_cpu_write(current_kprobe, &kretprobe_dummy);

Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?

BTW, we may be better to introduce a common kprobe_reject_section_start()
and kprobe_reject_section_end() so that the user don't need to prepare
dummy kprobes.

Thank you,

>  	kretprobe_table_lock(hash, &flags);
>  	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
>  		if (ri->task == tk)
>  			recycle_rp_inst(ri, &empty_rp);
>  	}
>  	kretprobe_table_unlock(hash, &flags);
> +	__this_cpu_write(current_kprobe, NULL);
>  	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
>  		hlist_del(&ri->hlist);
>  		kfree(ri);
> -- 
> 2.25.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
