Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C61DC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3847A20857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587661832;
	bh=5BqhgWBrzM6R5NlmLRb1Jr1mqRd7QBtnHc2PAxEr9sc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hJQX53rkfUQTywhuuYdQxcHl+Q4bpkYrYejTmwsao/ZfweYUBAcKSyfe36dXlGtqk
	 BmFhZd56j6adNqOK10e2fTwLEGXqRCIof2+2SxlndoPIoVpUxMkGrvBykAPe3NaMsK
	 uc4aeJbRw9BzCAt9RexrNXE7ZQ7hnlvCKS5fXHZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgDWRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgDWRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:10:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296D420781;
        Thu, 23 Apr 2020 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587661830;
        bh=5BqhgWBrzM6R5NlmLRb1Jr1mqRd7QBtnHc2PAxEr9sc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZO8FHLVcSynUjyCR6CImw2zvvp04qjEqdrGjy2WTAuGkOVjnt7ktA8FKzmoh9cK9V
         eNdWe6PxYzazQZZFm+R8SnUNRqI8BrBnII/NgWF5HTrCN1f3SWnJm1dSbR3U8zh/MO
         JBJ6xHh9Km7tXgSaxzVqhq3342LVoWbbAEBlrluY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D6B313522721; Thu, 23 Apr 2020 10:10:29 -0700 (PDT)
Date:   Thu, 23 Apr 2020 10:10:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, bigeasy@linutronix.de
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
Message-ID: <20200423171029.GS17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:40:47AM -0700, John Stultz wrote:
> Hey Folks,
> 
> Recently, I've seen some occasional hangs earlyish in boot on my
> HiKey960 board with 5.7-rc1/rc2. The kernel isn't totally wedged as I
> will see some kernel messages (firmware loading failures, etc) much
> later if I leave it.  But oddly sysrq doesn't respond.
> 
> Figuring it must be some sort of deadlock, I added LOCKDEP and a bunch
> of other debug options and started booting in a loop. So far I've not
> been able to trigger the original problem, but I do see the following
> every boot:
> 
> Curious if this was already on anyone's radar?

Looks like __queue_work() is attempting to acquire a normal spinlock_t
with interrupts disabled, which -rt doesn't like much.  And I believe
that lockdep has been upgraded to check for this.

Adding Sebastian for his thoughts.

							Thanx, Paul

> thanks
> -john
> 
> [    2.111212] =============================
> [    2.115256] [ BUG: Invalid wait context ]
> [    2.119303] 5.7.0-rc2-00070-g4160a2ecd371 #247 Not tainted
> [    2.124842] -----------------------------
> [    2.128886] swapper/5/0 is trying to lock:
> [    2.133019] ffffff8219c33258 (&pool->lock){..-.}-{3:3}, at:
> __queue_work+0x108/0x7c8
> [    2.140856] other info that might help us debug this:
> [    2.145954] context-{2:2}
> [    2.148593] 1 lock held by swapper/5/0:
> [    2.152461]  #0: ffffffc011d749c8 (rcu_read_lock){....}-{1:3}, at:
> __queue_work+0x48/0x7c8
> [    2.160814] stack backtrace:
> [    2.163719] CPU: 5 PID: 0 Comm: swapper/5 Not tainted
> 5.7.0-rc2-00070-g4160a2ecd371 #247
> [    2.171891] Hardware name: HiKey960 (DT)
> [    2.175847] Call trace:
> [    2.178315]  dump_backtrace+0x0/0x1a8
> [    2.182009]  show_stack+0x18/0x28
> [    2.185354]  dump_stack+0xdc/0x148
> [    2.188786]  __lock_acquire+0x5c0/0x1568
> [    2.192744]  lock_acquire+0x100/0x378
> [    2.196441]  _raw_spin_lock+0x64/0x108
> [    2.200225]  __queue_work+0x108/0x7c8
> [    2.203918]  queue_work_on+0xd0/0xf0
> [    2.207526]  timers_update_nohz+0x28/0x38
> [    2.211572]  tick_setup_sched_timer+0x110/0x178
> [    2.216144]  hrtimer_run_queues+0x114/0x170
> [    2.220365]  run_local_timers+0x30/0x70
> [    2.224234]  update_process_times+0x28/0x58
> [    2.228457]  tick_periodic+0x48/0x148
> [    2.232151]  tick_handle_periodic+0x28/0xc8
> [    2.236375]  arch_timer_handler_phys+0x2c/0x50
> [    2.238026] VFS: Disk quotas dquot_6.6.0
> [    2.240862]  handle_percpu_devid_irq+0xe0/0x460
> [    2.240866]  generic_handle_irq+0x30/0x48
> [    2.240868]  __handle_domain_irq+0x88/0xf8
> [    2.240873]  gic_handle_irq+0x5c/0xb0
> [    2.240877]  el1_irq+0xf4/0x1c0
> [    2.240882]  arch_cpu_idle+0x2c/0x230
> [    2.244918] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    2.249406]  default_idle_call+0x20/0x44
> [    2.249409]  do_idle+0x1ec/0x2d0
> [    2.249411]  cpu_startup_entry+0x24/0x48
> [    2.249416]  secondary_start_kernel+0x160/0x210
