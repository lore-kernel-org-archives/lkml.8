Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8577AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CCA206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LEx5afIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCLXjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:39:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40397 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:39:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so4048273pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DXlVKlUxHiN1BkDGEP3NLaDmdwuj+DcaMo6FXkgPxOk=;
        b=LEx5afISDjP7kfavtwMJwBmcVG5EraO/BaUeNJ2i1xA9qO8fw/wGPBHFdhxyJsywgx
         ENWLdHfD5Ajj/YaQJUUB0IR76umzsXtDKAevXtB/eQedXDrs2MI2Y5B6dn/02nFLddCe
         Oj2we3+tWhAowzBLwdgpJT25ulKRrK9+y5/ySAi3b4ade2o2y8g0fHBueotjak0jslQu
         CJCyfabV/GEfU1gE4QDY/oS+7rCA6BynJQBBRzhYaawlkCwfZXprtNkWNWs0z267Lur2
         58rY97yYlEz2RLGez645hA0B0OKOrdz+PN3CRq6oG0aHbZ991vp4BFNfx84OSjlAakGW
         0YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DXlVKlUxHiN1BkDGEP3NLaDmdwuj+DcaMo6FXkgPxOk=;
        b=RFlwACJcYH6W8o6550TxlPD/BSTwsHLH1RPkenrSUJvT6tYLYGViqVSEQ3bywLWIzb
         fexiqK9MVMeoJm2qcfj7bQojTxdhb36vHhWixEls2y9aAotyGr+Tw424Kg9U6NwtUe/A
         qOMQXaFZsWoP9kELXHySzm5gLwRO43DLenml3HFr3ZZZL2RSTF9mzWW8nNkcoD5aorO5
         mBsBjjrZI3wgV1jn6YPTz+Wa5D9ItL9jg+5NtCvCTs9aJXDCtu3yeBzgbvtwagjJxD9H
         sIguhYTpM4DIx4QF5kEbHvaDUO04xjnygedtPpBDcEF9OrUQE5KazOGFZkguefdAHe98
         6sUQ==
X-Gm-Message-State: ANhLgQ0pWcQZN0oN+ALXlOobrX1xFHxQIyeBZDn70/+iAegjO7ib3D+X
        9BnJ+A7fsAdJDY5Pdx+N/eTWyd6Pex0=
X-Google-Smtp-Source: ADFU+vvCR3YDNY9Vjfe0rXX301WDBJRS0VpvDfB24Dih6n8hzQ1rYpHAEH1KigRSt5n1iX5PnHAiTg==
X-Received: by 2002:a63:330f:: with SMTP id z15mr10420185pgz.104.1584056347186;
        Thu, 12 Mar 2020 16:39:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:918e:f0ca:8a52:212e? ([2601:646:c200:1ef2:918e:f0ca:8a52:212e])
        by smtp.gmail.com with ESMTPSA id w16sm12355117pfj.79.2020.03.12.16.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 16:39:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Add trace points to (nearly) all vectors
Date:   Thu, 12 Mar 2020 16:39:04 -0700
Message-Id: <742AF79F-BAE4-4E6C-944D-10C3E6F66CD0@amacapital.net>
References: <20200312231916.132753-1-andi@firstfloor.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20200312231916.132753-1-andi@firstfloor.org>
To:     Andi Kleen <andi@firstfloor.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 12, 2020, at 4:19 PM, Andi Kleen <andi@firstfloor.org> wrote:
>=20
> =EF=BB=BFFrom: Andi Kleen <ak@linux.intel.com>
>=20
> In some scenarios it can be useful to count or trace every kernel
> entry.

Can you elaborate?  What problem does this solve?

> Most entry paths are covered by trace points already,
> but some of the more obscure entry points do not have
> trace points.
>=20
> The most common uncovered one was KVM async page fault.

NAK.  This path is going away.=20

