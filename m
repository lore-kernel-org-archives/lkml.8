Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508E9C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3068021973
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZV03zoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDSUq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:46:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587329186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYLscaipbpGaDqlHvBu8FlIWcjCnc2WaOfL03yyepS0=;
        b=dZV03zoIsEp576owEp02sFHHw1HWCb462ycusxH6gTuA4Jovpnilr1LZXtA14bgiGCPmHz
        dhqXUj3iqFfMNoeH3NvDlf2gYn1bqlEXVKb9aHPyGNGNFLpvhHq6kQKJ3+QgOCBTVXHusA
        IBzfpw0zPTUjFQonryOIKF7yXsljnoA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-YKeyPkA9N7mjvPSUFqj5gQ-1; Sun, 19 Apr 2020 16:46:24 -0400
X-MC-Unique: YKeyPkA9N7mjvPSUFqj5gQ-1
Received: by mail-wm1-f69.google.com with SMTP id 14so2774824wmo.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QYLscaipbpGaDqlHvBu8FlIWcjCnc2WaOfL03yyepS0=;
        b=T5bQsxDegs1xlqUX11tQ1HACsTMLZ6fAFH3al7YjsC0PmHcmFRiduvozejoX4wukdk
         toNVbFBhdt3GdZDm+OC2zk9AQSO1LL8J9yEbsRW8+TsHOYD4aXp1jfaCVsZuaJCESga2
         rLkxLhP4btyhY0pMh+IbDKc1OZJ7a2G/ucT5fnAiurFdzkoBZzcjdgg0Utle1zrjwCHo
         gcdhxzhWh1opDv1L1wx+ilQ343uXfltYgyb8yj9tTeOMm4G5uwFdio4SHMRbjXIq3maV
         uUDZzwx1UQ0xDh4nT46EP5xaHRjmaVRdnWkelwCNjsGsi/BczkfXIwJh/gQ+TxXJsgAr
         M0KA==
X-Gm-Message-State: AGi0PuarmwNb5Rib7yHoqzirqHgbW3uuj6qUCkcVSpKz/DT/81lnczyi
        LkT2uBbzYoYkbFORVgg+jcAAzJOAUpzhpl8o7hgXD2cVuEI8Dqs4TjNkRX9yGEi5yj07r2Iv5AB
        hsIEDiSmxa5znF+GiqqSyhK1P
X-Received: by 2002:a5d:428a:: with SMTP id k10mr15170070wrq.59.1587329182440;
        Sun, 19 Apr 2020 13:46:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ26BjuQ80y8lQHVdWuiefce0zg/HlUqcog4tzz6stRarLO++VB/dMipAIEjiP2oQy9+4pD5A==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr15170053wrq.59.1587329182151;
        Sun, 19 Apr 2020 13:46:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n2sm20689701wrq.74.2020.04.19.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 13:46:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Cargille <jcargill@google.com>
Cc:     David Matlack <dmatlack@google.com>,
        Jon Cargille <jcargill@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: add capability for halt polling
In-Reply-To: <20200417221446.108733-1-jcargill@google.com>
References: <20200417221446.108733-1-jcargill@google.com>
Date:   Sun, 19 Apr 2020 22:46:20 +0200
Message-ID: <87d083td9f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Cargille <jcargill@google.com> writes:

> From: David Matlack <dmatlack@google.com>
>
> KVM_CAP_HALT_POLL is a per-VM capability that lets userspace
> control the halt-polling time, allowing halt-polling to be tuned or
> disabled on particular VMs.
>
> With dynamic halt-polling, a VM's VCPUs can poll from anywhere from
> [0, halt_poll_ns] on each halt. KVM_CAP_HALT_POLL sets the
> upper limit on the poll time.

Out of pure curiosity, why is this a per-VM and not a per-VCPU property?

