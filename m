Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F682C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E220124650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV8ETSo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgBUPgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:36:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57191 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgBUPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOToEHS8ihajx9JSHSORZaVCnP2phBIkFva4hj6D5cY=;
        b=QV8ETSo2NF3mXqmW1yYuKExJ9hj5wCd2P4UMO0s0vls1moUog6vPciGcy2PVRxXD6VIAiK
        ubfw4iVc2Ntjmj8FTDDdY0+Mtz6tG/Or3jR9/KyHXeSE3VxxnWThory/F19TJ73gmt7nak
        LBaM3+marJoQR4HLkoDHnqL/UODKQ7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-O4u3L0xnMxWWEtwuSESEcw-1; Fri, 21 Feb 2020 10:36:03 -0500
X-MC-Unique: O4u3L0xnMxWWEtwuSESEcw-1
Received: by mail-wr1-f69.google.com with SMTP id a12so1167969wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oOToEHS8ihajx9JSHSORZaVCnP2phBIkFva4hj6D5cY=;
        b=amATMN4DJ4irlKgfmaCgjfbj6lyy3+7UyHgIs5wFIrPeg6kJFRqWOz6hu0FO1fCgbM
         9hfveUpWmYvFjpX/6TjLLEtMulL+2WvTdNCR5+qCP88StkKIW3XgIzZYEbOUcGel7uIk
         Ai2Dh8NmnT1wizz4lcwqmbnLbi6PaX0FYRWMpPhdQc8J0+qOWBaxKfAtOS8TeWx7LeKC
         i6B1uCJ2KyQ5MyFotyzM+o8bIUNRzgIhzxcmL05asfbpXOObAY59TMBH/cLs21JfKq9s
         qTNwtLrdyX+ic9VpXO+vAiWXUu81JmOnJXedvmt6s32jI5m7XC0LmvSP4KAc4dzLNCCR
         7/mg==
X-Gm-Message-State: APjAAAVHopZvWqqiKe2eejzcwpKk9fHHOi6TkAR9Xqv8sUSxOWpQAF4y
        GrwfaZJq4QqHU0YSgssXMFn2On3dgb0sbRyNJiUMxWthc4l0aMsnqM4YpRTSJMkavKwHMNSvTbx
        0F4rOz4aFrP8z1tSHp+rzmUbf
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr51994288wru.220.1582299361668;
        Fri, 21 Feb 2020 07:36:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEUtM+sR0YQOKEdCKvF0CFcEBjKZHAFpG0mki6xtVyPaCiKifi4wmUC/gBy9khmvLU/IPTwQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr51994269wru.220.1582299361468;
        Fri, 21 Feb 2020 07:36:01 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm4581585wra.83.2020.02.21.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:36:00 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/61] KVM: x86: Clear output regs for CPUID 0x14 if PT isn't exposed to guest
In-Reply-To: <20200201185218.24473-24-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-24-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 16:36:00 +0100
Message-ID: <87eeuoq7fj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Clear the output regs for the main CPUID 0x14 leaf (index=0) if Intel PT
> isn't exposed to the guest.  Leaf 0x14 enumerates Intel PT capabilities
> and should return zeroes if PT is not supported.  Incorrectly reporting
> PT capabilities is essentially a cosmetic error, i.e. doesn't negatively
> affect any known userspace/kernel, as the existence of PT itself is
> correctly enumerated via CPUID 0x7.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d3c93b94abc3..056faf27b14b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -663,8 +663,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	/* Intel PT */
>  	case 0x14:
> -		if (!f_intel_pt)
> +		if (!f_intel_pt) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>  			break;
> +		}
>  
>  		for (i = 1, max_idx = entry->eax; i <= max_idx; ++i) {
>  			if (!do_host_cpuid(array, function, i))

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

