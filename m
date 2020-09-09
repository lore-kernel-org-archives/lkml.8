Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC40C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E07215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO8o1zkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgIIIl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:41:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgIIIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599640913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T36t7fQZrvyiAzT5j5Q2jRiJ36nfS5YR20jv9iVoAto=;
        b=TO8o1zkqOAPz7lusmAiR3Eqq4BLkai6FkVarSKwOeH1C3L0TUaRrUIgQ3Niy3YC6EE6M1F
        r0yBnQt0EKNXEBQ2lVGOkTQXX6+WZUsbovuys5Rhq3aUGNM0AQ2bZNB+Ahi5lBoV+tKL41
        5HFQMUZ6dHar338IMd5a4RZGTrF/F+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-sIX0-UBKNtC5bJ7q6n_Qig-1; Wed, 09 Sep 2020 04:41:52 -0400
X-MC-Unique: sIX0-UBKNtC5bJ7q6n_Qig-1
Received: by mail-wr1-f71.google.com with SMTP id a10so691291wrw.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=T36t7fQZrvyiAzT5j5Q2jRiJ36nfS5YR20jv9iVoAto=;
        b=KinyOJuvZSsDBKTQscbm0Bp9P4ukjXU/a+YAyKG0Tt93ckcYWTOBmlHG7IG7QyttzQ
         BCa99ORrHAO9U8BW+aV1KYZGzMyciMn836bXW0djzm9dVP2yVAOvQVYKvzQ0P0Zcne1y
         eaGYeOp94u+P03q3AU/nImY7IBi5ELBCUH24aeOem54AaqhAgDLl/rHq1ZwPOw4weNzV
         eRCkhNDoNs09P+ZB9ifJiF2lqgO9VRJAlIyki6Jz9hLgcShxuE4GwoEJjicfQt5H3tZZ
         +bxFscXWrE5+YAqqeS5N0YDwt/T2soxrNfhrm4Q0tdaXJ3VmxY4A3IRhi13U+S6CKH/X
         2aQA==
X-Gm-Message-State: AOAM532smhbkL6HaPhIE1hWCUrogsl6qCUWJ+/ZocY9TN+ouHTtWImUq
        S9K7sZ8FbAOhQqy6HpS+S2GokgOOV69TLR491uaoe9XyGbDEHBv640EyCTsV+UzCnjo4GdbdoUc
        +jMBnyBR+W9jQV9yZ0OXUnTyF
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr2275266wmj.63.1599640910872;
        Wed, 09 Sep 2020 01:41:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlN5J94Y8BYA6qYXY7wIIaOrIgJb7mS6rfcMp2Fpo44YIPTD6vwynEu5UzWqHoGtXWhNv+2Q==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr2275246wmj.63.1599640910690;
        Wed, 09 Sep 2020 01:41:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l10sm2827473wmh.27.2020.09.09.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:41:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>
Subject: Re: [PATCH 3/3] KVM: SVM: Reenable handle_fastpath_set_msr_irqoff() after complete_interrupts()
In-Reply-To: <1599620139-13019-1-git-send-email-wanpengli@tencent.com>
References: <1599620139-13019-1-git-send-email-wanpengli@tencent.com>
Date:   Wed, 09 Sep 2020 10:41:48 +0200
Message-ID: <87blifmjeb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Moving the call to svm_exit_handlers_fastpath() after svm_complete_interrupts() 
> since svm_complete_interrupts() consumes rip and reenable the function 
> handle_fastpath_set_msr_irqoff() call in svm_exit_handlers_fastpath().
>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Paul K. <kronenpj@kronenpj.dyndns.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/svm/svm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 74bcf0a..ac819f0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3347,6 +3347,11 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
>  
>  static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
>  {
> +	if (!is_guest_mode(vcpu) &&
> +	    to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
> +	    to_svm(vcpu)->vmcb->control.exit_info_1)
> +		return handle_fastpath_set_msr_irqoff(vcpu);
> +
>  	return EXIT_FASTPATH_NONE;
>  }
>  
> @@ -3495,7 +3500,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	stgi();
>  
>  	/* Any pending NMI will happen here */
> -	exit_fastpath = svm_exit_handlers_fastpath(vcpu);
>  
>  	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
>  		kvm_after_interrupt(&svm->vcpu);
> @@ -3529,6 +3533,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  		svm_handle_mce(svm);
>  
>  	svm_complete_interrupts(svm);
> +	exit_fastpath = svm_exit_handlers_fastpath(vcpu);
>  
>  	vmcb_mark_all_clean(svm->vmcb);
>  	return exit_fastpath;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