>=20
> This patch kit adds trace points to all the other vectors,
> except UV (anyone uses?), Xen (generic code), reboot (pointless)
>=20
> To avoid creating a lot of new trace points this just
> lumps them all together into a "other_vector" trace point, because
> they're all fairly obscure and uncommon, and can be figured
> out from the number when needed, or filtered using the filter
> expression. This makes the needed perf command line much shorter.
>=20
> The exception is the KVM async page fault which is fairly common
> inside KVM guests, so is worth breaking out.
>=20
> The Xen vectors could be done done as a followon if desired.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>=20
> --
>=20
> v2: Fix build errors found by 0day for some configurations.
> v3: Finally use correct CONFIG symbol to check for KVM guest.
> Thanks 0day.
> v4: Fix build for 32bit with !CONFIG_X86_LOCAL_APIC. Thanks 0day.
> v5: Rebase. No changes.
> ---
> arch/x86/hyperv/hv_init.c                |  3 ++
> arch/x86/include/asm/trace/irq_vectors.h | 17 ++++++++--
> arch/x86/kernel/apic/vector.c            |  3 ++
> arch/x86/kernel/cpu/mce/core.c           |  3 ++
> arch/x86/kernel/irq.c                    |  6 ++++
> arch/x86/kernel/kvm.c                    |  5 +++
> arch/x86/kernel/traps.c                  | 40 +++++++++++++++++++-----
> 7 files changed, 67 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 2db3972c0e0f..d97e570e37b6 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -21,6 +21,7 @@
> #include <linux/slab.h>
> #include <linux/cpuhotplug.h>
> #include <clocksource/hyperv_timer.h>
> +#include <asm/trace/irq_vectors.h>
>=20
> void *hv_hypercall_pg;
> EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> @@ -144,8 +145,10 @@ __visible void __irq_entry hyperv_reenlightenment_int=
r(struct pt_regs *regs)
>=20
>    inc_irq_stat(irq_hv_reenlightenment_count);
>=20
> +    trace_other_vector_entry(HYPERV_REENLIGHTENMENT_VECTOR);
>    schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
>=20
> +    trace_other_vector_exit(HYPERV_REENLIGHTENMENT_VECTOR);
>    exiting_irq();
> }
>=20
> diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/a=
sm/trace/irq_vectors.h
> index 33b9d0f0aafe..b50b3dc02e71 100644
> --- a/arch/x86/include/asm/trace/irq_vectors.h
> +++ b/arch/x86/include/asm/trace/irq_vectors.h
> @@ -8,8 +8,6 @@
> #include <linux/tracepoint.h>
> #include <asm/trace/common.h>
>=20
> -#ifdef CONFIG_X86_LOCAL_APIC
> -
> extern int trace_resched_ipi_reg(void);
> extern void trace_resched_ipi_unreg(void);
>=20
> @@ -49,6 +47,8 @@ DEFINE_EVENT_FN(x86_irq_vector, name##_exit,    \
>    trace_resched_ipi_reg,            \
>    trace_resched_ipi_unreg);
>=20
> +#ifdef CONFIG_X86_LOCAL_APIC
> +
> /*
>  * local_timer - called when entering/exiting a local timer interrupt
>  * vector handler
> @@ -138,6 +138,19 @@ DEFINE_IRQ_VECTOR_EVENT(deferred_error_apic);
> DEFINE_IRQ_VECTOR_EVENT(thermal_apic);
> #endif
>=20
> +#endif /* CONFIG_X86_LOCAL_APIC */
> +
> +#ifdef CONFIG_KVM_GUEST
> +DEFINE_IRQ_VECTOR_EVENT(async_page_fault);
> +#endif
> +
> +/*
> + * Handle all other vectors.
> + */
> +DEFINE_IRQ_VECTOR_EVENT(other_vector);
> +
> +#ifdef CONFIG_X86_LOCAL_APIC
> +
> TRACE_EVENT(vector_config,
>=20
>    TP_PROTO(unsigned int irq, unsigned int vector,
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c=

> index 2c5676b0a6e7..2e883f38b895 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -860,6 +860,7 @@ asmlinkage __visible void __irq_entry smp_irq_move_cle=
anup_interrupt(void)
>    struct hlist_node *tmp;
>=20
>    entering_ack_irq();
> +    trace_other_vector_entry(IRQ_MOVE_CLEANUP_VECTOR);
>    /* Prevent vectors vanishing under us */
>    raw_spin_lock(&vector_lock);
>=20
> @@ -884,6 +885,8 @@ asmlinkage __visible void __irq_entry smp_irq_move_cle=
anup_interrupt(void)
>    }
>=20
>    raw_spin_unlock(&vector_lock);
> +    trace_other_vector_exit(IRQ_MOVE_CLEANUP_VECTOR);
> +    /* Prevent vectors vanishing under us */
>    exiting_irq();
> }
>=20
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core=
.c
> index 743370ee4983..f593bd6b0ed7 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -61,6 +61,9 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
> #define CREATE_TRACE_POINTS
> #include <trace/events/mce.h>
>=20
> +#undef CREATE_TRACE_POINTS
> +#include <asm/trace/irq_vectors.h>
> +
> #define SPINUNIT        100    /* 100ns */
>=20
> DEFINE_PER_CPU(unsigned, mce_exception_count);
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 21efee32e2b1..f57c148dc578 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -308,8 +308,10 @@ __visible void smp_kvm_posted_intr_ipi(struct pt_regs=
 *regs)
