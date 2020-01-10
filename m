Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5293C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26BC2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAJSjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:39:11 -0500
Received: from foss.arm.com ([217.140.110.172]:49848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgAJSjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:39:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED92330E;
        Fri, 10 Jan 2020 10:39:09 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C323F6C4;
        Fri, 10 Jan 2020 10:39:06 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
 <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
 <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
Date:   Fri, 10 Jan 2020 18:39:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 25/12/2019 19:01, Bhupesh Sharma wrote:
> On 12/12/2019 04:02 PM, James Morse wrote:
>> On 29/11/2019 19:59, Bhupesh Sharma wrote:
>>> vabits_actual variable on arm64 indicates the actual VA space size,
>>> and allows a single binary to support both 48-bit and 52-bit VA
>>> spaces.
>>>
>>> If the ARMv8.2-LVA optional feature is present, and we are running
>>> with a 64KB page size; then it is possible to use 52-bits of address
>>> space for both userspace and kernel addresses. However, any kernel
>>> binary that supports 52-bit must also be able to fall back to 48-bit
>>> at early boot time if the hardware feature is not present.
>>>
>>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
>>> addressed by TTBR1_EL1 (and hence can be used for determining the
>>> vabits_actual value) it makes more sense to export the same in
>>> vmcoreinfo rather than vabits_actual variable, as the name of the
>>> variable can change in future kernel versions, but the architectural
>>> constructs like TCR_EL1.T1SZ can be used better to indicate intended
>>> specific fields to user-space.
>>>
>>> User-space utilities like makedumpfile and crash-utility, need to
>>> read/write this value from/to vmcoreinfo
>>
>> (write?)
> 
> Yes, also write so that the vmcoreinfo from an (crashing) arm64 system can be used for
> analysis of the root-cause of panic/crash on say an x86_64 host using utilities like
> crash-utility/gdb.

I read this as as "User-space [...] needs to write to vmcoreinfo".


>>> for determining if a virtual address lies in the linear map range.
>>
>> I think this is a fragile example. The debugger shouldn't need to know this.
> 
> Well that the current user-space utility design, so I am not sure we can tweak that too much.
> 
>>> The user-space computation for determining whether an address lies in
>>> the linear map range is the same as we have in kernel-space:
>>>
>>>    #define __is_lm_address(addr)    (!(((u64)addr) & BIT(vabits_actual - 1)))
>>
>> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA space"). If user-space
>> tools rely on 'knowing' the kernel memory layout, they must have to constantly be fixed
>> and updated. This is a poor argument for adding this to something that ends up as ABI.
> 
> See above. The user-space has to rely on some ABI/guaranteed hardware-symbols which can be
> used for 'determining' the kernel memory layout.

I disagree. Everything and anything in the kernel will change. The ABI rules apply to
stuff exposed via syscalls and kernel filesystems. It does not apply to kernel internals,
like the memory layout we used yesterday. 14c127c957c1 is a case in point.

A debugger trying to rely on this sort of thing would have to play catchup whenever it
changes.

I'm looking for a justification that isn't paper-thin. Putting 'for guessing the memory
map' in the commit message gives the impression we can support that.


>> I think a better argument is walking the kernel page tables from the core dump.
>> Core code's vmcoreinfo exports the location of the kernel page tables, but in the example
>> above you can't walk them without knowing how T1SZ was configured.
> 
> Sure, both makedumpfile and crash-utility (which walks the kernel page tables from the
> core dump) use this (and similar) information currently in the user-space.

[...]

>> (From-memory: one of vmcore/kcore is virtually addressed, the other physically. Does this
>> fix your poblem in both cases?)
>>
>>
>>> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
>>> index ca4c3e12d8c5..f78310ba65ea 100644
>>> --- a/arch/arm64/kernel/crash_core.c
>>> +++ b/arch/arm64/kernel/crash_core.c
>>> @@ -7,6 +7,13 @@
>>>   #include <linux/crash_core.h>
>>>   #include <asm/memory.h>
>>
>> You need to include asm/sysreg.h for read_sysreg(), and asm/pgtable-hwdef.h for the macros
>> you added.
> 
> Ok. Will check as I did not get any compilation errors without the same and build-bot also
> did not raise a flag for the missing include files.

Don't trust the header jungle!


>>> +static inline u64 get_tcr_el1_t1sz(void);
> 
>> Why do you need to do this?
> 
> Without this I was getting a missing declaration error, while compiling the code.

Missing declaration?

>>> +static inline u64 get_tcr_el1_t1sz(void)
>>> +{
>>> +    return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
>>> +}

Here it is! (I must be going mad...)


Thanks,

James
