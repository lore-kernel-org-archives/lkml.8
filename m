Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A09C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0837C2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z109u7dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgGHObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:31:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53731 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729635AbgGHObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594218661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKC2bx14eHyjb/gYKwLehiBR3K2qmjX+EfAM9GW8MbE=;
        b=Z109u7dxUxr93Wk8jPEuNCQtOEuYSqj0yFXLAUd9n/auKhSrp/Kln29B0PKriL47FV0kPI
        b9a3orzOqTov6KVQUyN8RIPxCuxB06X1k3WEsvnTJPNM9S70E0wXXMaRO+7XgHSEbeKoe1
        JrZk/sixfvEbV7zwtnaVfZVI0nQ/2XU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-anRVKBTKPpaKUzstI5DsAQ-1; Wed, 08 Jul 2020 10:31:00 -0400
X-MC-Unique: anRVKBTKPpaKUzstI5DsAQ-1
Received: by mail-qt1-f200.google.com with SMTP id 94so32866618qtb.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKC2bx14eHyjb/gYKwLehiBR3K2qmjX+EfAM9GW8MbE=;
        b=jNNywCaImzKpscRzsUxaH/P4jDAE457OooU/uGXBi5rMuQqjj6oL2iKejb/KVaSAqE
         QjvOowSQbwTv7ZiYNHJXySP2yDJK1+c0zwiCSJq0JyPqrhTFhBzBEtGGIh94XihGUhd1
         QvuV0BfrZFNNARkeNjIjPSFXZgB8MVfVT5MFt8lwjrv0Q8b9qI0xLwo0QzSrx3mbBUwo
         OfxgxDqdRMZxSdJGwuPtt/UJoUtt4r+jtk1qE8T+fn5BDSdSLMZn+fGzCjcYhVrWCWgP
         eqERgDEt98Cx4Mpf1T8pX5Mi4Oj+oGegOzykcoOyYqJNE3UlouVHIba24K+dRx1AsXzI
         CmAw==
X-Gm-Message-State: AOAM533hTCyDVYQwyS27P9rVxE4j1QQlhZLiqCXxU4Hn4ZeShbY0EAEL
        K9qAY9gRAHbnfA36Hrm1zkp1uJJIPI1+gE7xel23oh07BFJln8EAJxzwEiclQiyzcGi7doj8sGO
        llz7oICy+lSUXd6vr32AToSzp
X-Received: by 2002:ac8:1c09:: with SMTP id a9mr60809774qtk.64.1594218658618;
        Wed, 08 Jul 2020 07:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYk2B2LITzgr08qVHFrCF5xDdaTXbhzj9HDMucSD4irg5jJk6wCgXMZq2DMNXcOuiETUUD8A==
X-Received: by 2002:ac8:1c09:: with SMTP id a9mr60809747qtk.64.1594218658367;
        Wed, 08 Jul 2020 07:30:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id k18sm25951849qki.30.2020.07.08.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:30:57 -0700 (PDT)
Date:   Wed, 8 Jul 2020 10:30:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 18/25] mm/s390: Use general page fault accounting
Message-ID: <20200708143054.GB199122@xz-x1>
References: <20200707225021.200906-1-peterx@redhat.com>
 <20200707225021.200906-19-peterx@redhat.com>
 <20200708054947.GA4026@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708054947.GA4026@oc3871087118.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 07:49:47AM +0200, Alexander Gordeev wrote:
> On Tue, Jul 07, 2020 at 06:50:14PM -0400, Peter Xu wrote:
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> > 
> > CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> > CC: Vasily Gorbik <gor@linux.ibm.com>
> > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > CC: linux-s390@vger.kernel.org
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/s390/mm/fault.c | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index fc14df0b4d6e..9aa201df2e94 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	 * make sure we exit gracefully rather than endlessly redo
> >  	 * the fault.
> >  	 */
> > -	fault = handle_mm_fault(vma, address, flags, NULL);
> > +	fault = handle_mm_fault(vma, address, flags, regs);
> >  	if (fault_signal_pending(fault, regs)) {
> >  		fault = VM_FAULT_SIGNAL;
> >  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> > @@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> >  
> > -	/*
> > -	 * Major/minor page fault accounting is only done on the
> > -	 * initial attempt. If we go through a retry, it is extremely
> > -	 * likely that the page will be found in page cache at that point.
> > -	 */
> >  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> 
> Shouldn't this check ^^^ be dropped as well?
> 
> Since commit 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times")
> FAULT_FLAG_ALLOW_RETRY never gets unset, so no need to check..

I agree, but it should be out of the scope of the accounting changes that this
patch wants to address.  Maybe more suitable for a work on top?

This should also exist for most of the archs too, and I'm also not sure whether
compiler could be smart enough to optimize this directly since it seems to have
all the knowledge.

Thanks,

-- 
Peter Xu

