Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E002075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8ihiDFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgEGNd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:33:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E7C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 06:33:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so6411704wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lavJtxKaYcyNLFyKsKYMDkQAHQjwXkcemrxVw4KhSys=;
        b=q8ihiDFWmxPihIUKThUImZ9SqPSGicCB/LUIH7G13GZkNXJykWaCALUvcVkKcfb+OT
         ISMslonAmpBXwKqoCaUXy/3GAeLnAN+2rqT8xag1XdqPbGIC/XX2bVX+EpLC3xHfPwMq
         KgjlZFMT3IBwk6c2lkgefiShIR70gBlf8h9NAwp9ezfG0Y7090yvadbR7daceiHVTn+J
         bLkajrwF3S3sjXshSRI3ocfRGRVetfg+zTEhDD5lrongAN8L8NiUnCeLUxp/NmVDcRV0
         uKQirezMvpbWE1Y5O75qcGmYMuC1EGZt31E/QKZfCRDuKPvxZ5+3aG84W79Zrh/wDhMO
         WXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lavJtxKaYcyNLFyKsKYMDkQAHQjwXkcemrxVw4KhSys=;
        b=iRa5HCRfinzwvekIBHhQWEwZvNM7U6tidOKHENHL/SnR0FZxdC4rf0s06AhVHAhGT/
         EDEunXKjwUBp4Pr2t1MrzK+ATBLVdq25wIXimTv+9rtzfla1XUOjAW5zJsqk6a83vTyo
         0G6sVsEaN9x3tnGqEdUTLnBF4JH1bjt3yiYLasPIAOGlcYCrLrYh/+20IMrB1kwoUZWe
         nY7eJnq17iazGI5o3tsbxl1bIfFG9hewH40zXTHZln2GQVfAk8gUbpVosjVxih7ZVEOj
         5L2DrhBPhYxgE1TgHrpCOOM1h5o65kOmj/MFLrKtclBel/7KhSQSKYQ8r2aQflhV4/tP
         LeUQ==
X-Gm-Message-State: AGi0PubuuF+xJRjvdFhD6HSdqR3NU1ssEsxslkHJWKkJmaQnbGd3ql1x
        +9+NeQHl/8kS5FflzZvqKpe58Q==
X-Google-Smtp-Source: APiQypK1mliJvEiy6KkK4NSYKEudXyeC7ljs0Mrh3EMKeWBt76IU1uAhJMUGJmPyzwky1z5OheEEAA==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr15388355wrn.21.1588858404386;
        Thu, 07 May 2020 06:33:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id n6sm8458850wrs.81.2020.05.07.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:33:23 -0700 (PDT)
Date:   Thu, 7 May 2020 14:33:20 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] arm64: kvm: Formalize host-hyp hypcall ABI
Message-ID: <20200507133320.GA16899@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-3-dbrazdil@google.com>
 <87d07fj3g9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d07fj3g9.wl-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Thursday 07 May 2020 at 14:10:30 (+0100), Marc Zyngier wrote:
> Hi David, Quentin,
> 
> On Thu, 30 Apr 2020 15:48:18 +0100,
> David Brazdil <dbrazdil@google.com> wrote:
> > 
> > From: Quentin Perret <qperret@google.com>
> > 
> > In preparation for removing the hyp code from the TCB, convert the current
> 
> nit: Unless we have a different interpretation of the TCB acronym, I
> think you want to remove anything *but* the EL2 code from the TCB.

Argh! Right... This should have been 'removing the /host/ code' :-)

