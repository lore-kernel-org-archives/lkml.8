Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEECC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03522076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4U2q1yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCRL0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:26:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22870 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgCRL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584530802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5igz5ifXUjPW3HOZrUuMXCx1D9YbVzwpu9tICwFVMz4=;
        b=Z4U2q1yqXf1zch0EcDOVh3U1K+OMXJHFv7NTspfYcSFz8HI5JHMsF9zCPoaXvjPp423ArG
        cyPa+MdL0f1+HAhdeqiqzn2HPCVyjwO7X3UJrxueIPJndBeTANhEk6IcyJu9c21YfHQCLU
        AtQCkWk/Pq4RS+K+ckR+lzP+kx/Swhc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-nEYzvfKIM5GApIyD39elQg-1; Wed, 18 Mar 2020 07:26:40 -0400
X-MC-Unique: nEYzvfKIM5GApIyD39elQg-1
Received: by mail-wr1-f71.google.com with SMTP id l16so11473964wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 04:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5igz5ifXUjPW3HOZrUuMXCx1D9YbVzwpu9tICwFVMz4=;
        b=IOQJk7/Zyo1KGP6Zb354a3iWy0IQu34Sa3WPPN4WD0cPZX1nFarYvmhajPraaI9to8
         VhnqbfIsouSOsDz8YuE3sjrnqjB+w+0zK7Bm2Ty9zo3anebZGErPQsEoheOVBUpJ4sUL
         visYThOmohxJhKHE0r70ieUoDE/BkBWy+nJ3OWx3G2IL0OkjbsDdAuAZrMbrAP7dOBYN
         AeGu2WYqARKcFLdA5wpTHXu1KRxtEUIkzTywEfZAr+k+C3AnoPnUEcnTYrCku5zwfTrv
         nKHTKLHr3+pG6Q4qbqsPWR/w7d3wXR6uMEMgBwKLPPqcbTqS50WqbnLsYw5vegh2O74q
         F7Qg==
X-Gm-Message-State: ANhLgQ0qR8ZlUf6EZJEyAf2Ts9/lswZvNgk7iSPbiLg7mNSWl7O3i3zt
        7MKQpmvwvJl9yQVhhsXWakJRoQHSRPkF2G9BVrutfSi+ltumpXeRebjB00xMWyt3bVHJL/svjgn
        ms3F3QcfrNGUgCYn3ohkMaJOA
X-Received: by 2002:adf:f807:: with SMTP id s7mr5040090wrp.49.1584530799360;
        Wed, 18 Mar 2020 04:26:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsNZ3RbBs/kRWmkrVpq+7LDajnIvwaWGyakEzMuR33iRe/bnqCAX/H4bBeFbfpC3O8OTc31ZQ==
X-Received: by 2002:adf:f807:: with SMTP id s7mr5040067wrp.49.1584530799133;
        Wed, 18 Mar 2020 04:26:39 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id z12sm1721100wrt.27.2020.03.18.04.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 04:26:38 -0700 (PDT)
Subject: Re: [PATCH rebase] KVM: x86: Expose AVX512 VP2INTERSECT in cpuid for
 TGL
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Zhong, Yang" <yang.zhong@intel.com>
References: <dcc9899c-f5af-9a4f-3ac2-f37fd8b930f7@redhat.com>
 <20200318032739.3745-1-zhenyuw@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65e997c3-9ef9-d9f3-143e-0bc0823aad4f@redhat.com>
Date:   Wed, 18 Mar 2020 12:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318032739.3745-1-zhenyuw@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/20 04:27, Zhenyu Wang wrote:
> On Tigerlake new AVX512 VP2INTERSECT feature is available.
> This trys to expose it for KVM supported cpuid.
> 
> Cc: "Zhong, Yang" <yang.zhong@intel.com>
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 08280d8a2ac9..435a7da07d5f 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -338,7 +338,7 @@ void kvm_set_cpu_caps(void)
>  	kvm_cpu_cap_mask(CPUID_7_EDX,
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
> -		F(MD_CLEAR)
> +		F(MD_CLEAR) | F(AVX512_VP2INTERSECT)
>  	);
>  
>  	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
> 

Queued, thanks.

Paolo

