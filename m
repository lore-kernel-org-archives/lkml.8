Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A75C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96E12076C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TZkafeZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgHAMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:17:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6900 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHAMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 08:17:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f255cdb0000>; Sat, 01 Aug 2020 05:15:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 01 Aug 2020 05:16:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 01 Aug 2020 05:16:59 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 1 Aug
 2020 12:16:45 +0000
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Bibek Basu" <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <20200724131059.GB6521@bogus>
 <00cf6e67-16ed-872d-2c16-0ceea6b6f514@nvidia.com>
 <20200727160515.GA8003@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com>
Date:   Sat, 1 Aug 2020 17:46:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200727160515.GA8003@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596284125; bh=q24iFuxw8zC/oQg0smu+jjzuQrKHW+skuVN3UJhlCSU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TZkafeZVd5Ysvgv2X2bTs4xTAOh+pJUpP2UWLnICkowvvmNZ+Cx5MVnW+Wc/+LBVL
         WIPjtw79BtBoYhOtunuJNBmBFHkU5szGwhWW6sAtI6PBAd4Cb3oBlCDaPyyfbrF9jC
         RhpZYNrkILMfQtkJTWLuYtbznZDoZqCmYyEUyXhVNv9CQ39iokzc3VisKaJXRiluTe
         9DwPf9pn0lgXSI4ZkTwO9nzEFEcpzRm1f/9xtE5m0HWHvq9Sz0Sh3tXamrhUp4Iy/k
         HvQFBcQS20diCrrawUPairmojUXUZQLbFEx73ueUc7SnRs2pQ7JUa+IgL7yVKBxNw1
         EKzQKXMDIFxYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
>>>>>
>>>>> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
>>>>> __cpu_logical_map to fix build issue.
>>>>>
>>>
>>> I wonder why like other instances in the drivers, the mpidr is not get
>>> directly from the cpu. The cpufreq_driver->init call happens when the cpu
>>> is being brought online and is executed on the required cpu IIUC.
>>>
>> Yes, this occurs during hotplug case.
>> But in the case of system boot, 'cpufreq_driver->init' is called later
>> during cpufreq platform driver's probe. The value of CPU in 'policy->cpu'
>> can be different from the current CPU. That's why read_cpuid_mpidr() can't
>> be used.
>>
> 
> Fair enough, why not do cross call like in set_target ? Since it is one-off
> in init, I don't see any issue when you are doing it runtime for set_target.
> 
>>> read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
>>> Though we may not add physical hotplug anytime soon, less dependency
>>> on this cpu_logical_map is better given that we can resolve this without
>>> the need to access the map.
>>>
> 
> To be honest, we have tried to remove all the dependency on cluster id
> in generic code as it is not well defined. This one is tegra specific
> driver so should be fine. But I am still bit nervous to export
> cpu_logical_map as we have no clue what that would mean for physical
> hotplug.
> 
As suggested, I have done below change to get the cluster number using 
read_cpuid_mpidr(). Please review and suggest if this looks ok?
I will send formal patch if the change is fine.

Thanks,
Sumit

----

diff --git a/drivers/cpufreq/tegra194-cpufreq.c 
b/drivers/cpufreq/tegra194-cpufreq.c
index bae527e..06f5ccf 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -56,9 +56,11 @@ struct read_counters_work {

  static struct workqueue_struct *read_counters_wq;

-static enum cluster get_cpu_cluster(u8 cpu)
+static void get_cpu_cluster(void *cluster)
  {
-       return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
+       u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+
+       *((uint32_t *) cluster) = MPIDR_AFFINITY_LEVEL(mpidr, 1);
  }

  /*
@@ -186,8 +188,10 @@ static unsigned int tegra194_get_speed(u32 cpu)
  static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
  {
         struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-       int cl = get_cpu_cluster(policy->cpu);
         u32 cpu;
+       u32 cl;
+
+       smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);


> 
> --
> Regards,
> Sudeep
> 
