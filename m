Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AA321532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX2iCcGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFQQo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:44:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726511AbgFQQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592412262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHqYGq8gMGijl7hrfFNPw6Y3ObzoMwmEvofgpNQ4KMA=;
        b=WX2iCcGCxdH7rERbx43gnemGw6gKx2ejAz4s6fxbyJtc/E5cuJtrdYwh9dwseVYx3t0m0Q
        wr7h7R9UeZhoodP1LoyPr1tuhsSfMTYwZZRwJi6jzsErIe/x6iAhk8JDIRIGBTLlvpb2q2
        NrQOnTkog457t4fCpJjvU1LXkgLbMKs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-DAkH77c_MSGlGs258zhLDw-1; Wed, 17 Jun 2020 12:44:17 -0400
X-MC-Unique: DAkH77c_MSGlGs258zhLDw-1
Received: by mail-qt1-f198.google.com with SMTP id y25so2169470qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHqYGq8gMGijl7hrfFNPw6Y3ObzoMwmEvofgpNQ4KMA=;
        b=oAzEhEioXvOZ3sNvln17RWOS2VTcZ9eNKP0w4CPBcYMLM+YaJp/93FUHpJSNA+rdCx
         6F9p7XZa0je5pjxDyohglKTejoTcFVUZSJhMOEEigm/rTmswi4D7rabY+LR23NdgnAv3
         pma519dj5eKBfwmeATBxP7Fmq7dIOYtz1LzaJubOqlx+pFFL8rQ25Ia7IaXg98aaNCqT
         WqOyq4qTBxK/DyqtCunAU5ADPJYimVW9ZGQQ5tfDA2nCMDNvxF75pzqjNQlNtJ+BFEiY
         6N0b/BGL3qWzSrEjBw0d9Uq204las+RzfcOaVpdU4ksp7FLIYJ2AKmhPBf82mxNXnqe8
         /aOQ==
X-Gm-Message-State: AOAM533+yuMfdpALSu2Tou3vD2tpWzmXfD+0Ytos/SC5RXpSvRW5o6K/
        IDEP+jH83xZo91w8CaJam5tSylrcCAKpvTnrU53f/x+FpQTy9BjpHl8qa2qGFmBLjPboS2G1wO7
        U6jzgPAPcGRoJtY8kGWGIPu8D
X-Received: by 2002:ac8:35fd:: with SMTP id l58mr27549715qtb.324.1592412256721;
        Wed, 17 Jun 2020 09:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzlHNvNUfv10ny3GvWXjj+c+QD1W86k7S+sDSFqbWy+cGxtKmllCh4TQR/EJJQuXLGd22t+g==
X-Received: by 2002:ac8:35fd:: with SMTP id l58mr27549692qtb.324.1592412256431;
        Wed, 17 Jun 2020 09:44:16 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m26sm380110qtm.73.2020.06.17.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:44:15 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:44:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200617164413.GG76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
 <20200616163510.GD11838@xz-x1>
 <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
 <20200617160617.GD76766@xz-x1>
 <8bd8dcf6-f2f0-d44e-9bf8-6fd4fe299aa9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bd8dcf6-f2f0-d44e-9bf8-6fd4fe299aa9@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:14:52PM +0200, Christian Borntraeger wrote:
> 
> 
> On 17.06.20 18:06, Peter Xu wrote:
> > Hi, Christian,
> > 
> > On Wed, Jun 17, 2020 at 08:19:29AM +0200, Christian Borntraeger wrote:
> >>
> >>
> >> On 16.06.20 18:35, Peter Xu wrote:
> >>> Hi, Alexander,
> >>>
> >>> On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> >>>>> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >>>>>  	if (unlikely(fault & VM_FAULT_ERROR))
> >>>>>  		goto out_up;
> >>>>>
> >>>>> -	/*
> >>>>> -	 * Major/minor page fault accounting is only done on the
> >>>>> -	 * initial attempt. If we go through a retry, it is extremely
> >>>>> -	 * likely that the page will be found in page cache at that point.
> >>>>> -	 */
> >>>>>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> >>>>> -		if (fault & VM_FAULT_MAJOR) {
> >>>>> -			tsk->maj_flt++;
> >>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> >>>>> -				      regs, address);
> >>>>> -		} else {
> >>>>> -			tsk->min_flt++;
> >>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> >>>>> -				      regs, address);
> >>>>> -		}
> >>>>>  		if (fault & VM_FAULT_RETRY) {
> >>>>>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >>>>>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> > 
> > [1]
> > 
> >>>>
> >>>> Seems like the call to mm_fault_accounting() will be missed if
> >>>> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> >>>> jumps to "out_up"...
> >>>
> >>> This is true as a functional change.  However that also means that we've got a
> >>> VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
> >>> than handled correctly (for instance, due to some try_lock failed during the
> >>> fault process).
> >>>
> >>> To me, that case should not be counted as a page fault at all?  Or we might get
> >>> the same duplicated accounting when the page fault retried from a higher stack.
> >>>
> >>> Thanks
> >>
> >> This case below (the one with the gmap) is the KVM case for doing a so called
> >> pseudo page fault to our guests. (we notify our guests about major host page
> >> faults and let it reschedule to something else instead of halting the vcpu).
> >> This is being resolved with either gup or fixup_user_fault asynchronously by
> >> KVM code (this can also be sync when the guest does not match some conditions)
> >> We do not change the counters in that code as far as I can tell so we should
> >> continue to do it here.
> >>
> >> (see arch/s390/kvm/kvm-s390.c
> >> static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
> >> {
> >> [...]
> >>         } else if (current->thread.gmap_pfault) {
> >>                 trace_kvm_s390_major_guest_pfault(vcpu);
> >>                 current->thread.gmap_pfault = 0;
> >>                 if (kvm_arch_setup_async_pf(vcpu))
> >>                         return 0;
> >>                 return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
> >>         }
> > 
> > Please correct me if I'm wrong... but I still think what this patch does is the
> > right thing to do.
> > 
> > Note again that IMHO when reached [1] above it means the page fault is not
> > handled correctly so we need to fallback to KVM async page fault, then we
> > shouldn't increment the accountings until it's finally handled correctly. That
> > final accounting should be done in the async pf path in gup code where the page
> > fault is handled:
> > 
> >   kvm_arch_fault_in_page
> >     gmap_fault
> >       fixup_user_fault
> > 
> > Where in fixup_user_fault() we have:
> > 
> > 	if (tsk) {
> > 		if (major)
> > 			tsk->maj_flt++;
> > 		else
> > 			tsk->min_flt++;
> > 	}
> > 
> 
> Right that case does work. Its the case where we do not inject a pseudo pagefault and
> instead fall back to synchronous fault-in.
> What is about the other case:
> 
> kvm_setup_async_pf
> 	->workqueue
> 		async_pf_execute
> 			get_user_pages_remote
> 
> Does get_user_pages_remote do the accounting as well? I cant see that.
> 

It should, with:

  get_user_pages_remote
    __get_user_pages_remote
      __get_user_pages_locked
        __get_user_pages
          faultin_page

Where the accounting is done in faultin_page().

We probably need to also move the accounting in faultin_page() to be after the
retry check too, but that should be irrelevant to this patch.

Thanks!

-- 
Peter Xu

