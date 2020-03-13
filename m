Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320882073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f93lXXCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCMKUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:20:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgCMKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584094848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8p0yU+2dtK6r1zkXXvBWL0DAYf00F48i3c6W+/DfDA=;
        b=f93lXXCxqMcVWXcM8uFA/fOGcluwnRfcoNQcq0LwGZwB6pThb2Kr4wU04Bjk0v6dXNH2q8
        Z4IjSptHn9P9vajpKHFXjc2wuVnQVbJDGmg5p7BVh02aIXEafNjFNHgJSgkCBy794caPjz
        K45khI23G5ZsfT44HLR+3HMiXpnL37k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-ogIELE8EMO2vJWWPS7Kl5Q-1; Fri, 13 Mar 2020 06:20:46 -0400
X-MC-Unique: ogIELE8EMO2vJWWPS7Kl5Q-1
Received: by mail-wm1-f69.google.com with SMTP id y7so3258021wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=p8p0yU+2dtK6r1zkXXvBWL0DAYf00F48i3c6W+/DfDA=;
        b=gD5TCSqyzOHX7EZTELXNu6C5HWyLQ1PZahDOdu94sz3SLSOU5/oa4ue+ajN3qkVSt2
         G5W69944qjDZa3oh7oFDLCaFbHo2j2LsXTd2B+74p2zY5RuadiZvkT3rwEXcy9NxMQg5
         lFH7L4LaqbPsckFxLmKoxZeji6E7nqDtQkcrWZVR2Xe0xl+wpWKw1c0vgh6cUho57hgc
         vTCae7JTaCx/noEKM1chbZpYXajE1ldztHMjrn3VT99mnquaGgiwkZad1fGTjVH5GDox
         XO+LQeBhVls2cd0HXcGXacBU3rkql7xZPToLmSf6OAk34HKJyAlwGqlQ6S3OUKzwGjhl
         5ifw==
X-Gm-Message-State: ANhLgQ34g8NCzQIY9SArFmVK2qb42d4kFka44ls3BU5sYGER87y2MnPb
        vT9QJBEcHhxC9aSNrTOhLr2dyPt4saMz/hBR2WHAmGUp+zNmuF9tmoExNCiFv9fWDYb2sqcjY/m
        2JmJ0/DoCdots+IvFdHy0zR95
X-Received: by 2002:a7b:c458:: with SMTP id l24mr9972982wmi.120.1584094845565;
        Fri, 13 Mar 2020 03:20:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu4okEOyFmr9Ae+lSmbX/xV4gnPgkDtiLRpMgrFE8NAiB8lzXzPaNtVJsV1W672x5xOLNPu8w==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr9972964wmi.120.1584094845318;
        Fri, 13 Mar 2020 03:20:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b187sm233348wmc.14.2020.03.13.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:20:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Print symbolic names of VMX VM-Exit flags in traces
