Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E7C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgAJL2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:28:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbgAJL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:28:32 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22CB5E1CF0C553E95238;
        Fri, 10 Jan 2020 19:28:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 19:28:18 +0800
Subject: Re: [RFC PATCH] arm64/ftrace: support dynamically allocated
 trampolines
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>,
        <catalin.marinas@arm.com>, <duwe@lst.de>,
        "chengjian (D)" <cj.chengjian@huawei.com>
References: <20200109142736.1122-1-cj.chengjian@huawei.com>
 <20200109164858.GH3112@lakrids.cambridge.arm.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <b0457ef0-f1b2-e258-b59d-aa9af8e48c5d@huawei.com>
Date:   Fri, 10 Jan 2020 19:28:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109164858.GH3112@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark

     Thanks for your reply.

On 2020/1/10 0:48, Mark Rutland wrote:
> On Thu, Jan 09, 2020 at 02:27:36PM +0000, Cheng Jian wrote:
>
> Just how bad is this, and when/where does it matter?
>
> How much does this patch improve matters?

I will have a test about this.

>> Known issues :
>> If kaslr is enabled, the address of tramp and ftrace call
>> may be far away. Therefore, long jump support is required.
>> Here I intend to use the same solution as module relocating,
>> Reserve enough space for PLT at the end when allocating, can
>> use PLT to complete these long jumps.
> This can happen both ways; the callsite can also be too far from the
> trampoline to be able to branch to it.


Yes, that can happen both ways.

> I've had issues with that for other reasons, and I think that we might
> be able to use -fpatchable-function-entry=N,M to place a PLT immediately
> before each function for that. However, I'm wary of doing so because it
> makes it much harder to modify the patch site itself.


This sounds good. I have no better idea than this now.

At least try it first.


>
>>   
>> +GLOBAL(ftrace_common_end)
>>   	ret	x9
> This doesn't look right. Surely you want the RET, too?


I will fix this error, thanks.

