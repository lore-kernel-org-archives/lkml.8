Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C37206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGYCAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:00:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbgGYCAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:00:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 522F119D60AA5CD15FA2;
        Sat, 25 Jul 2020 10:00:44 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:00:36 +0800
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hch@infradead.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <20200724131059.GB6521@bogus>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c24b88be-e711-66d8-796a-8964af1762de@huawei.com>
Date:   Sat, 25 Jul 2020 10:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200724131059.GB6521@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/24 21:10, Sudeep Holla wrote:
> On Fri, Jul 24, 2020 at 11:08:03AM +0800, Kefeng Wang wrote:
>> +maillist
>>
>> On 2020/7/24 11:04, Kefeng Wang wrote:
>>> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
>>>
>>> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
>>> __cpu_logical_map to fix build issue.
>>>
> I wonder why like other instances in the drivers, the mpidr is not get
> directly from the cpu. The cpufreq_driver->init call happens when the cpu
> is being brought online and is executed on the required cpu IIUC.
>
> read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
> Though we may not add physical hotplug anytime soon, less dependency
> on this cpu_logical_map is better given that we can resolve this without
> the need to access the map.

Hi all,  thanks for all comments.

As Sudeep said, I will using read_cpuid_mpidr() directly in 
tegra194-cpufreq to

fix the build issue,  and later we also would turn cpu_logical_map() 
into a C wrapper.

If that's ok, I will send a new build-fix patch firstly, thanks.


>

