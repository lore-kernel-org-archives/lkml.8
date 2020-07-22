Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82112C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58983206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8cNJ88H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgGVRCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:02:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595437337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbVInIg0O9sB9/rV79n2+MQeF/xVnND4ezNrHJWAuNU=;
        b=H8cNJ88HbymjGnpApfZHmlCLXzgAMROLrAGvjiXx25OQAk/V1i1eRD8Q80KMK+t3PJbWKM
        EYdDiwGIpekNa/Kx0Yzklr3txD6Vhx7uZIRDk209D+ivCyYIkUiQMoyyuFpi0GKOS1Nq3/
        kxG1Ozzzund8XRKvsFXyPF33q2/h8IY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-cRe68L73P6mawcl59-jCBA-1; Wed, 22 Jul 2020 13:02:13 -0400
X-MC-Unique: cRe68L73P6mawcl59-jCBA-1
Received: by mail-ej1-f72.google.com with SMTP id x15so1239166ejj.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kbVInIg0O9sB9/rV79n2+MQeF/xVnND4ezNrHJWAuNU=;
        b=gF0Ol1ypUQOgdmHWcbjLkWj7Yc+hm+v7ieprk6WkPwSjEw+WUIFIxsOXfGKwDzszoO
         yYXlZQagsJ1bCTUWkDQqtQOxtMSbAkp78exX6MNX5kJqm2siCt1Oxf1WfpF2xKuGbaI+
         eqH/c79vXkzPjDSYRSqddeaVN2e4TYLzuQQ1nzp0jocDdny1+Ut/HeEvm07lc5TSDV/U
         SFfwDWBFARzd+gQn+KEcDFgvhTA040/46qDyF/ltdajx6T2qJIQ5fYFyWziWuj9GIIa6
         m2k8Yq7sDzPijgURf6PfHPW7/nmyG/IRSwLoZkrt3SAZ0QITHT+2TUnPu3DpH1QZyJ37
         2yDg==
X-Gm-Message-State: AOAM532HpaQbDl6enOTujKLY49lLv4z9dwppFXOJZXVEcN3VVT8+UR5n
        b7giOmvtAn+p0r4y12Wm7X5luns1vsfS2yKmbYdt59gg36Oa5IFqAgYBDJkT6DMXlD8NEd1chFi
        MRP93eew235iQZOXSOeuhQl9w
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr374612edb.307.1595437331669;
        Wed, 22 Jul 2020 10:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz94j8HcWYcquzCOKto29+28RpeYYe5s5ZRTcFELIy0kjd1eezYC15hqN13fTOfh2pm35iWlw==
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr374579edb.307.1595437331400;
        Wed, 22 Jul 2020 10:02:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id sa10sm151309ejb.79.2020.07.22.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:02:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] KVM: nSVM: Correctly set the shadow NPT root level in its MMU role
In-Reply-To: <20200716034122.5998-2-sean.j.christopherson@intel.com>
References: <20200716034122.5998-1-sean.j.christopherson@intel.com> <20200716034122.5998-2-sean.j.christopherson@intel.com>
Date:   Wed, 22 Jul 2020 19:02:08 +0200
Message-ID: <877duvpjov.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the initialization of shadow NPT MMU's shadow_root_level into
> kvm_init_shadow_npt_mmu() and explicitly set the level in the shadow NPT
> MMU's role to be the TDP level.  This ensures the role and MMU levels
> are synchronized and also initialized before __kvm_mmu_new_pgd(), which
> consumes the level when attempting a fast PGD switch.
>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Fixes: 9fa72119b24db ("kvm: x86: Introduce kvm_mmu_calc_root_page_role()")
> Fixes: a506fdd223426 ("KVM: nSVM: implement nested_svm_load_cr3() and use it for host->guest switch")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c    | 3 +++
>  arch/x86/kvm/svm/nested.c | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 77810ce66bdb4..678b6209dad50 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4963,6 +4963,9 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
>  	union kvm_mmu_role new_role =
>  		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
>  
> +	new_role.base.level = vcpu->arch.tdp_level;
> +	context->shadow_root_level = new_role.base.level;
> +
>  	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base, false, false);
>  
>  	if (new_role.as_u64 != context->mmu_role.as_u64)
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 61378a3c2ce44..fb68467e60496 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -85,7 +85,6 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
>  	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
>  	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
>  	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
> -	vcpu->arch.mmu->shadow_root_level = vcpu->arch.tdp_level;
>  	reset_shadow_zero_bits_mask(vcpu, vcpu->arch.mmu);
>  	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
>  }

FWIW,

Reviewed-and-tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

