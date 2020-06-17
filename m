Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC29521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG6lUPhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:06:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23358 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgFQQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592409983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqkRPzEJNd4E9Q1G+k445oaqOMVgrxAg/Ac/nNCJrIc=;
        b=DG6lUPhAhbVCBFh2tHQypaEanewrP7VNJSmg+FFnFkH0z0AEIEiZHJTv0exgjQbwXRlLEK
        yUMDKkCt4rR5mVOPH0I0aE25ys7kJ5yqEAnOph0FO5b6GehysWhhGJ7BthYFMSdhwi9mBc
        RxyWiAXd0OlrYMPV0w77dc6rY7rPPjA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-O4-a7qGsMK-6QDyB6f5Lzg-1; Wed, 17 Jun 2020 12:06:21 -0400
X-MC-Unique: O4-a7qGsMK-6QDyB6f5Lzg-1
Received: by mail-qt1-f200.google.com with SMTP id h30so493196qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqkRPzEJNd4E9Q1G+k445oaqOMVgrxAg/Ac/nNCJrIc=;
        b=Dh3/x8WyaowhdgYd2DHzPb9yDXC5TydNyRamVe4nEi1sIMg2LWGDh1ggvLzFh7geIK
         StgDrchw+ziJTHOr/lhvC6WmG4Wcv7jwV5dXJTn3rlWoHO+juqWu6mk9AeCczz1NpbR+
         gVmhoaiEpS3MVbFevy0byNF6RVyaGZlX3n7ZyNa0DkQsmfU/h300dVMzchX5dAca1vWT
         B3sYu3HblqZcVwT6HR9v9grwujkVAT4D8j7nQR3d8lpcynqz9jfySwFkOmq317YyJKIp
         B+hzUloEN5viPs1ZyLwnNIqsaxeS58Su/37w0zj/GZ1BcOVXcMjC3b8Mu7ctez5jTgVa
         4tAw==
X-Gm-Message-State: AOAM53187Tqat9bPVozkCS6Mgx/jM8GxHpEIGHSzrpz4XUJO+acuezTu
        3xLH19/Y9QqC6xaJwltYzmxpEXPkR4GXa9xAhANKHT6ydzQaYmTfMY4UFQ3jvhZ6bYTk8EV63EO
        QkInnMn6mXU5OnCUKBxKF3wS5
X-Received: by 2002:aed:35c5:: with SMTP id d5mr27411830qte.243.1592409980720;
        Wed, 17 Jun 2020 09:06:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK0upNzVKga9t/cXz0nFIHNR+BgMqMR4Y9ZMPK25SOO6oD25NVr9OI+Cadxk2xEZtjGKxkZg==
X-Received: by 2002:aed:35c5:: with SMTP id d5mr27411804qte.243.1592409980451;
        Wed, 17 Jun 2020 09:06:20 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id e53sm295633qtk.50.2020.06.17.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:06:19 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:06:17 -0400
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
Message-ID: <20200617160617.GD76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
 <20200616163510.GD11838@xz-x1>
 <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian,

On Wed, Jun 17, 2020 at 08:19:29AM +0200, Christian Borntraeger wrote:
> 
> 
> On 16.06.20 18:35, Peter Xu wrote:
> > Hi, Alexander,
> > 
> > On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> >>> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >>>  	if (unlikely(fault & VM_FAULT_ERROR))
> >>>  		goto out_up;
> >>>
> >>> -	/*
> >>> -	 * Major/minor page fault accounting is only done on the
> >>> -	 * initial attempt. If we go through a retry, it is extremely
> >>> -	 * likely that the page will be found in page cache at that point.
> >>> -	 */
> >>>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> >>> -		if (fault & VM_FAULT_MAJOR) {
> >>> -			tsk->maj_flt++;
> >>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> >>> -				      regs, address);
> >>> -		} else {
> >>> -			tsk->min_flt++;
> >>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> >>> -				      regs, address);
> >>> -		}
> >>>  		if (fault & VM_FAULT_RETRY) {
> >>>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >>>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {

[1]

> >>
> >> Seems like the call to mm_fault_accounting() will be missed if
> >> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> >> jumps to "out_up"...
> > 
> > This is true as a functional change.  However that also means that we've got a
> > VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
> > than handled correctly (for instance, due to some try_lock failed during the
> > fault process).
> > 
> > To me, that case should not be counted as a page fault at all?  Or we might get
> > the same duplicated accounting when the page fault retried from a higher stack.
> > 
> > Thanks
> 
> This case below (the one with the gmap) is the KVM case for doing a so called
> pseudo page fault to our guests. (we notify our guests about major host page
> faults and let it reschedule to something else instead of halting the vcpu).
> This is being resolved with either gup or fixup_user_fault asynchronously by
> KVM code (this can also be sync when the guest does not match some conditions)
> We do not change the counters in that code as far as I can tell so we should
> continue to do it here.
> 
> (see arch/s390/kvm/kvm-s390.c
> static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
> {
> [...]
>         } else if (current->thread.gmap_pfault) {
>                 trace_kvm_s390_major_guest_pfault(vcpu);
>                 current->thread.gmap_pfault = 0;
>                 if (kvm_arch_setup_async_pf(vcpu))
>                         return 0;
>                 return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
>         }

Please correct me if I'm wrong... but I still think what this patch does is the
right thing to do.

Note again that IMHO when reached [1] above it means the page fault is not
handled correctly so we need to fallback to KVM async page fault, then we
shouldn't increment the accountings until it's finally handled correctly. That
final accounting should be done in the async pf path in gup code where the page
fault is handled:

  kvm_arch_fault_in_page
    gmap_fault
      fixup_user_fault

Where in fixup_user_fault() we have:

	if (tsk) {
		if (major)
			tsk->maj_flt++;
		else
			tsk->min_flt++;
	}

Thanks,

-- 
Peter Xu

