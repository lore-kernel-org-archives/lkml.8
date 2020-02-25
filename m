Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4EC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199532082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="fiBYar2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgBYUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:00:34 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:49082 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:00:34 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 570BF5C3734;
        Tue, 25 Feb 2020 21:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1582660832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pbXjCTmSWvRoORcqT8xdio5aWElTyodfDE1yRwxE88=;
        b=fiBYar2G/FyAj0rGQCdcDOsJCqXNCqszfBq8dZigfTqmWS+tLIEW0neeI804TrlxLJifMa
        1HPUdZmB6ic3W68C63TuiBA0p28gC+eEavJlWTzyGQtOdhiHIAyb442lak/sbUJJ3J3Xlc
        r4VrpgUqOqIDPIowtDZgzmq74SNHJ6g=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Tue, 25 Feb 2020 21:00:32 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Robin Murphy <robin.murphy@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Jian Cai <jiancai@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
In-Reply-To: <d7047fca-7efb-94bc-51aa-c33934df0721@arm.com>
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
 <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
 <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
 <d7047fca-7efb-94bc-51aa-c33934df0721@arm.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <0e4196b528284b07d088dec086f3378a@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-25 20:45, Robin Murphy wrote:
> On 2020-02-25 7:33 pm, Ard Biesheuvel wrote:
>> On Tue, 25 Feb 2020 at 20:10, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>>
>>> On Mon, Feb 24, 2020 at 9:22 PM Stefan Agner <stefan@agner.ch> wrote:
>>>>
>>>> Clang's integrated assembler does not allow to to use the mcr
>>>> instruction to access floating point co-processor registers:
>>>> arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
>>>>          fmxr(FPEXC, fpexc & ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEXC_TRAP_MASK));
>>>>          ^
>>>> arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
>>>>          asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
>>>>              ^
>>>> <inline asm>:1:6: note: instantiated into assembly here
>>>>          mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
>>>>              ^
>>>>
>>>> The GNU assembler supports the .fpu directive at least since 2.17 (when
>>>> documentation has been added). Since Linux requires binutils 2.21 it is
>>>> safe to use .fpu directive. Use the .fpu directive and mnemonics for VFP
>>>> register access.
>>>>
>>>> This allows to build vfpmodule.c with Clang and its integrated assembler.
>>>>
>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/905
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>>   arch/arm/vfp/vfpinstr.h | 12 ++++--------
>>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
>>>> index 38dc154e39ff..799ccf065406 100644
>>>> --- a/arch/arm/vfp/vfpinstr.h
>>>> +++ b/arch/arm/vfp/vfpinstr.h
>>>> @@ -62,21 +62,17 @@
>>>>   #define FPSCR_C (1 << 29)
>>>>   #define FPSCR_V        (1 << 28)
>>>>
>>>> -/*
>>>> - * Since we aren't building with -mfpu=vfp, we need to code
>>>> - * these instructions using their MRC/MCR equivalents.
>>>> - */
>>>> -#define vfpreg(_vfp_) #_vfp_
>>>> -
>>>>   #define fmrx(_vfp_) ({                 \
>>>>          u32 __v;                        \
>>>> -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #_vfp_    \
>>>> +       asm(".fpu       vfpv2\n"        \
>>>> +           "vmrs       %0, " #_vfp_    \
>>>>              : "=r" (__v) : : "cc");     \
>>>>          __v;                            \
>>>>    })
>>>>
>>>>   #define fmxr(_vfp_,_var_)              \
>>>> -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
>>>> +       asm(".fpu       vfpv2\n"        \
>>>> +           "vmsr       " #_vfp_ ", %0" \
>>>>             : : "r" (_var_) : "cc")
>>>>
>>>>   u32 vfp_single_cpdo(u32 inst, u32 fpscr);
>>>> --
>>>
>>> Hi Stefan,
>>> Thanks for the patch.  Reading through:
>>> - FMRX, FMXR, and FMSTAT:
>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0068b/Bcfbdihi.html
>>> - VMRS and VMSR:
>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204h/Bcfbdihi.html
>>>
>>> Should a macro called `fmrx` that had a comment about `fmrx` be using
>>> `vmrs` in place of `fmrx`?
>>>
>>> It looks like Clang treats them the same, but GCC keeps them separate:
>>> https://godbolt.org/z/YKmSAs
>>> Ah, this is only when streaming to assembly. Looks like they have the
>>> same encoding, and produce the same disassembly. (Godbolt emits
>>> assembly by default, and has the option to compile, then disassemble).
>>> If I take my case from godbolt above:
>>>
>>> ➜  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
>>> ➜  /tmp llvm-objdump -dr x.o
>>>
>>> x.o: file format elf32-arm-little
>>>
>>>
>>> Disassembly of section .text:
>>>
>>> 00000000 bar:
>>>         0: f1 ee 10 0a                  vmrs r0, fpscr
>>>         4: 70 47                        bx lr
>>>         6: 00 bf                        nop
>>>
>>> 00000008 baz:
>>>         8: f1 ee 10 0a                  vmrs r0, fpscr
>>>         c: 70 47                        bx lr
>>>         e: 00 bf                        nop
>>>
>>> So indeed a similar encoding exists for the two different assembler
>>> instructions.
>>
>> Does that hold for ARM (A32) instructions as well?
> 
> It should do - they're all the same thing underneath. The UAL syntax
> just renamed all the legacy VFP mnemonics from Fxxx to Vxxx form,
> apart from a couple of things that were already deprecated. GAS still
> accepts both regardless of ".syntax unified", and as a result GCC
> never saw a reason to stop emitting the old mnemonics.
> 

Yes this is really only a mnemonic change when unified assembler
language (UAL) got introduce, the ARM ARM has a list of mnemonic changes
in the appendix.

Just do make sure I also did compare the disassembled object file of
vfpmodule.c before and after this change.

I guess we could (should?) also change the macro name, but I guess that
should be a separate commit anyway.

--
Stefan