>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Jon Cargille <jcargill@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 17 +++++++++++++++++
>  include/linux/kvm_host.h       |  1 +
>  include/uapi/linux/kvm.h       |  1 +
>  virt/kvm/kvm_main.c            | 19 +++++++++++++++----
>  4 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index efbbe570aa9b7b..d871dacb984e98 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5802,6 +5802,23 @@ If present, this capability can be enabled for a VM, meaning that KVM
>  will allow the transition to secure guest mode.  Otherwise KVM will
>  veto the transition.
>  
> +7.20 KVM_CAP_HALT_POLL
> +----------------------
> +
> +:Architectures: all
> +:Target: VM
> +:Parameters: args[0] is the maximum poll time in nanoseconds
> +:Returns: 0 on success; -1 on error
> +
> +This capability overrides the kvm module parameter halt_poll_ns for the
> +target VM.
> +
> +VCPU polling allows a VCPU to poll for wakeup events instead of immediately
> +scheduling during guest halts. The maximum time a VCPU can spend polling is
> +controlled by the kvm module parameter halt_poll_ns. This capability allows
> +the maximum halt time to specified on a per-VM basis, effectively overriding
> +the module parameter for the target VM.
> +
>  8. Other capabilities.
>  ======================
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6d58beb65454f7..922b24ce5e7297 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -503,6 +503,7 @@ struct kvm {
>  	struct srcu_struct srcu;
>  	struct srcu_struct irq_srcu;
>  	pid_t userspace_pid;
> +	unsigned int max_halt_poll_ns;
>  };
>  
>  #define kvm_err(fmt, ...) \
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 428c7dde6b4b37..ac9eba0289d1b6 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1017,6 +1017,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_VCPU_RESETS 179
>  #define KVM_CAP_S390_PROTECTED 180
>  #define KVM_CAP_PPC_SECURE_GUEST 181
> +#define KVM_CAP_HALT_POLL 182
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 74bdb7bf32952e..ec038a9e60a275 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -710,6 +710,8 @@ static struct kvm *kvm_create_vm(unsigned long type)
>  			goto out_err_no_arch_destroy_vm;
>  	}
>  
> +	kvm->max_halt_poll_ns = halt_poll_ns;
> +
>  	r = kvm_arch_init_vm(kvm, type);
>  	if (r)
>  		goto out_err_no_arch_destroy_vm;
> @@ -2716,15 +2718,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  	if (!kvm_arch_no_poll(vcpu)) {
>  		if (!vcpu_valid_wakeup(vcpu)) {
>  			shrink_halt_poll_ns(vcpu);
> -		} else if (halt_poll_ns) {
> +		} else if (vcpu->kvm->max_halt_poll_ns) {
>  			if (block_ns <= vcpu->halt_poll_ns)
>  				;
>  			/* we had a long block, shrink polling */
> -			else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> +			else if (vcpu->halt_poll_ns &&
> +					block_ns > vcpu->kvm->max_halt_poll_ns)
>  				shrink_halt_poll_ns(vcpu);
>  			/* we had a short halt and our poll time is too small */
> -			else if (vcpu->halt_poll_ns < halt_poll_ns &&
> -				block_ns < halt_poll_ns)
> +			else if (vcpu->halt_poll_ns < vcpu->kvm->max_halt_poll_ns &&
> +					block_ns < vcpu->kvm->max_halt_poll_ns)
>  				grow_halt_poll_ns(vcpu);
>  		} else {
>  			vcpu->halt_poll_ns = 0;
> @@ -3516,6 +3519,7 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  	case KVM_CAP_IOEVENTFD_ANY_LENGTH:
>  	case KVM_CAP_CHECK_EXTENSION_VM:
>  	case KVM_CAP_ENABLE_CAP_VM:
> +	case KVM_CAP_HALT_POLL:
>  		return 1;
>  #ifdef CONFIG_KVM_MMIO
>  	case KVM_CAP_COALESCED_MMIO:
> @@ -3566,6 +3570,13 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
>  		return 0;
>  	}
>  #endif
> +	case KVM_CAP_HALT_POLL: {
> +		if (cap->flags || cap->args[0] != (unsigned int)cap->args[0])
> +			return -EINVAL;
> +
> +		kvm->max_halt_poll_ns = cap->args[0];

Is it safe to allow any value from userspace here or would it maybe make
sense to only allow [0, global halt_poll_ns]?


> +		return 0;
> +	}
>  	default:
>  		return kvm_vm_ioctl_enable_cap(kvm, cap);
>  	}

-- 
Vitaly

