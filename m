Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B36C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19AD207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqXPpFVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgGTQwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:52:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgGTQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595263941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+GTW6bUcVq9hOEzQOGLugjDBW3sKVqwUxpZJhBAW9g=;
        b=NqXPpFVd4h3vW5hAliif/OiNOmcgQyGZDwN38uLXcIg+lSEUg2VCZQbxp3BXF/5CGFmO/G
        yaJXVfJSzTNsklDa1E8uyHUguADi8RfaxouGVu5lFX5daGJHP+EkLyjYwNi0GKAXtXx5Wz
        o494qQX1hOUN/RdYMKxBfm26Pd5/Uic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-nyJsB-VzOFyUnd2qIbvzCg-1; Mon, 20 Jul 2020 12:52:19 -0400
X-MC-Unique: nyJsB-VzOFyUnd2qIbvzCg-1
Received: by mail-wr1-f71.google.com with SMTP id j16so12367083wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1+GTW6bUcVq9hOEzQOGLugjDBW3sKVqwUxpZJhBAW9g=;
        b=M1BB9rHiPOJyuWJG6Faa+fnIGVDiGxwS+ICfxoGi3VosI56xaWnuHK2s24yAETKTRj
         fwKo0XoChSHwQ8lvrg6WyfwYNxjtFn+Apduk+Vyqvd8F0yH5ddZn+NsCOA1aA6youAZt
         1U0Bl09kQfcBrnCN6H+JwC0ESkRnNdBzjkgzfMiV1TF/yDX6MImPm/yMy80mksRzcSjt
         Fwh8oBnkhtrbnikGwmNp4QVGOdzOonH+k5qzjgNFzXCwRi6kZDMLx0V3/Zm6UYxYuYpM
         KhLNwwe9EcOpFR76ygzqVsSPfx2utcCVp/gqRm198cNDCUVHdYu1X/C1IOCqUWX+Cgil
         bxWg==
X-Gm-Message-State: AOAM53362UzOhhwHbaSA0hK0qWezgXSeNXA5hP/0GRyKiXPxZ3QM4afV
        JjjrZZcB7qb0S3j6jwqADM+md3YVDnNzl26fbHh2P3epxMw5mAJeYtYPzKezS/J7NUTT2pAuzRA
        Qhtd3XFRlYmmCW/uyppGcznuq
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr253064wmc.154.1595263937944;
        Mon, 20 Jul 2020 09:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxABkQsaNC6uhHjD2qXLGgxcmAgBJje062qg/eXZVT4/eyQq3RRhVHJaDFgP8d/p0TurMOOuA==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr253040wmc.154.1595263937551;
        Mon, 20 Jul 2020 09:52:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h11sm10910239wrb.68.2020.07.20.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:52:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/7] KVM: x86: Use common definition for kvm_nested_vmexit tracepoint
