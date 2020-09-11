Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB04221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZoeWlLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKLvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:51:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgIKLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599824989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbEzTZlBUFKy7piP8BvfmrFeBFroI6ej+Yt1VrkfQ1U=;
        b=LZoeWlLZb4vmTg4+ss+vPj3woN6mhLPeaXrh5+Zh3tvkPiu70yDY18dXlNnvAJpPRDs2sE
        1BA39WCEJvo/Cv55Gw+b7JYXwK9XsrRRLQRbnfuMqLSNQuVqNGTh6vyJHjRtVIi+R6AWyy
        rLOKHy3U5PM3J2eRIppn3AAxLWuwDEU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-PlQxzSSHPamsyoRlTjaRvw-1; Fri, 11 Sep 2020 07:49:46 -0400
X-MC-Unique: PlQxzSSHPamsyoRlTjaRvw-1
Received: by mail-wr1-f70.google.com with SMTP id v5so3381036wrs.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DbEzTZlBUFKy7piP8BvfmrFeBFroI6ej+Yt1VrkfQ1U=;
        b=NQ/wTdz32XSHzTVhmqRDsp/kk84eoFMeyFSnPLJwaX/G8Ea7xmCKlodailZjQOMb6Y
         7nY6jzVtGK78DEiYpEmEAd89bMPr4vQlAOwlXnJrQMNyS+Wtje0WZa+S0cJNY2EjDizS
         +VlozTDskzJ2cgbXLW8RUhEfKPLvKb17vewOq5pDpv43RaKO+Lpgd++ncpiRzP9ryYNl
         p9VO3soJvIEjVytF7Pu4qyvTDjBjfE3S0fTvpMZgLIvYFblPbuAEFWSyo5zzHvQCcqjv
         SknBPY99PiWcUqebVXaalbSZ1aI72WmM0BZH4hbCwPrEmjE2IVQZMR0ajZ05RHh3oGGx
         6H8w==
X-Gm-Message-State: AOAM530kJzwls1rjD4BFHrdRkwKTWhLbSj2vC0O6D4ivzW2ANWojvaaN
        AGAfMqGajLcXhYasQgPr3IEBOg2XXFDAmFpMCg7NhhE50asUxCErWv9ZepIdJ7YhbQExcZ4WGjr
        cZdjVpPxPLAIBGD1pVKk2BoAw
X-Received: by 2002:adf:e952:: with SMTP id m18mr1661039wrn.171.1599824984852;
        Fri, 11 Sep 2020 04:49:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQpXn3O6dhb557D4NANTuUDGxEUZvFWXlBeAuUYP1vZZatKQtPsXhGfsneRWhJehwI7Yiyhw==
X-Received: by 2002:adf:e952:: with SMTP id m18mr1661017wrn.171.1599824984563;
        Fri, 11 Sep 2020 04:49:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k84sm3776613wmf.6.2020.09.11.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 04:49:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH][next] KVM: SVM: nested: fix free of uninitialized pointers save and ctl
In-Reply-To: <20200911110730.24238-1-colin.king@canonical.com>
References: <20200911110730.24238-1-colin.king@canonical.com>
Date:   Fri, 11 Sep 2020 13:49:42 +0200
Message-ID: <87o8mclei1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the error exit path to outt_set_gif will kfree on
> uninitialized

typo: out_set_gif

> pointers save and ctl.  Fix this by ensuring these pointers are
> inintialized to NULL to avoid garbage pointer freeing.
>
> Addresses-Coverity: ("Uninitialized pointer read")
> Fixes: 6ccbd29ade0d ("KVM: SVM: nested: Don't allocate VMCB structures
> on stack")

Where is this commit id from? I don't see it in Paolo's kvm tree, if
it's not yet merged, maybe we should fix it and avoid introducing the
issue in the first place?

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/kvm/svm/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 28036629abf8..2b15f49f9e5a 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1060,8 +1060,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	struct vmcb *hsave = svm->nested.hsave;
>  	struct vmcb __user *user_vmcb = (struct vmcb __user *)
>  		&user_kvm_nested_state->data.svm[0];
> -	struct vmcb_control_area *ctl;
> -	struct vmcb_save_area *save;
> +	struct vmcb_control_area *ctl = NULL;
> +	struct vmcb_save_area *save = NULL;
>  	int ret;
>  	u32 cr0;

I think it would be better if we eliminate 'out_set_gif; completely as
the 'error path' we have looks a bit weird anyway. Something like
(untested):

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 28036629abf8..d1ae94f40907 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1092,7 +1092,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
        if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE)) {
                svm_leave_nested(svm);
-               goto out_set_gif;
+               svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
+               return 0;
        }
 
        if (!page_address_valid(vcpu, kvm_state->hdr.svm.vmcb_pa))
@@ -1145,7 +1146,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
        load_nested_vmcb_control(svm, ctl);
        nested_prepare_vmcb_control(svm);
 
-out_set_gif:
        svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
        ret = 0;

-- 
Vitaly

