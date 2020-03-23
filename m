Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6094C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EECF20658
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YclV/LyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCWPYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:24:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53131 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbgCWPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584977052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FY0p3cqwN918CaX62qQRQ+vCrkce6hk743BEWFF5l9Q=;
        b=YclV/LyOZH+tZn0dDfOn4mKZ4+9jZtqb1QMGmTT3z7fIF5l7c7W0TSPOovIkRjsa7JHksN
        jTv1yYyCQd/CkFdJANQ63Lj5+1wQHHeYZT/Pt22JkCqIGc9Pl3JbyFX3cclQmKjWN5reK8
        9sh5BQ6nHYhe/HOH5b16/2sTPzwk7aU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-e5paFfcuPS672nWx1NRb9g-1; Mon, 23 Mar 2020 11:24:11 -0400
X-MC-Unique: e5paFfcuPS672nWx1NRb9g-1
Received: by mail-wr1-f69.google.com with SMTP id m15so3101714wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FY0p3cqwN918CaX62qQRQ+vCrkce6hk743BEWFF5l9Q=;
        b=IuNLNhGHRZmmZmcTzS1wCesToXE09jV6F9D/OBgJe0vT6+rrWLQoLK516rXTlWLYGR
         0le9FivpSkEUHSsOJr5vJ78A9kHVPOF2W5NX8NAODXhoS3DCkdVMmUAGRw/5lhigCGB1
         CmiiZqUpQq1PnePLNk+N15WOM9taahdXIcC19tys+wxj7/FnSmWszclc9nH3flAT7eBc
         xkvxLVIse9oh5JBPZGkoI8rgBvJSK96nI9nir5dAP7gcw5j1oV21To3TSlHLQghDAH8G
         HMGAG/TYktkspMTBtL+pn6ydxBCkZfQNIwGzo3jW2KDCVaMFL5zTYdXfaH5drzcUIeVO
         BjGw==
X-Gm-Message-State: ANhLgQ3sqypq+38zBl0+9fI6tw70PNpsjFpuukRhCdiZOQkxU6xmPWfM
        U9xuXIJKbIkTbTdvqhlVUeRiWYMkIxRbKWowxERrjqaLgQkUrCG1KhNw0IOixA9RqvZZMXVumBz
        UmairzhANKk5DgZ5HFvFUVcWo
X-Received: by 2002:a05:600c:2943:: with SMTP id n3mr6891040wmd.119.1584977048259;
        Mon, 23 Mar 2020 08:24:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkDVZhYjHAo50IfPuPfL1qa/i0rdqwGid9Gyb/xkxCwcgPDAvRvLodCDXDNhgK5xA5ft7xSw==
X-Received: by 2002:a05:600c:2943:: with SMTP id n3mr6891012wmd.119.1584977048031;
        Mon, 23 Mar 2020 08:24:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f10sm24052628wrw.96.2020.03.23.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:24:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 03/37] KVM: nVMX: Invalidate all EPTP contexts when emulating INVEPT for L1
In-Reply-To: <20200320212833.3507-4-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-4-sean.j.christopherson@intel.com>
Date:   Mon, 23 Mar 2020 16:24:05 +0100
Message-ID: <87y2rr857u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Free all L2 (guest_mmu) roots when emulating INVEPT for L1.  Outstanding
> changes to the EPT tables managed by L1 need to be recognized, and
> relying on KVM to always flush L2's EPTP context on nested VM-Enter is
> dangerous.
>
> Similar to handle_invpcid(), rely on kvm_mmu_free_roots() to do a remote
> TLB flush if necessary, e.g. if L1 has never entered L2 then there is
> nothing to be done.
>
> Nuking all L2 roots is overkill for the single-context variant, but it's
> the safe and easy bet.  A more precise zap mechanism will be added in
> the future.  Add a TODO to call out that KVM only needs to invalidate
> affected contexts.
>
> Fixes: b119019847fbc ("kvm: nVMX: Remove unnecessary sync_roots from handle_invept")
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index f3774cef4fd4..9624cea4ed9f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5160,12 +5160,12 @@ static int handle_invept(struct kvm_vcpu *vcpu)
>  		if (!nested_vmx_check_eptp(vcpu, operand.eptp))
>  			return nested_vmx_failValid(vcpu,
>  				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
> +
> +		/* TODO: sync only the target EPTP context. */
>  		fallthrough;
>  	case VMX_EPT_EXTENT_GLOBAL:
> -	/*
> -	 * TODO: Sync the necessary shadow EPT roots here, rather than
> -	 * at the next emulated VM-entry.
> -	 */
> +		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu,
> +				   KVM_MMU_ROOTS_ALL);
>  		break;

An ignorant reader may wonder "and how do we know that L1 actaully uses
EPT" as he may find out that guest_mmu is not being used otherwise. The
answer to the question will likely be "if L1 doesn't use EPT for some of
its guests than there's nothing we should do here as we will be
resetting root_mmu when switching to/from them". Hope the ignorant
reviewer typing this is not very wrong :-)

>  	default:
>  		BUG_ON(1);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

