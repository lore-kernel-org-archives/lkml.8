Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655CFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D139206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBozcdxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgEFIRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:17:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728217AbgEFIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588753038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xS/VsQIrf9pi+XL1Epo3nFIdOG1XWNf591vQGhiBo2A=;
        b=JBozcdxggfN0pMpr4hzzK6vEJHVOTqr9rGqHaLyJ42HPFuR2/9DnWjWkcsdInNpjuJmC7h
        k2P2/WLzZeYxGUaf3fXByuOrrmEJRRvg6MfasJEemK0rRjO46gjH7A8sTYwuWURhbT3hmk
        p0H7aKtsXT8o4WiPCxCKyLZwreVsFM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-zeDjKpcINZ612fVEVPtPKg-1; Wed, 06 May 2020 04:17:14 -0400
X-MC-Unique: zeDjKpcINZ612fVEVPtPKg-1
Received: by mail-wr1-f72.google.com with SMTP id g10so917657wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xS/VsQIrf9pi+XL1Epo3nFIdOG1XWNf591vQGhiBo2A=;
        b=USSLTyYIAFsCSELd3Y3oh7QmxNnmWdBG7mtP0GDL8fqrK6i4gbC36kkrhsUlLhS+dC
         pbVJSBGoYQHduXweJB66Hk3dkfZ8GGtuOobHKc4uWwO1iAqozAnb2AEG8QeTqISy3Rrt
         d49K2NV9pp2XbXULylXZ5tbtYd8zA7FfbjLw3iQbmTYwm6AOHs5pCIUjkRmTNaAceATr
         zbTI6T/hWPNRfkPGLh8Nzx2dWR2lHLH0edIlA3Nolq0e/2z1HGvoU9xz+NfWHD16AMKH
         bRptph+lSc1BGZokvCMfvj9HiST9wtFUDRI3nbeGINTHysJWIab0FzLU4dr8BBRelZwm
         ojwA==
X-Gm-Message-State: AGi0PuZUD6AdeBghZ2r/jpkSHq6KBC53MRCdT7dyl+J9b5dolOPgs8sY
        CqiijSMX1qBsuofeGBWhxHzs1da12ahELMd0jfHPC10VrwXGAxsy5DoHDVtuozHF6Ng/6+/xOtx
        0GHcaJrtjDFWd5qDjMfol9jiD
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr2932820wmb.75.1588753033376;
        Wed, 06 May 2020 01:17:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3TSis+O9q/ERs839RPx/dho0l9F3vlL4AQgND2HXbI9kI8SOzd/9mohF7xXrJQfqu2UYXWA==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr2932788wmb.75.1588753033096;
        Wed, 06 May 2020 01:17:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id a205sm1896308wmh.29.2020.05.06.01.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 01:17:12 -0700 (PDT)
Subject: Re: [patch V4 part 2 18/18] x86/kvm/svm: Move guest enter/exit into
 .noinstr.text
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505134112.272268764@linutronix.de>
 <20200505134341.873785437@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55792329-b457-8bc6-f102-2501aafd16be@redhat.com>
Date:   Wed, 6 May 2020 10:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.873785437@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:41, Thomas Gleixner wrote:
> Move the functions which are inside the RCU off region into the
> non-instrumentable text section.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm/svm.c     |  102 ++++++++++++++++++++++++---------------------
>  arch/x86/kvm/svm/vmenter.S |    2 
>  2 files changed, 57 insertions(+), 47 deletions(-)
> 
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3278,6 +3278,61 @@ static void svm_cancel_injection(struct
>  
>  void __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
>  
> +static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> +					struct vcpu_svm *svm)
> +{
> +	/*
> +	 * VMENTER enables interrupts (host state), but the kernel state is
> +	 * interrupts disabled when this is invoked. Also tell RCU about
> +	 * it. This is the same logic as for exit_to_user_mode().
> +	 *
> +	 * 1) Trace interrupts on state
> +	 * 2) Prepare lockdep with RCU on
> +	 * 3) Invoke context tracking if enabled to adjust RCU state
> +	 * 4) Tell lockdep that interrupts are enabled
> +	 *
> +	 * This has to be after x86_spec_ctrl_set_guest() because that can
> +	 * take locks (lockdep needs RCU) and calls into world and some
> +	 * more.
> +	 */
> +	instr_begin();
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> +	instr_end();
> +	guest_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
> +	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
> +
> +#ifdef CONFIG_X86_64
> +	native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
> +#else
> +	loadsegment(fs, svm->host.fs);
> +#ifndef CONFIG_X86_32_LAZY_GS
> +	loadsegment(gs, svm->host.gs);
> +#endif
> +#endif
> +
> +	/*
> +	 * VMEXIT disables interrupts (host state, see the CLI in the ASM
> +	 * above), but tracing and lockdep have them in state 'on'. Same as
> +	 * enter_from_user_mode().
> +	 *
> +	 * 1) Tell lockdep that interrupts are disabled
> +	 * 2) Invoke context tracking if enabled to reactivate RCU
> +	 * 3) Trace interrupts off state
> +	 *
> +	 * This needs to be done before the below as native_read_msr()
> +	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> +	 * into world and some more.
> +	 */
> +	lockdep_hardirqs_off(CALLER_ADDR0);
> +	guest_exit_irqoff();
> +	instr_begin();
> +	trace_hardirqs_off_prepare();
> +	instr_end();
> +}
> +
>  static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -3330,52 +3385,7 @@ static void svm_vcpu_run(struct kvm_vcpu
>  	 */
>  	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
>  
> -	/*
> -	 * VMENTER enables interrupts (host state), but the kernel state is
> -	 * interrupts disabled when this is invoked. Also tell RCU about
> -	 * it. This is the same logic as for exit_to_user_mode().
> -	 *
> -	 * 1) Trace interrupts on state
> -	 * 2) Prepare lockdep with RCU on
> -	 * 3) Invoke context tracking if enabled to adjust RCU state
> -	 * 4) Tell lockdep that interrupts are enabled
> -	 *
> -	 * This has to be after x86_spec_ctrl_set_guest() because that can
> -	 * take locks (lockdep needs RCU) and calls into world and some
> -	 * more.
> -	 */
> -	trace_hardirqs_on_prepare();
> -	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> -	guest_enter_irqoff();
> -	lockdep_hardirqs_on(CALLER_ADDR0);
> -
> -	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
> -
> -#ifdef CONFIG_X86_64
> -	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
> -#else
> -	loadsegment(fs, svm->host.fs);
> -#ifndef CONFIG_X86_32_LAZY_GS
> -	loadsegment(gs, svm->host.gs);
> -#endif
> -#endif
> -
> -	/*
> -	 * VMEXIT disables interrupts (host state, see the CLI in the ASM
> -	 * above), but tracing and lockdep have them in state 'on'. Same as
> -	 * enter_from_user_mode().
> -	 *
> -	 * 1) Tell lockdep that interrupts are disabled
> -	 * 2) Invoke context tracking if enabled to reactivate RCU
> -	 * 3) Trace interrupts off state
> -	 *
> -	 * This needs to be done before the below as native_read_msr()
> -	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> -	 * into world and some more.
> -	 */
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> -	guest_exit_irqoff();
> -	trace_hardirqs_off_prepare();
> +	svm_vcpu_enter_exit(vcpu, svm);
>  
>  	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S
> @@ -27,7 +27,7 @@
>  #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
>  #endif
>  
> -	.text
> +.section .noinstr.text, "ax"
>  
>  /**
>   * __svm_vcpu_run - Run a vCPU via a transition to SVM guest mode
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