> +/*
> + * ftrace_caller() or ftrace_regs_caller() trampoline
> + *				+-----------------------+
> + * ftrace_(regs_)caller =>	|	......		|
> + * ftrace_(regs_)caller_end =>	| b ftrace_common	| => nop
> + *				+-----------------------+
> + * ftrace_common =>		|	......		|
> + * function_trace_op_ptr =>	| adrp x2, sym		| => nop
> + *				| ldr  x2,[x2,:lo12:sym]| => ldr x2 <ftrace_op>
> + *				|	......		|
> + * ftrace_common_end  =>	|	retq		|
> Copy-paste from x86? arm64 doesn't have a retq instruction.
>
>> + *				+-----------------------+
>> + * ftrace_opt =>		|	ftrace_opt	|
>> + *				+-----------------------+
> Typo: s/opt/ops/ ?

Sorry for these scenes.


>> + */
>> +static unsigned long create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>> +{
>> +	unsigned long start_offset_caller, end_offset_caller, caller_size;
>> +	unsigned long start_offset_common, end_offset_common, common_size;
>> +	unsigned long op_offset, offset, size, ip, npages;
>> +	void *trampoline;
>> +	unsigned long *ptr;
>> +	/* ldr x2, <label> */
>> +	u32 pc_ldr = 0x58000002;
>> +	u32 mask = BIT(19) - 1;
> Instead of open-coding this, please teach the insn framework how to
> encode LDR (immediate).


I will, Thank you.

>
>> +	int shift = 5;
>> +	int ret;
>> +	u32 nop;
>> +
>> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
>> +		start_offset_caller = (unsigned long)ftrace_regs_caller;
>> +		end_offset_caller = (unsigned long)ftrace_regs_caller_end;
>> +	} else {
>> +		start_offset_caller = (unsigned long)ftrace_caller;
>> +		end_offset_caller = (unsigned long)ftrace_caller_end;
>> +	}
>> +	start_offset_common = (unsigned long)ftrace_common;
>> +	end_offset_common = (unsigned long)ftrace_common_end;
>> +
>> +	op_offset = (unsigned long)function_trace_op_ptr;
>> +
>> +	/*
>> +	 * Merge ftrace_caller/ftrace_regs_caller and ftrace_common
>> +	 * to one function in ftrace trampoline.
>> +	 */
>> +	caller_size = end_offset_caller - start_offset_caller + AARCH64_INSN_SIZE;
>> +	common_size = end_offset_common - start_offset_common + AARCH64_INSN_SIZE;
>> +	size = caller_size + common_size;
>> +
>> +	trampoline = alloc_tramp(caller_size + common_size + sizeof(void *));
>> +	if (!trampoline)
>> +		return 0;
>> +
>> +	*tramp_size = caller_size + common_size + sizeof(void *);
>> +	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
>> +
>> +	/* Copy ftrace_caller/ftrace_regs_caller onto the trampoline memory */
>> +	ret = probe_kernel_read(trampoline, (void *)start_offset_caller, caller_size);
>> +	if (WARN_ON(ret < 0))
>> +		goto free;
>> +
>> +	/*
>> +	 * Copy ftrace_common to the trampoline memory
>> +	 * below ftrace_caller/ftrace_regs_caller. so
>> +	 * we can merge the two function to one function.
>> +	 */
>> +	ret = probe_kernel_read(trampoline + caller_size, (void *)start_offset_common, common_size);
>> +	if (WARN_ON(ret < 0))
>> +		goto free;
>> +
>> +	/*
>> +	 * We merge the two functions to one function, so these is
>> +	 * no need to use jump instructions to ftrace_common, modify
>> +	 * it to NOP.
>> +	 */
>> +	ip = (unsigned long)trampoline + caller_size - AARCH64_INSN_SIZE;
>> +	nop = aarch64_insn_gen_nop();
>> +	memcpy((void *)ip, &nop, AARCH64_INSN_SIZE);
>> +
>> +	/*
>> +	 * Stored ftrace_ops at the end of the trampoline.
>> +	 * This will be used to load the third parameter for the callback.
>> +	 * Basically, that location at the end of the trampoline takes the
>> +	 * place of the global function_trace_op variable.
>> +	 */
>> +	ptr = (unsigned long *)(trampoline + size);
>> +	*ptr = (unsigned long)ops;
>> +
>> +	/*
>> +	 * Update the trampoline ops REF
>> +	 *
>> +	 * OLD INSNS : ldr_l x2, function_trace_op
>> +	 *	adrp	x2, sym
>> +	 *	ldr	x2, [x2, :lo12:\sym]
>> +	 *
>> +	 * NEW INSNS:
>> +	 *	nop
>> +	 *	ldr x2, <ftrace_ops>
>> +	 */
>> +	op_offset -= start_offset_common;
>> +	ip = (unsigned long)trampoline + caller_size + op_offset;
>> +	nop = aarch64_insn_gen_nop();
>> +	memcpy((void *)ip, &nop, AARCH64_INSN_SIZE);
>> +
>> +	op_offset += AARCH64_INSN_SIZE;
>> +	ip = (unsigned long)trampoline + caller_size + op_offset;
>> +	offset = (unsigned long)ptr - ip;
>> +	if (WARN_ON(offset % AARCH64_INSN_SIZE != 0))
>> +		goto free;
>> +	offset = offset / AARCH64_INSN_SIZE;
>> +	pc_ldr |= (offset & mask) << shift;
>> +	memcpy((void *)ip, &pc_ldr, AARCH64_INSN_SIZE);
> I think it would be much better to have a separate template for the
> trampoline which we don't have to patch in this way. It can even be
> placed into a non-executable RO section, since the template shouldn't be
> executed directly.


A separate template !

This may be a good way, and I think the patching here is very HACK 
too(Not very friendly).

