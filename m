Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CBC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6AD24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsGVPwje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgBUOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:22:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727096AbgBUOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582294976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLIKrkW+7T8bovTbNLkf8QwIZMSzY0Eq6ByLnO+LRhY=;
        b=XsGVPwje/awj3lCqjPsQRQGmVC16Z+3XqibwopAgzlLLTcaKnbpO1zxzrg7mOP7DzbykGD
        2GYmrFAdMhXN+4FZ22HrSu6sTcT9llzxoYoRcR8WWJlKxNpz2ld4mW29Ffog1xce966yG7
        n0ap4IMZkJ4FmdsksyAnJqeTy/YgLw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-aHGEmFB8Otyi4Zpc9ylgAA-1; Fri, 21 Feb 2020 09:22:54 -0500
X-MC-Unique: aHGEmFB8Otyi4Zpc9ylgAA-1
Received: by mail-wr1-f69.google.com with SMTP id n23so1072833wra.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xLIKrkW+7T8bovTbNLkf8QwIZMSzY0Eq6ByLnO+LRhY=;
        b=FX0rsU/fZjrtU/e55A+GcdlynXqR362EsyfTeUk/SdIezDIfXKi/Od1eB2kNvocS+l
         H8rQ6o7NwczHp1Vt3YrUpXPERySFuTWbAhg6KPEHRq7ejllKEzjxQK76Q10GS6Bksror
         HHQht2Fqmw63mLGp1QKww+mjpsWjwoRXn1myq85CEqKdwjVFRQrFIaOLFD3rRGdtblwa
         dPOK8N29koTcnYx+3VY7FXTqRU39MznS1ggoTJ2Z/h3oWQLDUq5STxd0Mu79fFLjkvKS
         yUPp5YVr+DJjO/4GL5w6lBgNSz5Qr/b7ebixxV8u65BVYqsDA/44vYYRO+eY1COgITQP
         Q+xA==
X-Gm-Message-State: APjAAAXeZLedkMUnsUIJiVXWVJVgEDuiVU2J8NvGyqgTwz72yOLA6/RL
        yeYrZqi9tmQyHaE10gJjEu2RWxNpq/W9CKo0je6ofIFOAH65/1e+nAVUj2FgFsDnfQH7ijrR+eL
        aHaov0sj8I3JLRC+f+fnvbTa9
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr49374949wrq.415.1582294973568;
        Fri, 21 Feb 2020 06:22:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXH+1bNydktIBfToHlQ+wvN4TSJ4BYIrG7stJFpEV8g/MpsEtwEtwPB/hRtc+nDNkgFPezTA==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr49374931wrq.415.1582294973355;
        Fri, 21 Feb 2020 06:22:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s22sm3837132wmh.4.2020.02.21.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 06:22:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/61] KVM: x86: Drop the explicit @index from do_cpuid_7_mask()
In-Reply-To: <20200201185218.24473-12-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-12-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 15:22:52 +0100
Message-ID: <87d0a8rpdv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Drop the index param from do_cpuid_7_mask() and instead switch on the
> entry's index, which is guaranteed to be set by do_host_cpuid().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b626893a11d5..fd04f17d1836 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -346,7 +346,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_entry2 *entry,
>  	return 0;
>  }
>  
> -static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
> +static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
>  	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
>  	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
> @@ -380,7 +380,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
>  	const u32 kvm_cpuid_7_1_eax_x86_features =
>  		F(AVX512_BF16);
>  
> -	switch (index) {
> +	switch (entry->index) {
>  	case 0:
>  		entry->eax = min(entry->eax, 1u);
>  		entry->ebx &= kvm_cpuid_7_0_ebx_x86_features;
> @@ -573,7 +573,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  	case 7: {
>  		int i;
>  
> -		do_cpuid_7_mask(entry, 0);
> +		do_cpuid_7_mask(entry);
>  
>  		for (i = 1; i <= entry->eax; i++) {
>  			if (*nent >= maxnent)
> @@ -582,7 +582,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  			do_host_cpuid(&entry[i], function, i);
>  			++*nent;
>  
> -			do_cpuid_7_mask(&entry[i], i);
> +			do_cpuid_7_mask(&entry[i]);
>  		}
>  		break;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

