Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6FE21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zxhkliAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAUREu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:04:50 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54232 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4w5j2rjvzCBD7QP4k4t3Wl1ksmz9OpCbbWqDD9X7AkI=; b=zxhkliAtxRtYVF3GY5sKaRMGD
        qU0uMjAz7S8MJ6YeX85an8ipGfQt/WswXErZHKHH1L0HmTNbYodIRx78KUIuLuRO9E/kuBmGVCVrL
        ohOMmLlCbfSRgCDyKZ6R2m/dkj/W+oqFmS9+e1Ik5qqJs0oI3brlY70Qwv48TioYUmM7MPUd/g+Bo
        qWfGyZ026BWQnmhJv85aEqnNY/jXDin3D1U0yYnDmXxvAUwvmjiripA3NCtSYGnBguPR6QA6U271P
        SyB7LlND2mzj3pixI6qRNa6z7jHFyJB4po2i9pIwbWtO2R4VKsCAKDpTIykWo0DG9vTA1IBJHEv+K
        o1FWYIv8A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37250)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1itwwV-00061k-7C; Tue, 21 Jan 2020 17:03:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1itwwQ-0003zI-Oi; Tue, 21 Jan 2020 17:03:50 +0000
Date:   Tue, 21 Jan 2020 17:03:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20200121170350.GC18808@shell.armlinux.org.uk>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125112754.25223-2-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:27:41AM +0000, Qais Yousef wrote:
> This function will be used later in machine_shutdown() for some archs.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Josh Poimboeuf <jpoimboe@redhat.com>
> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> CC: Jiri Kosina <jkosina@suse.cz>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Eiichi Tsukata <devel@etsukata.com>
> CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> CC: Nadav Amit <namit@vmware.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index bc6c879bd110..8229932fb053 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -118,6 +118,7 @@ extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
>  int cpu_down(unsigned int cpu);
> +extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
>  
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> @@ -129,6 +130,7 @@ static inline int  cpus_read_trylock(void) { return true; }
>  static inline void lockdep_assert_cpus_held(void) { }
>  static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
> +static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
>  #endif	/* !CONFIG_HOTPLUG_CPU */
>  
>  /* Wrappers which go away once all code is converted */
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index e2cad3ee2ead..94055a0d989e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1058,6 +1058,23 @@ int cpu_down(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpu_down);
>  
> +void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> +{
> +	unsigned int cpu;
> +
> +	if (!cpu_online(primary_cpu)) {
> +		pr_info("Attempting to shutdodwn nonboot cpus while boot cpu is offline!\n");
> +		cpu_online(primary_cpu);
> +	}
> +
> +	for_each_present_cpu(cpu) {
> +		if (cpu == primary_cpu)
> +			continue;
> +		if (cpu_online(cpu))
> +			cpu_down(cpu);
> +	}

How does this avoid racing with userspace attempting to restart CPUs
that have already been taken down by this function?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
