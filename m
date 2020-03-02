Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B81C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F88924697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCBHM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:12:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbgCBHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:12:56 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C6DC3895D5107159B6EA;
        Mon,  2 Mar 2020 15:12:47 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 15:12:40 +0800
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Scott Wood <oss@buserror.net>, Daniel Axtens <dja@axtens.net>,
        <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <me@tobin.cc>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <87tv3drf79.fsf@dja-thinkpad.axtens.net>
 <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
 <e8cd8f287934954cfa07dcf76ac73492e2d49a5b.camel@buserror.net>
 <dd8db870-b607-3f74-d3bc-a8d9f33f9852@huawei.com>
 <4c0e7fec63dbc7b91fa6c24692c73c256c131f51.camel@buserror.net>
 <188971ed-f1c4-39b3-c07e-89cc593d88d7@huawei.com>
 <530c49dfd97c811dc53ffc78c594d7133f7eb1e9.camel@buserror.net>
 <35e6c660-3896-bdb8-45f3-c1504aa2171f@huawei.com>
 <31b5966ba579ef246176a7d8ad18c2c02788dd27.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <17658c2b-9eb8-cee9-e9a2-93d316a401b1@huawei.com>
Date:   Mon, 2 Mar 2020 15:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <31b5966ba579ef246176a7d8ad18c2c02788dd27.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/2 11:24, Scott Wood 写道:
> On Mon, 2020-03-02 at 10:17 +0800, Jason Yan wrote:
>>
>> 在 2020/3/1 6:54, Scott Wood 写道:
>>> On Sat, 2020-02-29 at 15:27 +0800, Jason Yan wrote:
>>>>
>>>> Turnning to %p may not be a good idea in this situation. So
>>>> for the REG logs printed when dumping stack, we can disable it when
>>>> KASLR is open. For the REG logs in other places like show_regs(), only
>>>> privileged can trigger it, and they are not combind with a symbol, so
>>>> I think it's ok to keep them.
>>>>
>>>> diff --git a/arch/powerpc/kernel/process.c
>>>> b/arch/powerpc/kernel/process.c
>>>> index fad50db9dcf2..659c51f0739a 100644
>>>> --- a/arch/powerpc/kernel/process.c
>>>> +++ b/arch/powerpc/kernel/process.c
>>>> @@ -2068,7 +2068,10 @@ void show_stack(struct task_struct *tsk, unsigned
>>>> long *stack)
>>>>                    newsp = stack[0];
>>>>                    ip = stack[STACK_FRAME_LR_SAVE];
>>>>                    if (!firstframe || ip != lr) {
>>>> -                       printk("["REG"] ["REG"] %pS", sp, ip, (void
>>>> *)ip);
>>>> +                       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>>> +                               printk("%pS", (void *)ip);
>>>> +                       else
>>>> +                               printk("["REG"] ["REG"] %pS", sp, ip,
>>>> (void *)ip);
>>>
>>> This doesn't deal with "nokaslr" on the kernel command line.  It also
>>> doesn't
>>> seem like something that every callsite should have to opencode, versus
>>> having
>>> an appropriate format specifier behaves as I described above (and I still
>>> don't see why that format specifier should not be "%p").
>>>
>>
>> Actually I still do not understand why we should print the raw value
>> here. When KALLSYMS is enabled we have symbol name  and  offset like
>> put_cred_rcu+0x108/0x110, and when KALLSYMS is disabled we have the raw
>> address.
> 
> I'm more concerned about the stack address for wading through a raw stack dump
> (to find function call arguments, etc).  The return address does help confirm
> that I'm on the right stack frame though, and also makes looking up a line
> number slightly easier than having to look up a symbol address and then add
> the offset (at least for non-module addresses).
> 
> As a random aside, the mismatch between Linux printing a hex offset and GDB
> using decimal in disassembly is annoying...
> 

OK, I will send a RFC patch to add a new format specifier such as "%pk" 
or change the exsiting "%pK" to print raw value of addresses when KASLR 
is disabled and print hash value of addresses when KASLR is enabled. 
Let's see what the printk guys would say :)


> -Scott
> 
> 
> 
> .
> 

