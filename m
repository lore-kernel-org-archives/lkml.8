Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63739C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB01218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT7fnmjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIIIgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:36:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgIIIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599640559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxG3m4nR+YU53uab+z7iQIRwHNJ3l863/1VrYJ0fNCg=;
        b=FT7fnmjvLvXlwI8zFI/tWp5WiHR88psNAMpLsPLvVX6c6yDWPpYc+6KT2XQ/5EN+s/PA9/
        dVGr0APIr65YrkxYnwuLdinD3QDMLUm8Q5SDSAlQYPjc+kNQ07EyOZ39YxmN/zcsbGS6+5
        9IOaNfhOfoOAN+SmxuqOpou3LZ1UiIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-D8XfbYm2Oeqo-mr0IwSfAQ-1; Wed, 09 Sep 2020 04:35:58 -0400
X-MC-Unique: D8XfbYm2Oeqo-mr0IwSfAQ-1
Received: by mail-wm1-f72.google.com with SMTP id 23so565261wmk.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BxG3m4nR+YU53uab+z7iQIRwHNJ3l863/1VrYJ0fNCg=;
        b=Dd+clpCZyUGk4Zt+oFc7SYlv0omjzwPKLgc7jRW607BEF9f38HtrINa97ciOqb27j8
         pbzNTISMO61LmmgessjDcszsRV+zPNMhWjSy2CAmrca0s+Pa3Rud0uUOaqarlES9x1J2
         fIflP/wmx7cvPasZKlay1Kw18nlkdj12OKjMPm9jucOvms5oPPhIcCnS3GWS/pn4r8dR
         BI27YqVuFG4JchLA5tK+KCJ8Q9ob01g9ycZ4Yo0H3tG8N6Ys5rYMpHV6gzAdTcJ3XB0S
         NOT84kZdAmSVTCa/QGvmvvzVORboW9dxfLtVrnj+JmfeEiFbtbwwW0G1+U+SrWK0ibjD
         X4Ng==
X-Gm-Message-State: AOAM530kRAGfX1zomOz7Glfr9E2okD12DgrKaEkzFpe5FtQCCLtTALFS
        2WeYbSvi/9aL5/iiaX+oFxt9+taKZNRpB0DXXRvCDgwYkEW3L8530VndS35kOIzkZPodzntJ0If
        vMablHd8inQgqD+NEDh+BeN9b
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr2518606wmf.111.1599640557060;
        Wed, 09 Sep 2020 01:35:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU4GkzkooxdDUYfIcFo7UAIjKzbfraZwoqESsmxrN7yZFaybBNzbJ/XdCEGBZ7NL9hhZaeGw==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr2518578wmf.111.1599640556820;
        Wed, 09 Sep 2020 01:35:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a15sm3372141wrn.3.2020.09.09.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:35:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>
Subject: Re: [PATCH 2/3] KVM: SVM: Move svm_complete_interrupts() into svm_vcpu_run()
In-Reply-To: <1599620119-12971-1-git-send-email-wanpengli@tencent.com>
References: <1599620119-12971-1-git-send-email-wanpengli@tencent.com>
Date:   Wed, 09 Sep 2020 10:35:55 +0200
Message-ID: <87eenbmjo4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Moving svm_complete_interrupts() into svm_vcpu_run() which can align VMX 
> and SVM with respect to completing interrupts.
>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Paul K. <kronenpj@kronenpj.dyndns.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/svm/svm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c61bc3b..74bcf0a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2938,8 +2938,6 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	if (npt_enabled)
>  		vcpu->arch.cr3 = svm->vmcb->save.cr3;
>  
> -	svm_complete_interrupts(svm);
> -
>  	if (is_guest_mode(vcpu)) {
>  		int vmexit;
>  
> @@ -3530,6 +3528,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  		     SVM_EXIT_EXCP_BASE + MC_VECTOR))
>  		svm_handle_mce(svm);
>  
> +	svm_complete_interrupts(svm);
> +
>  	vmcb_mark_all_clean(svm->vmcb);
>  	return exit_fastpath;
>  }

This seems to be the right thing to do, however, the amount of code
between kvm_x86_ops.run() and kvm_x86_ops.handle_exit() is non-trivial,
hope it won't blow up in testing...

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

One more thing:

VMX version does

        vmx_complete_interrupts(vmx);
        if (is_guest_mode(vcpu))
                return EXIT_FASTPATH_NONE;

and on SVM we analyze is_guest_mode() inside
svm_exit_handlers_fastpath() - should we also change that for
conformity?

-- 
Vitaly

