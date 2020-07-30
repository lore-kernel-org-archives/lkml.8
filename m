Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A1B2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II1kswmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgG3I7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:59:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27320 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgG3I7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596099575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdxRMpm/pZA1NsiYA+o59yt28QeE/ohtoEKvTQssaTw=;
        b=II1kswmxG3wh6WOTdCpcic/ztNveb+3iyPfIxVjr+HRZSYgIqsnY7xTsa2j+MpfQq0Tge4
        9GB5mV1pDCsG38YUBdr9/Mj0MkcqsdVl/NvpVU6eALhNIVw7dYZWB6baifAdr6FPAq4YE2
        hJSUE5TIXaO9Rm4HtMNMoL0l2+0mLu0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-yopgKPFQPW-ytrAk5hLeQw-1; Thu, 30 Jul 2020 04:59:33 -0400
X-MC-Unique: yopgKPFQPW-ytrAk5hLeQw-1
Received: by mail-ej1-f71.google.com with SMTP id a19so4148800ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qdxRMpm/pZA1NsiYA+o59yt28QeE/ohtoEKvTQssaTw=;
        b=hwvgDymYAw9eTd4pKhyWgmQlZY2c4Hxm7OEgcv6FImXhlD8nVQywqXJoyM7fcgQa+a
         zjtaeUkmyqWZAleaBp5lDu6O4cYJsZGjGLAjPuGT7EgLLymDhnMvWJj2VaVvrwRyk5vH
         xLJigCf+5H2W6lSEji96oNs/EpnKCVb/kaMXLjXC9j8ISdI/zzy0nowHN5OX7zAPfy0R
         aEKTsl2LSpGm8nm8VX8N/HfpNCuROYG+Owv4xWTxpvaCdrt0Gm1bTLPhTQQhXK1j/iFC
         hk9CKYgtrMShlJUuoVPZzXhCG46WqxAjA2P1cFcu6MS2QKVpzdo3FgaavOcwxcL9yGXf
         lLVA==
X-Gm-Message-State: AOAM530ZMPkvKPTg6w+Lcj39UDaeNg8Za/TNDsxHJXCthW86GWrf0ISn
        28ytyTjFTJ5fdCH35bIv71v1gTeDC5wbVwVPX7fuM9sjbquUm1sklfjyhkmuWQn0WSJcCrdM0Kt
        GOzPdWIqqt0vfRoDgRuuGoqVr
X-Received: by 2002:a17:906:e10e:: with SMTP id gj14mr1720543ejb.218.1596099571844;
        Thu, 30 Jul 2020 01:59:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM2wRcfvMoNY4OeNoiMMF6RHSwityFqsCunaJ3RUA0xLg+JIuT1imJKeVu9PtF2WNgTGEsDQ==
X-Received: by 2002:a17:906:e10e:: with SMTP id gj14mr1720525ejb.218.1596099571444;
        Thu, 30 Jul 2020 01:59:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x21sm5126723edq.84.2020.07.30.01.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 01:59:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Alexander Graf <graf@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: x86: Introduce allow list for MSR emulation
In-Reply-To: <20200729235929.379-3-graf@amazon.com>
References: <20200729235929.379-1-graf@amazon.com> <20200729235929.379-3-graf@amazon.com>
Date:   Thu, 30 Jul 2020 10:59:29 +0200
Message-ID: <87eeotl6oe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Graf <graf@amazon.com> writes:

