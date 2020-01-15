Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4038C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A2C2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7Wxsgoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAOSIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:08:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53715 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729085AbgAOSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5ayVeHtywtAZ8iHKxphL0A5R/B7E3CKCfl0+VtoYVo=;
        b=Q7Wxsgoa0dx2JjuBDh/XWXW4uHqUBAeCS8YtG7ZiU0A5iorGHueta/vvmCVIkTq/gL04gm
        PeLHFXzzAtVAXLlU7gJX0F23QmKmBMmJpt594tf3i7PUmw3tMkMTKBCbJM1MMROQhc+Hfk
        ZgiytvQXgqPdOC6tSNeYQT/vs9mOmNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-YIhfToOfP7WA9S-fF5OJYQ-1; Wed, 15 Jan 2020 13:08:28 -0500
X-MC-Unique: YIhfToOfP7WA9S-fF5OJYQ-1
Received: by mail-wm1-f72.google.com with SMTP id f25so247562wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w5ayVeHtywtAZ8iHKxphL0A5R/B7E3CKCfl0+VtoYVo=;
        b=W1fs88XEwvtWJUMQWrQ1F/sVVy26nQKEMsKOxb9/iYjElnaN8wWR+ccm267r+SjBol
         fxTU+mbc+8qcbW9VduiY3i5o6CdOddMvdY/XYZrLTsPiDUaZsj68komrN98ZzuLEEg84
         38KaS7aLDtZF0dK8+BcJOYYng4E/LAinE3IwC7KQyBUOaG9bvLp6xhvkw4DK/v8S0yeA
         Ulh7/zaZsxcWKfEqvhJtQr34dwaSzjkkwJs4NHBEHgQGMvZZhlGVWtjDBaBQEVSLS+cW
         cvJ6sd/tsThf+0nbhc61fLznpb0Pdb6P4UG3t/PGDMPcdo/2+fD5fHd0zob8EkOaYU4r
         r7DA==
X-Gm-Message-State: APjAAAU7oDiXlhB8HPLXrfRUE24hdxEa5GTM7/QZgpGPX8Dx5ocbd4ew
        5dtdBPQjC5xu6cOf5uhSTUQTgjnw2ojfsSnkrXfUwml8aysAZfOL1GlTyojB8tdGylcMAJNz13Y
        lAmRCIF34WrEIsJYdMW0IZ6C3
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr1262246wml.28.1579111707653;
        Wed, 15 Jan 2020 10:08:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzudxSmFCpQ2b8K45MRgV8cH5Fw/TvUv/MQE62HNDVPvCAdHeh4gxH3ZU9jiHwRIX4eZ9tpLg==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr1262215wml.28.1579111707469;
        Wed, 15 Jan 2020 10:08:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id a1sm822476wmj.40.2020.01.15.10.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:08:26 -0800 (PST)
Subject: Re: [PATCH] KVM: vmx: delete meaningless
 nested_vmx_prepare_msr_bitmap() declaration
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1576306125-18843-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b52df53-33a5-f7f9-fb1d-6de3abd2c695@redhat.com>
Date:   Wed, 15 Jan 2020 19:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1576306125-18843-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/19 07:48, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The function nested_vmx_prepare_msr_bitmap() declaration is below its
> implementation. So this is meaningless and should be removed.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 63ab49de324d..e038a331583c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3048,9 +3048,6 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
> -						 struct vmcs12 *vmcs12);
> -
>  static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  {
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> 

Queued, thanks.

Paolo

