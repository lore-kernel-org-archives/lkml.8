Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D6CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8052073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGXKeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:34:03 -0400
Received: from foss.arm.com ([217.140.110.172]:59732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGXKeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4808730E;
        Fri, 24 Jul 2020 03:34:02 -0700 (PDT)
Received: from [10.163.85.90] (unknown [10.163.85.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773A53F66E;
        Fri, 24 Jul 2020 03:33:58 -0700 (PDT)
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com>
 <20200724091308.GA44746@C02TD0UTHF1T.local> <20200724093528.GB23388@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9e84050e-d748-5840-128c-2438ac005416@arm.com>
Date:   Fri, 24 Jul 2020 16:03:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200724093528.GB23388@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/24/2020 03:05 PM, Catalin Marinas wrote:
> On Fri, Jul 24, 2020 at 10:13:52AM +0100, Mark Rutland wrote:
>> On Fri, Jul 24, 2020 at 01:46:18PM +0530, Anshuman Khandual wrote:
>>> On 07/24/2020 08:38 AM, Kefeng Wang wrote:
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>> ï¿½ arch/arm64/kernel/setup.c | 1 +
>>>>> ï¿½ 1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>>> index c793276ec7ad9..3aea05fbb9998 100644
>>>>> --- a/arch/arm64/kernel/setup.c
>>>>> +++ b/arch/arm64/kernel/setup.c
>>>>> @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
>>>>> ï¿½ arch_initcall(reserve_memblock_reserved_regions);
>>>>> ï¿½ ï¿½ u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>>>> +EXPORT_SYMBOL(__cpu_logical_map);
>>
>> If modules are using cpu_logical_map(), this looks sane ot me, but I
>> wonder if we should instead turn cpu_logical_map() into a C wrapper in
>> smp.c, or at least mark __cpu_logical_map as __ro_after_init lest
>> someone have the bright idea to fiddle with it.
> 
> I'd go for a C wrapper and also change a couple of instances where we
> assign a value directly to cpu_logical_map(cpu).

Probably also create a set_cpu_logical_map(cpu, hwid) for those instances
as well.