>    struct pt_regs *old_regs =3D set_irq_regs(regs);
>=20
>    entering_ack_irq();
> +    trace_other_vector_entry(POSTED_INTR_VECTOR);
>    inc_irq_stat(kvm_posted_intr_ipis);
>    exiting_irq();
> +    trace_other_vector_exit(POSTED_INTR_VECTOR);
>    set_irq_regs(old_regs);
> }
>=20
> @@ -321,8 +323,10 @@ __visible void smp_kvm_posted_intr_wakeup_ipi(struct p=
t_regs *regs)
>    struct pt_regs *old_regs =3D set_irq_regs(regs);
>=20
>    entering_ack_irq();
> +    trace_other_vector_entry(POSTED_INTR_WAKEUP_VECTOR);
>    inc_irq_stat(kvm_posted_intr_wakeup_ipis);
>    kvm_posted_intr_wakeup_handler();
> +    trace_other_vector_exit(POSTED_INTR_WAKEUP_VECTOR);
>    exiting_irq();
>    set_irq_regs(old_regs);
> }
> @@ -335,7 +339,9 @@ __visible void smp_kvm_posted_intr_nested_ipi(struct p=
t_regs *regs)
>    struct pt_regs *old_regs =3D set_irq_regs(regs);
>=20
>    entering_ack_irq();
> +    trace_other_vector_entry(POSTED_INTR_NESTED_VECTOR);
>    inc_irq_stat(kvm_posted_intr_nested_ipis);
> +    trace_other_vector_exit(POSTED_INTR_NESTED_VECTOR);
>    exiting_irq();
>    set_irq_regs(old_regs);
> }
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index e820568ed4d5..8d915b559617 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -33,6 +33,7 @@
> #include <asm/apicdef.h>
> #include <asm/hypervisor.h>
> #include <asm/tlb.h>
> +#include <asm/trace/irq_vectors.h>
>=20
> static int kvmapf =3D 1;
>=20
> @@ -246,6 +247,8 @@ do_async_page_fault(struct pt_regs *regs, unsigned lon=
g error_code, unsigned lon
> {
>    enum ctx_state prev_state;
>=20
> +    trace_async_page_fault_entry(0);
> +
>    switch (kvm_read_and_reset_pf_reason()) {
>    default:
>        do_page_fault(regs, error_code, address);
> @@ -262,6 +265,8 @@ do_async_page_fault(struct pt_regs *regs, unsigned lon=
g error_code, unsigned lon
>        rcu_irq_exit();
>        break;
>    }
> +
> +    trace_async_page_fault_exit(0);
> }
> NOKPROBE_SYMBOL(do_async_page_fault);
>=20
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4bb0f8447112..6ccc01d74747 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -62,6 +62,8 @@
> #include <asm/vm86.h>
> #include <asm/umip.h>
>=20
> +#include <asm/trace/irq_vectors.h>
> +
> #ifdef CONFIG_X86_64
> #include <asm/x86_init.h>
> #include <asm/pgalloc.h>
> @@ -264,19 +266,22 @@ static void do_error_trap(struct pt_regs *regs, long=
 error_code, char *str,
>    unsigned long trapnr, int signr, int sicode, void __user *addr)
> {
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +    trace_other_vector_entry(trapnr);
>=20
>    /*
>     * WARN*()s end up here; fix them up before we call the
>     * notifier chain.
>     */
>    if (!user_mode(regs) && fixup_bug(regs, trapnr))
> -        return;
> +        goto out;
>=20
>    if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=3D
>            NOTIFY_STOP) {
>        cond_local_irq_enable(regs);
>        do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
>    }
> +out:
> +    trace_other_vector_exit(trapnr);
> }
>=20
> #define IP ((void __user *)uprobe_get_trap_addr(regs))
> @@ -433,9 +438,10 @@ dotraplinkage void do_bounds(struct pt_regs *regs, lo=
ng error_code)
>    const struct mpx_bndcsr *bndcsr;
>=20
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +    trace_other_vector_entry(X86_TRAP_BR);
>    if (notify_die(DIE_TRAP, "bounds", regs, error_code,
>            X86_TRAP_BR, SIGSEGV) =3D=3D NOTIFY_STOP)
> -        return;
> +        goto exit;
>    cond_local_irq_enable(regs);
>=20
>    if (!user_mode(regs))
> @@ -501,6 +507,8 @@ dotraplinkage void do_bounds(struct pt_regs *regs, lon=
g error_code)
>        die("bounds", regs, error_code);
>    }
>=20
> +exit:
> +    trace_other_vector_exit(X86_TRAP_BR);
>    return;
>=20
> exit_trap:
> @@ -512,6 +520,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, lon=
g error_code)
>     * time..
>     */
>    do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
> +    goto exit;
> }
>=20
> dotraplinkage void
> @@ -522,22 +531,23 @@ do_general_protection(struct pt_regs *regs, long err=
or_code)
>=20
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>    cond_local_irq_enable(regs);
> +    trace_other_vector_entry(X86_TRAP_GP);
>=20
>    if (static_cpu_has(X86_FEATURE_UMIP)) {
>        if (user_mode(regs) && fixup_umip_exception(regs))
> -            return;
> +            goto out;
>    }
>=20
>    if (v8086_mode(regs)) {
>        local_irq_enable();
>        handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
> -        return;
> +        goto out;
>    }
>=20
>    tsk =3D current;
>    if (!user_mode(regs)) {
>        if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
> -            return;
> +            goto out;
>=20
>        tsk->thread.error_code =3D error_code;
>        tsk->thread.trap_nr =3D X86_TRAP_GP;
> @@ -549,12 +559,12 @@ do_general_protection(struct pt_regs *regs, long err=
or_code)
>         */
>        if (!preemptible() && kprobe_running() &&
>            kprobe_fault_handler(regs, X86_TRAP_GP))
> -            return;
> +            goto out;
>=20
>        if (notify_die(DIE_GPF, desc, regs, error_code,
>                   X86_TRAP_GP, SIGSEGV) !=3D NOTIFY_STOP)
>            die(desc, regs, error_code);
> -        return;
> +        goto out;
>    }
>=20
>    tsk->thread.error_code =3D error_code;
> @@ -563,6 +573,9 @@ do_general_protection(struct pt_regs *regs, long error=
_code)
>    show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
>=20
>    force_sig(SIGSEGV);
> +
> +out:
> +    trace_other_vector_exit(X86_TRAP_GP);
> }
> NOKPROBE_SYMBOL(do_general_protection);
>=20
> @@ -588,6 +601,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *reg=
s, long error_code)
>     * This means that we can't schedule.  That's okay.
>     */
>    ist_enter(regs);
> +    trace_other_vector_entry(X86_TRAP_BP);
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>    if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
> @@ -609,6 +623,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *reg=
s, long error_code)
>    cond_local_irq_disable(regs);
>=20
> exit:
> +    trace_other_vector_exit(X86_TRAP_BP);
>    ist_exit(regs);
> }
> NOKPROBE_SYMBOL(do_int3);
> @@ -714,6 +729,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long=
 error_code)
