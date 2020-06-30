Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B298D206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxNZuWxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgF3NYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:24:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730381AbgF3NYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593523489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FO62VxTVP0c22pP93bCu+ULSsUX9Fjc6lol5S1ApaDQ=;
        b=AxNZuWxJHR3bat5i4gWoK6re7f/cFazu3Dt7ob3eMwf/XoiPd1gCYHn7ZkvYRBeII4VZ2E
        Ac4ADcuxXup5sBW9adKi3TUiu2DwOSqo1O4l9Sc5VSmPzK+2YSu/V6kyEZHDlroxoaGifh
        JRCJiYVU0mxa3+89k+xaGFlSY179F24=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-9tuBYv1sO4G2AQMDQoi45A-1; Tue, 30 Jun 2020 09:24:48 -0400
X-MC-Unique: 9tuBYv1sO4G2AQMDQoi45A-1
Received: by mail-ed1-f69.google.com with SMTP id j15so13147051edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FO62VxTVP0c22pP93bCu+ULSsUX9Fjc6lol5S1ApaDQ=;
        b=ll2oWsAQN3le3ByNV1bwXdey4ZxIFRsqE3m4Dsy21pfzCjr78Yzwycgm+F9B/4efGR
         hfEax19BraCwaPEheIFdDvvCsDrMqWoh6kuqvM3Rv8sLWOl8WSHuT8Jw7qWckW6eRD6B
         sSoqQ5G31qiyvVF4a3yf6jWfIwrhUgNv98SvEzyb30U9LJIOOSlAcj1RbgzVvXblInLQ
         h7/+Yb0MRg32vjo0E514SR6DNlxF2tY+MSHiGyiF/u4qfkxmk2WzAINL8ITONmxbmQ6l
         B0WnGjy1mvU1j/EIa2BA/4fOl+y7OJMs+LuQWnaAi2G5OjXfocz8+nchpyv7E7k9LAfN
         vqug==
X-Gm-Message-State: AOAM530jJM6vIMOQZ2w6pdGTfiSKFv4IOmDhSiLdVK7ar9mQcOcV7pd4
        HAY6HwMIhgFsrSgYTrz6MQcldNkZ57/T96wSIRE0USC1CLHLOeRx7NktXkn5UXfYSGsIVr5xaWY
        kOeiSyVMKJRxR0gblzQ8urtOK
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr17948395ejb.317.1593523486438;
        Tue, 30 Jun 2020 06:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx98SSlXM+BrQCEjYUidshkj1n6YQC9RXWXVxRbiMJOBoLhMuFoOusHuSL90CEN05zgb47A7w==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr17948373ejb.317.1593523486178;
        Tue, 30 Jun 2020 06:24:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v5sm2052016ejj.61.2020.06.30.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:24:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, virtio-fs@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kvm,x86: Exit to user space in case of page fault error
