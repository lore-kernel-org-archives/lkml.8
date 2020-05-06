Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C34C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6BB2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V228Mktb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgEFHmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:42:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728355AbgEFHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588750950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pt9RXBz5Ep4eVnWUkQ01hiUS0JziYDC4pseXUe01Hb8=;
        b=V228MktblyfjVGNPivZDJjuzDiGOJLRrFVXON6vBKwjX0+Re4zTGB5/heOVu7mj8gE+rrF
        vuqg9ORYlC6uH2U+OP+h5QAivqbZslB7hIriVxfiKPSoBz2wLd6cHwpVI1pP/T/fZetPm5
        gGKKrNNAn2+bdzzXjlxMnkuig5YbRF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-i_Er50tzNG6Kw9ZalBp9Mg-1; Wed, 06 May 2020 03:42:26 -0400
X-MC-Unique: i_Er50tzNG6Kw9ZalBp9Mg-1
Received: by mail-wr1-f70.google.com with SMTP id f15so886964wrj.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pt9RXBz5Ep4eVnWUkQ01hiUS0JziYDC4pseXUe01Hb8=;
        b=ScmxMdWC2r9OPCZViqNkQlbwXAEnC+JGf/pecghILYoeWa5H42pVuAd9MWcyYcjW/X
         W3jcG8B7iWt6D+cIXAhXQduXI9XGZspo7MaBzdVhqLddbKe5vETBcwTghHcW6iKJaIyv
         KnuZi0kzbxNIToYbwXOqFYVOqsbU5XICxG8N/6CfaFUmg7FNjqtkPNdi73FMvobLJ6hy
         Xy+0MyPYsDHz2But/YaJCgk1y7gfoKz794gxJaE00VkW84UtgXRSdloYO2FTwFbFpsan
         feek3XMXsLn+3fCdPwEXwf/8atisJCT+otXdVhXcJCn04fpf/p/VMk1ELDsUnXANQDZv
         kHJg==
X-Gm-Message-State: AGi0Pub7CjvH9k9UQf5tDA8+s5mJNNNlrnx58Of/5nnGZL33qb8vzgnM
        N09QWh0fEpz/4Pet0JFm7pvhANnf5071L9nJAbqZqdlumfTsTQusapls9nUr2FiooT2trdFcumi
        7DMqzkuofrBSNY6rix80Sn5/q
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr3103882wmm.174.1588750944764;
        Wed, 06 May 2020 00:42:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+qR8ZPEaoljOyEFw1F3+9x2QEJKI3lLW0+HlP3Zb8tDQkS1g2NiDw0Qhm9P150KGF45+YWQ==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr3103862wmm.174.1588750944516;
        Wed, 06 May 2020 00:42:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id e5sm1288140wru.92.2020.05.06.00.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:42:23 -0700 (PDT)
Subject: Re: [patch V4 part 2 13/18] x86/kvm: Move context tracking where it
 belongs
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
 <20200505134341.379326289@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02c12ed7-6a7c-9526-cd75-827d2f56bfaa@redhat.com>
Date:   Wed, 6 May 2020 09:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.379326289@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:41, Thomas Gleixner wrote:
> Context tracking for KVM happens way too early in the vcpu_run()
> code. Anything after guest_enter_irqoff() and before guest_exit_irqoff()
> cannot use RCU and should also be not instrumented.
> 
> The current way of doing this covers way too much code. Move it closer to
> the actual vmenter/exit code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm/svm.c |   16 ++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c |   10 ++++++++++
>  arch/x86/kvm/x86.c     |    2 --
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3330,6 +3330,14 @@ static void svm_vcpu_run(struct kvm_vcpu
>  	 */
>  	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
>  
> +	/*
> +	 * Tell context tracking that this CPU is about to enter guest
> +	 * mode. This has to be after x86_spec_ctrl_set_guest() because
> +	 * that can take locks (lockdep needs RCU) and calls into world and
> +	 * some more.
> +	 */
> +	guest_enter_irqoff();
> +
>  	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
>  
>  #ifdef CONFIG_X86_64
> @@ -3340,6 +3348,14 @@ static void svm_vcpu_run(struct kvm_vcpu
>  	loadsegment(gs, svm->host.gs);
>  #endif
>  #endif
> +	/*
> +	 * Tell context tracking that this CPU is back.
> +	 *
> +	 * This needs to be done before the below as native_read_msr()
> +	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> +	 * into world and some more.
> +	 */
> +	guest_exit_irqoff();
>  
>  	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6603,6 +6603,11 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	 */
>  	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
>  
> +	/*
> +	 * Tell context tracking that this CPU is about to enter guest mode.
> +	 */
> +	guest_enter_irqoff();
> +
>  	/* L1D Flush includes CPU buffer clear to mitigate MDS */
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
>  		vmx_l1d_flush(vcpu);
> @@ -6618,6 +6623,11 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	vcpu->arch.cr2 = read_cr2();
>  
>  	/*
> +	 * Tell context tracking that this CPU is back.
> +	 */
> +	guest_exit_irqoff();
> +
> +	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
>  	 * SPEC_CTRL MSR it may have left it on; save the value and
>  	 * turn it off. This is much more efficient than blindly adding
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8404,7 +8404,6 @@ static int vcpu_enter_guest(struct kvm_v
>  	}
>  
>  	trace_kvm_entry(vcpu->vcpu_id);
> -	guest_enter_irqoff();
>  
>  	fpregs_assert_state_consistent();
>  	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> @@ -8467,7 +8466,6 @@ static int vcpu_enter_guest(struct kvm_v
>  	local_irq_disable();
>  	kvm_after_interrupt(vcpu);
>  
> -	guest_exit_irqoff();
>  	if (lapic_in_kernel(vcpu)) {
>  		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;
>  		if (delta != S64_MIN) {
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