>    int si_code;
>=20
>    ist_enter(regs);
> +    trace_other_vector_entry(X86_TRAP_DB);
>=20
>    get_debugreg(dr6, 6);
>    /*
> @@ -806,6 +822,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long=
 error_code)
>    debug_stack_usage_dec();
>=20
> exit:
> +    trace_other_vector_exit(X86_TRAP_DB);
>    ist_exit(regs);
> }
> NOKPROBE_SYMBOL(do_debug);
> @@ -858,14 +875,18 @@ static void math_error(struct pt_regs *regs, int err=
or_code, int trapnr)
> dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_c=
ode)
> {
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +    trace_other_vector_entry(X86_TRAP_MF);
>    math_error(regs, error_code, X86_TRAP_MF);
> +    trace_other_vector_exit(X86_TRAP_MF);
> }
>=20
> dotraplinkage void
> do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
> {
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +    trace_other_vector_entry(X86_TRAP_XF);
>    math_error(regs, error_code, X86_TRAP_XF);
> +    trace_other_vector_exit(X86_TRAP_XF);
> }
>=20
> dotraplinkage void
> @@ -881,6 +902,7 @@ do_device_not_available(struct pt_regs *regs, long err=
or_code)
>=20
>    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>=20
> +    trace_other_vector_entry(X86_TRAP_NM);
> #ifdef CONFIG_MATH_EMULATION
>    if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
>        struct math_emu_info info =3D { };
> @@ -889,7 +911,7 @@ do_device_not_available(struct pt_regs *regs, long err=
or_code)
>=20
>        info.regs =3D regs;
>        math_emulate(&info);
> -        return;
> +        goto out;
>    }
> #endif
>=20
> @@ -905,6 +927,8 @@ do_device_not_available(struct pt_regs *regs, long err=
or_code)
>         */
>        die("unexpected #NM exception", regs, error_code);
>    }
> +out: __maybe_unused;
> +    trace_other_vector_exit(X86_TRAP_NM);
> }
> NOKPROBE_SYMBOL(do_device_not_available);
>=20
> --=20
> 2.24.1
>=20