In-Reply-To: <20200718063854.16017-7-sean.j.christopherson@intel.com>
References: <20200718063854.16017-1-sean.j.christopherson@intel.com> <20200718063854.16017-7-sean.j.christopherson@intel.com>
Date:   Mon, 20 Jul 2020 18:52:15 +0200
Message-ID: <87365mqgcg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use the newly introduced TRACE_EVENT_KVM_EXIT to define the guts of
> kvm_nested_vmexit so that it captures and prints the same information as
> with kvm_exit.  This has the bonus side effect of fixing the interrupt
> info and error code printing for the case where they're invalid, e.g. if
> the exit was a failed VM-Entry.  This also sets the stage for retrieving
> EXIT_QUALIFICATION and VM_EXIT_INTR_INFO in nested_vmx_reflect_vmexit()
> if and only if the VM-Exit is being routed to L1.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm/svm.c    |  7 +------
>  arch/x86/kvm/trace.h      | 34 +---------------------------------
>  arch/x86/kvm/vmx/nested.c |  5 +----
>  3 files changed, 3 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8ab3413094500..133581c5b0dc0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2950,12 +2950,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	if (is_guest_mode(vcpu)) {
>  		int vmexit;
>  
> -		trace_kvm_nested_vmexit(vcpu, exit_code,
> -					svm->vmcb->control.exit_info_1,
> -					svm->vmcb->control.exit_info_2,
> -					svm->vmcb->control.exit_int_info,
> -					svm->vmcb->control.exit_int_info_err,
> -					KVM_ISA_SVM);
> +		trace_kvm_nested_vmexit(exit_code, vcpu, KVM_ISA_SVM);
>  
>  		vmexit = nested_svm_exit_special(svm);
>  
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index 6cb75ba494fcd..e29576985e03a 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -579,39 +579,7 @@ TRACE_EVENT(kvm_nested_intercepts,
>  /*
>   * Tracepoint for #VMEXIT while nested
>   */
> -TRACE_EVENT(kvm_nested_vmexit,
> -	    TP_PROTO(struct kvm_vcpu *vcpu, __u32 exit_code,
> -		     __u64 exit_info1, __u64 exit_info2,
> -		     __u32 exit_int_info, __u32 exit_int_info_err, __u32 isa),
> -	    TP_ARGS(vcpu, exit_code, exit_info1, exit_info2,
> -		    exit_int_info, exit_int_info_err, isa),
> -
> -	TP_STRUCT__entry(
> -		__field(	__u64,		rip			)
> -		__field(	__u32,		exit_code		)
> -		__field(	__u64,		exit_info1		)
> -		__field(	__u64,		exit_info2		)
> -		__field(	__u32,		exit_int_info		)
> -		__field(	__u32,		exit_int_info_err	)
> -		__field(	__u32,		isa			)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->rip			= kvm_rip_read(vcpu);
> -		__entry->exit_code		= exit_code;
> -		__entry->exit_info1		= exit_info1;
> -		__entry->exit_info2		= exit_info2;
> -		__entry->exit_int_info		= exit_int_info;
> -		__entry->exit_int_info_err	= exit_int_info_err;
> -		__entry->isa			= isa;
> -	),
> -	TP_printk("rip: 0x%016llx reason: %s%s%s ext_inf1: 0x%016llx "
> -		  "ext_inf2: 0x%016llx ext_int: 0x%08x ext_int_err: 0x%08x",
> -		  __entry->rip,
> -		  kvm_print_exit_reason(__entry->exit_code, __entry->isa),
> -		  __entry->exit_info1, __entry->exit_info2,
> -		  __entry->exit_int_info, __entry->exit_int_info_err)
> -);
> +TRACE_EVENT_KVM_EXIT(kvm_nested_vmexit);
>  
>  /*
>   * Tracepoint for #VMEXIT reinjected to the guest
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index fc70644b916ca..f437d99f4db09 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5912,10 +5912,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
>  	exit_intr_info = vmx_get_intr_info(vcpu);
>  	exit_qual = vmx_get_exit_qual(vcpu);
>  
> -	trace_kvm_nested_vmexit(vcpu, exit_reason, exit_qual,
> -				vmx->idt_vectoring_info, exit_intr_info,
> -				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
> -				KVM_ISA_VMX);
> +	trace_kvm_nested_vmexit(exit_reason, vcpu, KVM_ISA_VMX);
>  
>  	/* If L0 (KVM) wants the exit, it trumps L1's desires. */
>  	if (nested_vmx_l0_wants_exit(vcpu, exit_reason))

With so many lines removed I'm almost in love with the patch! However,
when testing on SVM (unrelated?) my trace log looks a bit ugly:

           <...>-315119 [010]  3733.092646: kvm_nested_vmexit:    CAN'T FIND FIELD "rip"<CANT FIND FIELD exit_code>vcpu 0 reason npf rip 0x400433 info1 0x0000000200000006 info2 0x0000000000641000 intr_info 0x00000000 error_code 0x00000000
           <...>-315119 [010]  3733.092655: kvm_nested_vmexit:    CAN'T FIND FIELD "rip"<CANT FIND FIELD exit_code>vcpu 0 reason npf rip 0x400433 info1 0x0000000100000014 info2 0x0000000000400000 intr_info 0x00000000 error_code 0x00000000

...

but after staring at this for some time I still don't see where this
comes from :-( ... but reverting this commit helps:

 qemu-system-x86-9928  [022]   379.260656: kvm_nested_vmexit:    rip 400433 reason EXIT_NPF info1 200000006 info2 641000 int_info 0 int_info_err 0
 qemu-system-x86-9928  [022]   379.260666: kvm_nested_vmexit:    rip 400433 reason EXIT_NPF info1 100000014 info2 400000 int_info 0 int_info_err 0

-- 
Vitaly

