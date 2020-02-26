Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF5C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4FB2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew0zWO8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgBZKy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:54:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37780 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728129AbgBZKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582714494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVpb8nHUOa2idHX+MG3/yjyRnJPwiujzokW0+TY8t/I=;
        b=ew0zWO8d7cUpY0cdM714mO7qHb0WCs1FrbycxWNXHolfopYVmKo3MCTxnplzbMNxaI+ZjD
        C0GcGN9+bzCr9ZvnmLmG+wnzkySKGOL7cYAca2Pselfjzdvi2zSw4ErAGRt+D15ZsEH+wX
        TA/ZD36Vp45l5yL/yYeaU6EzYF3sYyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-0lNuxNBjNB-WZMZlU31VmQ-1; Wed, 26 Feb 2020 05:54:52 -0500
X-MC-Unique: 0lNuxNBjNB-WZMZlU31VmQ-1
Received: by mail-wr1-f69.google.com with SMTP id u18so1293711wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KVpb8nHUOa2idHX+MG3/yjyRnJPwiujzokW0+TY8t/I=;
        b=jrNhodS3kFpie0dwXMbLN6DJNIJm4ZApXjXXItHnTtkTkhq3bsDFmXNTBMCEozYJxT
         4jEhd74EZoVn303IlBDuXQKbgeGuLMlVVTskVoW2leDvlMQy2EfHqhyYpEGwUiPf13A2
         H6l5Yf/QzNy0YRW3F8Yfb0X1OREWWXR/Mh7/VTSfV/Gx1OuytvZ5/vp3U1Zh9+tO/MUS
         94Qp3rOVIiUMfvH5ZLMcHPbl5Y8yEUIpY6O5BDldqQQvA0x9h6ZMG5XANIhiDabMsTUE
         I2PXjg6zQJIwFQI6O15xO+8wr1LhL/XwTY8EZ8HRNd0nGl/wT84VMWgpYvG/65iAQr6L
         sPBA==
X-Gm-Message-State: APjAAAUq+FuxFTWx5CLp3nFWZ4j5qTMN2v8Lt7Jh03AUae432RSATEX6
        eT2dTy3yFfk901WNmkaEBYX/Q7xFXNL40PsXy1GjXVTkGOqTr9yTMUxBmBe8GADVZftTDNuSGCk
        OqZ8TeyQduRSgG225wjnUnFQG
X-Received: by 2002:adf:f751:: with SMTP id z17mr265053wrp.207.1582714491452;
        Wed, 26 Feb 2020 02:54:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFpgfhcuEMPObXiVoukTkBTE6JsRNCBtqkFGR5pqxHNjWCREtJX3xW3Ga3ghXD+y7k7NdfBA==
X-Received: by 2002:adf:f751:: with SMTP id z17mr265028wrp.207.1582714491124;
        Wed, 26 Feb 2020 02:54:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id a22sm2467632wmd.20.2020.02.26.02.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:54:50 -0800 (PST)
Subject: Re: [patch 09/15] x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>
References: <20200225224719.950376311@linutronix.de>
 <20200225231609.835888421@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <766b7db8-6132-fcfa-3264-6041e6141cbb@redhat.com>
Date:   Wed, 26 Feb 2020 11:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225231609.835888421@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 23:47, Thomas Gleixner wrote:
> Convert KVm specific system vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototyoes
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/entry_32.S         |    3 ---
>  arch/x86/entry/entry_64.S         |    7 -------
>  arch/x86/include/asm/entry_arch.h |   19 -------------------
>  arch/x86/include/asm/hw_irq.h     |    5 -----
>  arch/x86/include/asm/idtentry.h   |    6 ++++++
>  arch/x86/include/asm/irq.h        |    3 ---
>  arch/x86/kernel/idt.c             |    6 +++---
>  arch/x86/kernel/irq.c             |    6 +++---
>  8 files changed, 12 insertions(+), 43 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1286,9 +1286,6 @@ SYM_FUNC_END(name)
>  #define BUILD_INTERRUPT(name, nr)		\
>  	BUILD_INTERRUPT3(name, nr, smp_##name);	\
>  
> -/* The include is where all of the SMP etc. interrupts come from */
> -#include <asm/entry_arch.h>
> -
>  #ifdef CONFIG_PARAVIRT
>  SYM_CODE_START(native_iret)
>  	iret
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -994,13 +994,6 @@ apicinterrupt3 \num \sym \do_sym
>  POP_SECTION_IRQENTRY
>  .endm
>  
> -
> -#ifdef CONFIG_HAVE_KVM
> -apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
> -apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
> -apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
> -#endif
> -
>  /*
>   * Reload gs selector with exception handling
>   * edi:  new selector
> --- a/arch/x86/include/asm/entry_arch.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * This file is designed to contain the BUILD_INTERRUPT specifications for
> - * all of the extra named interrupt vectors used by the architecture.
> - * Usually this is the Inter Process Interrupts (IPIs)
> - */
> -
> -/*
> - * The following vectors are part of the Linux architecture, there
> - * is no hardware IRQ pin equivalent for them, they are triggered
> - * through the ICC by us (IPIs)
> - */
> -
> -#ifdef CONFIG_HAVE_KVM
> -BUILD_INTERRUPT(kvm_posted_intr_ipi, POSTED_INTR_VECTOR)
> -BUILD_INTERRUPT(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR)
> -BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
> -#endif
> -
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -28,11 +28,6 @@
>  #include <asm/irq.h>
>  #include <asm/sections.h>
>  
> -/* Interrupt handlers registered during init_IRQ */
> -extern asmlinkage void kvm_posted_intr_ipi(void);
> -extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
> -extern asmlinkage void kvm_posted_intr_nested_ipi(void);
> -
>  #ifdef	CONFIG_X86_LOCAL_APIC
>  struct irq_data;
>  struct pci_dev;
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -517,6 +517,12 @@ DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VEC
>  DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
>  #endif
>  
> +#ifdef CONFIG_HAVE_KVM
> +DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
> +DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
> +DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
> +#endif
> +
>  #ifdef CONFIG_X86_MCE
>  /* Machine check */
>  DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
> --- a/arch/x86/include/asm/irq.h
> +++ b/arch/x86/include/asm/irq.h
> @@ -26,9 +26,6 @@ extern void fixup_irqs(void);
>  
>  #ifdef CONFIG_HAVE_KVM
>  extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
> -extern __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs);
> -extern __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs);
> -extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
>  #endif
>  
>  extern void (*x86_platform_ipi_callback)(void);
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -132,9 +132,9 @@ static const __initconst struct idt_data
>  	INTG(LOCAL_TIMER_VECTOR,		asm_sysvec_apic_timer_interrupt),
>  	INTG(X86_PLATFORM_IPI_VECTOR,		asm_sysvec_x86_platform_ipi),
>  # ifdef CONFIG_HAVE_KVM
> -	INTG(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
> -	INTG(POSTED_INTR_WAKEUP_VECTOR,		kvm_posted_intr_wakeup_ipi),
> -	INTG(POSTED_INTR_NESTED_VECTOR,		kvm_posted_intr_nested_ipi),
> +	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
> +	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
> +	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
>  # endif
>  # ifdef CONFIG_IRQ_WORK
>  	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
>  /*
>   * Handler for POSTED_INTERRUPT_VECTOR.
>   */
> -__visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
> +DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_ipi)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
> @@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
>  /*
>   * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
>   */
> -__visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
> +DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
> @@ -328,7 +328,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
>  /*
>   * Handler for POSTED_INTERRUPT_NESTED_VECTOR.
>   */
> -__visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
> +DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_nested_ipi)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

