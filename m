Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487EC20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DOYl1jEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:42:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:42:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so10745373qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+g+eXuYF8EBeAWaCkFiw7TSSKOlVsC3s99aW9CK/1rs=;
        b=DOYl1jEt35eGCVbJ5phB5c2CtExkCjMpi2pe8ev7eLLhSnyUxcJRuXen+D0PltOwfC
         K5AWf5qS1c/x6wR/7s5Louj0etFgY4vVnSpNO1wcU2Y+aW6pMHrNjqUnX8S0QpHWBdUB
         hq1mwbHv02cGwVkPzxBHscW4H8xkxkMik6JrdAb/mPnB9/KSZBfJKuJiGwRxPKZYSxMW
         GvHip3tbptdtMdXJLCWBGQ70VNAZ4fwCiXoMm4FBZ6tqNz/O87lXuB8KT9+ALutfJgao
         Vpge/R5OtJgvKUU/VTNKe46b7hqbAG3UVIrHsGZkDLQKlXBNUlkoApTfcOLjt7NercuX
         yzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+g+eXuYF8EBeAWaCkFiw7TSSKOlVsC3s99aW9CK/1rs=;
        b=OuIClvH1hfxn5q17rFN21C6WmwwiFuBYjO2gfN3mvJmnoMNILLUGVtYf7NQAZrhE1N
         tWP0ukVBXZ1v64njHjGFCHJsYgQpd61gV24Mfvx1S/ApxYKP3nqCPpQfXQIlParMTrF0
         UszaheAJcwdP3iyzoJzkWziANtNkeme2d1zFSRQ96VrmUiOUOv7gZ4hleHTiAPhTTaGN
         6bdq7Z0d0K4fX12UrLYBJwo3WQnDAZBQL+8f2dcr9OBKg5RaHXYh4qJilirTmzUUlJIf
         yTETohxZsdE5y2BlNsJrvhq84GnPOk1bGibwzE7heMGaHO+KsXrjvGx72E7Ya6oknj+f
         FYaw==
X-Gm-Message-State: AOAM5332Yp9Imb3VWeBeXuktm8CQ3LCDehSnL2e8YVA5my+M4pyWU7tB
        z5QVKGeWMfBPrHJcH3u5NUSt0A==
X-Google-Smtp-Source: ABdhPJxNXUbJzfrlHAfxIgbwkphAGjbAtuADXWnGR87zjBrsOu++puXM3djeHfpqeUmVqEavYCCWfg==
X-Received: by 2002:ac8:7111:: with SMTP id z17mr27946896qto.187.1591108962680;
        Tue, 02 Jun 2020 07:42:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q207sm2248613qke.55.2020.06.02.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:42:41 -0700 (PDT)