> It's not desireable to have all MSRs always handled by KVM kernel space. Some
> MSRs would be useful to handle in user space to either emulate behavior (like
> uCode updates) or differentiate whether they are valid based on the CPU model.
>
> To allow user space to specify which MSRs it wants to see handled by KVM,
> this patch introduces a new ioctl to push allow lists of bitmaps into
> KVM. Based on these bitmaps, KVM can then decide whether to reject MSR access.
> With the addition of KVM_CAP_X86_USER_SPACE_MSR it can also deflect the
> denied MSR events to user space to operate on.
>
> If no allowlist is populated, MSR handling stays identical to before.
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  Documentation/virt/kvm/api.rst  |  53 ++++++++++++++
>  arch/x86/include/asm/kvm_host.h |  10 +++
>  arch/x86/include/uapi/asm/kvm.h |  15 ++++
>  arch/x86/kvm/x86.c              | 123 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |   4 ++
>  5 files changed, 205 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index c1f991c1ffa6..ca92b9e2cded 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4697,6 +4697,45 @@ KVM_PV_VM_VERIFY
>    Verify the integrity of the unpacked image. Only if this succeeds,
>    KVM is allowed to start protected VCPUs.
>  
> +4.126 KVM_ADD_MSR_ALLOWLIST
> +-------------------------
> +
> +:Capability: KVM_CAP_ADD_MSR_ALLOWLIST
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: struct kvm_msr_allowlist
> +:Returns: 0 on success, < 0 on error
> +
> +::
> +
> +  struct kvm_msr_allowlist {
> +         __u32 flags;
> +         __u32 nmsrs; /* number of msrs in bitmap */
> +         __u32 base;  /* base address for the MSRs bitmap */
> +         __u32 pad;
> +
> +         __u8 bitmap[0]; /* a set bit allows that the operation set in flags */
> +  };
> +
> +This ioctl allows user space to define a set of bitmaps of MSR ranges to
> +specify whether a certain MSR access is allowed or not.
> +
> +If this ioctl has never been invoked, MSR accesses are not guarded and the
> +old KVM in-kernel emulation behavior is fully preserved.
> +
> +As soon as the first allow list was specified, only allowed MSR accesses
> +are permitted inside of KVM's MSR code.
> +
> +Each allowlist specifies a range of MSRs to potentially allow access on.
> +The range goes from MSR index [base .. base+nmsrs]. The flags field
> +indicates whether reads, writes or both reads and writes are permitted
> +by setting a 1 bit in the bitmap for the corresponding MSR index.

I think it would make sense to add KVM_MSR_ALLOW_READ/WRITE definitions
here as well to make the doc complete.

