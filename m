Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75333C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B524206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cubjLG9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgCWM7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:59:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25817 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgCWM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584968341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HTzcRz3o3qfXex5hqeXQ2T6ofF+yWf+Qi36UvhbgGw=;
        b=cubjLG9C8kO5DZTKpy/DEbEkZ7PShd1lbaVwY0mHpi26ZJRLIlUv1D0A4fhROfJBR/huYe
        a5mnL1iyYw7TOzpba8PPhI+eGLu0HyT5A6ONgq2RA1iBV2ErQeMswXaNSwTvkGPOmkCoTw
        ZwFFIbGnwP1ucui5tIdMcRxr8El8PXg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-r6cO9dm-OGuMIIhwD1WbzA-1; Mon, 23 Mar 2020 08:58:59 -0400
X-MC-Unique: r6cO9dm-OGuMIIhwD1WbzA-1
Received: by mail-wr1-f71.google.com with SMTP id v6so7271825wrg.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HTzcRz3o3qfXex5hqeXQ2T6ofF+yWf+Qi36UvhbgGw=;
        b=bKng3f3L6CUehFNuBZV/rUE025w0CplXBbRtdhh9T8Hd/CJBRAKuZrO0duNIkZs0gM
         LgPFVnZT8qSmj0mmX6bP7HLO2u68QxFUpsJb+SOaYjct4foltFKPe5sSd9CNQkdAfFVv
         51CSgtC+55g/ZpXEfRQBu77/fwficDg5RBuR32W2icvVXY1pWH5jzH95bsrNHVXYPdyv
         bu8WBAtptz0vw8e+7YVtKxU7iFfcXvsLFXTgx30EfdAWHz03K90pSQg1gtMGAdZWcJxe
         CW8NIEHMUh+UdKB3jrsG9UXyE0EsKgo2uasmddL3xg6Hx7en09audQOZW2YbVAZtmA8r
         EABA==
X-Gm-Message-State: ANhLgQ0vPkLEq7aGj1zJQBAqshwe3dvhhcOI0dGQtQzPrZuipMSnAXjM
        GE/L24+DTt/iEGR8PySz5NBgk7mS5yk4HdK9w6d2HtADQdfmA5Y0gtcRLIY0KaWHsc/uQMCs+Gg
        Qk36VSW+Dll0tIoRy9b45XO8G
X-Received: by 2002:adf:aacc:: with SMTP id i12mr31396969wrc.116.1584968338289;
        Mon, 23 Mar 2020 05:58:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6lNHTTDFNS1+6/voSjetJ50D0n//DWfUviVLJPhmz+dU6+d94lOeUVvb31wDc7vbhL+vjfQ==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr31396943wrc.116.1584968337983;
        Mon, 23 Mar 2020 05:58:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id g14sm22381288wme.32.2020.03.23.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 05:58:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Expose fast short REP MOV for supported cpuid
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200323092236.3703-1-zhenyuw@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5bf4035d-4c37-be3f-cfe2-759ccc0bc17d@redhat.com>
Date:   Mon, 23 Mar 2020 13:58:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323092236.3703-1-zhenyuw@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 10:22, Zhenyu Wang wrote:
> For CPU supporting fast short REP MOV (XF86_FEATURE_FSRM) e.g Icelake,
> Tigerlake, expose it in KVM supported cpuid as well.
> 
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 435a7da07d5f..cf6da12bd17a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -338,7 +338,7 @@ void kvm_set_cpu_caps(void)
>  	kvm_cpu_cap_mask(CPUID_7_EDX,
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
> -		F(MD_CLEAR) | F(AVX512_VP2INTERSECT)
> +		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM)
>  	);
>  
>  	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
> 

Queued, thanks.

Paolo

