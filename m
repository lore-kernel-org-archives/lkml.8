Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C0C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF79A21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgBYTpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:45:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgBYTpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:45:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714AE31B;
        Tue, 25 Feb 2020 11:45:30 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62DC3FA00;
        Tue, 25 Feb 2020 11:45:28 -0800 (PST)
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>, Jian Cai <jiancai@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
 <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
 <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d7047fca-7efb-94bc-51aa-c33934df0721@arm.com>
Date:   Tue, 25 Feb 2020 19:45:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-25 7:33 pm, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 20:10, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Mon, Feb 24, 2020 at 9:22 PM Stefan Agner <stefan@agner.ch> wrote:
>>>
>>> Clang's integrated assembler does not allow to to use the mcr
>>> instruction to access floating point co-processor registers:
>>> arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
>>>          fmxr(FPEXC, fpexc & ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEXC_TRAP_MASK));
>>>          ^
>>> arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
>>>          asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
>>>              ^
>>> <inline asm>:1:6: note: instantiated into assembly here
>>>          mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
>>>              ^
>>>
>>> The GNU assembler supports the .fpu directive at least since 2.17 (when
>>> documentation has been added). Since Linux requires binutils 2.21 it is
>>> safe to use .fpu directive. Use the .fpu directive and mnemonics for VFP
>>> register access.
>>>
>>> This allows to build vfpmodule.c with Clang and its integrated assembler.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/905
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>   arch/arm/vfp/vfpinstr.h | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
>>> index 38dc154e39ff..799ccf065406 100644
>>> --- a/arch/arm/vfp/vfpinstr.h
>>> +++ b/arch/arm/vfp/vfpinstr.h
>>> @@ -62,21 +62,17 @@
>>>   #define FPSCR_C (1 << 29)
>>>   #define FPSCR_V        (1 << 28)
>>>
>>> -/*
>>> - * Since we aren't building with -mfpu=vfp, we need to code
>>> - * these instructions using their MRC/MCR equivalents.
>>> - */
>>> -#define vfpreg(_vfp_) #_vfp_
>>> -
>>>   #define fmrx(_vfp_) ({                 \
>>>          u32 __v;                        \
>>> -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #_vfp_    \
>>> +       asm(".fpu       vfpv2\n"        \
>>> +           "vmrs       %0, " #_vfp_    \
>>>              : "=r" (__v) : : "cc");     \
>>>          __v;                            \
>>>    })
>>>
>>>   #define fmxr(_vfp_,_var_)              \
>>> -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
>>> +       asm(".fpu       vfpv2\n"        \
>>> +           "vmsr       " #_vfp_ ", %0" \
>>>             : : "r" (_var_) : "cc")
>>>
>>>   u32 vfp_single_cpdo(u32 inst, u32 fpscr);
>>> --
>>
>> Hi Stefan,
>> Thanks for the patch.  Reading through:
>> - FMRX, FMXR, and FMSTAT:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0068b/Bcfbdihi.html
>> - VMRS and VMSR:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204h/Bcfbdihi.html
>>
>> Should a macro called `fmrx` that had a comment about `fmrx` be using
>> `vmrs` in place of `fmrx`?
>>
>> It looks like Clang treats them the same, but GCC keeps them separate:
>> https://godbolt.org/z/YKmSAs
>> Ah, this is only when streaming to assembly. Looks like they have the
>> same encoding, and produce the same disassembly. (Godbolt emits
>> assembly by default, and has the option to compile, then disassemble).
>> If I take my case from godbolt above:
>>
>> ➜  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
>> ➜  /tmp llvm-objdump -dr x.o
>>
>> x.o: file format elf32-arm-little
>>
>>
>> Disassembly of section .text:
>>
>> 00000000 bar:
>>         0: f1 ee 10 0a                  vmrs r0, fpscr
>>         4: 70 47                        bx lr
>>         6: 00 bf                        nop
>>
>> 00000008 baz:
>>         8: f1 ee 10 0a                  vmrs r0, fpscr
>>         c: 70 47                        bx lr
>>         e: 00 bf                        nop
>>
>> So indeed a similar encoding exists for the two different assembler
>> instructions.
> 
> Does that hold for ARM (A32) instructions as well?

It should do - they're all the same thing underneath. The UAL syntax 
just renamed all the legacy VFP mnemonics from Fxxx to Vxxx form, apart 
from a couple of things that were already deprecated. GAS still accepts 
both regardless of ".syntax unified", and as a result GCC never saw a 
reason to stop emitting the old mnemonics.

Robin.