I had thought of other ways before, similar to the method on X86_64, remove
the ftrace_common(), directly modifying ftrace_caller/ftrace_reg_caller, 
We will

only need to copy the code once in this way, and these is no need to modify

call ftrace_common to NOP.


Using a trampoline template sounds great. but this also means that we 
need to

maintain a template(or maybe two templates: one for caller, another for 
regs_caller).

Hi, Mark, what do you think about it ?


>> +
>> +	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
>> +
>> +	set_vm_flush_reset_perms(trampoline);
>> +
>> +	/*
>> +	 * Module allocation needs to be completed by making the page
>> +	 * executable. The page is still writable, which is a security hazard,
>> +	 * but anyhow ftrace breaks W^X completely.
>> +	 */
>> +	set_memory_x((unsigned long)trampoline, npages);
> Why is the page still writeable? Surely you can make it RO first?
>
> Please do not break W^X restrictions; we've tried to ensure that arm64
> does the right thing by default here.
>
> Note that arm64's ftrace_modify_code() will use a writeable alias, so it
> can be used after the memory has been marked RO.

YEAH, I will. arm64's ftrace_modify_code can work after the trampoline has
been marked RO.

>> +
>> +	return (unsigned long)trampoline;
>> +
>> +free:
>> +	tramp_free(trampoline);
>> +	return 0;
>> +}
>> +
>> +static unsigned long calc_trampoline_call_offset(struct ftrace_ops *ops)
>> +{
>> +	unsigned call_offset, end_offset, offset;
>> +
>> +	call_offset = (unsigned long)&ftrace_call;
>> +	end_offset = (unsigned long)ftrace_common_end;
>> +	offset = end_offset - call_offset;
>> +
>> +	return ops->trampoline_size - AARCH64_INSN_SIZE - sizeof(void *) - offset;
>> +}
>> +
>> +static int ftrace_trampoline_modify_call(struct ftrace_ops *ops)
>> +{
>> +	unsigned long offset;
>> +	unsigned long pc;
>> +	ftrace_func_t func;
>> +	u32 new;
>> +
>> +	offset = calc_trampoline_call_offset(ops);
>> +	pc = ops->trampoline + offset;
>> +
>> +	func = ftrace_ops_get_func(ops);
>> +	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func, AARCH64_INSN_BRANCH_LINK);
>> +
>> +	return ftrace_modify_code(pc, 0, new, false);
>> +}
>> +
>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> +
>> +static unsigned long calc_trampoline_graph_call_offset(struct ftrace_ops *ops)
>> +{
>> +	unsigned end_offset, call_offset, offset;
>> +
>> +	call_offset = (unsigned long)&ftrace_graph_call;
>> +	end_offset = (unsigned long)ftrace_common_end;
>> +	offset = end_offset - call_offset;
>> +
>> +	return ops->trampoline_size - AARCH64_INSN_SIZE - sizeof(void *) - offset;
>> +}
>> +
>> +extern int ftrace_graph_active;
>> +static int ftrace_trampoline_modify_graph_call(struct ftrace_ops *ops)
>> +{
>> +	unsigned long offset;
>> +	unsigned long pc;
>> +	u32 branch, nop;
>> +
>> +	offset = calc_trampoline_graph_call_offset(ops);
>> +	pc = ops->trampoline + offset;
>> +
>> +	branch = aarch64_insn_gen_branch_imm(pc,
>> +					     (unsigned long)ftrace_graph_caller,
>> +					     AARCH64_INSN_BRANCH_NOLINK);
>> +	nop = aarch64_insn_gen_nop();
>> +
>> +	if (ftrace_graph_active)
>> +		return ftrace_modify_code(pc, 0, branch, false);
>> +	else
>> +		return ftrace_modify_code(pc, 0, nop, false);
>> +}
> It should be posbile to share the bulk of this code with the non-graph
> versions.

It seems that, I will cleanup my code.


>
> Thanks,
> Mark.
>
> .


Thank you very much.

-- Cheng Jian.


