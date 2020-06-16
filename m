Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D2F2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RO2ejTt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgFPVDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:03:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728666AbgFPVDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592341398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrv6u/IyjeoGyX7Yz14HGrcrd86qr4fiQrLVf2Tt4MM=;
        b=RO2ejTt8EL6Sp6wQwtQ6NSI4gYPDYTK7xHNi8UfCeXCPFRF+zJFEEOG8nUTl1Mk+QEtO6p
        ynSunFbGZn+EWwJYC+MUmefDTJ/AoVbDvIiwXPZ59wBgWPyRb2Th+NXZzfEZeScWrid6mO
        gUJy8X5SyVX4RhdubudP6l7m2YyZ3qQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-k6v_PQdWMmK81La-sldPLg-1; Tue, 16 Jun 2020 17:03:16 -0400
X-MC-Unique: k6v_PQdWMmK81La-sldPLg-1
Received: by mail-qk1-f200.google.com with SMTP id g72so85393qke.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrv6u/IyjeoGyX7Yz14HGrcrd86qr4fiQrLVf2Tt4MM=;
        b=otKD1leT9WWqzEX8gG/b7ewOrUc96zCXDzgp9qcjJzd0GKrdJh8hIva2QZBZ/W45o0
         ygLPa2+Sw3ON4uITYkrYK2b+dvEf3YAkrSh4jUrhFRmVNY9dkI2Dshcn6OmS8IJ7rZtF
         vMZHPRxUhAhC+bLpqnqOOnhWDcYCVM/fvWMVwkBZrVy8+Llf4X7+FChNFhLBFlNXfXr8
         cBKrEx0YpG4vTSk7I6NMVXXLPgYz6TAK2bkMSf77MWs4XB6rkEvYFT4gzkf2PWJf2T5Y
         umFJ393cC9vrDcXoEU9nvMjQRsR0A3/1daVvOPMNMfxBJFPL1oImKJMC4H1liBxvj2ez
         7mOQ==
X-Gm-Message-State: AOAM532qblENbddaO0SfpkRhy4/6LQJ3CnlC/kdBEjdJpbFicNnrwsAT
        aMQg1WL+7qExCv804nDEV4cp6PW2YNvF8P5d2ykcZ80fl6mXFc3HSgn2NICPVVM36aKUZXEsHz0
        MQsFcHvMrdDaXw68a3mHYEf7Q
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr23634386qtv.163.1592341395502;
        Tue, 16 Jun 2020 14:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF61Dh2xefzBMPBEm2C7AoRpqAxg6bYegNDhmpzkQWpsDpqFwc6dGag1E30rH+tRg9dP4ZMQ==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr23634348qtv.163.1592341395148;
        Tue, 16 Jun 2020 14:03:15 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 6sm13935183qkl.26.2020.06.16.14.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 14:03:14 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:03:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
Message-ID: <20200616210312.GF11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:55:17AM -0700, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This series tries to address all of them by introducing mm_fault_accounting()
> > first, so that we move all the page fault accounting into the common code base,
> > then call it properly from arch pf handlers just like handle_mm_fault().
> 
> Hmm.
> 
> So having looked at this a bit more, I'd actually like to go even
> further, and just get rid of the per-architecture code _entirely_.
> 
> Here's a straw-man patch to the generic code - the idea is mostly laid
> out in the comment that I'm just quoting here directly too:
> 
>         /*
>          * Do accounting in the common code, to avoid unnecessary
>          * architecture differences or duplicated code.
>          *
>          * We arbitrarily make the rules be:
>          *
>          *  - faults that never even got here (because the address
>          *    wasn't valid). That includes arch_vma_access_permitted()
>          *    failing above.
>          *
>          *    So this is expressly not a "this many hardware page
>          *    faults" counter. Use the hw profiling for that.
>          *
>          *  - incomplete faults (ie RETRY) do not count (see above).
>          *    They will only count once completed.
>          *
>          *  - the fault counts as a "major" fault when the final
>          *    successful fault is VM_FAULT_MAJOR, or if it was a
>          *    retry (which implies that we couldn't handle it
>          *    immediately previously).
>          *
>          *  - if the fault is done for GUP, regs wil be NULL and
>          *    no accounting will be done (but you _could_ pass in
>          *    your own regs and it would be accounted to the thread
>          *    doing the fault, not to the target!)
>          */
> 
> the code itself in the patch is
> 
>  (a) pretty trivial and self-evident
> 
>  (b) INCOMPLETE
> 
> that (b) is worth noting: this patch won't compile on its own. It
> intentionally leaves all the users without the new 'regs' argument,
> because you obviously simply need to remove all the code that
> currently tries to do any accounting.
> 
> Comments?

Looks clean to me.  The definition of "major faults" will slightly change even
for those who has done the "major |= fault & MAJOR" operations before, but at
least I can't see anything bad about that either...

To make things easier, we can use the 1st patch to introduce this change,
however pass regs==NULL at the callers to never trigger this accounting.  Then
we can still use one patch for each arch to do the final convertions.

> 
> This is a bigger change, but I think it might be worth it to _really_
> consolidate the major/minor logic.
> 
> One detail worth noting: I do wonder if we should put the
> 
>     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> 
> just in the arch code at the top of the fault handling, and consider
> it entirely unrelated to the major/minor fault handling. The
> major/minor faults fundamnetally are about successes. But the plain
> PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> things that never even get to this point at all.
> 
> I'm not convinced it's useful to have three SW events that are defined
> to be A=B+C.

IMHO it's still common to have a "total" statistics in softwares even if each
of the subsets are accounted separately.  Here it's just a bit special because
there're only two elements so the addition is so straightforward.  It seems a
trade-off on whether we'd like to do the accounting of errornous faults, or we
want to make it cleaner by put them altogether but only successful page faults.
I slightly preferred the latter due to the fact that I failed to find great
usefulness out of keeping error fault accountings, but no strong opinions..

Thanks,

-- 
Peter Xu

