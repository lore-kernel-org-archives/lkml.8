Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC31C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A5521569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iop+mjF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBLLzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:55:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728373AbgBLLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581508533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VO92xNjuqVngdbAeJCqPywWhfFf8cqpsXDffiMY5IzI=;
        b=iop+mjF0W/Hx4rLbTYV25qwTmIO8+lK4Gz8CU36yoGg3AzbXR4MyMAnpbO86mGhCLupvle
        L+udIrPDeYuXnFJP5m0kvntvKFo/TqHlv3WLE9PFVbWXZdnQp6WdWDLmljdRe6SUJLec03
        BM4/Pm1+Qt24/R7JtnwCgMcRO41uFAY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-HhdXONtoOsmfwzE-ThdVyw-1; Wed, 12 Feb 2020 06:55:32 -0500
X-MC-Unique: HhdXONtoOsmfwzE-ThdVyw-1
Received: by mail-wr1-f71.google.com with SMTP id a12so707427wrn.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VO92xNjuqVngdbAeJCqPywWhfFf8cqpsXDffiMY5IzI=;
        b=JCPN8cEksnAsX7EOP21m8WPC6bqb8EjdVOobwsrkZG2Oln09D8zrBpO+JUYidSFevU
         Xwhoi3MdhFGBw96EiUv6PtqhzYdndBED90alkM4sNeu8DHgnlW9Py4Nzat6Ph3Ic5RmY
         mQ1Y5AQHmZIf1BYMbLoRup2oDICkozoyQ02gdloR8AyV8JDoUSoOOjOgfx6eMurt6qbB
         Tveh4UaGvm0XLksOwRhrjTFBPsAbfcX8vr71aqLJsVHdrEtLfjAXve+3vCIwbjwEjbjl
         QGoroV1+760i50+qdDOwWUOnQzUX4wv4RKwXCZysLRlGQfxyIray2CgniiptqWwngLoy
         FXrg==
X-Gm-Message-State: APjAAAU2/G99jJCANL1tiNmEm5+d10ArOHgABallQl2jlG9cL0APqY8B
        zNVZlQdyuCSceDk1W0OzoxRgrREHF7e7NlJ5ZSGlM7VZN0rS8HvVnfjlU3KtWTmFLot1OCyBJm2
        jgtuxxxEOtD/ffpFi1aan8wmg
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr14707767wrp.63.1581508531296;
        Wed, 12 Feb 2020 03:55:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyN1KE6FEsA3zB3+ukJKbm1l3xqWsAV89kzf2dgLcA5uAeLVWKrS9BHxf2NkFIDJ1UWsFq4Gw==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr14707736wrp.63.1581508531015;
        Wed, 12 Feb 2020 03:55:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id x11sm391189wmg.46.2020.02.12.03.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:55:30 -0800 (PST)
Subject: Re: [PATCH v2] KVM: apic: reuse smp_wmb() in kvm_make_request()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581088927-3269-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4202948e-1c12-9ab0-5bba-d63846da8001@redhat.com>
Date:   Wed, 12 Feb 2020 12:55:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581088927-3269-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 16:22, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> kvm_make_request() provides smp_wmb() so pending_events changes are
> guaranteed to be visible.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> v1->v2:
> Collected Vitaly's R-b
> Use Vitaly's alternative wording
> Drop unnecessary comment as suggested by Sean Christopherson
> ---
>  arch/x86/kvm/lapic.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index eafc631d305c..afcd30d44cbb 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1080,9 +1080,6 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
>  			result = 1;
>  			/* assumes that there are only KVM_APIC_INIT/SIPI */
>  			apic->pending_events = (1UL << KVM_APIC_INIT);
> -			/* make sure pending_events is visible before sending
> -			 * the request */
> -			smp_wmb();
>  			kvm_make_request(KVM_REQ_EVENT, vcpu);
>  			kvm_vcpu_kick(vcpu);
>  		}
> 


Queued, thanks.

Paolo

