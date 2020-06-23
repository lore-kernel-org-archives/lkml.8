Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD509C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL2Ro76o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgFWKB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:01:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732155AbgFWKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592906485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQEOlaY8lxWBLhrq3UdUAQbRpH9mXTgZnwUd3lDN5GM=;
        b=DL2Ro76oByhd4hbudVqp72gyHK0ATINEnbr4w3zCl0b2Nl7JX/J+nPAZwJXwwcDzvuU85L
        0XDqRR9vZGN6dwHEYOpS0ZWaX4x5vjZwkej+3EkLB8KtGQUNec6Jf3H7EdO6CCMNkwL0mu
        5LIzdhfCj4CutolLeEFk74GUUm+mZ4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-vq7dUH4pPZK_k5udlWRbRw-1; Tue, 23 Jun 2020 06:01:24 -0400
X-MC-Unique: vq7dUH4pPZK_k5udlWRbRw-1
Received: by mail-wr1-f72.google.com with SMTP id d6so14651665wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IQEOlaY8lxWBLhrq3UdUAQbRpH9mXTgZnwUd3lDN5GM=;
        b=i4jT71JhAoVqFzwIxiK/QBumUc7XTMNPmFrAFaYvCPNvQ5LImgK4a5yUPLEqhYrIvb
         qnvhs7KoFEhJsnDnyGBdDN1lQmRkD+yXmkqDkhyeosMejBdFMvJTJfO2RI5QqZ8M9rpy
         WhO0iTnpj4CM2KwVeVpB2fVxszrfsyOTcfaUHuF8iJic3VD/3/djSavx2JdvTcvBfpNu
         qwoLo3AxI2NjEmsJkiN2Ii0esumF/Ar3y9I6HOq0TyGkPhwHET8taxFkcIVa+xl6bcXL
         Utnn8/TSthxFJ/rjs8csB2Evfn/7aAAFthZY03Gv/SjNofG+N4RB3Bx03CKgI04jmMJB
         wFhQ==
X-Gm-Message-State: AOAM533JbWeY+R3XRhlTZIjRneQ22udUx6rFf9wCAQ/XJCC6941NgIwr
        iMMcds6gj50KuD7t/NcRM+AgtioOgL/dB2c68NT/56rlcQKqyyZLkfQ7fGxGoBqu0jXlTSJ9VSH
        q9uYRv3YV7C5+NW1OWdMPdhZR
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr15910105wmd.104.1592906482798;
        Tue, 23 Jun 2020 03:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfjQfcrfEvAiyMmTmFbpV5259IlrHhUHT8iGhKenG96MPP3HDlHdZJMiu3eN2Qsh/PdP0hPQ==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr15910080wmd.104.1592906482548;
        Tue, 23 Jun 2020 03:01:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id z16sm12335961wrr.35.2020.06.23.03.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:01:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200617034123.25647-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49c2b03c-900b-864f-2eae-770068908ad9@redhat.com>
Date:   Tue, 23 Jun 2020 12:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200617034123.25647-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/20 05:41, Sean Christopherson wrote:
> Remove vcpu_vmx.host_pkru, which got left behind when PKRU support was
> moved to common x86 code.
> 
> No functional change intended.
> 
> Fixes: 37486135d3a7b ("KVM: x86: Fix pkru save/restore when guest CR4.PKE=0, move it to x86.c")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 8a83b5edc820..639798e4a6ca 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -288,8 +288,6 @@ struct vcpu_vmx {
>  
>  	u64 current_tsc_ratio;
>  
> -	u32 host_pkru;
> -
>  	unsigned long host_debugctlmsr;
>  
>  	/*
> 

Queued, thanks.

Paolo

