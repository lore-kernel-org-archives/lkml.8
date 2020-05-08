Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE1CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F09208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uy6xu+Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEHNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:45:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgEHNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588945527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cvO1MNDWTrpGEavzHVto++mtvCyR8HPo6ImKDZslJs=;
        b=Uy6xu+RyofSE19DCxCHLgRgsrXR/es3t0oYG/K4d0zsBkBiIau89iuFFI8VMLiBwbJnXgK
        pcK2CcahT98tdVDY0V/VroH8lAzIadRyyOaXz3qXT4oa5apwa7Ef6MH6aorC5oe5yWa8MA
        +HIIhwcsWPFd+W3SgXlmSNyoNLeqJwY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Q_15Jy6LNzyq_gzs_TXtBA-1; Fri, 08 May 2020 09:45:24 -0400
X-MC-Unique: Q_15Jy6LNzyq_gzs_TXtBA-1
Received: by mail-wm1-f72.google.com with SMTP id s12so5168291wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6cvO1MNDWTrpGEavzHVto++mtvCyR8HPo6ImKDZslJs=;
        b=Uaa6glTswcEB8eFiq3PXOH5briQlujVchcwRzO7l9XPKAKg+Q5MZjIk3R40Iv54I4E
         XU+dDxScTT7YrJMWhNFLN+37eKO57vUa87cTN5cNPWoZ0upSKsnP4ti8Ey2BrfkGY/GQ
         TLMXLNiEhK1Aa9TEFoYBwpv21P2o6PtORi23yx4DbduTTBplUvomlx4hPheesvOqqxFo
         a1cFFKdIoBnyS3mjjuMKcqQjl8z9QyLz3UCXFZXtS8HwNDyrUBtsKzVgBSQptDJh4NIM
         HM6y3T+q8Ct4KlWTlEAPt0UsbLOGBdrn+S3jumBOGc4EaL9jNabkkLyQtFGatVjuV2X3
         5dyQ==
X-Gm-Message-State: AGi0PuZQXOJgdWW9CLKsO8ZvVPOKxKVTuekXK2vZXfJaKUdgCxkxQ74j
        6kA0OAmsvaFOMudXmXgJTon8KlPsDlSdyNRE4WrnL1SvJKXNktrcCUqppDEaLLF7njvCVKl1GnW
        cZWZ6YwSlSIAFNUhqs+1JaPmm
X-Received: by 2002:a1c:6389:: with SMTP id x131mr17025901wmb.155.1588945523335;
        Fri, 08 May 2020 06:45:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPFiEzUexjeH9dMzXIAQCclZONIAQLACp8kFw5j8EZx7aGf0m5M7iPE2qhV3RaR3ghDmkXvA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr17025742wmb.155.1588945522143;
        Fri, 08 May 2020 06:45:22 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.138])
        by smtp.gmail.com with ESMTPSA id s18sm3410682wra.94.2020.05.08.06.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 06:45:21 -0700 (PDT)
Subject: Re: [patch V5 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on
 guest enter/exit
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
 <20200505134341.579034898@linutronix.de>
 <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com>
 <87imh9o3e1.fsf@nanos.tec.linutronix.de>
 <cade8b44-4330-2dc1-e490-c2f001cc1c95@redhat.com>
 <875zd7g5zb.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf4c1124-836e-2903-401a-7ced619371ac@redhat.com>
Date:   Fri, 8 May 2020 15:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zd7g5zb.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 16:44, Thomas Gleixner wrote:
> Entering guest mode is more or less the same as returning to user
> space. From an instrumentation point of view both leave kernel mode and the
> transition to guest or user mode reenables interrupts on the host. In user
> mode an interrupt is served directly and in guest mode it causes a VM exit
> which then handles or reinjects the interrupt.
> 
> The transition from guest mode or user mode to kernel mode disables
> interrupts, which needs to be recorded in instrumentation to set the
> correct state again.
> 
> This is important for e.g. latency analysis because otherwise the execution
> time in guest or user mode would be wrongly accounted as interrupt disabled
> and could trigger false positives.
> 
> Add hardirq tracing to guest enter/exit functions in the same way as it
> is done in the user mode enter/exit code, respecting the RCU requirements.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> V5: Adjust comments and changelog

Apart from the subject being svm and not vmx, it looks great.  Thanks!

Paolo

> ---
>  arch/x86/kvm/vmx/vmx.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6604,9 +6604,21 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
>  
>  	/*
> -	 * Tell context tracking that this CPU is about to enter guest mode.
> +	 * VMENTER enables interrupts (host state), but the kernel state is
> +	 * interrupts disabled when this is invoked. Also tell RCU about
> +	 * it. This is the same logic as for exit_to_user_mode().
> +	 *
> +	 * This ensures that e.g. latency analysis on the host observes
> +	 * guest mode as interrupt enabled.
> +	 *
> +	 * guest_enter_irqoff() informs context tracking about the
> +	 * transition to guest mode and if enabled adjusts RCU state
> +	 * accordingly.
>  	 */
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	guest_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>  
>  	/* L1D Flush includes CPU buffer clear to mitigate MDS */
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
> @@ -6623,9 +6635,20 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	vcpu->arch.cr2 = read_cr2();
>  
>  	/*
> -	 * Tell context tracking that this CPU is back.
> +	 * VMEXIT disables interrupts (host state), but tracing and lockdep
> +	 * have them in state 'on' as recorded before entering guest mode.
> +	 * Same as enter_from_user_mode().
> +	 *
> +	 * guest_exit_irqoff() restores host context and reinstates RCU if
> +	 * enabled and required.
> +	 *
> +	 * This needs to be done before the below as native_read_msr()
> +	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> +	 * into world and some more.
>  	 */
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>  	guest_exit_irqoff();
> +	trace_hardirqs_off_prepare();
>  
>  	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
> 

