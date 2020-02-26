Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C2C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2730C222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ7fCm7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBZRaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:30:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgBZRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582738201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWaFYELZAqp7S0DPNkT2/G/O9Nz8o6ax+ZJG3x3QOCg=;
        b=eZ7fCm7/8Dr/EIh2LUVg2GsIohLP2k6OW4b6D6qFmm6kO4YHwrO+FsS+06PrVAsca5WChC
        nLfKjHu5/dJmuzM9MEgAQeSbH/W4gnPhO+C/++PXMCBars4Vef8IL0QAIxkSHUaNeilgiY
        aELdb6Dj0pegDphBPZD0jCN2zakmV4M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-ntvSU_GWNqWTUCgztQ5Slw-1; Wed, 26 Feb 2020 12:30:00 -0500
X-MC-Unique: ntvSU_GWNqWTUCgztQ5Slw-1
Received: by mail-wr1-f70.google.com with SMTP id h4so57231wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PWaFYELZAqp7S0DPNkT2/G/O9Nz8o6ax+ZJG3x3QOCg=;
        b=KF6GhEeowclWOvBxwboRENnsXY1rHRbHqQPVaYBm2HpPFrRjnyIX2UdSAvRcbHafT8
         w82CdwyCjRAgpIPVDR/gj2qH6S7GdD9bKpDeG3yHeH8JxJZKs5X5qXz8N5Tco9EnBJEQ
         Ob5Lstjay7y58Bfy91BIqu0fN+Ht5MFJdPtga6osa6GzZmBq3CmODR5WkSoWaL4TK0jv
         TNTnwyeYjqvZpjW7D/R5ejB/8CRfWHMwH3hnf7Cx+B5a5eXsl5FR3cFl6QN6IfSI10VK
         eqxGJOVMNGVZyOjz/QuCFlSUEFSikIoGFBXQrCt3/puB8yNDDv15iJ1duwgIEXqQApaB
         vTsg==
X-Gm-Message-State: APjAAAUEXvaqZaofu2zbmbB7NzYfQmQq/WTI2AnuGFzCYxX5Anu6TKpY
        WEedXxiQwjlr6yyR4yQoNI0/BfZGXn2S2aSBsKFWQGB2dx2KPe+Xvo3Ac6i+jYosqDEF1pagv3v
        OPt8YnBbjA2c37X903/K3wcGJ
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr7005756wrm.302.1582738198231;
        Wed, 26 Feb 2020 09:29:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZZSajn9L+tisuQJAgphv9J/6zT8Z7M0xLGnp4b/Jy3DRzWGmPgqUKLLs3ljygtbc2azw6mQ==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr7005730wrm.302.1582738197925;
        Wed, 26 Feb 2020 09:29:57 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j16sm4155888wru.68.2020.02.26.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:29:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] KVM: x86: Dynamically allocate per-vCPU emulation context
