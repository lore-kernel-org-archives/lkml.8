Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96BEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8E32075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgG0QF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:05:26 -0400
Received: from foss.arm.com ([217.140.110.172]:47214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgG0QF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:05:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1CCD6E;
        Mon, 27 Jul 2020 09:05:25 -0700 (PDT)
Received: from bogus (unknown [10.37.12.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851B23F718;
        Mon, 27 Jul 2020 09:05:22 -0700 (PDT)
Date:   Mon, 27 Jul 2020 17:05:15 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200727160515.GA8003@bogus>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <20200724131059.GB6521@bogus>
 <00cf6e67-16ed-872d-2c16-0ceea6b6f514@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cf6e67-16ed-872d-2c16-0ceea6b6f514@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 05:16:27PM +0530, Sumit Gupta wrote:
> > > > ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> > > >
> > > > ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> > > > __cpu_logical_map to fix build issue.
> > > >
> >
> > I wonder why like other instances in the drivers, the mpidr is not get
> > directly from the cpu. The cpufreq_driver->init call happens when the cpu
> > is being brought online and is executed on the required cpu IIUC.
> >
> Yes, this occurs during hotplug case.
> But in the case of system boot, 'cpufreq_driver->init' is called later
> during cpufreq platform driver's probe. The value of CPU in 'policy->cpu'
> can be different from the current CPU. That's why read_cpuid_mpidr() can't
> be used.
>

Fair enough, why not do cross call like in set_target ? Since it is one-off
in init, I don't see any issue when you are doing it runtime for set_target.

> > read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
> > Though we may not add physical hotplug anytime soon, less dependency
> > on this cpu_logical_map is better given that we can resolve this without
> > the need to access the map.
> >

To be honest, we have tried to remove all the dependency on cluster id
in generic code as it is not well defined. This one is tegra specific
driver so should be fine. But I am still bit nervous to export
cpu_logical_map as we have no clue what that would mean for physical
hotplug.


--
Regards,
Sudeep
