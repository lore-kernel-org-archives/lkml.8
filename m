Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F73C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10892076C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hye34L+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIIX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgIIIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599639804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipg+kGRxf4wxWeQOhvAJYTIzegDq0gtF7D+pA4396Qw=;
        b=hye34L+gA6pRupUUmu0wORcHDDnfHuPyyhSkc/7vgNzOm001FvlwV9kK8tltHtDeT8E6z7
        3iRSvsPmMQTHum5xHoEZ8CP4Mfm3WL987XCvo0ktDMvE8Mv0wfy3fT99IWy9qArjpNOej8
        0e44kih1xtZ+Lyun7K80DH+8/WjpvnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-veC0PqnwMK6cPElMzpBeTQ-1; Wed, 09 Sep 2020 04:23:23 -0400
X-MC-Unique: veC0PqnwMK6cPElMzpBeTQ-1
Received: by mail-wm1-f69.google.com with SMTP id x81so503354wmg.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ipg+kGRxf4wxWeQOhvAJYTIzegDq0gtF7D+pA4396Qw=;
        b=l+wEfhHwb9oviilzsVoDHyud8VczJbTSqzy2/PXQByniW3yk8hSuM2ueZ9jAiXeLct
         wc283nusik5YItsYiOpkaG/N8R24Bsn0XweygyA0GI87bned3ENWOhCt0i1zuDE18O8R
         Gbr5WIjt87jHJrXw54wmds+T6Q5wLfofBr1UYf2xKRxKW8wpJnGRtUb5Kr2X21lhN6gV
         9xerSFho/EyUqAwkGMUK1wbsQ7DUDoksERK5HJEV/xgmt9WPQlDmChqH4BydS1AU6SG+
         U/httHcBYyOXF0V1ap8KZBnTGxEjuBBJwSFsPlM7NpFnzO0uzgZluQTWwzBi2vdy6PRN
         JM0w==
X-Gm-Message-State: AOAM532E8Sw0ovkpMRxk/111qhCz6D2Y0MbyM9tzTGs9iRpWKjywPdLB
        g40hV3UG1h8cYU09B3F2t8XGFO+QO7T3dcBh6xy2oGmh8cFW/vrEJZ6tBVLHcUhiy3C740YlhtA
        JA6VmV18DDW13ZO8NlQPcJcRQ
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr2493837wmm.38.1599639801897;
        Wed, 09 Sep 2020 01:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe4nQzns/RJMYzARqqL49tYar+YFQfC6QojwjzqbtuqOGYc6Q3M7yHZV1wTiTye79EV4m7mA==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr2493821wmm.38.1599639801726;
        Wed, 09 Sep 2020 01:23:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m3sm3246714wme.31.2020.09.09.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:23:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] KVM: SVM: Get rid of handle_fastpath_set_msr_irqoff()
In-Reply-To: <1599620043-12908-1-git-send-email-wanpengli@tencent.com>
References: <1599620043-12908-1-git-send-email-wanpengli@tencent.com>
Date:   Wed, 09 Sep 2020 10:23:20 +0200
Message-ID: <87h7s7mk93.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Analysis from Sean:
>
>  | svm->next_rip is reset in svm_vcpu_run() only after calling 
>  | svm_exit_handlers_fastpath(), which will cause SVM's 
>  | skip_emulated_instruction() to write a stale RIP.
>  

This should only happen when svm->vmcb->control.next_rip is not set by
hardware as skip_emulated_instruction() itself sets 'svm->next_rip'
otherwise, right?

> Let's get rid of handle_fastpath_set_msr_irqoff() in svm_exit_handlers_fastpath()
> to have a quick fix.

which in the light of the whole seeries seems to be appropriate, so:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>
> Reported-by: Paul K. <kronenpj@kronenpj.dyndns.org>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Paul K. <kronenpj@kronenpj.dyndns.org>
> Cc: <stable@vger.kernel.org> # v5.8-rc1+
> Fixes: 404d5d7bff0d (KVM: X86: Introduce more exit_fastpath_completion enum values)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/svm/svm.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 19e622a..c61bc3b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3349,11 +3349,6 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
>  
>  static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
>  {
> -	if (!is_guest_mode(vcpu) &&
> -	    to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
> -	    to_svm(vcpu)->vmcb->control.exit_info_1)
> -		return handle_fastpath_set_msr_irqoff(vcpu);
> -
>  	return EXIT_FASTPATH_NONE;
>  }

-- 
Vitaly

