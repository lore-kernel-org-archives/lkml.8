Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D4C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8175D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIT/SarM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBEO2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:28:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgBEO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580912931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVktf06+GZqAo22U81ichbfeIFv6sOB8dBH2Oa/AtXQ=;
        b=CIT/SarMAxH0Pe0tiAMiNdSnd59yLFZAVuy2ub/3BjcTrh618hmeB/uOGiUfIuolDvguLY
        HSgSJLkxXeRdpQJd2AIKyS+bXUvbV7mlZb/CWU+Lka8Hu70WPUwOrbjqrnj0KHscCk0jLw
        2QjijCNzhbZgfaM7vkmcQNyBj/Iy/bM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-oXZTs3JyOTmsUM5QoazqNA-1; Wed, 05 Feb 2020 09:28:49 -0500
X-MC-Unique: oXZTs3JyOTmsUM5QoazqNA-1
Received: by mail-wm1-f69.google.com with SMTP id 7so1057034wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VVktf06+GZqAo22U81ichbfeIFv6sOB8dBH2Oa/AtXQ=;
        b=kcc1nLruOlIIkqc5sr8GJx+bAP9etRuCfBQCsMmEoXAC5H899ZPMurP7Fpfw3tmMKZ
         mXcYS/UcKUmG9q4fH4sNz+odAAW7JhIJPfLhMzJ7FMQNug22DFoaWa8bVKC7Z+Hg+kGt
         72Y/b4AMZKqC5voUOEGB1cfnEtcmKJYddZ1WtJcNin30ybY3EpmJ72gqD2xpw0TSWPEF
         QLVWspcbzVgAOutf/Z+8Ok/SZiAz2DHR7/HTuvtqENAtzDDILMn+rwK7x4FwE8EZeggS
         xMEaaClB8SI02rFbJicGNOIDTHl4j1nVsbc7dFFcIST4xx3Y+bJ2iwFx2ELs92UJ8Ecz
         mDBA==
X-Gm-Message-State: APjAAAVHqERs7sDWfZMkqdP+VbsDXBydA961wzjFMBahJi5ygItQJ0Ze
        jimY3rVVLEQlTapYFCWg4PodKQykjq2Kt5h6LIGtsEbO4bIIs/rDlGn7ZFuSViU1db3r7SDPHLd
        2j+8mwyK0OFsqV8OztX1YIxDM
X-Received: by 2002:a1c:740b:: with SMTP id p11mr6293063wmc.78.1580912928002;
        Wed, 05 Feb 2020 06:28:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxT+e8hvj/MufgYJHCGifPCvbBShe4n/7zTciX41OS2hObKa3dxiQxvgkgaTmHXGd/bD/YTg==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr6293031wmc.78.1580912927687;
        Wed, 05 Feb 2020 06:28:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id 18sm8243459wmf.1.2020.02.05.06.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:28:47 -0800 (PST)
Subject: Re: [PATCH] x86/kvm: do not setup pv tlb flush when not
 paravirtualized
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        kvm@vger.kernel.org
Cc:     sean.j.christopherson@intel.com, wanpengli@tencent.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20200131155655.49812-1-cascardo@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11c6069b-1248-30b5-f69c-36f47755d75f@redhat.com>
Date:   Wed, 5 Feb 2020 15:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200131155655.49812-1-cascardo@canonical.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/20 16:56, Thadeu Lima de Souza Cascardo wrote:
> kvm_setup_pv_tlb_flush will waste memory and print a misguiding message
> when KVM paravirtualization is not available.
> 
> Intel SDM says that the when cpuid is used with EAX higher than the
> maximum supported value for basic of extended function, the data for the
> highest supported basic function will be returned.
> 
> So, in some systems, kvm_arch_para_features will return bogus data,
> causing kvm_setup_pv_tlb_flush to detect support for pv tlb flush.
> 
> Testing for kvm_para_available will work as it checks for the hypervisor
> signature.
> 
> Besides, when the "nopv" command line parameter is used, it should not
> continue as well, as kvm_guest_init will no be called in that case.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  arch/x86/kernel/kvm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 81045aabb6f4..d817f255aed8 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -736,6 +736,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  {
>  	int cpu;
>  
> +	if (!kvm_para_available() || nopv)
> +		return 0;
> +
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
> 

Queued, thanks.

Paolo

