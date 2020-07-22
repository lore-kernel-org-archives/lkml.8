Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEF3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2442065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0ml5UxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgGVRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:05:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726888AbgGVRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595437546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTz3ZD7cdIvH74d22/mEvgDoRVXc5NZa/DgnJ6bYkEM=;
        b=I0ml5UxXstfmS/Ir4CVofiEB3NtOO/H/8eCFfhXzpsqDAmccPgJrCjcLoTJU/jVsKiMTTx
        ocTp6ypFNstDFdNGgYZWq4hlaVtwilN9OPZ5cfG7je/BGBYACiHXPuyTr5688IFhiWx4du
        rPstUvD9ksncEFGCqIRjTYdBZ0D7GOc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-DHEgmUE4OmqFHzyB2-7NqQ-1; Wed, 22 Jul 2020 13:05:45 -0400
X-MC-Unique: DHEgmUE4OmqFHzyB2-7NqQ-1
Received: by mail-ed1-f69.google.com with SMTP id 64so998445edf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jTz3ZD7cdIvH74d22/mEvgDoRVXc5NZa/DgnJ6bYkEM=;
        b=Bmxl6QyrT+bxg0PInXQzaLfBAiaI6BZhkulsb2lBMN1Y5MQAsOzyHe0CUr/+6MyryR
         gD9bWKKlhAaK/5OmWuELhJjgnTfsAx4664DYh7MuEBsVo7SWnViBXNzjBcgzPPxTe7v/
         6EPqB3ToWI4uoxm8qioqL9PQXSdwP0LrvE1PsUmkytxPqxO341Ekf42kumtWAPB/Lsge
         Z59sXnkOV9OKUZn31I7l3mJ/zysdKwYTKXkteMyNatcsRRc4Rhwu5C4aifZVNgC/jHo/
         zXXCmmhrO7Vnkwy+d2oXxIF95MT0rUUgK8lJncD7q9jxxsLRbYpVavcfRKyGpn59lmsY
         hiNA==
X-Gm-Message-State: AOAM532iMHOfePM7By5gj0dtu1Xb0f+d1vDveSz0ihSKj3rV9t9D8I/k
        8s9MX639uk3DReb5NYiK3VCaVVUGq/QTEAzSGK6Vh7y3MS1m9FenUfBwsFk1RgcTflncnLHGOrg
        ZhHRhKmZ9EwFPX2Cai27tqaio
X-Received: by 2002:a17:906:fca4:: with SMTP id qw4mr492900ejb.362.1595437542528;
        Wed, 22 Jul 2020 10:05:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj8FclCoM6atIbpTs7lUMxmiRQYxaDcSoch5yZklPT8M6/m08LQ3lzV3/MfAXS2DbPk9dKdA==
X-Received: by 2002:a17:906:fca4:: with SMTP id qw4mr492880ejb.362.1595437542272;
        Wed, 22 Jul 2020 10:05:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id lm22sm141617ejb.109.2020.07.22.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:05:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] KVM: x86/mmu: Add separate helper for shadow NPT root page role calc
In-Reply-To: <20200716034122.5998-3-sean.j.christopherson@intel.com>
References: <20200716034122.5998-1-sean.j.christopherson@intel.com> <20200716034122.5998-3-sean.j.christopherson@intel.com>
Date:   Wed, 22 Jul 2020 19:05:40 +0200
Message-ID: <874kpzpjiz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Refactor the shadow NPT role calculation into a separate helper to
> better differentiate it from the non-nested shadow MMU, e.g. the NPT
> variant is never direct and derives its root level from the TDP level.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 678b6209dad50..0fb033ce6cc57 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4908,7 +4908,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>  }
>  
>  static union kvm_mmu_role
> -kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
> +kvm_calc_shadow_root_page_role_common(struct kvm_vcpu *vcpu, bool base_only)
>  {
>  	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
>  
> @@ -4916,9 +4916,19 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
>  		!is_write_protection(vcpu);
>  	role.base.smap_andnot_wp = role.ext.cr4_smap &&
>  		!is_write_protection(vcpu);
> -	role.base.direct = !is_paging(vcpu);
>  	role.base.gpte_is_8_bytes = !!is_pae(vcpu);
>  
> +	return role;
> +}
> +
> +static union kvm_mmu_role
> +kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
> +{
> +	union kvm_mmu_role role =
> +		kvm_calc_shadow_root_page_role_common(vcpu, base_only);
> +
> +	role.base.direct = !is_paging(vcpu);
> +
>  	if (!is_long_mode(vcpu))
>  		role.base.level = PT32E_ROOT_LEVEL;
>  	else if (is_la57_mode(vcpu))
> @@ -4956,14 +4966,24 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efe
>  		shadow_mmu_init_context(vcpu, context, cr0, cr4, efer, new_role);
>  }
>  
> +static union kvm_mmu_role
> +kvm_calc_shadow_npt_root_page_role(struct kvm_vcpu *vcpu)
> +{
> +	union kvm_mmu_role role =
> +		kvm_calc_shadow_root_page_role_common(vcpu, false);
> +
> +	role.base.direct = false;
> +	role.base.level = vcpu->arch.tdp_level;
> +
> +	return role;
> +}
> +
>  void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
>  			     gpa_t nested_cr3)
>  {
>  	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
> -	union kvm_mmu_role new_role =
> -		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
> +	union kvm_mmu_role new_role = kvm_calc_shadow_npt_root_page_role(vcpu);
>  
> -	new_role.base.level = vcpu->arch.tdp_level;
>  	context->shadow_root_level = new_role.base.level;
>  
>  	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base, false, false);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

