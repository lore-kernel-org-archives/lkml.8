Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C79C4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5300D20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkGBsigT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBZSBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:01:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbgBZSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582740091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+j9PbT5QAZpP/mItAsMzoO98L8Enk3oE2QSK5MgUDSA=;
        b=VkGBsigTDqIQhDSrUu4xKStr4EpkKnUbveXL41M3Uuuf2nVYtTeDWU/NteQ2wGuUmz2aHN
        DhKqx2nB/kE8dVNGEKxGcrDE4MIntMWy5ZJERwYyfz4gwP9Luy4BSi9f6A/CYVGPsmIFBS
        v0aWofD6fCThNiwzvyOVg59vrXyoz94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-aKYTksPKNo-kNz1pjlmtNQ-1; Wed, 26 Feb 2020 13:01:29 -0500
X-MC-Unique: aKYTksPKNo-kNz1pjlmtNQ-1
Received: by mail-wm1-f71.google.com with SMTP id c5so874330wmd.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+j9PbT5QAZpP/mItAsMzoO98L8Enk3oE2QSK5MgUDSA=;
        b=m1UAvs2vSIneyJJmiGB3bw7hggkOY3wlkcwBPHnOWyecUHfAs8d3KCCnbcrX2xNKIt
         o8fGrpxYQqo3WL7Jxsmnp6N5vBJC/frbvhyeFTWIpgVRbHgUwlSC/0VW6iyOxtCGXh3k
         Jolfo2U4ImoV4YaxqQv5NMaunHvu7AmGV8ALKcM4SGPOl/HSqNCZBIy0ZcmX627bN0M2
         p5D0W0g0d8j6YDFLMFHKBbBD0QAJmXnP3dadV9Q27HUeC4C3kQ2gEqEyQjof8CjY2+dp
         uIkruxAy9/ysFOMx/Qa6OD5CUQaoSrW7/PSs6vyYR/nP4PxVfZs68e7pTYaxzGkFl1fb
         +u0w==
X-Gm-Message-State: APjAAAWuBmK65cGGcpodEXN6R0GT9k3YsYiCKghhlA/BRuxCRYixUb4I
        2Gyu/BbMkZwfW1xhsx1G6/PcnTl1iRNikDsggkvtRxuuEU5IYW4Hk5U4QSH6etEsGhZihNb7ZRY
        gwnoZwqxsgPy+jYO/r/ulVQf1
X-Received: by 2002:a5d:6411:: with SMTP id z17mr7070240wru.57.1582740087721;
        Wed, 26 Feb 2020 10:01:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwI/tB5gPzUUtrLtMjPQZmicXa9lh8ssIM/ynrqM2BBE3oMo3Yidd0H5ZVKOIFp8Q1j1UU+fw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr7070191wru.57.1582740087215;
        Wed, 26 Feb 2020 10:01:27 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b82sm3669800wmb.16.2020.02.26.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:01:26 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/13] KVM: x86: Add variable to control existence of emulator
