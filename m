Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F995206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMzw4Gh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEFIPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728296AbgEFIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588752919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfSNjMAczK/vunc2EyYGtUJbLDjhm05Sh49fgsqRIek=;
        b=VMzw4Gh6YTZeVMYY4oAdtlrdFVkkaF4khDUNbYUn9oLfA2kR1zyTlfzjQaUyGmChYDU4yw
        fbEl7aguT+4KYWQHqRIyuWnyEwUecmoqvvAvkl/BpwKY2Agfh0PK3cafiABLJ3GJTu7LMX
        Uqz34F8KbdJMEoLW/NsOAxT6XUSpGH0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-lj0Qkg72MfGhwRd-1zlA0Q-1; Wed, 06 May 2020 04:15:14 -0400
X-MC-Unique: lj0Qkg72MfGhwRd-1zlA0Q-1
Received: by mail-wr1-f71.google.com with SMTP id h12so907122wrr.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IfSNjMAczK/vunc2EyYGtUJbLDjhm05Sh49fgsqRIek=;
        b=XJLJGKRSRvUJ3izAAikKCV1oVHV2+GMln7BJF7BVL1HEKAWbEZoIf3Up1jv3TKFRSI
         P+hVj50OGqSFAjAjj41EpmsuqfCTFq7OgTH5XwdB/udUOYNKHTtG9av24auGTZgq9QqY
         0Mt1GcjOoQROk8XZdz6GAXykM/GNNhPnZY1i3oE3zKUy5YTyLj8d1vdrslS31ssO2l1b
         5+9q3W+sl109so4WqeG0yYDSGDSTsyLPK4wLhTce81fiwOAzJSbcxVrQ1PkqUBt8fg6M
         rkNkmFfuCJMLpLN+tPYs/57WdX3UKyU/Y508PqKvwKbir8T9xnaw7fQOvZjJ1LJ2ok7R
         LUYQ==
X-Gm-Message-State: AGi0PuY4YVV2QtDhWsVUXVSJktQ3sQ0lccjBD+VKzXC9RdMFfe/iuxJo
        5XUPA4INt5P/1SbsIP4ZZPZ1ARbaInxXTEXWeAF0R8gkwp2sg1fmJHkUFiG3cD5iM9eoOYlVkh9
        vqmB4WMS8/q9eJ1W9tNX/HWoU
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr3032086wme.42.1588752913353;
        Wed, 06 May 2020 01:15:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypItug0G7AbO026Lh+lHWKZctchEGslIv6vGZsWLqxAsXwKYuNIw+z+LdLuxhIMVrMy9WEaJtQ==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr3032040wme.42.1588752912997;
        Wed, 06 May 2020 01:15:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id n12sm1573561wrj.95.2020.05.06.01.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 01:15:12 -0700 (PDT)
Subject: Re: [patch V4 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com>
Date:   Wed, 6 May 2020 10:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.579034898@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:41, Thomas Gleixner wrote:
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
>  	 */
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	guest_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>  
>  	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
>  
> @@ -3348,14 +3359,23 @@ static void svm_vcpu_run(struct kvm_vcpu
>  	loadsegment(gs, svm->host.gs);
>  #endif
>  #endif
> +
>  	/*
> -	 * Tell context tracking that this CPU is back.
> +	 * VMEXIT disables interrupts (host state, see the CLI in the ASM
> +	 * above),

Apart from the small inaccuracy in that CLI has moved to vmenter.S, the
comments and commit message don't really help my understanding of why
this is needed.

It's true that interrupts cause a vmexit, and therefore from the
processor point of view it's as if they are enabled.  However, the
interrupt remains latched until local_irq_enable() in vcpu_enter_guest,
so from the point of view of the kernel interrupts are still disabled. I
don't understand why it's necessary to inform tracing and lockdep about
a processor-internal state that doesn't percolate up to the kernel.

For VMX indeed some care is necessary, because we the interrupt is eaten
rather than latched.  Therefore, we call the interrupt handler from
handle_external_interrupt_irqoff while EFLAGS.IF is still clear.
However, if informing trace and lockdep turns out to be unnecessary
after all for SVM, it should be okay (and clearer) to place the code in
handle_external_interrupt_irqoff (also in arch/x86/kvm/vmx/vmx.c) .

Instead, if I'm wrong, the four steps above are the same in code and
comment, and same for the three steps in the comment below.  Can you
replace them with the "why" of this change?

Thanks,

Paolo

> +      but tracing and lockdep have them in state 'on'. Same as
> +	 * enter_from_user_mode().
> +	 *
> +	 * 1) Tell lockdep that interrupts are disabled
> +	 * 2) Invoke context tracking if enabled to reactivate RCU
> +	 * 3) Trace interrupts off state
>  	 *
>  	 * This needs to be done before the below as native_read_msr()
>  	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
>  	 * into world and some more.
>  	 */
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>  	guest_exit_irqoff();
> +	trace_hardirqs_off_prepare();
>  

