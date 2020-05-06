Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C660206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKlj2sHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgEFHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728317AbgEFHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588751726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5r8cUH87Cm8pn1J05aD8IU2r+ddBiUrzbcyrQ1rqlY=;
        b=dKlj2sHvdCRotAUu6obIPOpzOhMz2x6P9GgOumXUl5uymjpQbbM6aViYWhlKZlXayllF7S
        tBwKxjOTDQv1pEnKgqHZfqAwgkIeZojCN+w89gkkuQNv+ZFsSN7yeEBTB8a2YjuK6ksA7c
        ZsdtykmnqTUufM90PDV37APeWJ61GQY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-zq3Y9ouJMZW_arB2IhDVQw-1; Wed, 06 May 2020 03:55:24 -0400
X-MC-Unique: zq3Y9ouJMZW_arB2IhDVQw-1
Received: by mail-wr1-f71.google.com with SMTP id v17so887155wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5r8cUH87Cm8pn1J05aD8IU2r+ddBiUrzbcyrQ1rqlY=;
        b=TqFsZYPluXO72CmrvE2cgHxIL5Pa5SwrgnbX9gofNIyYjdwLOG39s/iFXvMzxeAoNH
         QzXmNwtHJYE70y50Of4h76HXmbJlwpS+O/xB/RIxcEVyfw2D+OOr7hfNq/N52LdiRIfu
         ie39nxwYhK4pDEuirnXBpyT1Cgn3Mcozzgo8RTVEFBU1tZsCzHTOfyFvbuniCfPE2QNb
         d1usTmzq1ldiEN5f6i5inxkAf+S7AKpHREmVD/E2jTLShHelPDN821fdw8VFOO702cJJ
         Er3xu4nC/xpx/wrWgdcQeEkXeE+lS+pPWsUQKXKs1+DlI+3SJn5M6pgxJeZ3p4c2UJvc
         kKzQ==
X-Gm-Message-State: AGi0Puae1aCWHxk+XQKn+xQ+G/z122zfuxUQDbjjynUtroSf4Tx4mtfo
        Bk0eWOBx2eG0Du570zx8YLO0AHE+6v0yXhkqyay543tbyiIypoh9DSeVYbaBiIegUPf+UCr/29n
        wfpQ7mSbAbND15zHqtWCFP9Lo
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr8688810wrh.254.1588751723674;
        Wed, 06 May 2020 00:55:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypIL+Ft4xqYKYiJ9ce/pssPSPl7vb4LMqt0EzMtrAHXoiKlJ7M20A89Huk0ZnMTW4xaQoVcVLA==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr8688777wrh.254.1588751723416;
        Wed, 06 May 2020 00:55:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id n12sm1483755wrj.95.2020.05.06.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:55:22 -0700 (PDT)
Subject: Re: [patch V4 part 2 14/18] x86/kvm/vmx: Add hardirq tracing to guest
 enter/exit
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
 <20200505134341.471542318@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6217b923-fc1b-29c3-cab7-04b7d2d6a0fb@redhat.com>
Date:   Wed, 6 May 2020 09:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.471542318@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:41, Thomas Gleixner wrote:
> Add hardirq tracing to guest enter/exit functions in the same way as it
> is done in the user mode enter/exit code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c |   25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6604,9 +6604,19 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
>  
>  	/*
> -	 * Tell context tracking that this CPU is about to enter guest mode.
> +	 * VMENTER enables interrupts (host state), but the kernel state is
> +	 * interrupts disabled when this is invoked. Also tell RCU about
> +	 * it. This is the same logic as for exit_to_user_mode().
> +	 *
> +	 * 1) Trace interrupts on state
> +	 * 2) Prepare lockdep with RCU on
> +	 * 3) Invoke context tracking if enabled to adjust RCU state
> +	 * 4) Tell lockdep that interrupts are enabled
>  	 */
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	guest_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>  
>  	/* L1D Flush includes CPU buffer clear to mitigate MDS */
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
> @@ -6623,9 +6633,20 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	vcpu->arch.cr2 = read_cr2();
>  
>  	/*
> -	 * Tell context tracking that this CPU is back.
> +	 * VMEXIT disables interrupts (host state), but tracing and lockdep
> +	 * have them in state 'on'. Same as enter_from_user_mode().
> +	 *
> +	 * 1) Tell lockdep that interrupts are disabled
> +	 * 2) Invoke context tracking if enabled to reactivate RCU
> +	 * 3) Trace interrupts off state
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

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

