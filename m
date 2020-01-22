Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315A824655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAVKc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:32:57 -0500
Received: from foss.arm.com ([217.140.110.172]:54612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgAVKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:32:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3942A1FB;
        Wed, 22 Jan 2020 02:32:56 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72CD3F68E;
        Wed, 22 Jan 2020 02:32:53 -0800 (PST)
Date:   Wed, 22 Jan 2020 10:32:51 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Nadav Amit <namit@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] smp: Create a new function to shutdown nonboot
 cpus
Message-ID: <20200122103250.jdssttb7veevfttz@e107158-lin.cambridge.arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-2-qais.yousef@arm.com>
 <20200121170350.GC18808@shell.armlinux.org.uk>
 <20200121174751.5opyyjwxfnwdgcev@e107158-lin.cambridge.arm.com>
 <20200121180930.GJ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121180930.GJ25745@shell.armlinux.org.uk>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/20 18:09, Russell King - ARM Linux admin wrote:
> On Tue, Jan 21, 2020 at 05:47:52PM +0000, Qais Yousef wrote:
> > On 01/21/20 17:03, Russell King - ARM Linux admin wrote:
> > > On Mon, Nov 25, 2019 at 11:27:41AM +0000, Qais Yousef wrote:
> > > > +void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> > > > +{
> > > > +	unsigned int cpu;
> > > > +
> > > > +	if (!cpu_online(primary_cpu)) {
> > > > +		pr_info("Attempting to shutdodwn nonboot cpus while boot cpu is offline!\n");
> > > > +		cpu_online(primary_cpu);
> > 
> > Eh, that should be cpu_up(primary_cpu)!
> > 
> > Which I have to say I'm not if is the right thing to do.
> > migrate_to_reboot_cpu() picks the first online cpu if reboot_cpu (assumed 0) is
> > offline
> > 
> > migrate_to_reboot_cpu():
> >  225         /* Make certain the cpu I'm about to reboot on is online */
> >  226         if (!cpu_online(cpu))
> >  227                 cpu = cpumask_first(cpu_online_mask);
> > 
> > > > +	}
> > > > +
> > > > +	for_each_present_cpu(cpu) {
> > > > +		if (cpu == primary_cpu)
> > > > +			continue;
> > > > +		if (cpu_online(cpu))
> > > > +			cpu_down(cpu);
> > > > +	}
> > > 
> > > How does this avoid racing with userspace attempting to restart CPUs
> > > that have already been taken down by this function?
> > 
> > This is meant to be called from machine_shutdown() only.
> > 
> > But you've got a point.
> > 
> > The previous logic that used disable_nonboot_cpus(), which in turn called
> > freeze_secondary_cpus() didn't hold hotplug lock. So I assumed the higher level
> > logic of machine_shutdown() ensures that hotplug lock is held to synchronize
> > with potential other hotplug operations.
> 
> freeze_secondary_cpus() takes the CPU maps lock while it takes CPUs
> down, and then disables cpu hotplug by incrementing
> cpu_hotplug_disabled.  Incrementing that prevents cpu_up() and
> cpu_down() being used, thereby preventing userspace from changing the
> online state of any CPU in the system.

I see. Sorry I missed the CPU maps lock.

Yes this makes sense and should work here too.

Thanks for the help.

Thomas, I'll wait for your comment on this and potentially other patches before
sending v3.

Thanks

--
Qais Yousef