In-Reply-To: <20200312181535.23797-1-sean.j.christopherson@intel.com>
References: <20200312181535.23797-1-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 11:20:43 +0100
Message-ID: <87sgicpnd0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use __print_flags() to display the names of VMX flags in VM-Exit traces
> and strip the flags when printing the basic exit reason, e.g. so that a
> failed VM-Entry due to invalid guest state gets recorded as
> "INVALID_STATE FAILED_VMENTRY" instead of "0x80000021".
>
> Opportunstically fix misaligned variables in the kvm_exit and
> kvm_nested_vmexit_inject tracepoints.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/uapi/asm/vmx.h |  3 +++
>  arch/x86/kvm/trace.h            | 32 +++++++++++++++++---------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
> index e95b72ec19bc..b8ff9e8ac0d5 100644
> --- a/arch/x86/include/uapi/asm/vmx.h
> +++ b/arch/x86/include/uapi/asm/vmx.h
> @@ -150,6 +150,9 @@
>  	{ EXIT_REASON_UMWAIT,                "UMWAIT" }, \
>  	{ EXIT_REASON_TPAUSE,                "TPAUSE" }
>  
> +#define VMX_EXIT_REASON_FLAGS \
> +	{ VMX_EXIT_REASONS_FAILED_VMENTRY,	"FAILED_VMENTRY" }
> +
>  #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
>  #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
>  #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index f5b8814d9f83..3cfc8d97b158 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -219,6 +219,14 @@ TRACE_EVENT(kvm_apic,
>  #define KVM_ISA_VMX   1
>  #define KVM_ISA_SVM   2
>  
> +#define kvm_print_exit_reason(exit_reason, isa)				\
> +	(isa == KVM_ISA_VMX) ?						\
> +	__print_symbolic(exit_reason & 0xffff, VMX_EXIT_REASONS) :	\
> +	__print_symbolic(exit_reason, SVM_EXIT_REASONS),		\
> +	(isa == KVM_ISA_VMX && exit_reason & ~0xffff) ? " " : "",	\
> +	(isa == KVM_ISA_VMX) ?						\
> +	__print_flags(exit_reason & ~0xffff, " ", VMX_EXIT_REASON_FLAGS) : ""
> +
>  /*
>   * Tracepoint for kvm guest exit:
>   */
> @@ -244,12 +252,10 @@ TRACE_EVENT(kvm_exit,
>  					   &__entry->info2);
>  	),
>  
> -	TP_printk("vcpu %u reason %s rip 0x%lx info %llx %llx",
> +	TP_printk("vcpu %u reason %s%s%s rip 0x%lx info %llx %llx",
>  		  __entry->vcpu_id,
> -		 (__entry->isa == KVM_ISA_VMX) ?
> -		 __print_symbolic(__entry->exit_reason, VMX_EXIT_REASONS) :
> -		 __print_symbolic(__entry->exit_reason, SVM_EXIT_REASONS),
> -		 __entry->guest_rip, __entry->info1, __entry->info2)
> +		  kvm_print_exit_reason(__entry->exit_reason, __entry->isa),
> +		  __entry->guest_rip, __entry->info1, __entry->info2)
>  );
>  
>  /*
> @@ -582,12 +588,10 @@ TRACE_EVENT(kvm_nested_vmexit,
>  		__entry->exit_int_info_err	= exit_int_info_err;
>  		__entry->isa			= isa;

Unrelated to your patch, just a random thought: I *think* it would be
possible to avoid passing 'isa' to these tracepoints and figure out
which module is embedding them instead (THIS_MODULE/KBUILD_MODNAME/...
magic or something like that) but it may not worth the effort.

>  	),
> -	TP_printk("rip: 0x%016llx reason: %s ext_inf1: 0x%016llx "
> +	TP_printk("rip: 0x%016llx reason: %s%s%s ext_inf1: 0x%016llx "
>  		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
>  		  __entry->rip,
> -		 (__entry->isa == KVM_ISA_VMX) ?
> -		 __print_symbolic(__entry->exit_code, VMX_EXIT_REASONS) :
> -		 __print_symbolic(__entry->exit_code, SVM_EXIT_REASONS),
> +		  kvm_print_exit_reason(__entry->exit_code, __entry->isa),
>  		  __entry->exit_info1, __entry->exit_info2,
>  		  __entry->exit_int_info, __entry->exit_int_info_err)
>  );
> @@ -620,13 +624,11 @@ TRACE_EVENT(kvm_nested_vmexit_inject,
>  		__entry->isa			= isa;
>  	),
>  
> -	TP_printk("reason: %s ext_inf1: 0x%016llx "
> +	TP_printk("reason: %s%s%s ext_inf1: 0x%016llx "
>  		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
> -		 (__entry->isa == KVM_ISA_VMX) ?
> -		 __print_symbolic(__entry->exit_code, VMX_EXIT_REASONS) :
> -		 __print_symbolic(__entry->exit_code, SVM_EXIT_REASONS),
> -		__entry->exit_info1, __entry->exit_info2,
> -		__entry->exit_int_info, __entry->exit_int_info_err)
> +		  kvm_print_exit_reason(__entry->exit_code, __entry->isa),
> +		  __entry->exit_info1, __entry->exit_info2,
> +		  __entry->exit_int_info, __entry->exit_int_info_err)
>  );
>  
>  /*

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

