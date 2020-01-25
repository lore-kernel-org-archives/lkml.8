Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C2C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F32075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579968657;
	bh=RszO1XWvG6X3QjRvvnCJKOjTIMC7AHJ2DZewS3QmahA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hQJCMHHOgMwASXt5KtP4AtV6KWi6VJUdLtgNEFu5YyqeSZ0gW2NbyX0pRQA21t9ji
	 GF+srCpWP9kccNT1qwnjDrHc6FmHf9TcjDwLuOzZLAYDQCZIzQjEqpW4TsaDPtfdds
	 F287g3VxNz9LrMLDhz9jHn6idC1F4BMixE6sc3dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAYQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgAYQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:10:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF4D82071A;
        Sat, 25 Jan 2020 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579968651;
        bh=RszO1XWvG6X3QjRvvnCJKOjTIMC7AHJ2DZewS3QmahA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=v1V1XKJ+/a7JhVA+e22ZP5jUmtW0+O6C1b3Y1yXSmlH9sVpcm60jP/7ShaEzNHXIF
         Ot6m6qSRIyH3ueBXAMOBWbae57+dAiOxSfSRSwJv1TsIgRY/l5vUIWtSiIGvrUXTa9
         3Jxn446bZZVJv5uLLCH1PYS8Mmg1qOh6OwIkjTM8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C58CF352274E; Sat, 25 Jan 2020 08:10:50 -0800 (PST)
Date:   Sat, 25 Jan 2020 08:10:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125161050.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125131425.GB16136@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 02:14:26PM +0100, Borislav Petkov wrote:
> Hi Paul,
> 
> On Sat, Jan 25, 2020 at 10:42:56AM -0000, tip-bot2 for Paul E. McKenney wrote:
> > The following commit has been merged into the core/rcu branch of tip:
> > 
> > Commit-ID:     df1e849ae4559544ff00ff5052eefe2479750539
> > Gitweb:        https://git.kernel.org/tip/df1e849ae4559544ff00ff5052eefe2479750539
> > Author:        Paul E. McKenney <paulmck@kernel.org>
> > AuthorDate:    Wed, 27 Nov 2019 16:36:45 -08:00
> > Committer:     Paul E. McKenney <paulmck@kernel.org>
> > CommitterDate: Mon, 09 Dec 2019 12:32:59 -08:00
> > 
> > rcu: Enable tick for nohz_full CPUs slow to provide expedited QS
> > 
> > An expedited grace period can be stalled by a nohz_full CPU looping
> > in kernel context.  This possibility is currently handled by some
> > carefully crafted checks in rcu_read_unlock_special() that enlist help
> > from ksoftirqd when permitted by the scheduler.  However, it is exactly
> > these checks that require the scheduler avoid holding any of its rq or
> > pi locks across rcu_read_unlock() without also having held them across
> > the entire RCU read-side critical section.
> > 
> > It would therefore be very nice if expedited grace periods could
> > handle nohz_full CPUs looping in kernel context without such checks.
> > This commit therefore adds code to the expedited grace period's wait
> > and cleanup code that forces the scheduler-clock interrupt on for CPUs
> > that fail to quickly supply a quiescent state.  "Quickly" is currently
> > a hard-coded single-jiffy delay.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/tick.h  |  5 +++-
> >  kernel/rcu/tree.h     |  1 +-
> >  kernel/rcu/tree_exp.h | 52 ++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 50 insertions(+), 8 deletions(-)
> 
> ...
> 
> > @@ -460,22 +489,31 @@ static void synchronize_rcu_expedited_wait(void)
> >  	unsigned long jiffies_start;
> >  	unsigned long mask;
> >  	int ndetected;
> > +	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  	struct rcu_node *rnp_root = rcu_get_root();
> > -	int ret;
> >  
> >  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
> >  	jiffies_stall = rcu_jiffies_till_stall_check();
> >  	jiffies_start = jiffies;
> > +	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> > +		if (synchronize_rcu_expedited_wait_once(1))
> > +			return;
> > +		rcu_for_each_leaf_node(rnp) {
> > +			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
> > +				rdp = per_cpu_ptr(&rcu_data, cpu);
> > +				if (rdp->rcu_forced_tick_exp)
> > +					continue;
> > +				rdp->rcu_forced_tick_exp = true;
> > +				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> > +			}
> > +		}
> > +		WARN_ON_ONCE(1);
> 
> I'm hitting this on a big AMD box, CONFIG_NO_HZ_FULL=y.

