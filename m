Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EDA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoW9vTNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgE0QSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:18:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55891 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728807AbgE0QSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590596284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRm5cPL6z15Mnl2YBaAR83qOl+cyrSmYGHPD6J5WtrA=;
        b=WoW9vTNAtgJy2dk8XQ8N/IAnhas7wNzW1NzmHh1a4cE6T86FKdRSQycqSHgMJhFJeF8O/u
        J7HFMt2yFbpZDQYrTs9bJ6e2dCYChvJz5MlsaIWKLCIZsroGoxFFh96aqXkYcAT9IJg8Aq
        NM79cfTErKh4IRgnBg+VbSTojj+K5Es=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-e1mS3h_TPeCCJ3GFpiJJoQ-1; Wed, 27 May 2020 12:18:03 -0400
X-MC-Unique: e1mS3h_TPeCCJ3GFpiJJoQ-1
Received: by mail-wm1-f71.google.com with SMTP id z5so1296120wml.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CRm5cPL6z15Mnl2YBaAR83qOl+cyrSmYGHPD6J5WtrA=;
        b=Uma2r5kR2Ms+UADQyLnVKrbHM756DQ4kEw8s+eRmk8MyRICMyUXmg+j45MuTvjNXRX
         AC+OGsIbwAQR9R7xZt40xUvNSXHaie2LEw3rh+lWFwyRgYyKTUE/zAQEJIYnyQxTgy8u
         gZ0dp1/0JlTBP7VAd8J4T6ooFyz+kIMI95FadtiWhmNnZcvddh7wMCHNtbBUtgxxltd3
         dpyDGkaw+qmvw1ebMjQDb6qPK5YoIDa3/KUDtlqfGmV0YjN16FshhDoE3xq6aG/F7j7d
         pXpC31TMNWM1tb9oMADmoAYrAJxp5VNm3yass1addaCebDBZDuKNvQ95VOeRE0wHEyFo
         feHA==
X-Gm-Message-State: AOAM531YTNc3Jakx+WIZDEfYKeD5lUyAU5YS5vY8q7nMsZeKIjquR/h4
        HEoPReNa4zk0n8cas9Jd41xOk0WB3ZLZ1lt/aRTtwtBDFkgffsSBcmb1LDBfg678CpIJwjQTy87
        ZDXndVrstcoFjFDVK97KfGcR4
X-Received: by 2002:a5d:5605:: with SMTP id l5mr14379295wrv.318.1590596281370;
        Wed, 27 May 2020 09:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzum5m0L/JLhaElxEyyZzYisH72lxYN4r2OudO4NQkaHD5ru8XuM+8rkO6kq1TRyEptOKI8gA==
X-Received: by 2002:a5d:5605:: with SMTP id l5mr14379279wrv.318.1590596281110;
        Wed, 27 May 2020 09:18:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id n1sm3216999wrp.10.2020.05.27.09.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:18:00 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
References: <20200527085400.23759-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40800163-2b28-9879-f21b-687f89070c91@redhat.com>
Date:   Wed, 27 May 2020 18:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527085400.23759-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 10:54, Sean Christopherson wrote:
> Initialize vcpu->arch.tdp_level during vCPU creation to avoid consuming
> garbage if userspace calls KVM_RUN without first calling KVM_SET_CPUID.
> 
> Fixes: e93fd3b3e89e9 ("KVM: x86/mmu: Capture TDP level when updating CPUID")
> Reported-by: syzbot+904752567107eefb728c@syzkaller.appspotmail.com
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b226fb8abe41b..01a6304056197 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9414,6 +9414,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	fx_init(vcpu);
>  
>  	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
> +	vcpu->arch.tdp_level = kvm_x86_ops.get_tdp_level(vcpu);
>  
>  	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;

Queued, it is probably a good idea to add a selftests testcase for this
(it's even okay if it doesn't use the whole selftests infrastructure and
invokes KVM_CREATE_VM/KVM_CREATE_VCPU/KVM_RUN manually).

Paolo

