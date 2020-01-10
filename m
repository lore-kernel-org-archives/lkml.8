Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7696C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8783A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578669725;
	bh=dM50kEyYri3M6BsZWBRhzpz2Md+9xq+uYd39z3WiZKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZzK9c4RuoAFT7Exs9ZqYlmYTJTz8m5HvxJAu5FVMFD/lGZ41g1iKSaA2zRQT70OzL
	 C5qC8aAPfjcxtVrBdnafsUjrswN9pG8Chtsv7ql881wYNxq5P2oGMU2c4zz8KULm6h
	 zTgAdjbHg3TcQgxvV9M7fI8JJnMYBR0c71yeTD34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgAJPWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgAJPWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:22:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2762072E;
        Fri, 10 Jan 2020 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578669721;
        bh=dM50kEyYri3M6BsZWBRhzpz2Md+9xq+uYd39z3WiZKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7EZ62GZOyNbQDYTIPbL+qXWsWYA1sM+/tAhc+cZIdulup8St0fSewCjzE6VmmD5f
         5OY/OaX3nTZCLh3F02aYj+6IDGOLMVoFMLMGHkW6KT3xQxTAd4AnFT2oPnwQOYd5tA
         2UVmHk1IcYjbrlGclMQOStSIfzo3xrxFG/70/wV4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1ipw6p-0002e2-G9; Fri, 10 Jan 2020 15:21:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 10 Jan 2020 15:21:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 7/7] arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag
 cleanly
In-Reply-To: <d5e27bf5-3cc9-c8bd-5699-71658983054e@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-8-suzuki.poulose@arm.com>
 <94c0bdd9f26c3262ff8a885d13a64d22@www.loen.fr>
 <9e491901-b589-b486-1cad-1bd92a35da95@arm.com>
 <3b30d44c34bc265ce4122396077a1670@www.loen.fr>
 <d5e27bf5-3cc9-c8bd-5699-71658983054e@arm.com>
