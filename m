Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F1EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF120722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KD8IVJgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCXAr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:47:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28448 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgCXAr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585010876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rl+mfoH6kKdfgtm7U9jABfG0W/KFJbp5iUypKMc+8BA=;
        b=KD8IVJgrKezx2xPzOoD8LzLkgDnQTK9HfVJJeTq7e9VsDuKuGcS5bCpw6qXOf/9GrdIM0N
        of1vwmDAUQ3owgnbIzT05mRiGuhGc04j4KofjFSs2tasH1T4uMpbxundPDJp2nPrN8hyUS
        IjPiSmFDFIEvrq7J3UuPHPaYOrXwezU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-4bokuVKUPWStEWBXjW_wQg-1; Mon, 23 Mar 2020 20:47:55 -0400
X-MC-Unique: 4bokuVKUPWStEWBXjW_wQg-1
Received: by mail-wr1-f70.google.com with SMTP id j12so4497434wrr.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rl+mfoH6kKdfgtm7U9jABfG0W/KFJbp5iUypKMc+8BA=;
        b=KDkyOiMGrvNpN7S5ZCMr7npMYN83PEEJy7QJ6ChZUSePthbZldm1aSZd79HID/Ug/d
         PGIUfLOQn1NWkDetvpy+V+bGevwBuG8wzg9931rcGKut1FLzDBIUbWgIJyX04TEPFhsW
         N5fkuLHkpjCxcEGhscH0n7J3LNzyqOoRyj5o4I/2A5SJl/8wMYpxURlPL3aZPjWQ9bqi
         qG6A/bJM5uv1bVweyv7O9CrJ1CuW4y7hyOzul1/kSBGBdxxshjl2ndO3D3zu57w6E+Ko
         A/f+SU+xtWmSm700+XX/mz3GsF7vyEA+0D76Aye7F0y1KUepoolaD+9xioCEn+FrolwG
         nyEA==
X-Gm-Message-State: ANhLgQ3n9sdfj2DnNbxrP/Q89LGFhMrgInLvpI90sEUR+QMGiTh6AJZn
        Ha5MOE0ixUDx1iqqyzIiJjp+0VwvgYlLrLNySyLDtGioloSBVirIRZaoXGRYKyJK7FeTYO8e5Tx
        HvV5Au15AnrzrTGfSBmOk3hq2
X-Received: by 2002:a1c:648b:: with SMTP id y133mr2123673wmb.173.1585010873978;
        Mon, 23 Mar 2020 17:47:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvX2iebmj1yEz+8fw55gpX59C/DxKKYCVUHxVRdmbbxEtTsRf+QwDxmDZ7QlKxFkIPN89pjvw==
X-Received: by 2002:a1c:648b:: with SMTP id y133mr2123643wmb.173.1585010873527;
        Mon, 23 Mar 2020 17:47:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id z6sm24638859wrp.95.2020.03.23.17.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 17:47:52 -0700 (PDT)
Subject: Re: [PATCH v3 06/37] KVM: x86: Consolidate logic for injecting page
 faults to L1
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-7-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5225c99c-8231-ae7a-62d3-f461749da7d0@redhat.com>
Date:   Tue, 24 Mar 2020 01:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320212833.3507-7-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 22:28, Sean Christopherson wrote:
> +void kvm_inject_l1_page_fault(struct kvm_vcpu *vcpu,
> +			      struct x86_exception *fault)
> +{
> +	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
> +}
> +
>  bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
>  				    struct x86_exception *fault)
>  {
> @@ -619,7 +625,7 @@ bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
>  	if (mmu_is_nested(vcpu) && !fault->nested_page_fault)
>  		vcpu->arch.nested_mmu.inject_page_fault(vcpu, fault);
>  	else
> -		vcpu->arch.mmu->inject_page_fault(vcpu, fault);
> +		kvm_inject_l1_page_fault(vcpu, fault);
>  
>  	return fault->nested_page_fault;

This all started with "I don't like the name of the function" but
thinking more about it, we can also write this as

	if (mmu_is_nested(vcpu) && !fault->nested_page_fault)
		vcpu->arch.walk_mmu->inject_page_fault(vcpu, fault);
	else
		vcpu->arch.mmu->inject_page_fault(vcpu, fault);

Now, if !mmu_is_nested(vcpu) then walk_mmu == mmu, so it's much simpler
up until this patch:

	fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu : vcpu->arch.walk_mmu;
	fault_mmu->inject_page_fault(vcpu, fault);

(which also matches how fault->nested_page_fault is assigned to).
In patch 7 we add the invalidation in kvm_inject_l1_page_fault, but
is it necessary to do it only in the else?

+	if (!vcpu->arch.mmu->direct_map &&
+	    (fault->error_code & PFERR_PRESENT_MASK))
+		vcpu->arch.mmu->invlpg(vcpu, fault->address,
+				       vcpu->arch.mmu->root_hpa);
+
 	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
 }
 
The direct_map check is really just an optimization to avoid a
retpoline if ->invlpg is nonpaging_invlpg.  We can change it to
!vcpu->arch.mmu->invlpg if nonpaging_invlpg is replaced with NULL,
and then the same "if" condition can also be used for the nested_mmu
i.e. what patch 7 writes as

+		/*
+		 * No need to sync SPTEs, the fault is being injected into L2,
+		 * whose page tables are not being shadowed.
+		 */
 		vcpu->arch.nested_mmu.inject_page_fault(vcpu, fault);


Finally, patch 7 also adds a tlb_flush_gva call which is already present
in kvm_mmu_invlpg, and this brings the final form to look like this:

bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
                                    struct x86_exception *fault)
{
        struct kvm_mmu *fault_mmu;
        WARN_ON_ONCE(fault->vector != PF_VECTOR);

        fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu : vcpu->arch.walk_mmu;

        /*
         * Invalidate the TLB entry for the faulting address, if it exists,
         * else the access will fault indefinitely (and to emulate hardware).
         */
        if (fault->error_code & PFERR_PRESENT_MASK)
                __kvm_mmu_invlpg(vcpu, fault_mmu, fault->address);

        fault_mmu->inject_page_fault(vcpu, fault);
        return fault->nested_page_fault;
}

This will become a formal mini-series replacing patches 6 and 7
after I test it, so no need to do anything on your part.

Paolo

