Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD3CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AEF208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGfVzxmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCFOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727283AbgCFOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583505770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLLvybIkZToJWwG5l2PYUU2ex1kd112gNJFDc2w6TOA=;
        b=PGfVzxmbsvB4BwMooJIwJFZq44jWyw6U7/0yc5NeghPn40YC3yW4neo9dO3/UdEBeTEAXT
        ryJoIeYAS8e8h6YGH+EoxsbT8GsdluL3alrFj5vq3LudZn6zdUMotvrAVdDzMuOXzGxTKH
        OvZDZerP/sjivNQjI0iFxKBgOoajEQg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-DrgbRXyrMvylPHNkQDq2xQ-1; Fri, 06 Mar 2020 09:42:49 -0500
X-MC-Unique: DrgbRXyrMvylPHNkQDq2xQ-1
Received: by mail-wr1-f70.google.com with SMTP id f10so1096454wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HLLvybIkZToJWwG5l2PYUU2ex1kd112gNJFDc2w6TOA=;
        b=Pf2FxF1bic9uYd/lP16lgKi3m1dbyb0NBFKpYNXlCQNcYI+Gv7ydKC/lPyZPIxDzM4
         KauGLz7HzIflbhk3hz2qzJ076GaT6g8yDlk+8SAxRRFPMK7OzxYYUcuVSttM/P0lrdxv
         L/iPuto2xt6ERDzaqo5Fw4RXQgbQOiNiWX1vJOfkOVrZIFg5rSsrSjKhA4+iNNXTFHrK
         eiel7uMEdaJoNt0Dh6KWcU1/s1ZR+YiJACvyfKfn4Ch3AWXO4ATl1StC2WdxrxxFl5U1
         OcydNBwCgG7sJPRqHXpyf20JOE25wbBZqrO5az+BQ8pxOel1TALypw3MncRASiDurB3U
         KZgw==
X-Gm-Message-State: ANhLgQ0hdkACVgUbT02n8HV+of/AaDxE73oa2RAl9iuGtj6NmoucVnDC
        2H4kelXGgR65riH+JhfuMyETITHwyatP1X9xWKpyuvdSwKsnH6BtPmyPhFJD7QCPqZFDjJXgOTO
        f76JjQphztulCbQhVWpGJMK+I
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4490460wmi.31.1583505768161;
        Fri, 06 Mar 2020 06:42:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv0GHdnQTlOXauLVuuvOdsabAO+MLHyVMgLpxz0U/9X9I4+XIIqfVkCeaqT93Lit7k+6eR7Hw==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4490429wmi.31.1583505767847;
        Fri, 06 Mar 2020 06:42:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a70sm14012856wme.28.2020.03.06.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 06:42:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     cavery@redhat.com, jan.kiszka@siemens.com, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: nSVM: do not change host intercepts while nested VM is running
In-Reply-To: <1583403227-11432-2-git-send-email-pbonzini@redhat.com>
References: <1583403227-11432-1-git-send-email-pbonzini@redhat.com> <1583403227-11432-2-git-send-email-pbonzini@redhat.com>
Date:   Fri, 06 Mar 2020 15:42:46 +0100
Message-ID: <87a74tee8p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Instead of touching the host intercepts so that the bitwise OR in
> recalc_intercepts just works, mask away uninteresting intercepts
> directly in recalc_intercepts.
>
> This is cleaner and keeps the logic in one place even for intercepts
> that can change even while L2 is running.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 247e31d21b96..14cb5c194008 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -519,10 +519,24 @@ static void recalc_intercepts(struct vcpu_svm *svm)
>  	h = &svm->nested.hsave->control;
>  	g = &svm->nested;
>  
> -	c->intercept_cr = h->intercept_cr | g->intercept_cr;
> -	c->intercept_dr = h->intercept_dr | g->intercept_dr;
> -	c->intercept_exceptions = h->intercept_exceptions | g->intercept_exceptions;
> -	c->intercept = h->intercept | g->intercept;
> +	c->intercept_cr = h->intercept_cr;
> +	c->intercept_dr = h->intercept_dr;
> +	c->intercept_exceptions = h->intercept_exceptions;
> +	c->intercept = h->intercept;
> +
> +	if (svm->vcpu.arch.hflags & HF_VINTR_MASK) {
> +		/* We only want the cr8 intercept bits of L1 */
> +		c->intercept_cr &= ~(1U << INTERCEPT_CR8_READ);
> +		c->intercept_cr &= ~(1U << INTERCEPT_CR8_WRITE);
> +	}
> +
> +	/* We don't want to see VMMCALLs from a nested guest */
> +	c->intercept &= ~(1ULL << INTERCEPT_VMMCALL);
> +
> +	c->intercept_cr |= g->intercept_cr;
> +	c->intercept_dr |= g->intercept_dr;
> +	c->intercept_exceptions |= g->intercept_exceptions;
> +	c->intercept |= g->intercept;
>  }
>  
>  static inline struct vmcb *get_host_vmcb(struct vcpu_svm *svm)
> @@ -3590,15 +3604,6 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
>  	else
>  		svm->vcpu.arch.hflags &= ~HF_VINTR_MASK;
>  
> -	if (svm->vcpu.arch.hflags & HF_VINTR_MASK) {
> -		/* We only want the cr8 intercept bits of the guest */
> -		clr_cr_intercept(svm, INTERCEPT_CR8_READ);
> -		clr_cr_intercept(svm, INTERCEPT_CR8_WRITE);
> -	}
> -
> -	/* We don't want to see VMMCALLs from a nested guest */
> -	clr_intercept(svm, INTERCEPT_VMMCALL);
> -
>  	svm->vcpu.arch.tsc_offset += nested_vmcb->control.tsc_offset;
>  	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset;

FWIW,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

