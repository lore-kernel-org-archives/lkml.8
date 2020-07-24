Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A98C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6751C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:16:50 -0400
Received: from foss.arm.com ([217.140.110.172]:57408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgGXIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:16:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41121D6E;
        Fri, 24 Jul 2020 01:16:49 -0700 (PDT)
Received: from [10.163.85.90] (unknown [10.163.85.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BFBF3F66F;
        Fri, 24 Jul 2020 01:16:46 -0700 (PDT)
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
Date:   Fri, 24 Jul 2020 13:46:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/24/2020 08:38 AM, Kefeng Wang wrote:
> +maillist

This does not seem to be a correct method of posting any patch.

> 
> On 2020/7/24 11:04, Kefeng Wang wrote:
>> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!


>>
>> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
>> __cpu_logical_map to fix build issue.

Commit 887d5fc82cb4 ("cpufreq: Add Tegra194 cpufreq driver") which adds
this particular driver is present just on linux-next. But as expected,
the driver does not use __cpu_logical_map directly but instead accesses
it via cpu_logical_map() wrapper. Wondering, how did you even trigger
the modpost error ?

>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/arm64/kernel/setup.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index c793276ec7ad9..3aea05fbb9998 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
>>   arch_initcall(reserve_memblock_reserved_regions);
>>     u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>> +EXPORT_SYMBOL(__cpu_logical_map);
>>     void __init setup_arch(char **cmdline_p)
>>   {
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
