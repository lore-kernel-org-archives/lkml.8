Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2363EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5DF2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP5DzO9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGNMAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:00:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgGNMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594728013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2X7NACrHk+056/NrhRPs2QrhtNqs/Hn1NwOQ/IQB6FE=;
        b=gP5DzO9QUa264Zy6fVUm6cOsfY8x0DiArrtbg+YdUItwnb9MA02Da7uNCBaKgt/aweGeLC
        +U7pvfSsnCtdShwa4RCMA/tRzaBFztGmpDpByh3EGU+BHLsf/YgOdOc9G9bJlcbsNNw/Yz
        bpYHZ5UreguECsHA2NqLoGvwXQmR3Tk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-equlkhRVP4C8ZLAd-qDCRA-1; Tue, 14 Jul 2020 08:00:08 -0400
X-MC-Unique: equlkhRVP4C8ZLAd-qDCRA-1
Received: by mail-wm1-f71.google.com with SMTP id g6so3609569wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2X7NACrHk+056/NrhRPs2QrhtNqs/Hn1NwOQ/IQB6FE=;
        b=S27LoVS6+dqH1h4P6kIn4WFaVu3/6sudm/qr2VCPqdnZNbMmbKDx7TVv7HQOeXJhbl
         IbObuurlcbYCCgvg0jXZcRNK51pBT9Myv+iCFMp/xsCC+lzG4PMNQfzdc9G8dongk84F
         eB2mnTfD0bl7eV87K6y0KPx6z8CxEiyHNhDvNReqy2isJ7VIH5IAbvna7D92M4kOQpxC
         NSwA0koTHNtZ0zmhe9951gMtxUX+N7vcWRVC43hkfNFa+ENbqZ/5cqxhkZ1KwPX19iyL
         UgnElSQpeCCz+Na6HKNgY05r1W9WvFPj6K5gWdnQHKAaffbJ8rflv656ynTpr93yD0CD
         nk8A==
X-Gm-Message-State: AOAM531M5R577supywfqhiiwQfvhe2Ly0NmMc/X8PfT79F1t3vdTSvfr
        o6QQXZqSnIXeT92JyfTMwR/cNSqofzi+fWiW30cwYHLP1b+fPnp5OSeYfiQy6bkX2rnV3UFNqFD
        PxVTfBjregVlC5giZ+UFMyOyl
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4709006wru.88.1594728007119;
        Tue, 14 Jul 2020 05:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfXD4PNiff8ppZAUdbaWET9RDCKzKfXPAFlhAMhdZ+fkuToo31w86c+WObTDjaxPLdR4o6oA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4708961wru.88.1594728006852;
        Tue, 14 Jul 2020 05:00:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z8sm4158901wmg.39.2020.07.14.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 05:00:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Don't attempt to load PDPTRs when 64-bit mode is enabled
In-Reply-To: <20200714015732.32426-1-sean.j.christopherson@intel.com>
References: <20200714015732.32426-1-sean.j.christopherson@intel.com>
Date:   Tue, 14 Jul 2020 14:00:04 +0200
Message-ID: <87wo36s3wb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Don't attempt to load PDPTRs if EFER.LME=1, i.e. if 64-bit mode is
> enabled.  A recent change to reload the PDTPRs when CR0.CD or CR0.NW is
> toggled botched the EFER.LME handling and sends KVM down the PDTPR path
> when is_paging() is true, i.e. when the guest toggles CD/NW in 64-bit
> mode.
>
> Split the CR0 checks for 64-bit vs. 32-bit PAE into separate paths.  The
> 64-bit path is specifically checking state when paging is toggled on,
> i.e. CR0.PG transititions from 0->1.  The PDPTR path now needs to run if
> the new CR0 state has paging enabled, irrespective of whether paging was
> already enabled.  Trying to shave a few cycles to make the PDPTR path an
> "else if" case is a mess.
>
> Fixes: d42e3fae6faed ("kvm: x86: Read PDPTEs on CR0.CD and CR0.NW changes")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Oliver Upton <oupton@google.com>
> Cc: Peter Shier <pshier@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>
> The other way to fix this, with a much smaller diff stat, is to simply
> move the !is_page(vcpu) check inside (vcpu->arch.efer & EFER_LME).  But
> that results in a ridiculous amount of nested conditionals for what is a
> very straightforward check e.g.
>
> 	if (cr0 & X86_CR0_PG) {
> 		if (vcpu->arch.efer & EFER_LME) }
> 			if (!is_paging(vcpu)) {
> 				...
> 			}
> 		}
> 	}
>
> Since this doesn't need to be backported anywhere, I didn't see any value
> in having an intermediate step.
>
>  arch/x86/kvm/x86.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 95ef629228691..5f526d94c33f3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -819,22 +819,22 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>  	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
>  		return 1;
>  
> -	if (cr0 & X86_CR0_PG) {
>  #ifdef CONFIG_X86_64
> -		if (!is_paging(vcpu) && (vcpu->arch.efer & EFER_LME)) {
> -			int cs_db, cs_l;
> +	if ((vcpu->arch.efer & EFER_LME) && !is_paging(vcpu) &&
> +	    (cr0 & X86_CR0_PG)) {

it seems we have more than one occurance of "if (vcpu->arch.efer &
EFER_LME)" under "#ifdef CONFIG_X86_64" and we alredy have 

static inline int is_long_mode(struct kvm_vcpu *vcpu)
{
#ifdef CONFIG_X86_64
     return vcpu->arch.efer & EFER_LMA;
#else
     return 0;
#endif
}

so if we use this instead, the compilers will just throw away the
non-reachable blocks when !(#ifdef CONFIG_X86_64), right?

> +		int cs_db, cs_l;
>  
> -			if (!is_pae(vcpu))
> -				return 1;
> -			kvm_x86_ops.get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
> -			if (cs_l)
> -				return 1;
> -		} else
> -#endif
> -		if (is_pae(vcpu) && ((cr0 ^ old_cr0) & pdptr_bits) &&
> -		    !load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu)))
> +		if (!is_pae(vcpu))
> +			return 1;
> +		kvm_x86_ops.get_cs_db_l_bits(vcpu, &cs_db, &cs_l);
> +		if (cs_l)
>  			return 1;
>  	}
> +#endif
> +	if (!(vcpu->arch.efer & EFER_LME) && (cr0 & X86_CR0_PG) &&
> +	    is_pae(vcpu) && ((cr0 ^ old_cr0) & pdptr_bits) &&
> +	    !load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu)))
> +		return 1;
>  
>  	if (!(cr0 & X86_CR0_PG) && kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE))
>  		return 1;

-- 
Vitaly

