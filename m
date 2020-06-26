Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81082C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5947A206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W11EUkty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFZPDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:03:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727943AbgFZPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593183793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbbm/TbFSROfdFMnHjMyJ/DJL0wHiGp0BTDJLEl5I30=;
        b=W11EUktyC9CTx+Z2hnXHeIvykCscPl/o3oWMykrE9EHeJ0rXLFduyzRv+a9C82ZxGrQ6sl
        mOTjutLp490ZJw9jb0+2zNNnyv/uEgF214RjYrwKH4hU1KlrkZK1AUIXwsyvsfmISwpfU5
        x4eJwmz3zBPtxu/uWilqavTNXSOgTiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-uN93BnBAO7yBqJa4ASKuiA-1; Fri, 26 Jun 2020 11:03:08 -0400
X-MC-Unique: uN93BnBAO7yBqJa4ASKuiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2312E8015CB;
        Fri, 26 Jun 2020 15:03:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-87.rdu2.redhat.com [10.10.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 304AD1944D;
        Fri, 26 Jun 2020 15:03:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7D36E222D88; Fri, 26 Jun 2020 11:03:03 -0400 (EDT)
Date:   Fri, 26 Jun 2020 11:03:03 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, virtio-fs@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kvm,x86: Exit to user space in case of page fault
 error
Message-ID: <20200626150303.GC195150@redhat.com>
References: <20200625214701.GA180786@redhat.com>
 <87lfkach6o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfkach6o.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:25:19AM +0200, Vitaly Kuznetsov wrote:

[..]
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 76817d13c86e..a882a6a9f7a7 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4078,7 +4078,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
> >  	if (!async)
> >  		return false; /* *pfn has correct page already */
> >  
> > -	if (!prefault && kvm_can_do_async_pf(vcpu)) {
> > +	if (!prefault && kvm_can_do_async_pf(vcpu, cr2_or_gpa >> PAGE_SHIFT)) {
> 
> gpa_to_gfn(cr2_or_gpa) ?

Will do.

[..]
> > -bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
> > +bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu, gfn_t gfn)
> >  {
> >  	if (unlikely(!lapic_in_kernel(vcpu) ||
> >  		     kvm_event_needs_reinjection(vcpu) ||
> > @@ -10504,7 +10506,13 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
> >  	 * If interrupts are off we cannot even use an artificial
> >  	 * halt state.
> >  	 */
> > -	return kvm_arch_interrupt_allowed(vcpu);
> > +	if (!kvm_arch_interrupt_allowed(vcpu))
> > +		return false;
> > +
> > +	if (vcpu->arch.apf.error_gfn == gfn)
> > +		return false;
> > +
> > +	return true;
> >  }
> >  
> >  bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
> 
> I'm a little bit afraid that a single error_gfn may not give us
> deterministric behavior. E.g. when we have a lot of faulting processes
> it may take many iterations to hit 'error_gfn == gfn' because we'll
> always be overwriting 'error_gfn' with new values and waking up some
> (random) process.
> 
> What if we just temporary disable the whole APF mechanism? That would
> ensure we're making forward progress. Something like (completely
> untested):
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f8998e97457f..945b3d5a2796 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -778,6 +778,7 @@ struct kvm_vcpu_arch {
>  		unsigned long nested_apf_token;
>  		bool delivery_as_pf_vmexit;
>  		bool pageready_pending;
> +		bool error_pending;
>  	} apf;
>  
>  	/* OSVW MSRs (AMD only) */
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fdd05c233308..e5f04ae97e91 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4124,8 +4124,18 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  	if (try_async_pf(vcpu, prefault, gfn, gpa, &pfn, write, &map_writable))
>  		return RET_PF_RETRY;
>  
> -	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
> +	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r)) {
> +		/*
> +		 * In case APF mechanism was previously disabled due to an error
> +		 * we are ready to re-enable it here as we're about to inject an
> +		 * error to userspace. There is no guarantee we are handling the
> +		 * same GFN which failed in APF here but at least we are making
> +		 * forward progress.
> +		 */
> +
> +		vcpu->arch.apf.error_pending = false;

I like this idea. It is simple. But I have a concern with it though.

- Can it happen that we never retry faulting in error pfn.  Say a process
  accessed a pfn, we set error_pending, and then process got killed due
  to pending signal. Now process will not retry error pfn. And
  error_pending will remain set and we completely disabled APF
  mechanism till next error happens (if it happens).

In another idea, we could think of maintaining another hash of error
gfns. Similar to "vcpu->arch.apf.gfns[]". Say "vgpu->arch.apf.error_gfns[]"

- When error happens on a gfn, add it to hash. If slot is busy, overwrite
  it.

- When kvm_can_do_async_pf(gfn) is called, check if this gfn is present
  in error_gfn, if yes, clear it and force sync fault.

This is more complicated but should take care of your concerns. Also 
even if process never retries that gfn, we are fine. At max that
gfn will remain error_gfn array but will not disable APF completely.

Thanks
Vivek

>  		return r;
> +	}
>  
>  	r = RET_PF_RETRY;
>  	spin_lock(&vcpu->kvm->mmu_lock);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 00c88c2f34e4..4607cf4d5117 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10379,7 +10379,9 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
>  	      work->arch.cr3 != vcpu->arch.mmu->get_guest_pgd(vcpu))
>  		return;
>  
> -	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
> +	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
> +	if (r < 0)
> +		vcpu->arch.apf.error_pending = true;
>  }
>  
>  static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
> @@ -10499,6 +10501,9 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
>  	if (kvm_hlt_in_guest(vcpu->kvm) && !kvm_can_deliver_async_pf(vcpu))
>  		return false;
>  
> +	if (unlikely(vcpu->arch.apf.error_pending))
> +		return false;
> +
>  	/*
>  	 * If interrupts are off we cannot even use an artificial
>  	 * halt state.
> 
> -- 
> Vitaly
> 

