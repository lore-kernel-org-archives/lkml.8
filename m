Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D93C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E222072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgC3TkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:40:19 -0400
Received: from foss.arm.com ([217.140.110.172]:34028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgC3TkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:40:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DCB81FB;
        Mon, 30 Mar 2020 12:40:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE1F53F68F;
        Mon, 30 Mar 2020 12:40:16 -0700 (PDT)
Date:   Mon, 30 Mar 2020 20:40:14 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Boqun Feng <boqun.feng@gmail.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz,
        konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
        mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/hotplug] cpu/hotplug: Abort disabling secondary CPUs if
 wakeup is pending
Message-ID: <20200330194014.lwpmbv2zekfk6ywx@e107158-lin.cambridge.arm.com>
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
 <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org>
 <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <874kuaxdiz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kuaxdiz.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/20 12:06, Thomas Gleixner wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> > From the commit message, it makes sense to add the pm_wakeup_pending()
> > check if freeze_secondary_cpus() is used for system suspend. However,
> > freeze_secondary_cpus() is also used in kexec path on arm64:
> 
> Bah!
> 
> > 	kernel_kexec():
> > 	  machine_shutdown():
> > 	    disable_nonboot_cpus():
> > 	      freeze_secondary_cpus()
> >
> > , so I wonder whether the pm_wakeup_pending() makes sense in this
> > situation? Because IIUC, in this case we want to reboot the system
> > regardlessly, the pm_wakeup_pending() checking seems to be inappropriate
> > then.
> 
> Fix below.
> 
> Thanks,
> 
>         tglx
> 
> 8<------------
> 
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -133,12 +133,18 @@ static inline void get_online_cpus(void)
>  static inline void put_online_cpus(void) { cpus_read_unlock(); }
>  
>  #ifdef CONFIG_PM_SLEEP_SMP
> -extern int freeze_secondary_cpus(int primary);
> +int __freeze_secondary_cpus(int primary, bool suspend);
> +static inline int freeze_secondary_cpus(int primary)
> +{
> +	return __freeze_secondary_cpus(primary, true);
> +}
> +
>  static inline int disable_nonboot_cpus(void)
>  {
> -	return freeze_secondary_cpus(0);
> +	return __freeze_secondary_cpus(0, false);
>  }

If I read the code correctly, arch/x86/power/cpu.c is calling
disable_nonboot_cpus() from suspend resume, which is the only user in
tip/smp/core after my series.

This means you won't abort a suspend/hibernate if a late wakeup source happens?
Or it might just mean that we'll wakeup slightly later than we would have done.

Anyways. I think it would be better to kill off disable_nonboot_cpus() and
directly call freeze_nonboot_cpus() in x86/power/cpu.c.

I'd be happy to send a patch for this.

Assuming that x86 is okay with the late(r) abort, this patch could stay as-is
for stable trees. Otherwise, maybe we need to revert this and look for another
option for stable trees?

Thanks

--
Qais Yousef

> -extern void enable_nonboot_cpus(void);
> +
> +void enable_nonboot_cpus(void);
>  
>  static inline int suspend_disable_secondary_cpus(void)
>  {
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1200,7 +1200,7 @@ EXPORT_SYMBOL_GPL(cpu_up);
>  #ifdef CONFIG_PM_SLEEP_SMP
>  static cpumask_var_t frozen_cpus;
>  
> -int freeze_secondary_cpus(int primary)
> +int __freeze_secondary_cpus(int primary, bool suspend)
>  {
>  	int cpu, error = 0;
>  
> @@ -1225,7 +1225,7 @@ int freeze_secondary_cpus(int primary)
>  		if (cpu == primary)
>  			continue;
>  
> -		if (pm_wakeup_pending()) {
> +		if (suspend && pm_wakeup_pending()) {
>  			pr_info("Wakeup pending. Abort CPU freeze\n");
>  			error = -EBUSY;
>  			break;
