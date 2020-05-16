Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6968B206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgEPIUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:20:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgEPIUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:20:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A1E3781923FF99478CE;
        Sat, 16 May 2020 16:20:49 +0800 (CST)
Received: from [10.166.215.145] (10.166.215.145) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:20:45 +0800
Subject: Re: [PATCH 4/4] arm64: kgdb: Set PSTATE.SS to 1 to reenable
 single-step
To:     Doug Anderson <dianders@chromium.org>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
 <20200509214159.19680-5-liwei391@huawei.com>
 <CAD=FV=Vb6=f=fr83-k0YH86k4v4G5LcfOGcks7RM9VxzxOnXsQ@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <5cf0ccf6-79e7-7ad4-c007-f0041daf9a42@huawei.com>
Date:   Sat, 16 May 2020 16:20:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vb6=f=fr83-k0YH86k4v4G5LcfOGcks7RM9VxzxOnXsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On 2020/5/14 8:23, Doug Anderson wrote:
(SNIP)
>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> index 3910ac06c261..093ad9d2e5e6 100644
>> --- a/arch/arm64/kernel/kgdb.c
>> +++ b/arch/arm64/kernel/kgdb.c
>> @@ -230,7 +230,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>>                         kernel_prepare_single_step(&per_cpu(kgdb_ss_flags,
>>                                         raw_smp_processor_id()), linux_regs);
>>                         kernel_enable_single_step(linux_regs);
>> -               }
>> +               } else
>> +                       set_regs_spsr_ss(linux_regs);
> 
> One slight nit is that my personal preference is that if one half of
> an "if/else" needs braces then both halves should have braces.  I
Thanks for spotting it. Refer to Documentation/process/coding-style.rst,
i will fix it in the v2.

> don't know what Catalin and Will's policies are, though.
> 
> Other than that, this seems right to me.  I will leave it to the
> Catalin and Will folks to say if they'd rather have this call made
> from a different place or if they're happy with where you've put it.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 

Thanks,
Wei
