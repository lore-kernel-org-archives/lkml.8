Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B946C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1112078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7wPsDGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgCaPDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:03:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730391AbgCaPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585666991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuC5qdyP+Hb7LJ96xDW130ZCvd2QXz6VBqm++Yqquzk=;
        b=c7wPsDGl6eG6ySeuNzTU9mV86zAZ4ucD5x41Jzavd4bBQRexakN/OAGVGkENDtiAV9DYFt
        rgXdMrF5z4YQBiLIO2lcYltoDruEvbD+8eS7ybE0H3EE2O+FocnfRPVohQiUcVepgi1fWs
        EyzVXtOUWUD1lwh/KpyP6TOOY9uNipg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-VV0FLrUTNOWoxFLWwsyw6Q-1; Tue, 31 Mar 2020 11:03:09 -0400
X-MC-Unique: VV0FLrUTNOWoxFLWwsyw6Q-1
Received: by mail-wm1-f69.google.com with SMTP id z24so264700wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OuC5qdyP+Hb7LJ96xDW130ZCvd2QXz6VBqm++Yqquzk=;
        b=qB/bS1Bb6d9xez43hbDOOMBqHJufLVE+cK0VN+gtV0ripuhniwH8uFEiJNhX5tJElW
         Vo/dIsxN2c3TP1/BkgRfb72iY0U+1kn2Ejmu9mjf3KQcDHTnYkfhFCId7vWQQ1cV7vwr
         rUwPP0QjLpfgzJ/pseCuSerBdUx56pnj2SGklpHU225jv2lFlg9lm1kwo98DqPEVMsGV
         haHh25huN24rLRQT3E0BXqWbiJfBWyAMr6jfX4CvJZyIzbAS4APvlkY/jPk9+xdJT03+
         AQmKhMbMSXCme7MSf2axHT4UGIAgIZlJKnUnhwjIG/t/0AwyQYJEc/Pjkr/DEAHaFlzx
         +tIA==
X-Gm-Message-State: ANhLgQ2Qf8cP7Ducj3OrnkFc4DnhgGn7z6Bky1LRSHI6NeFwB7C2dNno
        cNgCtUHgsldP3LfRYcDSEWTi/TdVk1F4e3EWHVSvVAI4eh1xVmUKpQLoYLLInZK07Y5WLnMzzv6
        NCm8/8PINlnAlhCB3ji7b0OTV
X-Received: by 2002:adf:f386:: with SMTP id m6mr21147563wro.107.1585666987780;
        Tue, 31 Mar 2020 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvUiwF3Dh/Ba/C78xkoltocbrQ7LmtXMcA3X07xNZYC6YzSnEp8XcvSsoRfiwetNJ3xcydXYw==
