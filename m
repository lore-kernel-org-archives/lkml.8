Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612AC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D20F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3RtQARH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBUNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:54:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727836AbgBUNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582293287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LrJP8CFwR0eYb5yjnCrrgpHe2D62qRQVD0aKyEgzsF4=;
        b=O3RtQARHj8v6S73x6CI4i61zEZcXgHuxYHRZz9Hjh9TQIlyILAohSmlUeoLjD0VoCZMOd9
        4/mD6yeND0JzxIlbNk+JlTbwAkCU/77oyLToQYiCdz1rZyWYGXLwkpBsVc+lMOX5H76ru/
        USRI3KHNO9vNmzeqBm/VrA6TsDtlQdI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-xICDYfcfO7q3Fj1JpGNvvA-1; Fri, 21 Feb 2020 08:54:45 -0500
X-MC-Unique: xICDYfcfO7q3Fj1JpGNvvA-1
Received: by mail-wr1-f70.google.com with SMTP id a12so1038072wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LrJP8CFwR0eYb5yjnCrrgpHe2D62qRQVD0aKyEgzsF4=;
        b=sfmZFLkSizd0RYPLVdm9Jd+2s9Wg39JR+IINin4TVoeA/Y2cFIBUwaPFLCFHPsplx5
         AsZt93SZ3BQZ/btDBtaPi4z+L1ynYf4s2PZs7KILaFBlnz8i5i+csH07bKA9JZg7vzHz
         7embN59vbidrCNqHk0LXEm/57+KS/5ln6IIzOsDj29md0VASJLVJwO4sfTRHzryUcNkf
         n1xwxFdvWNOYHf0axxk0jyhPQJcipIfY0Ib20Ph+wKzU0gNkawxUvx7q/ac2AitibtZ7
         Mc5GLvu2zInpfSrolQdOtuAunviEy/n0nggRn4N2TjlK6RwO2cxcN0hRvmnDVTTaOeKo
         5ibA==
X-Gm-Message-State: APjAAAXDeJeMn6q8fdGy6Qd1Jwk8aqp3tQrs/Cjw9vhplUDlL2bPa5Q9
        nupYhRqFBiRYAM6pbENaIz1ajmmkQ1w9fC9FO6SLMvsrWX407TLYxY0W3dEfzJRZaCFKJWIAEiK
        4mIiOAvZQ9IBFaCNfA8G7ZskV
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr48466795wrj.165.1582293283944;
        Fri, 21 Feb 2020 05:54:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqypCQVdasfRnNXDTX4aGD7CTCMhAe0gR/KZ7ldH3C0p7fXCOZpqLU+JnrR0QV2HrEDGeiAu/Q==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr48466777wrj.165.1582293283691;
        Fri, 21 Feb 2020 05:54:43 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i204sm3897111wma.44.2020.02.21.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:54:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] KVM: VMX: Clean up vmx_flush_tlb_gva()
In-Reply-To: <20200220204356.8837-8-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com> <20200220204356.8837-8-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 14:54:42 +0100
Message-ID: <87r1yorqot.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Refactor vmx_flush_tlb_gva() to remove a superfluous local variable and
> clean up its comment, which is oddly located below the code it is
> commenting.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5372a93e1727..906e9d9aa09e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2824,15 +2824,11 @@ static void exit_lmode(struct kvm_vcpu *vcpu)
>  
>  static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
>  {
> -	int vpid = to_vmx(vcpu)->vpid;
> -
> -	vpid_sync_vcpu_addr(vpid, addr);
> -
>  	/*
> -	 * If VPIDs are not supported or enabled, then the above is a no-op.
> -	 * But we don't really need a TLB flush in that case anyway, because
> -	 * each VM entry/exit includes an implicit flush when VPID is 0.
> +	 * vpid_sync_vcpu_addr() is a nop if vmx->vpid==0, see the comment in
> +	 * vmx_flush_tlb_guest() for an explanation of why this is ok.

"OK" :-)

>  	 */
> +	vpid_sync_vcpu_addr(to_vmx(vcpu)->vpid, addr);
>  }
>  
>  static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