In-Reply-To: <20200218232953.5724-9-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-9-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 18:29:56 +0100
Message-ID: <87wo89i7e3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Allocate the emulation context instead of embedding it in struct
> kvm_vcpu_arch.
>
> Dynamic allocation provides several benefits:
>
>   - Shrinks the size x86 vcpus by ~2.5k bytes, dropping them back below
>     the PAGE_ALLOC_COSTLY_ORDER threshold.
>   - Allows for dropping the include of kvm_emulate.h from asm/kvm_host.h
>     and moving kvm_emulate.h into KVM's private directory.
>   - Allows a reducing KVM's attack surface by shrinking the amount of
>     vCPU data that is exposed to usercopy.
>   - Allows a future patch to disable the emulator entirely, which may or
>     may not be a realistic endeavor.
>
> Mark the entire struct as valid for usercopy to maintain existing
> behavior with respect to hardened usercopy.  Future patches can shrink
> the usercopy range to cover only what is necessary.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_emulate.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  2 +-
>  arch/x86/kvm/x86.c                 | 61 ++++++++++++++++++++++++++----
>  3 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
> index 03946eb3e2b9..2f0a600efdff 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -293,6 +293,7 @@ enum x86emul_mode {
>  #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
>  
>  struct x86_emulate_ctxt {
> +	void *vcpu;

Why 'void *'? I changed this to 'struct kvm_vcpu *' and it seems to
compile just fine...

>  	const struct x86_emulate_ops *ops;
>  
>  	/* Register state before/after emulation. */
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c750cd957558..e069f71667b1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -678,7 +678,7 @@ struct kvm_vcpu_arch {
>  
>  	/* emulate context */
>  
> -	struct x86_emulate_ctxt emulate_ctxt;
> +	struct x86_emulate_ctxt *emulate_ctxt;
>  	bool emulate_regs_need_sync_to_vcpu;
>  	bool emulate_regs_need_sync_from_vcpu;
>  	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0e67f90db9a6..5ab7d4283185 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -81,7 +81,7 @@ u64 __read_mostly kvm_mce_cap_supported = MCG_CTL_P | MCG_SER_P;
>  EXPORT_SYMBOL_GPL(kvm_mce_cap_supported);
>  
>  #define emul_to_vcpu(ctxt) \
> -	container_of(ctxt, struct kvm_vcpu, arch.emulate_ctxt)
> +	((struct kvm_vcpu *)(ctxt)->vcpu)
>  
>  /* EFER defaults:
>   * - enable syscall per default because its emulated by KVM
> @@ -230,6 +230,19 @@ u64 __read_mostly host_xcr0;
>  struct kmem_cache *x86_fpu_cache;
>  EXPORT_SYMBOL_GPL(x86_fpu_cache);
>  
> +static struct kmem_cache *x86_emulator_cache;
> +
> +static struct kmem_cache *kvm_alloc_emulator_cache(void)
> +{
> +	return kmem_cache_create_usercopy("x86_emulator",
> +					  sizeof(struct x86_emulate_ctxt),
> +					  __alignof__(struct x86_emulate_ctxt),
> +					  SLAB_ACCOUNT,
> +					  0,
> +					  sizeof(struct x86_emulate_ctxt),
> +					  NULL);
> +}
> +
>  static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
>  
>  static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
> @@ -6414,6 +6427,23 @@ static bool inject_emulated_exception(struct x86_emulate_ctxt *ctxt)
>  	return false;
>  }
>  
> +static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
> +{
> +	struct x86_emulate_ctxt *ctxt;
> +
> +	ctxt = kmem_cache_zalloc(x86_emulator_cache, GFP_KERNEL_ACCOUNT);
> +	if (!ctxt) {
> +		pr_err("kvm: failed to allocate vcpu's emulator\n");
> +		return NULL;
> +	}
> +
> +	ctxt->vcpu = vcpu;
> +	ctxt->ops = &emulate_ops;
> +	vcpu->arch.emulate_ctxt = ctxt;
> +
> +	return ctxt;
> +}
> +
>  static void init_emulate_ctxt(struct x86_emulate_ctxt *ctxt)
>  {
>  	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> @@ -6440,7 +6470,7 @@ static void init_emulate_ctxt(struct x86_emulate_ctxt *ctxt)
>  
>  void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip)
>  {
> -	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
> +	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  	int ret;
>  
>  	init_emulate_ctxt(ctxt);
> @@ -6756,7 +6786,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  			    int emulation_type, void *insn, int insn_len)
>  {
>  	int r;
> -	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
> +	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  	bool writeback = true;
>  	bool write_fault_to_spt = vcpu->arch.write_fault_to_shadow_pgtable;
>  
> @@ -7339,10 +7369,16 @@ int kvm_arch_init(void *opaque)
>  		goto out;
>  	}
>  
> +	x86_emulator_cache = kvm_alloc_emulator_cache();
> +	if (!x86_emulator_cache) {
> +		pr_err("kvm: failed to allocate cache for x86 emulator\n");
> +		goto out_free_x86_fpu_cache;
> +	}
> +
>  	shared_msrs = alloc_percpu(struct kvm_shared_msrs);
>  	if (!shared_msrs) {
>  		printk(KERN_ERR "kvm: failed to allocate percpu kvm_shared_msrs\n");
> -		goto out_free_x86_fpu_cache;
> +		goto out_free_x86_emulator_cache;
>  	}
>  
>  	r = kvm_mmu_module_init();
> @@ -7375,6 +7411,8 @@ int kvm_arch_init(void *opaque)
>  
>  out_free_percpu:
>  	free_percpu(shared_msrs);
> +out_free_x86_emulator_cache:
> +	kmem_cache_destroy(x86_emulator_cache);
>  out_free_x86_fpu_cache:
>  	kmem_cache_destroy(x86_fpu_cache);
>  out:
> @@ -8754,7 +8792,7 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  		 * that usually, but some bad designed PV devices (vmware
>  		 * backdoor interface) need this to work
>  		 */
> -		emulator_writeback_register_cache(&vcpu->arch.emulate_ctxt);
> +		emulator_writeback_register_cache(vcpu->arch.emulate_ctxt);
>  		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
>  	}
>  	regs->rax = kvm_rax_read(vcpu);
> @@ -8940,7 +8978,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  		    int reason, bool has_error_code, u32 error_code)
>  {
> -	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
> +	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  	int ret;
>  
>  	init_emulate_ctxt(ctxt);
> @@ -9273,7 +9311,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	struct page *page;
>  	int r;
>  
> -	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
>  	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
>  		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  	else
> @@ -9311,11 +9348,14 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  				GFP_KERNEL_ACCOUNT))
>  		goto fail_free_mce_banks;
>  
> +	if (!alloc_emulate_ctxt(vcpu))
> +		goto free_wbinvd_dirty_mask;
> +
>  	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
>  						GFP_KERNEL_ACCOUNT);
>  	if (!vcpu->arch.user_fpu) {
>  		pr_err("kvm: failed to allocate userspace's fpu\n");
> -		goto free_wbinvd_dirty_mask;
> +		goto free_emulate_ctxt;
>  	}
>  
>  	vcpu->arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
> @@ -9357,6 +9397,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
>  free_user_fpu:
>  	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
> +free_emulate_ctxt:
> +	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
>  free_wbinvd_dirty_mask:
>  	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
>  fail_free_mce_banks:
> @@ -9409,6 +9451,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  
>  	kvm_x86_ops->vcpu_free(vcpu);
>  
> +	if (vcpu->arch.emulate_ctxt)
> +		kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);

Checking for NULL here seems superfluous as we create the context in
kvm_arch_vcpu_create() unconditionally. I'd suggest we move the check to 
"[PATCH v2 12/13] KVM: x86: Add variable to control existence of
emulator" where 'enable_emulator' global is added.

> +
>  	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
>  	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
>  	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);

-- 
Vitaly