> +
> +If an MSR access is not permitted through the allow list, it generates a
> +#GP inside the guest. When combined with KVM_CAP_X86_USER_SPACE_MSR, that
> +allows user space to deflect and potentially handle various MSR accesses
> +into user space.
> +
>  
>  5. The kvm_run structure
>  ========================
> @@ -6213,3 +6252,17 @@ writes to user space. It can be enabled on a VM level. If enabled, MSR
>  accesses that would usually trigger a #GP by KVM into the guest will
>  instead get bounced to user space through the KVM_EXIT_RDMSR and
>  KVM_EXIT_WRMSR exit notifications.
> +
> +8.25 KVM_CAP_ADD_MSR_ALLOWLIST
> +------------------------------
> +
> +:Architectures: x86
> +
> +This capability indicates that KVM supports emulation of only select MSR
> +registers. With this capability exposed, KVM exports a new VM ioctl
> +KVM_ADD_MSR_ALLOWLIST which allows user space to specify bitmaps of MSR
> +ranges that KVM should emulate in kernel space.
> +
> +In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
> +trap and emulate MSRs that are outside of the scope of KVM as well as
> +limit the attack surface on KVM's MSR emulation code.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2f2307e71342..4b1ff7cb848f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -901,6 +901,13 @@ struct kvm_hv {
>  	struct kvm_hv_syndbg hv_syndbg;
>  };
>  
> +struct msr_bitmap_range {
> +	u32 flags;
> +	u32 nmsrs;
> +	u32 base;
> +	unsigned long *bitmap;
> +};
> +
>  enum kvm_irqchip_mode {
>  	KVM_IRQCHIP_NONE,
>  	KVM_IRQCHIP_KERNEL,       /* created with KVM_CREATE_IRQCHIP */
> @@ -1005,6 +1012,9 @@ struct kvm_arch {
>  	/* Deflect RDMSR and WRMSR to user space when they trigger a #GP */
>  	bool user_space_msr_enabled;
>  
> +	struct msr_bitmap_range msr_allowlist_ranges[10];
> +	int msr_allowlist_ranges_count;
> +
>  	struct kvm_pmu_event_filter *pmu_event_filter;
>  	struct task_struct *nx_lpage_recovery_thread;
>  };
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 0780f97c1850..bd640a43cad6 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -192,6 +192,21 @@ struct kvm_msr_list {
>  	__u32 indices[0];
>  };
>  
> +#define KVM_MSR_ALLOW_READ  (1 << 0)
> +#define KVM_MSR_ALLOW_WRITE (1 << 1)

Nit: BIT(0)/BIT(1) maybe?

> +
> +/* Maximum size of the of the bitmap in bytes */
> +#define KVM_MSR_ALLOWLIST_MAX_LEN 0x600
> +
> +/* for KVM_ADD_MSR_ALLOWLIST */
> +struct kvm_msr_allowlist {
> +	__u32 flags;
> +	__u32 nmsrs; /* number of msrs in bitmap */
> +	__u32 base;  /* base address for the MSRs bitmap */
> +	__u32 pad;
> +
> +	__u8 bitmap[0]; /* a set bit allows that the operation set in flags */
> +};
>  
>  struct kvm_cpuid_entry {
>  	__u32 function;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 11e94a780656..924baec58d87 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1472,6 +1472,29 @@ void kvm_enable_efer_bits(u64 mask)
>  }
>  EXPORT_SYMBOL_GPL(kvm_enable_efer_bits);
>  
> +static bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
> +{
> +	struct msr_bitmap_range *ranges = vcpu->kvm->arch.msr_allowlist_ranges;
> +	u32 count = vcpu->kvm->arch.msr_allowlist_ranges_count;
> +	u32 i;
> +
> +	/* MSR allowlist not set up, allow everything */
> +	if (!count)
> +		return true;
> +
> +	for (i = 0; i < count; i++) {
> +		u32 start = ranges[i].base;
> +		u32 end = start + ranges[i].nmsrs;
> +		int flags = ranges[i].flags;
> +		unsigned long *bitmap = ranges[i].bitmap;
> +
> +		if ((index >= start) && (index < end) && (flags & type))
> +			return !!test_bit(index - start, bitmap);
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Write @data into the MSR specified by @index.  Select MSR specific fault
>   * checks are bypassed if @host_initiated is %true.
> @@ -1483,6 +1506,9 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  {
>  	struct msr_data msr;
>  
> +	if (!host_initiated && !kvm_msr_allowed(vcpu, index, KVM_MSR_ALLOW_WRITE))
> +		return -ENOENT;
> +
>  	switch (index) {
>  	case MSR_FS_BASE:
>  	case MSR_GS_BASE:
> @@ -1528,6 +1554,9 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  	struct msr_data msr;
>  	int ret;
>  
> +	if (!host_initiated && !kvm_msr_allowed(vcpu, index, KVM_MSR_ALLOW_READ))
> +		return -ENOENT;
> +
>  	msr.index = index;
>  	msr.host_initiated = host_initiated;
>  
> @@ -3549,6 +3578,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_EXCEPTION_PAYLOAD:
>  	case KVM_CAP_SET_GUEST_DEBUG:
>  	case KVM_CAP_X86_USER_SPACE_MSR:
> +	case KVM_CAP_ADD_MSR_ALLOWLIST:
>  		r = 1;
>  		break;
>  	case KVM_CAP_SYNC_REGS:
> @@ -5074,6 +5104,92 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  	return r;
>  }
>  
> +static bool msr_range_overlaps(struct kvm *kvm, struct msr_bitmap_range *range)
> +{
> +	struct msr_bitmap_range *ranges = kvm->arch.msr_allowlist_ranges;
> +	u32 i, count = kvm->arch.msr_allowlist_ranges_count;
> +
> +	for (i = 0; i < count; i++) {
> +		u32 start = max(range->base, ranges[i].base);
> +		u32 end = min(range->base + range->nmsrs,
> +			      ranges[i].base + ranges[i].nmsrs);
> +
> +		if ((start < end) && (range->flags & ranges[i].flags))
> +			return true;
> +	}
> +
> +	return false;
> +}

It is a bit weird that we can only add something to allowlist, there is
no way to remove anything/everything from it.

E.g. if I add a range of msrs allowing read access only but later some
feature gets enabled and I'd like to convert some of these MSRs to
read/write, I, apparently can add overlapping ranges with "write-only"
access (as range->flags & ranges[i].flags allows me to do that) but I
can't add an overlapping 'read/write' region. This is not obvious.

> +
> +static int kvm_vm_ioctl_add_msr_allowlist(struct kvm *kvm, void __user *argp)
> +{
> +	struct msr_bitmap_range *ranges = kvm->arch.msr_allowlist_ranges;
> +	struct kvm_msr_allowlist __user *user_msr_allowlist = argp;
> +	struct msr_bitmap_range range;
> +	struct kvm_msr_allowlist kernel_msr_allowlist;
> +	unsigned long *bitmap = NULL;
> +	size_t bitmap_size;
> +	int r;
> +
> +	if (copy_from_user(&kernel_msr_allowlist, user_msr_allowlist,
> +			   sizeof(kernel_msr_allowlist))) {
> +		r = -EFAULT;
> +		goto out_err;
> +	}
> +
> +	bitmap_size = BITS_TO_LONGS(kernel_msr_allowlist.nmsrs) * sizeof(long);
> +	if (bitmap_size > KVM_MSR_ALLOWLIST_MAX_LEN) {
> +		r = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	bitmap = memdup_user(user_msr_allowlist->bitmap, bitmap_size);
> +	if (IS_ERR(bitmap)) {
> +		r = PTR_ERR(bitmap);
> +		goto out_err;
> +	}
> +
> +	range = (struct msr_bitmap_range) {
> +		.flags = kernel_msr_allowlist.flags,
> +		.base = kernel_msr_allowlist.base,
> +		.nmsrs = kernel_msr_allowlist.nmsrs,
> +		.bitmap = bitmap,
> +	};
> +
> +	if (range.flags & ~(KVM_MSR_ALLOW_READ | KVM_MSR_ALLOW_WRITE)) {
> +		r = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	/*
> +	 * Protect from concurrent calls to this function that could trigger
> +	 * a TOCTOU violation on kvm->arch.msr_allowlist_ranges_count.
> +	 */
> +	mutex_lock(&kvm->lock);
> +
> +	if (kvm->arch.msr_allowlist_ranges_count >=
> +	    ARRAY_SIZE(kvm->arch.msr_allowlist_ranges)) {
> +		r = -E2BIG;
> +		goto out_err;
> +	}
> +
> +	if (msr_range_overlaps(kvm, &range)) {
> +		r = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	/* Everything ok, add this range identifier to our global pool */
> +	ranges[kvm->arch.msr_allowlist_ranges_count++] = range;
> +
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +
> +out_err:

You seem to forget to unlock &kvm->lock here.

> +	kfree(bitmap);
> +	return r;
> +}
> +
>  long kvm_arch_vm_ioctl(struct file *filp,
>  		       unsigned int ioctl, unsigned long arg)
>  {
> @@ -5380,6 +5496,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	case KVM_SET_PMU_EVENT_FILTER:
>  		r = kvm_vm_ioctl_set_pmu_event_filter(kvm, argp);
>  		break;
> +	case KVM_ADD_MSR_ALLOWLIST:
> +		r = kvm_vm_ioctl_add_msr_allowlist(kvm, argp);
> +		break;
>  	default:
>  		r = -ENOTTY;
>  	}
> @@ -10091,6 +10210,8 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
>  
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> +	int i;
> +
>  	if (current->mm == kvm->mm) {
>  		/*
>  		 * Free memory regions allocated on behalf of userspace,
> @@ -10107,6 +10228,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  	}
>  	if (kvm_x86_ops.vm_destroy)
>  		kvm_x86_ops.vm_destroy(kvm);
> +	for (i = 0; i < kvm->arch.msr_allowlist_ranges_count; i++)
> +		kfree(kvm->arch.msr_allowlist_ranges[i].bitmap);
>  	kvm_pic_destroy(kvm);
>  	kvm_ioapic_destroy(kvm);
>  	kvm_free_vcpus(kvm);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index df237bf2bdc2..44ee9df8007f 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1042,6 +1042,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HALT_POLL 182
>  #define KVM_CAP_ASYNC_PF_INT 183
>  #define KVM_CAP_X86_USER_SPACE_MSR 184
> +#define KVM_CAP_ADD_MSR_ALLOWLIST 185

X86?

>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1543,6 +1544,9 @@ struct kvm_pv_cmd {
>  /* Available with KVM_CAP_S390_PROTECTED */
>  #define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
>  
> +/* Available with KVM_CAP_ADD_MSR_ALLOWLIST */
> +#define KVM_ADD_MSR_ALLOWLIST     _IOW(KVMIO,  0xc6, struct kvm_msr_allowlist)
> +
>  /* Secure Encrypted Virtualization command */
>  enum sev_cmd_id {
>  	/* Guest initialization commands */

-- 
Vitaly

