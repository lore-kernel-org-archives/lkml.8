Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7274C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FEA2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgERPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:41:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4857 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgERPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:41:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6737BA8FA906232413BF;
        Mon, 18 May 2020 23:41:00 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.93) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 18 May 2020
 23:40:53 +0800
Subject: Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, <tglx@linutronix.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <hulkci@huawei.com>
References: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
 <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <0bc3eb36-7b9d-7c86-130c-68b566e85c10@huawei.com>
Date:   Mon, 18 May 2020 23:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/18 22:09, Daniel Lezcano wrote:
> On 13/05/2020 23:14, Palmer Dabbelt wrote:
>> On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.com wrote:
>>> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   drivers/clocksource/timer-riscv.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clocksource/timer-riscv.c
>>> b/drivers/clocksource/timer-riscv.c
>>> index c4f15c4068c0..071b8c144027 100644
>>> --- a/drivers/clocksource/timer-riscv.c
>>> +++ b/drivers/clocksource/timer-riscv.c
>>> @@ -19,6 +19,7 @@
>>>
>>>   u64 __iomem *riscv_time_cmp;
>>>   u64 __iomem *riscv_time_val;
>>> +EXPORT_SYMBOL(riscv_time_val);
>>>
>>>   static inline void mmio_set_timer(u64 val)
>>>   {
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> Adding the clocksource maintainers.  Let me know if you want this
>> through my
>> tree, I'm assuming you want it through your tree.
> How can we end up by an export symbol here ?!

Hi Danile,

Found this build error when CONFIG_RISCV_M_MODE=y and CONFIG_RISCV_SBI 
is not,

see patch "4f9bbcefa142 riscv: add support for MMIO access to the timer 
registers"

thanks.

>
>