In-Reply-To: <20200218232953.5724-13-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-13-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 19:01:25 +0100
Message-ID: <87lfopi5xm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add a global variable to control whether or not the emulator is enabled,
> and make all necessary changes to gracefully handle reaching emulation
> paths with the emulator disabled.
>
> Running with VMX's unrestricted guest disabled requires special
> consideration due to its use of kvm_inject_realmode_interrupt().  When
> unrestricted guest is disabled, KVM emulates interrupts and exceptions
> when the processor is in real mode, but does so without going through
> the standard emulator loop.  Ideally, kvm_inject_realmode_interrupt()
> would only log the interrupt and defer actual emulation to the standard
> run loop, but that is a non-trivial change and a waste of resources
> given that unrestricted guest is supported on all CPUs shipped within
> the last decade.  Similarly, dirtying up the event injection stack for
> such a legacy feature is undesirable.  To avoid the conundrum, prevent
> disabling both the emulator and unrestricted guest.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/svm.c              |  2 +-
>  arch/x86/kvm/vmx/vmx.c          |  7 ++++++-
>  arch/x86/kvm/x86.c              | 18 +++++++++++++++---
>  4 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 0dfe11f30d7f..c4baac32a291 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1050,7 +1050,7 @@ struct kvm_x86_ops {
>  	int (*hardware_enable)(void);
>  	void (*hardware_disable)(void);
>  	int (*check_processor_compatibility)(void);/* __init */
> -	int (*hardware_setup)(void);               /* __init */
> +	int (*hardware_setup)(bool enable_emulator); /* __init */
>  	void (*hardware_unsetup)(void);            /* __exit */
>  	bool (*cpu_has_accelerated_tpr)(void);
>  	bool (*has_emulated_msr)(int index);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index ae62ea454158..810139b3bfe4 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1350,7 +1350,7 @@ static __init void svm_adjust_mmio_mask(void)
>  	kvm_mmu_set_mmio_spte_mask(mask, mask, PT_WRITABLE_MASK | PT_USER_MASK);
>  }
>  
> -static __init int svm_hardware_setup(void)
> +static __init int svm_hardware_setup(bool enable_emulator)
>  {
>  	int cpu;
>  	struct page *iopm_pages;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 09bb0d98afeb..e05d36f63b73 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7548,7 +7548,7 @@ static bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
>  	return to_vmx(vcpu)->nested.vmxon;
>  }
>  
> -static __init int hardware_setup(void)
> +static __init int hardware_setup(bool enable_emulator)
>  {
>  	unsigned long host_bndcfgs;
>  	struct desc_ptr dt;
> @@ -7595,6 +7595,11 @@ static __init int hardware_setup(void)
>  	if (!cpu_has_virtual_nmis())
>  		enable_vnmi = 0;
>  
> +	if (!enable_emulator && !enable_unrestricted_guest) {
> +		pr_warn("kvm: unrestricted guest disabled, emulator must be enabled\n");
> +		return -EIO;
> +	}
> +
>  	/*
>  	 * set_apic_access_page_addr() is used to reload apic access
>  	 * page upon invalidation.  No need to do anything if not
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7bffdc6f9e1b..f9134e1104c2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -159,6 +159,8 @@ EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
>  static bool __read_mostly force_emulation_prefix = false;
>  module_param(force_emulation_prefix, bool, S_IRUGO);
>  
> +static const bool enable_emulator = true;
> +
>  int __read_mostly pi_inject_timer = -1;
>  module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
>  
> @@ -6474,6 +6476,9 @@ void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip)
>  	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  	int ret;
>  
> +	if (WARN_ON_ONCE(!ctxt))
> +		return;
> +
>  	init_emulate_ctxt(ctxt);
>  
>  	ctxt->op_bytes = 2;
> @@ -6791,6 +6796,9 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  	bool writeback = true;
>  	bool write_fault_to_spt = vcpu->arch.write_fault_to_shadow_pgtable;
>  
> +	if (!ctxt)
> +		return internal_emulation_error(vcpu);
> +
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
>  	/*
> @@ -8785,7 +8793,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  
>  static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> -	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
> +	if (vcpu->arch.emulate_regs_need_sync_to_vcpu &&
> +	    !(WARN_ON_ONCE(!vcpu->arch.emulate_ctxt))) {
>  		/*
>  		 * We are here if userspace calls get_regs() in the middle of
>  		 * instruction emulation. Registers state needs to be copied
> @@ -8982,6 +8991,9 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  	int ret;
>  
> +	if (!ctxt)
> +		return internal_emulation_error(vcpu);
> +
>  	init_emulate_ctxt(ctxt);
>  
>  	ret = emulator_task_switch(ctxt, tss_selector, idt_index, reason,
> @@ -9345,7 +9357,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  				GFP_KERNEL_ACCOUNT))
>  		goto fail_free_mce_banks;
>  
> -	if (!alloc_emulate_ctxt(vcpu))
> +	if (enable_emulator && !alloc_emulate_ctxt(vcpu))
>  		goto free_wbinvd_dirty_mask;
>  
>  	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
> @@ -9651,7 +9663,7 @@ int kvm_arch_hardware_setup(void)
>  {
>  	int r;
>  
> -	r = kvm_x86_ops->hardware_setup();
> +	r = kvm_x86_ops->hardware_setup(enable_emulator);
>  	if (r != 0)
>  		return r;

I'm not sure that emulator disablement should _only_ be a global
varaiable, i.e. why can't we do it for some VMs and allow for others?
(we can even run different userspaces for different needs). This,
however, is complementary.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(I hope we have some userspaces which are already onboard)

-- 
Vitaly

