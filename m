Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgC3ScQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:32:16 -0400
Received: from foss.arm.com ([217.140.110.172]:32852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3ScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:32:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7C81FB;
        Mon, 30 Mar 2020 11:32:15 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4C73F68F;
        Mon, 30 Mar 2020 11:32:08 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:32:06 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz,
        konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
        mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/hotplug] cpu/hotplug: Abort disabling secondary CPUs if
 wakeup is pending
Message-ID: <20200330183205.gn6c7ffpdujlrxxe@e107158-lin.cambridge.arm.com>
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
 <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org>
 <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/20 10:53, Boqun Feng wrote:
> Hi Thomas and Pavankumar,
> 
> I have a question about this patch, please see below:
> 
> On Wed, Jun 12, 2019 at 05:34:08AM -0700, tip-bot for Pavankumar Kondeti wrote:
> > Commit-ID:  a66d955e910ab0e598d7a7450cbe6139f52befe7
> > Gitweb:     https://git.kernel.org/tip/a66d955e910ab0e598d7a7450cbe6139f52befe7
> > Author:     Pavankumar Kondeti <pkondeti@codeaurora.org>
> > AuthorDate: Mon, 3 Jun 2019 10:01:03 +0530
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Wed, 12 Jun 2019 11:03:05 +0200
> > 
> > cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending
> > 
> > When "deep" suspend is enabled, all CPUs except the primary CPU are frozen
> > via CPU hotplug one by one. After all secondary CPUs are unplugged the
> > wakeup pending condition is evaluated and if pending the suspend operation
> > is aborted and the secondary CPUs are brought up again.
> > 
> > CPU hotplug is a slow operation, so it makes sense to check for wakeup
> > pending in the freezer loop before bringing down the next CPU. This
> > improves the system suspend abort latency significantly.
> > 
> 
> From the commit message, it makes sense to add the pm_wakeup_pending()
> check if freeze_secondary_cpus() is used for system suspend. However,
> freeze_secondary_cpus() is also used in kexec path on arm64:
> 
> 	kernel_kexec():
> 	  machine_shutdown():
> 	    disable_nonboot_cpus():
> 	      freeze_secondary_cpus()

FWIW, I fixed this already and the change was picked up:

	https://lore.kernel.org/lkml/20200323135110.30522-7-qais.yousef@arm.com/

Only x86 now uses disable_nonboot_cpus().

# tip/smp/core

$ git grep disable_nonboot_cpus
Documentation/power/suspend-and-cpuhotplug.rst:                              disable_nonboot_cpus()
Documentation/power/suspend-and-cpuhotplug.rst:                       /* disable_nonboot_cpus() complete */
arch/x86/power/cpu.c:   ret = disable_nonboot_cpus();
include/linux/cpu.h:static inline int disable_nonboot_cpus(void)
include/linux/cpu.h:static inline int disable_nonboot_cpus(void) { return 0; }
kernel/cpu.c:    * this even in case of failure as all disable_nonboot_cpus() users are

Thanks

--
Qais Yousef

> 
> , so I wonder whether the pm_wakeup_pending() makes sense in this
> situation? Because IIUC, in this case we want to reboot the system
> regardlessly, the pm_wakeup_pending() checking seems to be inappropriate
> then.
> 
> I'm asking this because I'm debugging a kexec failure on ARM64 guest on
> Hyper-V, and I got the BUG_ON() triggered:
> 
> [  108.378016] kexec_core: Starting new kernel
> [  108.378018] Disabling non-boot CPUs ...
> [  108.378019] Wakeup pending. Abort CPU freeze
> [  108.378020] Non-boot CPUs are not disabled
> [  108.378049] ------------[ cut here ]------------
> [  108.378050] kernel BUG at arch/arm64/kernel/machine_kexec.c:154!
> 
> Thanks!
> 
> Regards,
> Boqun
> 
> > [ tglx: Massaged changelog and improved printk message ]
> > 
> > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: iri Kosina <jkosina@suse.cz>
> > Cc: Mukesh Ojha <mojha@codeaurora.org>
> > Cc: linux-pm@vger.kernel.org
> > Link: https://lkml.kernel.org/r/1559536263-16472-1-git-send-email-pkondeti@codeaurora.org
> > 
> > ---
> >  kernel/cpu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index be82cbc11a8a..0778249cd49d 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1221,6 +1221,13 @@ int freeze_secondary_cpus(int primary)
> >  	for_each_online_cpu(cpu) {
> >  		if (cpu == primary)
> >  			continue;
> > +
> > +		if (pm_wakeup_pending()) {
> > +			pr_info("Wakeup pending. Abort CPU freeze\n");
> > +			error = -EBUSY;
> > +			break;
> > +		}
> > +
> >  		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
> >  		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> >  		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
