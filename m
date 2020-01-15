Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B740AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E824679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6OCHPVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgAORxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:53:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27566 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbgAORxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579110822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a21Qt8oFCTbhrNX1697lVeADy2POBjMF/euhssereqA=;
        b=F6OCHPVVY4Ffag5Feb79SX5CSiCAgcTFSt+sa2AsBGzPeCWhuR5uag29Q5ZVyrU6m46Wec
        6VRknnICc8HINEzueyAt70bMSaU0ldtQaUOpvBe+RU0kSPY9Bti9RPLqamNIabhClv9GOV
        RcL9c0Sp40KA62wnw134cin2/X1ZnFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-hIF5X58yOVONhQjUDaLaeQ-1; Wed, 15 Jan 2020 12:53:40 -0500
X-MC-Unique: hIF5X58yOVONhQjUDaLaeQ-1
Received: by mail-wm1-f69.google.com with SMTP id p2so232932wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a21Qt8oFCTbhrNX1697lVeADy2POBjMF/euhssereqA=;
        b=bu9t8SZrtETjK16QMNOUidYOA4Jr81LhPd0xG6wYUwV36e5NFLkjH6KCGde1Y+k05F
         7KwMoxWFzIxY24s5cMxumzz3ky1RZFqdMOkRWCGluhbtuVjHz2aQS0Ae8Ib3fhdPKFhi
         xREJYlgVi2gc1rw4+16qnxRGu2J3cRVX8QwIS6H91qzrrFvwNVXu7icIfIiHu6VdgqjS
         R4Ud9oIHkSjn6b7At/tkAZDZoCYYkdS5h5EF1d9b55QfdebpAHdOwNdQFhwVlERiAo+k
         +d6v/WU/v3eZbcXePodOkHZguBhxezgSPkKxIyzY5ejqsDZA81tPjV3htGXJy1AvfE/0
         wdaw==
X-Gm-Message-State: APjAAAWyUGLQUoBdOfzsfA/N8mlD3W432T/NPJn6M+/PLwnaTjFP/Jfv
        B0R5lRYKPhvzVCQRuETcZCSshzFo0Z8CvXIVQW7mPAYTEMdhs9ldGQzOEqUoDIoxvjQaP2IRqKo
        S0as48SEBNckTcUOR/jjqH6nR
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr1075074wmg.83.1579110819592;
        Wed, 15 Jan 2020 09:53:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVUW0GWD/BbLlkB6QCotVb7uRTNn5MEbaGIbppm9s4IVai07E++87QyL+uOr4TgKm96kAD2Q==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr1075044wmg.83.1579110819370;
        Wed, 15 Jan 2020 09:53:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id q3sm26493043wrn.33.2020.01.15.09.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:53:38 -0800 (PST)
Subject: Re: [PATCH 5/6] KVM: x86: check kvm_pit outside
 kvm_vm_ioctl_reinject()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1575710723-32094-1-git-send-email-linmiaohe@huawei.com>
 <1575710723-32094-6-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5968f94f-ecd9-c284-b762-683ea761ec68@redhat.com>
Date:   Wed, 15 Jan 2020 18:53:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575710723-32094-6-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/19 10:25, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> check kvm_pit outside kvm_vm_ioctl_reinject() to keep codestyle consistent
> with other kvm_pit func and prepare for futher cleanups.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2d4e3a2dfec6..00b5d4ace383 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4662,9 +4662,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
>  {
>  	struct kvm_pit *pit = kvm->arch.vpit;
>  
> -	if (!pit)
> -		return -ENXIO;
> -
>  	/* pit->pit_state.lock was overloaded to prevent userspace from getting
>  	 * an inconsistent state after running multiple KVM_REINJECT_CONTROL
>  	 * ioctls in parallel.  Use a separate lock if that ioctl isn't rare.
> @@ -5029,6 +5026,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r =  -EFAULT;
>  		if (copy_from_user(&control, argp, sizeof(control)))
>  			goto out;
> +		r = -ENXIO;
> +		if (!kvm->arch.vpit)
> +			goto out;
>  		r = kvm_vm_ioctl_reinject(kvm, &control);
>  		break;
>  	}
> 

Applied this one, I don't think the others are a useful improvement.

Paolo

