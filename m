Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E4F20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb62JDvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbgFYIJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:09:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390396AbgFYIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593072558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSGQ/c5ShJ+Wy+Y09jXsrJyUMElWj+v+/BP4E6A1ROc=;
        b=Xb62JDvcO6JH75Tf8GdtNFShvqCYACDkEHN0zP7Cb085w+SD8bocuAS4Ok8z/IOx/f7B4p
        Is6jBS/DaBUYUwHZhZiwdqoFU2d3cTt3bPtNPNJBMaLXd9q/bwSSKsgLIIgfTti16V6vds
        FeJyR05jKNyt52i2RxnJ6aN7l+1x5Og=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hoaWqXptNyCO_x6Ycx9cFg-1; Thu, 25 Jun 2020 04:09:16 -0400
X-MC-Unique: hoaWqXptNyCO_x6Ycx9cFg-1
Received: by mail-wr1-f72.google.com with SMTP id i5so5041661wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kSGQ/c5ShJ+Wy+Y09jXsrJyUMElWj+v+/BP4E6A1ROc=;
        b=h11375cHkD7NvgTKDJelVP1yIrXZWKH6JFD9GtSVod7GiupDq0T+qyHqDC7YzOC8Rq
         gzLT8+AiDyXhRXctSrRNGyiUgtqTuXxD0R2jrhmSiBm+tTbnMxqFg6i8B5n3nGyl+COz
         4q968QrM76vBNhruYcZbVp+f6GeW+QjYSdR0iW9PTH0nfuDwRG9jA378YV6tlvMvN3nY
         rrX3sZHDqdXEMPwm1rP4B8x8JtLfIdX4M1zMd/afcnGvecqjeeZ9J21ZiusTxZK2ePoN
         Y1A9tKjDvzTp1f4+SihwbhiXk5N5SF1ev1WEq8+D6nITqmPZVtKz0zlK01H3rc5NN52h
         06Hw==
X-Gm-Message-State: AOAM530ZOwhTtiP/xCGc24xglBqOuFnoWTZtSqdNqppGDdpw2CTZdnii
        O6MQF9VYrosFsDVZK/ja6wCWU0K5Cehqr7UYnakureI0GI30jiJrIWjQB9NR1uq/YXFoeuDYKde
        g/1zMj0GxDEWhiYcTMxXFw/kz
X-Received: by 2002:a5d:5270:: with SMTP id l16mr27931641wrc.122.1593072555469;
        Thu, 25 Jun 2020 01:09:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu3WRKqxf9t0ItCr5MiLTW4CShMAwLhiKgnLtu7bDrz9rzBO8clwwCNiY44t+zaDTL7zOcpQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr27931621wrc.122.1593072555252;
        Thu, 25 Jun 2020 01:09:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80? ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
        by smtp.gmail.com with ESMTPSA id u23sm16912259wru.94.2020.06.25.01.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 01:09:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200622220442.21998-1-peterx@redhat.com>
 <20200622220442.21998-2-peterx@redhat.com>
 <20200625061544.GC2141@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cebc562-89e9-3806-bb3c-771946fc64f3@redhat.com>
Date:   Thu, 25 Jun 2020 10:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200625061544.GC2141@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/20 08:15, Sean Christopherson wrote:
> IMO, kvm_cpuid() is simply buggy.  If KVM attempts to access a non-existent
> MSR then it darn well should warn.
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8a294f9747aa..7ef7283011d6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1013,7 +1013,8 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>                 *ebx = entry->ebx;
>                 *ecx = entry->ecx;
>                 *edx = entry->edx;
> -               if (function == 7 && index == 0) {
> +               if (function == 7 && index == 0 && (*ebx | (F(RTM) | F(HLE))) &&
> +                   (vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR)) {
>                         u64 data;
>                         if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
>                             (data & TSX_CTRL_CPUID_CLEAR))
> 

That works too, but I disagree that warning is the correct behavior
here.  It certainly should warn as long as kvm_get_msr blindly returns
zero.  However, for a guest it's fine to access a potentially
non-existent MSR if you're ready to trap the #GP, and the point of this
series is to let cpuid.c or any other KVM code do the same.

Paolo

