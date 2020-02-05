Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E7C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A0420702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHgXRVr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBENhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:37:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41395 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727330AbgBENhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580909865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ZHZKV/jKaOSLjENoe5XZtmnBOqMNMYSGhSaLDt7Q6E=;
        b=fHgXRVr0YdebxG8WqXD8L03XF6IMUri2fKgBII0x7+8jdCFfGfoiZNVVWwN8myTdW5/Tn5
        isuhUfk7CoEXhMY1ZOYXe+g0En/SVKEPYpqdSMgIWeFKpbBcidF5iZp4REtMbHGAzqtgzf
        mx8EoaU1+FuJZ9uVoIj6SO+skpjo1w8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-7iBa3A2dN2-KRBK5Hp_dKA-1; Wed, 05 Feb 2020 08:37:28 -0500
X-MC-Unique: 7iBa3A2dN2-KRBK5Hp_dKA-1
Received: by mail-wm1-f71.google.com with SMTP id b202so1011083wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 05:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1ZHZKV/jKaOSLjENoe5XZtmnBOqMNMYSGhSaLDt7Q6E=;
        b=duU+3F4tYWrKs03dnyBPN9iuAiqK5q/5a/Pxwx/LFTw4gjUbkNhuGvjT1YsJTyWqPF
         sNcUIkkBvoA+uqNvyTlhI59xassaNnzYnIYnINFSMtG0+tQpTvS4JNeZZJVlmwIsBg20
         kbpgEVueHpp2QChnpIsWdcloYg2YXAqT6trF/gnBNVh3SX4ZnYxAgMC9pdw1lBB7byNx
         gkjCnzp3ukMWitNlswhQTdCtIZxl1fvEPzsLwHB1e/APEUnP6Ikr4gB7OGGIDW3VT3/t
         nthHq00+Oij28NzWENRzrCeHc0oZC83DV/Rus5EcRZTjBKGjQRxiAieX1yjlS2jlYyIk
         z7mg==
X-Gm-Message-State: APjAAAUehXU0/3snWpUpE65S3bvIIztAOaJRUgN7YWNx+xlnPgw5QyI+
        2TNWuEcJkWxUnJO3/jlGJ0g5kLgJwzXvczJkK+RNVp4k9Rb7tNCTc2cJFuQSDAMkfZYHPg2Ccoy
        TT58GG/YsYXLcn6mD01M8vNET
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr5908606wme.79.1580909847561;
        Wed, 05 Feb 2020 05:37:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzFfXP0e0I4L4edLOhHxfXyc4Wmj97qyd8lGe4qqcytnp7OMRoH9/s3pDomwcVTc8YqdMMAg==
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr5908575wme.79.1580909847254;
        Wed, 05 Feb 2020 05:37:27 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k13sm33844114wrx.59.2020.02.05.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:37:26 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] kvm: mmu: Separate generating and setting mmio ptes
In-Reply-To: <20200203230911.39755-2-bgardon@google.com>
References: <20200203230911.39755-1-bgardon@google.com> <20200203230911.39755-2-bgardon@google.com>
Date:   Wed, 05 Feb 2020 14:37:25 +0100
Message-ID: <87sgjpkve2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gardon <bgardon@google.com> writes:

> Separate the functions for generating MMIO page table entries from the
> function that inserts them into the paging structure. This refactoring
> will facilitate changes to the MMU sychronization model to use atomic
> compare / exchanges (which are not guaranteed to succeed) instead of a
> monolithic MMU lock.
>
> No functional change expected.
>
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
>
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2359
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Oliver Upton <oupton@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a9c593dec49bf..b81010d0edae1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -451,9 +451,9 @@ static u64 get_mmio_spte_generation(u64 spte)
>  	return gen;
>  }
>  
> -static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> -			   unsigned int access)
> +static u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
>  {
> +

Unneded newline.

>  	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
>  	u64 mask = generation_mmio_spte_mask(gen);
>  	u64 gpa = gfn << PAGE_SHIFT;
> @@ -464,6 +464,17 @@ static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>  	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
>  		<< shadow_nonpresent_or_rsvd_mask_len;
>  
> +	return mask;
> +}
> +
> +static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> +			   unsigned int access)
> +{
> +	u64 mask = make_mmio_spte(vcpu, gfn, access);
> +	unsigned int gen = get_mmio_spte_generation(mask);
> +
> +	access = mask & ACC_ALL;
> +
>  	trace_mark_mmio_spte(sptep, gfn, access, gen);

'access' and 'gen' are only being used for tracing, would it rather make
sense to rename&move it to the newly introduced make_mmio_spte()? Or do
we actually need tracing for both?

Also, I dislike re-purposing function parameters.

>  	mmu_spte_set(sptep, mask);
>  }

-- 
Vitaly