Message-ID: <e1ba712b42886594fe1095019f2c5813@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com, dave.martin@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 12:00, Suzuki Kuruppassery Poulose wrote:
> On 18/12/2019 11:56, Marc Zyngier wrote:
>> On 2019-12-18 11:42, Suzuki Kuruppassery Poulose wrote:
>>> Hi Marc,
>>> 
>>> On 17/12/2019 19:05, Marc Zyngier wrote:
>>>> Hi Suzuki,
>>>> On 2019-12-17 18:34, Suzuki K Poulose wrote:
>>>>> We detect the absence of FP/SIMD after an incapable CPU is brought 
>>>>> up,
>>>>> and by then we have kernel threads running already with
>>>>> TIF_FOREIGN_FPSTATE set
>>>>> which could be set for early userspace applications (e.g, modprobe 
>>>>> triggered
>>>>> from initramfs) and init. This could cause the applications to loop
>>>>> forever in
>>>>> do_nofity_resume() as we never clear the TIF flag, once we now know 
>>>>> that
>>>>> we don't support FP.
>>>>> 
>>>>> Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
>>>>> for tasks which may have them set, as we would have done in the 
>>>>> normal
>>>>> case, but avoiding touching the hardware state (since we don't 
>>>>> support any).
>>>>> 
>>>>> Also to make sure we handle the cases seemlessly we categorise the
>>>>> helper functions to two :
>>>>>  1) Helpers for common core code, which calls into take appropriate
>>>>>     actions without knowing the current FPSIMD state of the 
>>>>> CPU/task.
>>>>> 
>>>>>     e.g fpsimd_restore_current_state(), fpsimd_flush_task_state(),
>>>>>         fpsimd_save_and_flush_cpu_state().
>>>>> 
>>>>>     We bail out early for these functions, taking any appropriate 
>>>>> actions
>>>>>     (e.g, clearing the TIF flag) where necessary to hide the 
>>>>> handling
>>>>>     from core code.
>>>>> 
>>>>>  2) Helpers used when the presence of FP/SIMD is apparent.
>>>>>     i.e, save/restore the FP/SIMD register state, modify the 
>>>>> CPU/task
>>>>>     FP/SIMD state.
>>>>>     e.g,
>>>>> 
>>>>>     fpsimd_save(), task_fpsimd_load() - save/restore task FP/SIMD 
>>>>> registers
>>>>> 
>>>>>     fpsimd_bind_task_to_cpu()  \
>>>>>                                 - Update the "state" metadata for 
>>>>> CPU/task.
>>>>>     fpsimd_bind_state_to_cpu() /
>>>>> 
>>>>>     fpsimd_update_current_state() - Update the fp/simd state for 
>>>>> the current
>>>>>                                     task from memory.
>>>>> 
>>>>>     These must not be called in the absence of FP/SIMD. Put in a 
>>>>> WARNING
>>>>>     to make sure they are not invoked in the absence of FP/SIMD.
>>>>> 
>>>>> KVM also uses the TIF_FOREIGN_FPSTATE flag to manage the FP/SIMD 
>>>>> state
>>>>> on the CPU. However, without FP/SIMD support we trap all accesses 
>>>>> and
>>>>> inject undefined instruction. Thus we should never "load" guest 
>>>>> state.
>>>>> Add a sanity check to make sure this is valid.
>>>> Yes, but no, see below.
>>>> 
>>>>> 
>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> No idea who that guy is. It's a fake! ;-)
>>> 
>>> Sorry about that, will fix it.
>>> 
>>>> 
>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> ---
>>>>>  arch/arm64/kernel/fpsimd.c  | 31 +++++++++++++++++++++++++++----
>>>>>  arch/arm64/kvm/hyp/switch.c |  9 +++++++++
>>>>>  2 files changed, 36 insertions(+), 4 deletions(-)
>>>>> 
>>>> [...]
>>>> 
>>>>> diff --git a/arch/arm64/kvm/hyp/switch.c 
>>>>> b/arch/arm64/kvm/hyp/switch.c
>>>>> index 72fbbd86eb5e..9696ebb5c13a 100644
>>>>> --- a/arch/arm64/kvm/hyp/switch.c
>>>>> +++ b/arch/arm64/kvm/hyp/switch.c
>>>>> @@ -28,10 +28,19 @@
>>>>>  /* Check whether the FP regs were dirtied while in the host-side 
>>>>> run
>>>>> loop: */
>>>>>  static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
>>>>>  {
>>>>> +    /*
>>>>> +     * When the system doesn't support FP/SIMD, we cannot rely on
>>>>> +     * the state of _TIF_FOREIGN_FPSTATE. However, we will never
>>>>> +     * set the KVM_ARM64_FP_ENABLED, as the FP/SIMD accesses 
>>>>> always
>>>>> +     * inject an abort into the guest. Thus we always trap the
>>>>> +     * accesses.
>>>>> +     */
>>>>>      if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
>>>>>          vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
>>>>>                        KVM_ARM64_FP_HOST);
>>>>> 
>>>>> +    WARN_ON(!system_supports_fpsimd() &&
>>>>> +        (vcpu->arch.flags & KVM_ARM64_FP_ENABLED));
>>>> Careful, this will panic the host if it happens on a !VHE host
>>>> (calling non-inline stuff from a __hyp_text function is usually
>>>> not a good idea).
>>> 
>>> Ouch! Sorry about that WARN_ON()! I could drop the warning and
>>> make this :
>>> 
>>> if (!system_supports_fpsimd() ||
>>>     (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE))
>>>     vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
>>>                   KVM_ARM64_FP_HOST);
>>> 
>>> to make sure we never say fp is enabled.
>>> 
>>> What do you think ?
>> 
>> Sure, that would work. I can't really see how KVM_ARM64_FP_ENABLED
> 
> Thanks I have fixed this locally now.
> 
>> would get set though. But it probably doesn't matter (WTF is going
> 
> Right. That cannot be set to begin with, as the first access to FP/SIMD
> injects an abort back to the guest, which is why I added a WARN() to
> begin with.
> 
> Just wanted to be extra safe.
> 
>> to run KVM with such broken HW?), and better safe than sorry.
> 
> Right, with no COMPAT KVM support it is really hard to get this far.

So with the above fix:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
