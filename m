Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F902086A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTvBU4sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFEReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728132AbgFEReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591378441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aal65plzbeSyYXmLW554nnRb5RbtIzEAofuK3KvvwQ=;
        b=KTvBU4sq750Ywo0idwMvbbJf4ZPgb1sF3EJIA1R/AQqzKf0grQ43X9Fv4yIFNBoKoAxEHy
        wFZuOI67jG5eFlFTQceqJQVWtHRc2uKSiwEZFh23vKD5wwtbIi9nGcnrrme8+st+p0pWnK
        p9EEpEHH412xzPwli6v5qqyiHAvPxyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-3m7Plw0LN7usO8lqMK3j3g-1; Fri, 05 Jun 2020 13:33:59 -0400
X-MC-Unique: 3m7Plw0LN7usO8lqMK3j3g-1
Received: by mail-wr1-f72.google.com with SMTP id p10so4055918wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 10:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0aal65plzbeSyYXmLW554nnRb5RbtIzEAofuK3KvvwQ=;
        b=AyFSyFdBhINMAmNoGbwrceoJP5oyTpiDVtytT00fmY/xBG24PSRxkHKqNd8xenLVyr
         KN1DSSxHUdKTaf7Skuez/RiGYsc3Lhxr3LgZsei4eeWSmPI4FhW9XuqlvKoTXpxncCfO
         Gw3q7yvOdpAxVnGrlBpSVR9dJaGPNZnfdzfN0PokkYGVEJStVp5z+Qn+xFM4tCtlEqsv
         9EQnjoUwVF7VVPkJSX+IECNcoXIK4KPd25pnaIa/dfRfDV84DE9JMBmVgCIe4PxnoQqj
         OUDjxPM344Jux0YkYZrrN9FtSPjK15sN0JnKDgiNxuXSY5ArLFW1zR9wZcX1zWRttb8d
         cwPA==
X-Gm-Message-State: AOAM532mBaU+vw+6twrsyf9cKLlud3UQQmcb7hRkn4pjIFn6tpYE3VIC
        VOYuNVSw6aV0orYoEdeIqWAIscgm02PkyF9HBxwZ6YqFvf8zspKTY48lDUaK/FbWSP6RdXi+KbD
        uVMo2Tkq+MS5HMQVB67ljzX+2
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr10304102wru.194.1591378437013;
        Fri, 05 Jun 2020 10:33:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWiRtmf6SMYmlHoEbROCKhYR9wsQ37MKaaPkjq7nH4qScnMbizM4PvJ33BL3NHlCV8yf8D+g==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr10304083wru.194.1591378436727;
        Fri, 05 Jun 2020 10:33:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id c16sm12977772wrx.4.2020.06.05.10.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 10:33:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Revert "KVM: x86: work around leak of
 uninitialized stack contents"
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200605115906.532682-1-vkuznets@redhat.com>
 <20200605115906.532682-2-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <100b82ab-d6f5-7b0e-2d4b-13bc16ec273f@redhat.com>
Date:   Fri, 5 Jun 2020 19:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605115906.532682-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 13:59, Vitaly Kuznetsov wrote:
> handle_vmptrst()/handle_vmread() stopped injecting #PF unconditionally
> and switched to nested_vmx_handle_memory_failure() which just kills the
> guest with KVM_EXIT_INTERNAL_ERROR in case of MMIO access, zeroing
> 'exception' in kvm_write_guest_virt_system() is not needed anymore.
> 
> This reverts commit 541ab2aeb28251bf7135c7961f3a6080eebcc705.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9e41b5135340..0097a97d331f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5647,13 +5647,6 @@ int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
>  	/* kvm_write_guest_virt_system can pull in tons of pages. */
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
> -	/*
> -	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
> -	 * is returned, but our callers are not ready for that and they blindly
> -	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
> -	 * uninitialized kernel stack memory into cr2 and error code.
> -	 */
> -	memset(exception, 0, sizeof(*exception));
>  	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
>  					   PFERR_WRITE_MASK, exception);
>  }
> 

Queued, thanks.

Paolo