How big?  (Seriously, given that the fix may depend on the number of CPUs.)

So the problem appears to be that some of the boot-time processing
is looping in the kernel, which is preventing the grace period from
completing.  One could argue that such code should be fixed, but on the
other hand, boot time is a bit special.  Later in -rcu's dev branch,
there are commits that forgive this boot-time misbehavior, but this is
a bit late in process to dump all of those commits into -tip.

The RT guys might need the warning, and it was them that I was thinking
of when adding it.  But let's see what works for mainline first.  And
since your box was booting fine without the warning before, I bet that
it boots just fine with that warning removed.

So could you please try out the (untested) patch below?

If that works, I will re-introduce the warning with proper protection
for the merge window following this coming one.

							Thanx, Paul

> Kernel is Linus master + tip/master from today.
> ...
> [   23.094781] BTRFS info (device sdb2): disk space caching is enabled
> [   23.094784] BTRFS info (device sdb2): has skinny extents
> [   23.139134] BTRFS info (device sdb2): enabling ssd optimizations
> [   23.395434] ------------[ cut here ]------------
> [   23.402616] WARNING: CPU: 6 PID: 1921 at kernel/rcu/tree_exp.h:511 rcu_exp_wait_wake+0x11f/0x740
> [   23.402616] Modules linked in: btrfs(E) libcrc32c(E) xor(E) hid_generic(E) usbhid(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ast(E) i2c_algo_bit(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) ahci(E) drm_kms_helper(E) syscopyarea(E) libahci(E) sysfillrect(E) xhci_pci(E) sysimgblt(E) fb_sys_fops(E) xhci_hcd(E) libata(E) drm(E) usbcore(E) wmi(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E)
> [   23.402630] CPU: 6 PID: 1921 Comm: kworker/6:2 Tainted: G            E     5.5.0-rc7+ #1
> [   23.402632] Workqueue: rcu_gp wait_rcu_exp_gp
> [   23.402634] RIP: 0010:rcu_exp_wait_wake+0x11f/0x740
> [   23.402636] Code: 3b 45 6c 7e be 48 63 05 8b 30 50 01 49 81 c5 40 02 00 00 48 8d 04 c0 48 c1 e0 06 48 05 80 b2 67 b5 49 39 c5 0f 82 72 ff ff ff <0f> 0b 49 c7 c7 00 fd 02 00 bb 01 00 00 00 4c 89 e7 e8 ab e7 ff ff
> [   23.402637] RSP: 0018:ffffbde38a8f3e50 EFLAGS: 00010246
> [   23.402637] RAX: ffffffffb567d8c0 RBX: ffffffffb567d6c0 RCX: 0000000000000040
> [   23.402638] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb567d6c0
> [   23.402638] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000001
> [   23.402639] R10: ffffbde3802cfdc0 R11: 0000000000000271 R12: 0000000000003a98
> [   23.402640] R13: ffffffffb567d8c0 R14: 00000000000000f0 R15: 000000000002fd00
> [   23.402640] FS:  0000000000000000(0000) GS:ffffa016cd380000(0000) knlGS:0000000000000000
> [   23.402641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.402641] CR2: 00007fc9957c5180 CR3: 0000800bb3e0a000 CR4: 0000000000340ee0
> [   23.402642] Call Trace:
> [   23.402647]  ? sync_rcu_exp_select_cpus+0x219/0x3e0
> [   23.402650]  process_one_work+0x20b/0x400
> [   23.402652]  worker_thread+0x2d/0x3f0
> [   23.402653]  ? process_one_work+0x400/0x400
> [   23.402655]  kthread+0x10d/0x130
> [   23.402656]  ? kthread_park+0x90/0x90
> [   23.402660]  ret_from_fork+0x27/0x50
> [   23.402663] ---[ end trace 85fb288edc35e984 ]---
> [   24.322452] BTRFS info (device sdb2): disk space caching is enabled
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6935a9e..dcbd757 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -508,7 +508,6 @@ static void synchronize_rcu_expedited_wait(void)
 				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
 			}
 		}
-		WARN_ON_ONCE(1);
 	}
 
 	for (;;) {
