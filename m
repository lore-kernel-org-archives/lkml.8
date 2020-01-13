Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEAC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F220678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgAMGS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:18:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAMGS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:18:28 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AABD8CDEBF98212D63B5;
        Mon, 13 Jan 2020 14:18:25 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 14:18:15 +0800
Subject: Re: [RFC PATCH] arm64/ftrace: support dynamically allocated
 trampolines
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>,
        <catalin.marinas@arm.com>, <duwe@lst.de>
References: <20200109142736.1122-1-cj.chengjian@huawei.com>
 <20200109164858.GH3112@lakrids.cambridge.arm.com>
 <b0457ef0-f1b2-e258-b59d-aa9af8e48c5d@huawei.com>
 <20200110121234.GA31707@lakrids.cambridge.arm.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <5fd602dd-a909-5209-56b6-39c7a34dfcff@huawei.com>
Date:   Mon, 13 Jan 2020 14:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110121234.GA31707@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/10 20:12, Mark Rutland wrote:
> On Fri, Jan 10, 2020 at 07:28:17PM +0800, chengjian (D) wrote:
>> On 2020/1/10 0:48, Mark Rutland wrote:
>>> On Thu, Jan 09, 2020 at 02:27:36PM +0000, Cheng Jian wrote:
>>>> +	/*
>>>> +	 * Update the trampoline ops REF
>>>> +	 *
>>>> +	 * OLD INSNS : ldr_l x2, function_trace_op
>>>> +	 *	adrp	x2, sym
>>>> +	 *	ldr	x2, [x2, :lo12:\sym]
>>>> +	 *
>>>> +	 * NEW INSNS:
>>>> +	 *	nop
>>>> +	 *	ldr x2, <ftrace_ops>
>>>> +	 */
>>>> +	op_offset -= start_offset_common;
>>>> +	ip = (unsigned long)trampoline + caller_size + op_offset;
>>>> +	nop = aarch64_insn_gen_nop();
>>>> +	memcpy((void *)ip, &nop, AARCH64_INSN_SIZE);
>>>> +
>>>> +	op_offset += AARCH64_INSN_SIZE;
>>>> +	ip = (unsigned long)trampoline + caller_size + op_offset;
>>>> +	offset = (unsigned long)ptr - ip;
>>>> +	if (WARN_ON(offset % AARCH64_INSN_SIZE != 0))
>>>> +		goto free;
>>>> +	offset = offset / AARCH64_INSN_SIZE;
>>>> +	pc_ldr |= (offset & mask) << shift;
>>>> +	memcpy((void *)ip, &pc_ldr, AARCH64_INSN_SIZE);
>>> I think it would be much better to have a separate template for the
>>> trampoline which we don't have to patch in this way. It can even be
>>> placed into a non-executable RO section, since the template shouldn't be
>>> executed directly.
>> A separate template !
>>
>> This may be a good way, and I think the patching here is very HACK too(Not
>> very friendly).
>>
>> I had thought of other ways before, similar to the method on X86_64,
>> remove the ftrace_common(), directly modifying
>> ftrace_caller/ftrace_reg_caller, We will only need to copy the code
>> once in this way, and these is no need to modify call ftrace_common to
>> NOP.
>>
>> Using a trampoline template sounds great. but this also means that we
>> need to aintain a template(or maybe two templates: one for caller,
>> another for regs_caller).
>>
>> Hi, Mark, what do you think about it ?
> I think that having two templates is fine. We can factor
> ftrace_common_return into a macro mirroring ftrace_regs_entry, and I
> suspect we can probably figure out some way to factor the common
> portion.
>
> Thanks,
> Mark.
>
> .


OK, I will do it.

Thank you, Mark.



   --Cheng Jian


