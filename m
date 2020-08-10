Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FD72065C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHJHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:50:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJHuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE36A1FB;
        Mon, 10 Aug 2020 00:50:01 -0700 (PDT)
Received: from bogus (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14A1E3F7BB;
        Mon, 10 Aug 2020 00:49:58 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:49:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Bibek Basu <bbasu@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200810074956.GB28091@bogus>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <20200724131059.GB6521@bogus>
 <00cf6e67-16ed-872d-2c16-0ceea6b6f514@nvidia.com>
 <20200727160515.GA8003@bogus>
 <e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 05:46:43PM +0530, Sumit Gupta wrote:
>
> > > > > > ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> > > > > >
> > > > > > ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> > > > > > __cpu_logical_map to fix build issue.
> > > > > >
> > > >
> > > > I wonder why like other instances in the drivers, the mpidr is not get
> > > > directly from the cpu. The cpufreq_driver->init call happens when the cpu
> > > > is being brought online and is executed on the required cpu IIUC.
> > > >
> > > Yes, this occurs during hotplug case.
> > > But in the case of system boot, 'cpufreq_driver->init' is called later
> > > during cpufreq platform driver's probe. The value of CPU in 'policy->cpu'
> > > can be different from the current CPU. That's why read_cpuid_mpidr() can't
> > > be used.
> > >
> >
> > Fair enough, why not do cross call like in set_target ? Since it is one-off
> > in init, I don't see any issue when you are doing it runtime for set_target.
> >
> > > > read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
> > > > Though we may not add physical hotplug anytime soon, less dependency
> > > > on this cpu_logical_map is better given that we can resolve this without
> > > > the need to access the map.
> > > >
> >
> > To be honest, we have tried to remove all the dependency on cluster id
> > in generic code as it is not well defined. This one is tegra specific
> > driver so should be fine. But I am still bit nervous to export
> > cpu_logical_map as we have no clue what that would mean for physical
> > hotplug.
> >
> As suggested, I have done below change to get the cluster number using
> read_cpuid_mpidr(). Please review and suggest if this looks ok?
> I will send formal patch if the change is fine.
>
> Thanks,
> Sumit
>
> ----
>
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c
> b/drivers/cpufreq/tegra194-cpufreq.c
> index bae527e..06f5ccf 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -56,9 +56,11 @@ struct read_counters_work {
>
>  static struct workqueue_struct *read_counters_wq;
>
> -static enum cluster get_cpu_cluster(u8 cpu)
> +static void get_cpu_cluster(void *cluster)
>  {
> -       return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
> +       u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> +
> +       *((uint32_t *) cluster) = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>  }
>
>  /*
> @@ -186,8 +188,10 @@ static unsigned int tegra194_get_speed(u32 cpu)
>  static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> -       int cl = get_cpu_cluster(policy->cpu);
>         u32 cpu;
> +       u32 cl;
> +
> +       smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);

Thanks for this, looks good to me. You can add:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
