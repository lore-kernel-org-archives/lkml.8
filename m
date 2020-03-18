Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD24C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF2F20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0IBSB7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCRKwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:52:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45126 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584528772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zRWEh6dCTPH78DCDAt8FvaodGeFVLM/kUqJmF9kDWc=;
        b=T0IBSB7QWVWgAwi8LDT4iJ7jzx/rS044ufVKcQRVTwr5Dz85+GkgIrxHIZYX7I+5gjxIav
        r/eD1aB2rQorjHtgiQLDkf8mKqN1Sd/u1OFGqdcwGyVFKqFrBip9cJT7uiRME7L8N+c6p4
        O0lXY0UV9sjjZ9gwdBlMw/e4mKnXwyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-cBZtP-7HNumTn8mzNxmVbg-1; Wed, 18 Mar 2020 06:52:50 -0400
X-MC-Unique: cBZtP-7HNumTn8mzNxmVbg-1
Received: by mail-wr1-f70.google.com with SMTP id t10so5832172wrp.15
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8zRWEh6dCTPH78DCDAt8FvaodGeFVLM/kUqJmF9kDWc=;
        b=b0hYXXudDHRsk15RgZk2QzUPDdC7xBhjlv0uPW04jpgfB/yjOUUhxqVD/6GFbR9jBM
         ApL7sqMb2QGUoVCcPDSR5BvqHux7QAtBfTNIYuu6PpvSTizjjt2Nv7FtMmIDDB5w8nK/
         RfxVY5NWRrfNd5l5s1U3qGXZ7u7p5oCjkdI2E+v8sKiW14AUS/aOnsj922s3Y5H9Z3mx
         qTH5fvusWrl/los5a65LWKTYk9QjmTO55IjPy9auR4WhqLy5Fh1ABmHRvBsrG5+ZMU7r
         3sT0ZALDchFHXgzQGVfNwvon3YhkoYtZk4f/STCSUTuI0zs42to/KXC9Jg4lkNCGxw3R
         f+cw==
X-Gm-Message-State: ANhLgQ3AEmrTJbbjVDkK032J5+NZ6s5LmbFl+RWBNDRM6MYWgidoCCe6
        GAiMajjjW/t/ycbOWJiCcBSD8u9+V9cSI4FgjYY5D6qR4omAFFT16NefWWSGHaPNEO0BejpH++W
        fLYoYQ2v9i7MKjAQbhR/ZDjo2
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr4712838wmm.42.1584528769386;
        Wed, 18 Mar 2020 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuNeCy/40nU+HN9VgYqkuRRWRRJdGk90A3w/dvrXr7Kw8tqqcm+rdoBXcJQrNyxGOpyONsZ/w==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr4712818wmm.42.1584528769102;
        Wed, 18 Mar 2020 03:52:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s127sm3412884wmf.28.2020.03.18.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:52:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: remove side effects from nested_vmx_exit_reflected
In-Reply-To: <1584468059-3585-1-git-send-email-pbonzini@redhat.com>
References: <1584468059-3585-1-git-send-email-pbonzini@redhat.com>
Date:   Wed, 18 Mar 2020 11:52:47 +0100
Message-ID: <87tv2m2av4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> The name of nested_vmx_exit_reflected suggests that it's purely
> a test, but it actually marks VMCS12 pages as dirty.  Move this to
> vmx_handle_exit, observing that the initial nested_run_pending check in
> nested_vmx_exit_reflected is pointless---nested_run_pending has just
> been cleared in vmx_vcpu_run and won't be set until handle_vmlaunch
> or handle_vmresume.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 18 ++----------------
>  arch/x86/kvm/vmx/nested.h |  1 +
>  arch/x86/kvm/vmx/vmx.c    | 19 +++++++++++++++++--
>  3 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8578513907d7..4ff859c99946 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3527,7 +3527,7 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
>  }
>  
>  
> -static void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
> +void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
>  {
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	gfn_t gfn;
> @@ -5543,8 +5543,7 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason)
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  
> -	if (vmx->nested.nested_run_pending)
> -		return false;
> +	WARN_ON_ONCE(vmx->nested.nested_run_pending);
>  
>  	if (unlikely(vmx->fail)) {
>  		trace_kvm_nested_vmenter_failed(
> @@ -5553,19 +5552,6 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason)
>  		return true;
>  	}
>  
> -	/*
> -	 * The host physical addresses of some pages of guest memory
> -	 * are loaded into the vmcs02 (e.g. vmcs12's Virtual APIC
> -	 * Page). The CPU may write to these pages via their host
> -	 * physical address while L2 is running, bypassing any
> -	 * address-translation-based dirty tracking (e.g. EPT write
> -	 * protection).
> -	 *
> -	 * Mark them dirty on every exit from L2 to prevent them from
> -	 * getting out of sync with dirty tracking.
> -	 */
> -	nested_mark_vmcs12_pages_dirty(vcpu);
> -
>  	trace_kvm_nested_vmexit(kvm_rip_read(vcpu), exit_reason,
>  				vmcs_readl(EXIT_QUALIFICATION),
>  				vmx->idt_vectoring_info,
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 21d36652f213..f70968b76d33 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -33,6 +33,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
>  			u32 vmx_instruction_info, bool wr, int len, gva_t *ret);
>  void nested_vmx_pmu_entry_exit_ctls_update(struct kvm_vcpu *vcpu);
> +void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu);
>  bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
>  				 int size);
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b447d66f44e6..07299a957d4a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5851,8 +5851,23 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	if (vmx->emulation_required)
>  		return handle_invalid_guest_state(vcpu);
>  
> -	if (is_guest_mode(vcpu) && nested_vmx_exit_reflected(vcpu, exit_reason))
> -		return nested_vmx_reflect_vmexit(vcpu, exit_reason);
> +	if (is_guest_mode(vcpu)) {
> +		/*
> +		 * The host physical addresses of some pages of guest memory
> +		 * are loaded into the vmcs02 (e.g. vmcs12's Virtual APIC
> +		 * Page). The CPU may write to these pages via their host
> +		 * physical address while L2 is running, bypassing any
> +		 * address-translation-based dirty tracking (e.g. EPT write
> +		 * protection).
> +		 *
> +		 * Mark them dirty on every exit from L2 to prevent them from
> +		 * getting out of sync with dirty tracking.
> +		 */
> +		nested_mark_vmcs12_pages_dirty(vcpu);
> +
> +		if (nested_vmx_exit_reflected(vcpu, exit_reason))
> +			return nested_vmx_reflect_vmexit(vcpu, exit_reason);
> +	}
>  
>  	if (exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {
>  		dump_vmcs();

The only functional difference seems to be that we're now doing
nested_mark_vmcs12_pages_dirty() in vmx->fail case too and this seems
superfluous: we failed to enter L2 so 'special' pages should remain
intact (right?) but this should be an uncommon case.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

