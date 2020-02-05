Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F8C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A52E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K17SnmxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBEOxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:53:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgBEOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MNWZsAt0GakYeHHsh62uWNt42TPtqTAAamgIIzZgO4=;
        b=K17SnmxKPaKH1VVQhd0Joiue2jDfOAbb8SCRbVscSkZ6Vzol48J6G7HQ6uC2LI1ncEr/+I
        U8AioQT/Vnzv2IRdmg32rBvJcdQ/NqqaWsu6JCotyuhHMyRETItiNDyGVgjehoPYFsw1Lp
        qY1a0nVZE0CsS7d495HdxHov0haNOG0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-UB5tXOZMMpKfY1yllftWew-1; Wed, 05 Feb 2020 09:53:48 -0500
X-MC-Unique: UB5tXOZMMpKfY1yllftWew-1
Received: by mail-wr1-f69.google.com with SMTP id o6so1299530wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/MNWZsAt0GakYeHHsh62uWNt42TPtqTAAamgIIzZgO4=;
        b=YMjFxve3dULNqCiwHXdarWU3FTMFMSa6OGXNQTQR9V1FzQYHKqrsFMnxDnrehRx9/O
         QfSPOnbNw5s1NrYWUehFFCauP0PqjQxik7K88jqaXjx+cGtPqJyU2bayRsMp+E9mTqkN
         mNojnSZlvPZevnnRXm++WN6RirfUYIAm9Fs4XCR8IvpLh0QyDi75a9xSlpq8aMY1c+9o
         DDIEohk3zgJW1h0aNTA8K+A16EowXoGY26zjR3SuPVbTSA5eSsPWmj2+UX3+dBveOFlW
         qNFgOJekqG6bHnDMgTTfD921BK7dBPwQ9JAJ7Npbbtb9SCoMp01UKhiIYcT/m7rtpYRL
         6Rjg==
X-Gm-Message-State: APjAAAUgpOYjV9U6yOc4n2/CJu21tEw7xLPDiqSB3UHIjkpYdcvjKAS5
        Hf4/VkVfg5+jp14LIvi5xjFB0UeQnW8l5isJi1yTQlhMGa3h341Heta6f+oXjejph/cNVRNvlmB
        +L455dEgfjCMUsrNisLHR2Vbu
X-Received: by 2002:a1c:8055:: with SMTP id b82mr6336224wmd.127.1580914426504;
        Wed, 05 Feb 2020 06:53:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhZKTW1RLaMrrkjkmXabRUb8UDiYlj7WTwbn0+/m2H2anJq6Rbw1Sd2Y0z5J7gS8UI/cyr8Q==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr6336207wmd.127.1580914426221;
        Wed, 05 Feb 2020 06:53:46 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm9302750wmh.3.2020.02.05.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:53:45 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/26] KVM: x86: Move MSR_IA32_BNDCFGS existence checks into vendor code
In-Reply-To: <20200129234640.8147-7-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-7-sean.j.christopherson@intel.com>
Date:   Wed, 05 Feb 2020 15:53:45 +0100
Message-ID: <878slhkruu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the MSR_IA32_BNDCFGS existence check into vendor code by way of
> ->has_virtualized_msr().  AMD does not support MPX, and given that Intel
> is in the process of removing MPX, it's extremely unlikely AMD will ever
> support MPX.
>
> Note, invoking ->has_virtualized_msr() requires an extra retpoline, but
> kvm_init_msr_list() is not a hot path.  As alluded to above, the
> motivation is to quarantine MPX as much as possible.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c     | 2 ++
>  arch/x86/kvm/vmx/vmx.c | 2 ++
>  arch/x86/kvm/x86.c     | 4 ----
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 4c8427f57b71..504118c49f46 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5990,6 +5990,8 @@ static bool svm_has_virtualized_msr(u32 index)
>  	switch (index) {
>  	case MSR_TSC_AUX:
>  		return boot_cpu_has(X86_FEATURE_RDTSCP);
> +	case MSR_IA32_BNDCFGS:
> +		return false;
>  	default:
>  		break;
>  	}
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9588914e941e..dbeef64f7409 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6279,6 +6279,8 @@ static bool vmx_has_virtualized_msr(u32 index)
>  	switch (index) {
>  	case MSR_TSC_AUX:
>  		return cpu_has_vmx_rdtscp();
> +	case MSR_IA32_BNDCFGS:
> +		return kvm_mpx_supported();
>  	default:
>  		break;
>  	}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a8619c52ea86..70cbb9164088 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5237,10 +5237,6 @@ static void kvm_init_msr_list(void)
>  		 * to the guests in some cases.
>  		 */
>  		switch (msr_index) {
> -		case MSR_IA32_BNDCFGS:
> -			if (!kvm_mpx_supported())
> -				continue;
> -			break;
>  		case MSR_IA32_RTIT_CTL:
>  		case MSR_IA32_RTIT_STATUS:
>  			if (!kvm_x86_ops->pt_supported())

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