X-Received: by 2002:adf:f386:: with SMTP id m6mr21147525wro.107.1585666987478;
        Tue, 31 Mar 2020 08:03:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id k185sm4320487wmb.7.2020.03.31.08.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 08:03:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Add a trampoline to fix VMREAD error handling
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200326160712.28803-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <140483ed-f1f9-067e-6b60-eccd7115bb0d@redhat.com>
Date:   Tue, 31 Mar 2020 17:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326160712.28803-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 17:07, Sean Christopherson wrote:
> Add a hand coded assembly trampoline to preserve volatile registers
> across vmread_error(), and to handle the calling convention differences
> between 64-bit and 32-bit due to asmlinkage on vmread_error().  Pass
> @field and @fault on the stack when invoking the trampoline to avoid
> clobbering volatile registers in the context of the inline assembly.
> 
> Calling vmread_error() directly from inline assembly is partially broken
> on 64-bit, and completely broken on 32-bit.  On 64-bit, it will clobber
> %rdi and %rsi (used to pass @field and @fault) and any volatile regs
> written by vmread_error().  On 32-bit, asmlinkage means vmread_error()
> expects the parameters to be passed on the stack, not via regs.
> 
> Opportunistically zero out the result in the trampoline to save a few
> bytes of code for every VMREAD.  A happy side effect of the trampoline
> is that the inline code footprint is reduced by three bytes on 64-bit
> due to PUSH/POP being more efficent (in terms of opcode bytes) than MOV.
> 
> Fixes: 6e2020977e3e6 ("KVM: VMX: Add error handling to VMREAD helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Becuase there just isn't enough custom assembly in VMX :-)
> 
> Simply reverting isn't a great option because we'd lose error reporting
> for VMREAD failure, i.e. it'd return garbage with no other indication that
> something went awry.
> 
> Tested all paths (fail, fault w/o rebooting, fault w/ rebooting) on both
> 64-bit and 32-bit.
> 
>  arch/x86/kvm/vmx/ops.h     | 28 +++++++++++++-----
>  arch/x86/kvm/vmx/vmenter.S | 58 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
> index 45eaedee2ac0..09b0937d56b1 100644
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -12,7 +12,8 @@
>  
>  #define __ex(x) __kvm_handle_fault_on_reboot(x)
>  
> -asmlinkage void vmread_error(unsigned long field, bool fault);
> +__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
> +							 bool fault);
>  void vmwrite_error(unsigned long field, unsigned long value);
>  void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
>  void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
> @@ -70,15 +71,28 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
>  	asm volatile("1: vmread %2, %1\n\t"
>  		     ".byte 0x3e\n\t" /* branch taken hint */
>  		     "ja 3f\n\t"
> -		     "mov %2, %%" _ASM_ARG1 "\n\t"
> -		     "xor %%" _ASM_ARG2 ", %%" _ASM_ARG2 "\n\t"
> -		     "2: call vmread_error\n\t"
> -		     "xor %k1, %k1\n\t"
> +
> +		     /*
> +		      * VMREAD failed.  Push '0' for @fault, push the failing
> +		      * @field, and bounce through the trampoline to preserve
> +		      * volatile registers.
> +		      */
> +		     "push $0\n\t"
> +		     "push %2\n\t"
> +		     "2:call vmread_error_trampoline\n\t"
> +
> +		     /*
> +		      * Unwind the stack.  Note, the trampoline zeros out the
> +		      * memory for @fault so that the result is '0' on error.
> +		      */
> +		     "pop %2\n\t"
> +		     "pop %1\n\t"
>  		     "3:\n\t"
>  
> +		     /* VMREAD faulted.  As above, except push '1' for @fault. */
>  		     ".pushsection .fixup, \"ax\"\n\t"
> -		     "4: mov %2, %%" _ASM_ARG1 "\n\t"
> -		     "mov $1, %%" _ASM_ARG2 "\n\t"
> +		     "4: push $1\n\t"
> +		     "push %2\n\t"
>  		     "jmp 2b\n\t"
>  		     ".popsection\n\t"
>  		     _ASM_EXTABLE(1b, 4b)
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 81ada2ce99e7..861ae40e7144 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -234,3 +234,61 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  2:	mov $1, %eax
>  	jmp 1b
>  SYM_FUNC_END(__vmx_vcpu_run)
> +
> +/**
> + * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
> + * @field:	VMCS field encoding that failed
> + * @fault:	%true if the VMREAD faulted, %false if it failed
> +
> + * Save and restore volatile registers across a call to vmread_error().  Note,
> + * all parameters are passed on the stack.
> + */
> +SYM_FUNC_START(vmread_error_trampoline)
> +	push %_ASM_BP
> +	mov  %_ASM_SP, %_ASM_BP
> +
> +	push %_ASM_AX
> +	push %_ASM_CX
> +	push %_ASM_DX
> +#ifdef CONFIG_X86_64
> +	push %rdi
> +	push %rsi
> +	push %r8
> +	push %r9
> +	push %r10
> +	push %r11
> +#endif
> +#ifdef CONFIG_X86_64
> +	/* Load @field and @fault to arg1 and arg2 respectively. */
> +	mov 3*WORD_SIZE(%rbp), %_ASM_ARG2
> +	mov 2*WORD_SIZE(%rbp), %_ASM_ARG1
> +#else
> +	/* Parameters are passed on the stack for 32-bit (see asmlinkage). */
> +	push 3*WORD_SIZE(%ebp)
> +	push 2*WORD_SIZE(%ebp)
> +#endif
> +
> +	call vmread_error
> +
> +#ifndef CONFIG_X86_64
> +	add $8, %esp
> +#endif
> +
> +	/* Zero out @fault, which will be popped into the result register. */
> +	_ASM_MOV $0, 3*WORD_SIZE(%_ASM_BP)
> +
> +#ifdef CONFIG_X86_64
> +	pop %r11
> +	pop %r10
> +	pop %r9
> +	pop %r8
> +	pop %rsi
> +	pop %rdi
> +#endif
> +	pop %_ASM_DX
> +	pop %_ASM_CX
> +	pop %_ASM_AX
> +	pop %_ASM_BP
> +
> +	ret
> +SYM_FUNC_END(vmread_error_trampoline)
> 

Queued, thanks.

Paolo