In-Reply-To: <20200629220353.GC269627@redhat.com>
References: <20200625214701.GA180786@redhat.com> <87lfkach6o.fsf@vitty.brq.redhat.com> <20200626150303.GC195150@redhat.com> <874kqtd212.fsf@vitty.brq.redhat.com> <20200629220353.GC269627@redhat.com>
Date:   Tue, 30 Jun 2020 15:24:43 +0200
Message-ID: <87sgecbs9w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Jun 29, 2020 at 10:56:25PM +0200, Vitaly Kuznetsov wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > On Fri, Jun 26, 2020 at 11:25:19AM +0200, Vitaly Kuznetsov wrote:
>> >
>> > [..]
>> >> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> >> > index 76817d13c86e..a882a6a9f7a7 100644
>> >> > --- a/arch/x86/kvm/mmu/mmu.c
>> >> > +++ b/arch/x86/kvm/mmu/mmu.c
>> >> > @@ -4078,7 +4078,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>> >> >  	if (!async)
>> >> >  		return false; /* *pfn has correct page already */
>> >> >  
>> >> > -	if (!prefault && kvm_can_do_async_pf(vcpu)) {
>> >> > +	if (!prefault && kvm_can_do_async_pf(vcpu, cr2_or_gpa >> PAGE_SHIFT)) {
>> >> 
>> >> gpa_to_gfn(cr2_or_gpa) ?
>> >
>> > Will do.
>> >
>> > [..]
>> >> > -bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
>> >> > +bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu, gfn_t gfn)
>> >> >  {
>> >> >  	if (unlikely(!lapic_in_kernel(vcpu) ||
>> >> >  		     kvm_event_needs_reinjection(vcpu) ||
>> >> > @@ -10504,7 +10506,13 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
>> >> >  	 * If interrupts are off we cannot even use an artificial
>> >> >  	 * halt state.
>> >> >  	 */
>> >> > -	return kvm_arch_interrupt_allowed(vcpu);
>> >> > +	if (!kvm_arch_interrupt_allowed(vcpu))
>> >> > +		return false;
>> >> > +
>> >> > +	if (vcpu->arch.apf.error_gfn == gfn)
>> >> > +		return false;
>> >> > +
>> >> > +	return true;
>> >> >  }
>> >> >  
>> >> >  bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>> >> 
>> >> I'm a little bit afraid that a single error_gfn may not give us
>> >> deterministric behavior. E.g. when we have a lot of faulting processes
>> >> it may take many iterations to hit 'error_gfn == gfn' because we'll
>> >> always be overwriting 'error_gfn' with new values and waking up some
>> >> (random) process.
>> >> 
>> >> What if we just temporary disable the whole APF mechanism? That would
>> >> ensure we're making forward progress. Something like (completely
>> >> untested):
>> >> 
>> >> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> >> index f8998e97457f..945b3d5a2796 100644
>> >> --- a/arch/x86/include/asm/kvm_host.h
>> >> +++ b/arch/x86/include/asm/kvm_host.h
>> >> @@ -778,6 +778,7 @@ struct kvm_vcpu_arch {
>> >>  		unsigned long nested_apf_token;
>> >>  		bool delivery_as_pf_vmexit;
>> >>  		bool pageready_pending;
>> >> +		bool error_pending;
>> >>  	} apf;
>> >>  
>> >>  	/* OSVW MSRs (AMD only) */
>> >> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> >> index fdd05c233308..e5f04ae97e91 100644
>> >> --- a/arch/x86/kvm/mmu/mmu.c
>> >> +++ b/arch/x86/kvm/mmu/mmu.c
>> >> @@ -4124,8 +4124,18 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>> >>  	if (try_async_pf(vcpu, prefault, gfn, gpa, &pfn, write, &map_writable))
>> >>  		return RET_PF_RETRY;
>> >>  
>> >> -	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
>> >> +	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r)) {
>> >> +		/*
>> >> +		 * In case APF mechanism was previously disabled due to an error
>> >> +		 * we are ready to re-enable it here as we're about to inject an
>> >> +		 * error to userspace. There is no guarantee we are handling the
>> >> +		 * same GFN which failed in APF here but at least we are making
>> >> +		 * forward progress.
>> >> +		 */
>> >> +
>> >> +		vcpu->arch.apf.error_pending = false;
>> >
>> > I like this idea. It is simple. But I have a concern with it though.
>> >
>> > - Can it happen that we never retry faulting in error pfn.  Say a process
>> >   accessed a pfn, we set error_pending, and then process got killed due
>> >   to pending signal. Now process will not retry error pfn. And
>> >   error_pending will remain set and we completely disabled APF
>> >   mechanism till next error happens (if it happens).
>> 
>> Can a process in kvm_async_pf_task_wait_schedule() get killed? I don't
>> see us checking signals/... in the loop, just 'if
>> (hlist_unhashed(&n.link))' -- and this only happens when APF task
>> completes. I don't know much about processes to be honest, could easily
>> be wrong completely :-)
>
> I think a waiting process will be woken up and scheduled again. And
> when it is starts running again and goes back to user space (faulting
> instruction was in user space), then we should check for pending SIGNAL
> and kill it.
>
> That's how my patches for sending SIGBUS were working. I queued SIGBUS
> and then when process got scheduled, it got SIGBUS and got killed and
> stopped retrying instruction. (Otherwise this fault cycle will never
> end).
>
> Hence, I think it is possible. Another process can send SIGKILL to
> this process which is waiting for APF. Once APF page ready event
> comes in, process will be killed after that without retrying the
> instruct. I will be glad to be corrected if I understood it wrong.
>

It's probably me who's missing something important here :-) but I think
you describe how it *should* work as I'm not seeing how we can leave the
loop in kvm_async_pf_task_wait_schedule() other than by 
"if (hlist_unhashed(&n.link)) break;" and this only happens when APF
completes.

>> 
>> >
>> > In another idea, we could think of maintaining another hash of error
>> > gfns. Similar to "vcpu->arch.apf.gfns[]". Say "vgpu->arch.apf.error_gfns[]"
>> >
>> > - When error happens on a gfn, add it to hash. If slot is busy, overwrite
>> >   it.
>> >
>> > - When kvm_can_do_async_pf(gfn) is called, check if this gfn is present
>> >   in error_gfn, if yes, clear it and force sync fault.
>> >
>> > This is more complicated but should take care of your concerns. Also 
>> > even if process never retries that gfn, we are fine. At max that
>> > gfn will remain error_gfn array but will not disable APF completely.
>> 
>> Yes, we can do that but I'm not sure it wouldn't be an overkill: we are
>> not trying to protect the mechanism against a malicious guest. Using APF
>> is guest's choice anyway so even if there's going to be an easy way to
>> disable it completely (poke an address and never retry upon wakeup) from
>> guest's side it doesn't sound like a big deal.
>
> Sure but if guest chose APF and then it got disabled completely
> intentionally, then its a probelm, isn't it. This is just a race
> condition which can disable APF unintentionally and leave it like
> that till next error happens. 
>
>> 
>> Also, we can introduce a status bit in the APF 'page ready' notification
>> stating that the page is actually NOT ready and the mecanism was blocked
>> because if that, the guest will have to access the GFN to get the error
>> injected (and unblock the mechanism).
>
> I am not sure how will we force guest to access that pfn if accessing
> process gets killed. This actually feels like least preferred of all
> options.

When guest receives the 'page ready' event with an error it (like for
every other 'page ready' event) tries to wake up the corresponding
process but if the process is dead already it can do in-kernel probing
of the GFN, this way we guarantee that the error is always injected. I'm
not sure if it is needed though but in case it is, this can be a
solution. We can add a new feature bit and only deliver errors when the
guest indicates that it knows what to do with them.

-- 
Vitaly

