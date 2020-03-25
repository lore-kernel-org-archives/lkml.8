Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19989C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6C420771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr48qr+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCYL0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:26:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27723 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727356AbgCYL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585135565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ae3Bh1ZlBbd/KBQwXPKN94pXtAOxkLC5jA3b9yhby3k=;
        b=Cr48qr+/DYb18Y/hicUiyWtZmBzzcpM38TkWhcgIN5DSskkKr1C7vcvD+jtneflDYc+Dcn
        22gr17q7zgzxyC7ZvaqXmQK3d8haQmQOCEI2ZluIsRh2WE2EgjkNCLvR3eLQ2sp8Fo03n0
        v2ZcsfJ49xgy1w+42j1LpJWBqfOzBK8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-7roI6z5-NtCwaTarcINDWw-1; Wed, 25 Mar 2020 07:26:04 -0400
X-MC-Unique: 7roI6z5-NtCwaTarcINDWw-1
Received: by mail-wm1-f71.google.com with SMTP id g9so2381003wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ae3Bh1ZlBbd/KBQwXPKN94pXtAOxkLC5jA3b9yhby3k=;
        b=T4PGyx3Iq5JeE5D3UpaUEiTynwRjS/iBQ/lIzfX4vkkSf7ROd98qdMv+wcSZwLHSfd
         3v7HlOdUcQriN+9vpiB49sPO1JHt8yO0gehmSNLwtN6lIjnylvtw4I97kVUqT7n7sN5C
         lfINinArtVtGDyd76Ujk0TeWx4Cs7tfu5NXRzP/YAPrRXpHjxIr6TjQbODIPqa5fynRs
         BVuHWeiqTjd8Bc7Upig4S2qk/wXzkSAcphuz34BwEwUrW1f2114wPIpvw6Zu4D/JLlY0
         08afcLrvnUhe0wbY9u0p8ZSGUQoRHz3YVlKOCk4/kF9kcXeBGOwST5jksDlo6Xo2Pq7q
         cH5A==
X-Gm-Message-State: ANhLgQ2ttIy320lNWPlbFnnvKjnu3EGVhZcgriFJLYEz/pQA83WdJdTT
        QOJyRD6dmF4PIBB+8boN48sMAuMl/Kn1g8dTrCOmvFYQfxPc4+x45MHNJqgsqfVWX5rcjs1xGgV
        XlNnAZkNFHHCZLujDVSOiB/Jn
X-Received: by 2002:adf:db49:: with SMTP id f9mr2754405wrj.145.1585135562108;
        Wed, 25 Mar 2020 04:26:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspLasieFBMXL6fs0QKpXZ526e9DIUxbZmAHTCJGxNfXakPND5GK++oNxLnkbN0fT32b1RV3w==
X-Received: by 2002:adf:db49:: with SMTP id f9mr2754380wrj.145.1585135561893;
        Wed, 25 Mar 2020 04:26:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u16sm33886558wro.23.2020.03.25.04.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:26:01 -0700 (PDT)
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
Subject: Re: [PATCH v3 19/37] KVM: nVMX: Move nested_get_vpid02() to vmx/nested.h
In-Reply-To: <20200320212833.3507-20-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-20-sean.j.christopherson@intel.com>
Date:   Wed, 25 Mar 2020 12:25:59 +0100
Message-ID: <87r1xg65h4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move nested_get_vpid02() to vmx/nested.h so that a future patch can
> reference it from vmx.c to implement context-specific TLB flushing.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 7 -------
>  arch/x86/kvm/vmx/nested.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0c71db6fec5a..77819d890088 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1154,13 +1154,6 @@ static bool nested_has_guest_tlb_tag(struct kvm_vcpu *vcpu)
>  	       (nested_cpu_has_vpid(vmcs12) && to_vmx(vcpu)->nested.vpid02);
>  }
>  
> -static u16 nested_get_vpid02(struct kvm_vcpu *vcpu)
> -{
> -	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -
> -	return vmx->nested.vpid02 ? vmx->nested.vpid02 : vmx->vpid;
> -}
> -
>  static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
>  {
>  	superset &= mask;
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 21d36652f213..debc5eeb5757 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -60,6 +60,13 @@ static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
>  		vmx->nested.hv_evmcs;
>  }
>  
> +static inline u16 nested_get_vpid02(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +	return vmx->nested.vpid02 ? vmx->nested.vpid02 : vmx->vpid;
> +}
> +
>  static inline unsigned long nested_ept_get_eptp(struct kvm_vcpu *vcpu)
>  {
>  	/* return the page table to be shadowed - in our case, EPT12 */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