Date:   Tue, 2 Jun 2020 10:42:35 -0400
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
Message-ID: <20200602144235.GA1129@lca.pw>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.359433429@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529213321.359433429@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:27:39PM +0200, Peter Zijlstra wrote:
> Because:
> 
>   irq_enter_rcu() includes lockdep_hardirq_enter()
>   irq_exit_rcu() does *NOT* include lockdep_hardirq_exit()
> 
> Which resulted in two 'stray' lockdep_hardirq_exit() calls in
> idtentry.h, and me spending a long time trying to find the matching
> enter calls.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/idtentry.h |    2 --
>  kernel/softirq.c                |   19 +++++++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
[]
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -404,12 +404,7 @@ static inline void tick_irq_exit(void)
>  #endif
>  }
>  
> -/**
> - * irq_exit_rcu() - Exit an interrupt context without updating RCU
> - *
> - * Also processes softirqs if needed and possible.
> - */
> -void irq_exit_rcu(void)
> +static inline void __irq_exit_rcu(void)
>  {
>  #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
>  	local_irq_disable();
> @@ -425,6 +420,18 @@ void irq_exit_rcu(void)
>  }
>  
>  /**
> + * irq_exit_rcu() - Exit an interrupt context without updating RCU
> + *
> + * Also processes softirqs if needed and possible.
> + */
> +void irq_exit_rcu(void)
> +{
> +	__irq_exit_rcu();
> +	 /* must be last! */
> +	lockdep_hardirq_exit();
> +}
> +
> +/**
>   * irq_exit - Exit an interrupt context, update RCU and lockdep
>   *
>   * Also processes softirqs if needed and possible.
> 
>

Reverted this commit fixed the POWER9 boot warning,

[    0.005196][    T0] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.012502][    T0] clocksource: timebase mult[1f40000] shift[24] registered
[    0.030273][    T0] ------------[ cut here ]------------
[    0.034421][    T0] DEBUG_LOCKS_WARN_ON(current->hardirq_context)
[    0.034433][    T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3680 lockdep_hardirqs_on_prepare+0x29c/0x2d0
[    0.045874][    T0] Modules linked in:
[    0.047977][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-next-20200602 #1
[    0.053187][    T0] NIP:  c0000000001d2fec LR: c0000000001d2fe8 CTR: c00000000074b0a0
[    0.057395][    T0] REGS: c00000000130f810 TRAP: 0700   Not tainted  (5.7.0-next-20200602)
[    0.062614][    T0] MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR: 48000422  XER: 20040000
[    0.069856][    T0] CFAR: c00000000010e448 IRQMASK: 1
[    0.069856][    T0] GPR00: c0000000001d2fe8 c00000000130faa0 c00000000130aa00 000000000000002d
[    0.069856][    T0] GPR04: c00000000133c3b0 000000000000000d 000000006e6f635f 72727563284e4f5f
[    0.069856][    T0] GPR08: 0000000000000002 c000000000dcf230 0000000000000001 c0000000012b0280
[    0.069856][    T0] GPR12: 0000000000000000 c0000000057b0000 0000000000000000 0000000000000000
[    0.069856][    T0] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.069856][    T0] GPR20: 0000000000000000 0000000000000001 0000000010004d9c 00000000100053ed
[    0.069856][    T0] GPR24: 0000000010005411 0000000000000001 0000000000000002 0000000000000003
[    0.069856][    T0] GPR28: 0000000000000000 0000000000000000 0000000000000000 c000000003e3b008
[    0.117846][    T0] NIP [c0000000001d2fec] lockdep_hardirqs_on_prepare+0x29c/0x2d0
[    0.123052][    T0] LR [c0000000001d2fe8] lockdep_hardirqs_on_prepare+0x298/0x2d0
[    0.127248][    T0] Call Trace:
[    0.129337][    T0] [c00000000130faa0] [c0000000001d2fe8] lockdep_hardirqs_on_prepare+0x298/0x2d0 (unreliable)
[    0.137613][    T0] [c00000000130fb10] [c0000000002d3834] trace_hardirqs_on+0x94/0x230
trace_hardirqs_on at kernel/trace/trace_preemptirq.c:49
[    0.141824][    T0] [c00000000130fb60] [c000000000039100] interrupt_exit_kernel_prepare+0x110/0x1f0
interrupt_exit_kernel_prepare at arch/powerpc/kernel/syscall_64.c:337
[    0.148069][    T0] [c00000000130fbc0] [c00000000000f328] interrupt_return+0x118/0x1c0
[    0.152281][    T0] --- interrupt: 900 at arch_local_irq_restore+0xc0/0xd0
arch_local_irq_restore at arch/powerpc/kernel/irq.c:367
(inlined by) arch_local_irq_restore at arch/powerpc/kernel/irq.c:318
[    0.152281][    T0]     LR = start_kernel+0x7f0/0x9dc
[    0.153579][    T0] [c00000000130fec0] [c000000001208fa8] init_on_free+0x0/0x2b0 (unreliable)
[    0.159810][    T0] [c00000000130fee0] [c000000000c845c8] start_kernel+0x7e4/0x9dc
start_kernel at init/main.c:961 (discriminator 3)
[    0.165017][    T0] [c00000000130ff90] [c00000000000c890] start_here_common+0x1c/0x8c
[    0.169224][    T0] Instruction dump:
[    0.171324][    T0] 0fe00000 e8010080 ebc10060 ebe10068 7c0803a6 4bfffe7c 3c82ff8b 3c62ff8a
[    0.177558][    T0] 38848808 3863e460 4bf3b3fd 60000000 <0fe00000> e8010080 ebc10060 ebe10068
[    0.183796][    T0] irq event stamp: 16
[    0.186904][    T0] hardirqs last  enabled at (14): [<c00000000020cf14>] rcu_core+0x9a4/0xbe0
[    0.191130][    T0] hardirqs last disabled at (15): [<c000000000a39944>] __do_softirq+0x5d4/0x8d8
[    0.195365][    T0] softirqs last  enabled at (16): [<c000000000a399c8>] __do_softirq+0x658/0x8d8
[    0.201606][    T0] softirqs last disabled at (5): [<c00000000011cbbc>] irq_exit+0x17c/0x1c0
[    0.206832][    T0] ---[ end trace 339d75c2056bfda1 ]---
[    0.208990][    T0] printk: console [hvc0] enabled
[    0.208990][    T0] printk: console [hvc0] enabled
