Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF067C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AC12074D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AKeE3rtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0DuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:50:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbgC0DuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:50:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48pSYG15kMz9sRR;
        Fri, 27 Mar 2020 14:50:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585281010;
        bh=4Qqg2r8oM4zPrJhzVQO07i32dlNDD+eFmBtDY+IJlB0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AKeE3rtC/tHmgbrDN+BCRn0kRIXQhECLUqtFW9Yv6a/cJApH/zdfgOFjn/WYU7Buh
         9ZmJqGOLvqNKaV2W2oAjBO8NHnQIqHpMFxsoI13sRFoBV183mxazsQLrPApSmkJrlH
         IN/ND6SstTbfalEQE+GOh13LwSwp8LMQmvm68zzqUHZ8LN+vUrcapZevjeh2vdQ6SY
         7ABlVGzAl+sJznQmXo/JukKf2j44nx35QMwZ1qRgOCBeaQ3TtCpk33AD8/U+PMRZlr
         EYZ75f3mkiwv3B+z4cVpg641xeIep6hQIP7vKZCpeSCXVF1elVrB8d02Jdui/slXo4
         XTioOijx4aiww==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/1] ppc/crash: Skip spinlocks during crash
In-Reply-To: <20200326232542.503157-1-leonardo@linux.ibm.com>
References: <20200326232542.503157-1-leonardo@linux.ibm.com>
Date:   Fri, 27 Mar 2020 14:50:14 +1100
Message-ID: <87d08ywj61.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Leonardo Bras <leonardo@linux.ibm.com> writes:
> During a crash, there is chance that the cpus that handle the NMI IPI
> are holding a spin_lock. If this spin_lock is needed by crashing_cpu it
> will cause a deadlock. (rtas_lock and printk logbuf_log as of today)

Please give us more detail on how those locks are causing you trouble, a
stack trace would be good if you have it.

> This is a problem if the system has kdump set up, given if it crashes
> for any reason kdump may not be saved for crash analysis.
>
> Skip spinlocks after NMI IPI is sent to all other cpus.

We don't want to add overhead to all spinlocks for the life of the
system, just to handle this one case.

There's already a flag that is set when the system is crashing,
"oops_in_progress", maybe we need to use that somewhere to skip a lock
or do an early return.

cheers

> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 860228e917dc..a6381d110795 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -111,6 +111,8 @@ static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
>  static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
>  #endif
>  
> +extern bool crash_skip_spinlock __read_mostly;
> +
>  static inline bool is_shared_processor(void)
>  {
>  #ifdef CONFIG_PPC_SPLPAR
> @@ -142,6 +144,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  		if (likely(__arch_spin_trylock(lock) == 0))
>  			break;
>  		do {
> +			if (unlikely(crash_skip_spinlock))
> +				return;
>  			HMT_low();
>  			if (is_shared_processor())
>  				splpar_spin_yield(lock);
> @@ -161,6 +165,8 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
>  		local_save_flags(flags_dis);
>  		local_irq_restore(flags);
>  		do {
> +			if (unlikely(crash_skip_spinlock))
> +				return;
>  			HMT_low();
>  			if (is_shared_processor())
>  				splpar_spin_yield(lock);
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index d488311efab1..ae081f0f2472 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -66,6 +66,9 @@ static int handle_fault(struct pt_regs *regs)
>  
>  #ifdef CONFIG_SMP
>  
> +bool crash_skip_spinlock;
> +EXPORT_SYMBOL(crash_skip_spinlock);
> +
>  static atomic_t cpus_in_crash;
>  void crash_ipi_callback(struct pt_regs *regs)
>  {
> @@ -129,6 +132,7 @@ static void crash_kexec_prepare_cpus(int cpu)
>  	/* Would it be better to replace the trap vector here? */
>  
>  	if (atomic_read(&cpus_in_crash) >= ncpus) {
> +		crash_skip_spinlock = true;
>  		printk(KERN_EMERG "IPI complete\n");
>  		return;
>  	}
> -- 
> 2.24.1
