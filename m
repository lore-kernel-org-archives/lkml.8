Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8682072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1HrsZ8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCMOKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:10:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbgCMOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584108604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1V8F7R+emEsH2Puu+xTU6xnzq5JbKAu2uhy1Jl9ZpQ=;
        b=W1HrsZ8+iu+NhfnOVMYd86Cwh5jX8ZGRpnqp1lA1lNgqrDnPOyMaYU9iKVpeWGhGUJ/bZY
        smxqA1XI3agKUWweOEjP1HdiO+pvXROkmWPM8bP+jTH4MgSBqYmdc8NLZ6RjNKEZDFuVvl
        CEP/OPQ1VjkLmdnyPFscXkpMImpVB08=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-g9vBft6BNmmdRxJRKpiV1g-1; Fri, 13 Mar 2020 10:09:59 -0400
X-MC-Unique: g9vBft6BNmmdRxJRKpiV1g-1
Received: by mail-wr1-f71.google.com with SMTP id p5so4276876wrj.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F1V8F7R+emEsH2Puu+xTU6xnzq5JbKAu2uhy1Jl9ZpQ=;
        b=ZGYMLrEnaBXxaVxFWrRU2F0N5On16ZmmG7GOpRSYgJznl6vIagPlMHgaAeffpN2Ng7
         UlSfcTvr9yyXgS1HjDLjOAa+PvcE//ZrL9G3JOVGPVn+nB5FPhoEDQfQ6tQ8ZDylqTKc
         6Sk4DVtAhkjKOffA0IJ1gMq8BqgcWGmg1f1xrHTLu6J1yUW9qOdnpRtRzSsQQQobUfZ2
         kD0GtbucChRzzQt+GF8IDzO7Oou7HhjNg3aAgp26EJ/Inc4uVSyb40xaCmxdwBFS49t3
         h22T6BgX8gA/igzSHMIFEXU9WgA2RWPBaXlTMiNl6j4stgxizywgbOO0PLF2X3F17mxI
         YPlQ==
X-Gm-Message-State: ANhLgQ3GpFQDYRnBEkkyFnrKUUb9+VlmvPgYafpLYkMy3hmnSKh28xpq
        1NUOpBNNylPHMGRBU1ZPcqwovdDp94fkJuOsQuwp+HGp/+d95YtTHVS3kVOMB/juQ0EGJquCqP7
        4jnTud64peVNawBgGIWYIThpJ
X-Received: by 2002:adf:9071:: with SMTP id h104mr18213507wrh.359.1584108597987;
        Fri, 13 Mar 2020 07:09:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvhEwV3TeTg8xQbLJb4GROPa8wOf4t+geLxrOrIV4oik7bg0a3LBUdPL/nDNQ3nNvTxJhw7oQ==
X-Received: by 2002:adf:9071:: with SMTP id h104mr18213482wrh.359.1584108597771;
        Fri, 13 Mar 2020 07:09:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k126sm17084484wme.4.2020.03.13.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:09:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 09/10] KVM: VMX: Cache vmx->exit_reason in local u16 in vmx_handle_exit_irqoff()
In-Reply-To: <20200312184521.24579-10-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-10-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 15:09:47 +0100
Message-ID: <87h7ysny6s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use a u16 to hold the exit reason in vmx_handle_exit_irqoff(), as the
> checks for INTR/NMI/WRMSR expect to encounter only the basic exit reason
> in vmx->exit_reason.
>

True Sean would also add:

"No functional change intended."

"Opportunistically align the params to handle_external_interrupt_irqoff()."

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d43e1d28bb58..910a7cadeaf7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6287,16 +6287,16 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
>  STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
>  
>  static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
> -	enum exit_fastpath_completion *exit_fastpath)
> +				   enum exit_fastpath_completion *exit_fastpath)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	u16 exit_reason = vmx->exit_reason;
>  
> -	if (vmx->exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> +	if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
>  		handle_external_interrupt_irqoff(vcpu);
> -	else if (vmx->exit_reason == EXIT_REASON_EXCEPTION_NMI)
> +	else if (exit_reason == EXIT_REASON_EXCEPTION_NMI)
>  		handle_exception_nmi_irqoff(vmx);
> -	else if (!is_guest_mode(vcpu) &&
> -		vmx->exit_reason == EXIT_REASON_MSR_WRITE)
> +	else if (!is_guest_mode(vcpu) && exit_reason == EXIT_REASON_MSR_WRITE)
>  		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