<snip>
> > diff --git a/arch/arm64/include/asm/kvm_host_hypercalls.h b/arch/arm64/include/asm/kvm_host_hypercalls.h
> > new file mode 100644
> > index 000000000000..af8ad505d816
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/kvm_host_hypercalls.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 Google, inc
> > + */
> > +
> > +#ifndef __KVM_HOST_HCALL
> > +#define __KVM_HOST_HCALL(x)
> > +#endif
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_enable_ssbs		0
> > +__KVM_HOST_HCALL(__kvm_enable_ssbs)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_get_mdcr_el2		1
> > +__KVM_HOST_HCALL(__kvm_get_mdcr_el2)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_timer_set_cntvoff	2
> > +__KVM_HOST_HCALL(__kvm_timer_set_cntvoff)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_local_vmid	3
> > +__KVM_HOST_HCALL(__kvm_tlb_flush_local_vmid)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_flush_vm_context	4
> > +__KVM_HOST_HCALL(__kvm_flush_vm_context)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_vcpu_run_nvhe		5
> > +__KVM_HOST_HCALL(__kvm_vcpu_run_nvhe)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_vmid		6
> > +__KVM_HOST_HCALL(__kvm_tlb_flush_vmid)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___kvm_tlb_flush_vmid_ipa	7
> > +__KVM_HOST_HCALL(__kvm_tlb_flush_vmid_ipa)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_init_lrs		8
> > +__KVM_HOST_HCALL(__vgic_v3_init_lrs)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_get_ich_vtr_el2	9
> > +__KVM_HOST_HCALL(__vgic_v3_get_ich_vtr_el2)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_write_vmcr		10
> > +__KVM_HOST_HCALL(__vgic_v3_write_vmcr)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_restore_aprs	11
> > +__KVM_HOST_HCALL(__vgic_v3_restore_aprs)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_read_vmcr		12
> > +__KVM_HOST_HCALL(__vgic_v3_read_vmcr)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_save_aprs		13
> > +__KVM_HOST_HCALL(__vgic_v3_save_aprs)
> > +
> > +#define __KVM_HOST_HCALL_TABLE_IDX_SIZE				14
> 
> This whole thing screams "enum" into my ears. Having to maintain these
> as #defines feels like a pain, specially if the numbers are never used
> in assembly code. (and for that, we have asm-offset.h).

This is essentially inspired from the various 'unistd.h' files we have
in the kernel, e.g. include/uapi/asm-generic/unistd.h, which have
exactly this type of construct. So, this was really just for consistency,
but no strong opinion from me.

> 
> > +
> > +/* XXX - Arbitrary offset for KVM-related hypercalls */
> > +#define __KVM_HOST_HCALL_BASE_SHIFT 8
> > +#define __KVM_HOST_HCALL_BASE (1ULL << __KVM_HOST_HCALL_BASE_SHIFT)
> > +#define __KVM_HOST_HCALL_END (__KVM_HOST_HCALL_BASE + \
> > +			      __KVM_HOST_HCALL_TABLE_IDX_SIZE)
> 
> I don't really get what is this offset for. It is too small to be used
> to skip the stub hypercalls (you'd need to start at 0x1000).

Oh, OK. I assumed anything above HVC_STUB_HCALL_NR would be fine. But
yes, this offset is really arbitrary, so if 0x1000 is better then that
totally works. For my education, where is that 0x1000 coming from ?

> Given
> that you store the whole thing in an array, you're wasting some
> memory. I'm sure you have a good story for it though! ;-)

Note that the array's length is __KVM_HOST_HCALL_TABLE_IDX_SIZE, which
doesn't include the offset, so we shouldn't be wasting memory here.

> > +
> > +/* Hypercall number = kvm offset + table idx */
> > +#define KVM_HOST_HCALL_NR(name) (__KVM_HOST_HCALL_TABLE_IDX_##name + \
> > +				 __KVM_HOST_HCALL_BASE)
> > diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> > index 8c9880783839..29e2b2cd2fbc 100644
> > --- a/arch/arm64/kvm/hyp/Makefile
> > +++ b/arch/arm64/kvm/hyp/Makefile
> > @@ -9,7 +9,7 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
> >  obj-$(CONFIG_KVM) += hyp.o
> >  
> >  hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
> > -	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
> > +	 debug-sr.o entry.o switch.o fpsimd.o tlb.o host_hypercall.o hyp-entry.o
> >  
> >  # KVM code is run at a different exception code with a different map, so
> >  # compiler instrumentation that inserts callbacks or checks into the code may
> > diff --git a/arch/arm64/kvm/hyp/host_hypercall.c b/arch/arm64/kvm/hyp/host_hypercall.c
> > new file mode 100644
> > index 000000000000..6b31310f36a8
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/host_hypercall.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Google, inc
> > + */
> > +
> > +#include <asm/kvm_hyp.h>
> > +
> > +typedef long (*kvm_hcall_fn_t)(void);
> > +
> > +static long __hyp_text kvm_hc_ni(void)
> > +{
> > +       return -ENOSYS;
> > +}
> > +
> > +#undef __KVM_HOST_HCALL
> > +#define __KVM_HOST_HCALL(name) \
> > +	[__KVM_HOST_HCALL_TABLE_IDX_##name] = (long (*)(void))name,
> > +
> > +const kvm_hcall_fn_t kvm_hcall_table[__KVM_HOST_HCALL_TABLE_IDX_SIZE] = {
> > +	[0 ... __KVM_HOST_HCALL_TABLE_IDX_SIZE-1] = kvm_hc_ni,
> > +#include <asm/kvm_host_hypercalls.h>
> > +};
> 
> Cunning. At the same time, if you can do this once, you can do it
> twice, and generating the __KVM_HOST_HCALL_TABLE_IDX_* as an enum
> should be pretty easy, and could live in its own include file.

Right, and that again is inspired from the arm64 syscall table (see
arch/arm64/kernel/sys.c). So the first intention was to keep things
consistent. But again, no strong opinion :)

> > diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> > index c2a13ab3c471..1a51a0958504 100644
> > --- a/arch/arm64/kvm/hyp/hyp-entry.S
> > +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> > @@ -13,6 +13,7 @@
> >  #include <asm/kvm_arm.h>
> >  #include <asm/kvm_asm.h>
> >  #include <asm/kvm_mmu.h>
> > +#include <asm/kvm_host_hypercalls.h>
> >  #include <asm/mmu.h>
> >  
> >  	.text
> > @@ -21,17 +22,26 @@
> >  .macro do_el2_call
> >  	/*
> >  	 * Shuffle the parameters before calling the function
> > -	 * pointed to in x0. Assumes parameters in x[1,2,3].
> > +	 * pointed to in x0. Assumes parameters in x[1,2,3,4,5,6].
> >  	 */
> >  	str	lr, [sp, #-16]!
> >  	mov	lr, x0
> >  	mov	x0, x1
> >  	mov	x1, x2
> >  	mov	x2, x3
> > +	mov	x3, x4
> > +	mov	x4, x5
> > +	mov	x5, x6
> 
> Has any function changed prototype as part of this patch that they'd
> require this change? It doesn't look like it. I guess this should be
> part of another patch.

Ack, this isn't needed just yet so we should split that out.

> 
> >  	blr	lr
> >  	ldr	lr, [sp], #16
> >  .endm
> >  
> > +/* kern_hyp_va(lm_alias(ksym)) */
> > +.macro ksym_hyp_va ksym, lm_offset
> > +	sub	\ksym, \ksym, \lm_offset
> > +	kern_hyp_va	\ksym
> > +.endm
> > +
> >  el1_sync:				// Guest trapped into EL2
> >  
> >  	mrs	x0, esr_el2
> > @@ -66,10 +76,32 @@ el1_sync:				// Guest trapped into EL2
> >  	br	x5
> >  
> >  1:
> > +	/* Check if the hcall number is valid */
> > +	cmp	x0, #__KVM_HOST_HCALL_BASE
> > +	b.lt	2f
> > +	cmp	x0, #__KVM_HOST_HCALL_END
> > +	b.lt	3f
> > +2:
> > +	mov	x0, -ENOSYS
> > +	eret
> > +
> > +3:
> > +	/* Compute lm_alias() offset in x9 */
> > +	ldr_l	x9, kimage_voffset
> > +	ldr_l	x10, physvirt_offset
> > +	add	x9, x9, x10
> > +
> > +	/* Find hcall function pointer in the table */
> > +	ldr	x10, =kvm_hcall_table
> > +	ksym_hyp_va	x10, x9
> 
> Can't kvm_hcall_table be referenced with adr or adr_l? It'd certainly
> be nice to avoid the extra load for something that is essentially a
> build-time constant.

In fact David already has a nice patch that transforms the whole thing
in a jump table, which is much nicer. I'll let him share the details :)

> Another thing that could be improved is to keep the lm_alias offset
> somewhere, saving one load per entry. Not a huge deal.

Ack.

> > +	sub	x0, x0, #__KVM_HOST_HCALL_BASE
> > +	add	x0, x10, x0, lsl 3
> 
> The usual convention for immediate is to prefix them with #.

Noted, thanks.

> > +	ldr	x0, [x0]
> > +	ksym_hyp_va	x0, x9
> > +
> >  	/*
> >  	 * Perform the EL2 call
> >  	 */
> > -	kern_hyp_va	x0
> >  	do_el2_call
> >  
> >  	eret
> > -- 
> > 2.26.1
> > 
> > 

Thanks for the review!
Quentin
