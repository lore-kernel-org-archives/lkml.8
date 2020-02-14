Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86795222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393474AbgBNSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:13:22 -0500
Received: from foss.arm.com ([217.140.110.172]:42788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393441AbgBNSNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:13:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D5F6328;
        Fri, 14 Feb 2020 10:13:19 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62A53F68E;
        Fri, 14 Feb 2020 10:13:16 -0800 (PST)
Subject: Re: [PATCH v7 11/11] arm64: scs: add shadow stacks for SDEI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-12-samitolvanen@google.com>
 <dbb090ae-d1ec-cb1a-0710-e1d3cfe762b9@arm.com>
 <CABCJKudpeTDa4Ro1aCsCJ-=x97SG0qu5LGpj9ywj1aLOtboNkQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a0ca5766-fb76-a498-ab2f-3015f1335fe9@arm.com>
Date:   Fri, 14 Feb 2020 18:13:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABCJKudpeTDa4Ro1aCsCJ-=x97SG0qu5LGpj9ywj1aLOtboNkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On 12/02/2020 20:59, Sami Tolvanen wrote:
> On Tue, Feb 11, 2020 at 5:57 AM James Morse <james.morse@arm.com> wrote:
>> On 28/01/2020 18:49, Sami Tolvanen wrote:
>>> This change adds per-CPU shadow call stacks for the SDEI handler.
>>> Similarly to how the kernel stacks are handled, we add separate shadow
>>> stacks for normal and critical events.
>>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> Tested-by: James Morse <james.morse@arm.com>

>>> diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
>>> index eaadf5430baa..dddb7c56518b 100644
>>> --- a/arch/arm64/kernel/scs.c
>>> +++ b/arch/arm64/kernel/scs.c
>>
>>> +static int scs_alloc_percpu(unsigned long * __percpu *ptr, int cpu)
>>> +{
>>> +     unsigned long *p;
>>> +
>>> +     p = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
>>> +                              VMALLOC_START, VMALLOC_END,
>>> +                              GFP_SCS, PAGE_KERNEL,
>>> +                              0, cpu_to_node(cpu),
>>> +                              __builtin_return_address(0));
>>
>> (What makes this arch specific? arm64 has its own calls like this for the regular vmap
>> stacks because it plays tricks with the alignment. Here the alignment requirement comes
>> from the core SCS code... Would another architecture implement these
>> scs_alloc_percpu()/scs_free_percpu() differently?)
> 
> You are correct, these aren't necessarily specific to arm64. However,
> right now, we are not allocating per-CPU shadow stacks anywhere else,
> so this was a natural place for the helper functions.

Fair enough,


> Would you prefer me to move these to kernel/scs.c instead?

I have no preference, as long as they don't get duplicated later!


Thanks,

James
