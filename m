Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C31C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B112146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG964+rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCITvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:51:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgCITvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583783467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rq+oYusc+Z0wUjpcAqLin4vzJG/NqgieMaLYChwrgfc=;
        b=JG964+rtnG9k8P2PpLjRdP44H/BiQPSCgYp+QBTkd0AMsaX0HDmSktcMgVrBC8+WlxREOw
        wi/RC+EIDLq031Kr3BrbDj7K1mAzgFf/3sMwIfmhb5BmJ48cFzHQEU2SSgpvBVzU3GAab1
        AvJSMOA0e0QQNbJzoS0KlaiWuLC19wg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-T9VfvMUROdiFyRY3hIj3lA-1; Mon, 09 Mar 2020 15:51:05 -0400
X-MC-Unique: T9VfvMUROdiFyRY3hIj3lA-1
Received: by mail-qv1-f70.google.com with SMTP id h17so7438690qvc.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 12:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rq+oYusc+Z0wUjpcAqLin4vzJG/NqgieMaLYChwrgfc=;
        b=kMSFlRLZGZM4vaw+xZg9npeUtguAsPeoVZNcUaYDjJEf+uv/EV7wAw7cJn9+b3jVcr
         yBIpA9HcaE2f46/myVl1ZhdMI0mWyHkgRPZtFOrM2eME/4KuMVCYU5m4vKK3mI7+ix3m
         mJ6z63tWRZZ1kYAPZdtXHe3PisKVTuWADZlkT3Ago669C2TV8TKAtjidJiDfoT8rW9e5
         kx7Mxy1ln9wK9juvtIs/leSTzpZYK/XPNPrSCbqUA4zKOawHKT80C+df0Smxcb/+01FQ
         GfzmtC6g48oQqJeUT9P9nUygMejctueLlCS4nkJdDbwl7yT8dqzMsd9R7A4viFWZBN9s
         nL2g==
X-Gm-Message-State: ANhLgQ0uyRHjZzV3wCHW24XpC8xN/ChHVzf25do1SVvvZ6d99syMLJZk
        Z8y0a/I1Fuahi/SUgVrflRfTZhBtK5qkBU+B08ymDzfcf1uWxRwxert8M3U2p1f6PJjxYE8oihc
        If5WaVIGBx5Pb701+nrd1KYQN
X-Received: by 2002:ac8:7585:: with SMTP id s5mr16046666qtq.339.1583783464835;
        Mon, 09 Mar 2020 12:51:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtsdpLiFNxSvSNps0MPHiFHF0cHjhwj7d6eDeDTgOttuytFJ0BM2ewUOiaOWVlvms5yZw1Haw==
X-Received: by 2002:ac8:7585:: with SMTP id s5mr16046647qtq.339.1583783464538;
        Mon, 09 Mar 2020 12:51:04 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g2sm22525948qkb.27.2020.03.09.12.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 12:51:02 -0700 (PDT)
Date:   Mon, 9 Mar 2020 15:51:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Message-ID: <20200309195100.GD4206@xz-x1>
References: <20200220155353.8676-1-peterx@redhat.com>
 <1eb7bdd4-348f-da87-47a1-0b022b70e918@redhat.com>
 <20200307214743.GA4206@xz-x1>
 <6d8ed084-0740-cee1-663e-a78a2faee432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d8ed084-0740-cee1-663e-a78a2faee432@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 01:12:34PM +0100, David Hildenbrand wrote:
> [...]
> 
> > Yes, IIUC the race can happen like this in your below test:
> > 
> >      main thread          uffd thread             disgard thread
> >      ===========          ===========             ==============
> >      access page
> >        uffd page fault
> >          wait for page
> >                           UFFDIO_ZEROCOPY
> >                             put a page P there
> >                                                   MADV_DONTNEED on P
> >                             wakeup main thread
> >          return from fault
> >        page still missing
> >        uffd page fault again
> >        (without ALLOW_RETRY)
> >        --> SIGBUS.
> 
> Exactly!
> 
> >> Can we please have a way to identify that this "feature" is available?
> >> I'd appreciate a new read-only UFFD_FEAT_ , so we can detect this from
> >> user space easily and use concurrent discards without crashing our applications.
> > 
> > I'm not sure how others think about it, but to me this still fells
> > into the bucket of "solving an existing problem" rather than a
> > feature.  Also note that this should change the behavior for the page
> > fault logic in general, rather than an uffd-only change. So I'm also
> > not sure whether UFFD_FEAT_* suites here even if we want it.
> 
> So, are we planning on backporting this to stable kernels?

I don't have a plan so far.  I'm still at the phase to only worry
about whether it can be at least merged in master.. :)

I would think it won't worth it to backport this to stables though,
considering that it could potentially change quite a bit for faulting
procedures, and after all the issues we're fixing shouldn't be common
to general users.

> 
> Imagine using this in QEMU/KVM to allow discards (e.g., balloon
> inflation) while postcopy is active . You certainly don't want random
> guest crashes. So either, we treat this as a fix (and backport) or as a
> change in behavior/feature.

I think we don't need to worry on that - QEMU will prohibit ballooning
during postcopy starting from the first day.  Feel free to see QEMU
commit 371ff5a3f04cd7 ("Inhibit ballooning during postcopy").

> 
> [...]
> 
> >>
> >> 2. What will happen if I don't place a page on a pagefault, but only do a UFFDIO_WAKE?
> >>    For now we were able to trigger a signal this way.
> > 
> > If I'm not mistaken the UFFDIO_WAKE will directly trigger the sigbus
> > even without the help of the MADV_DONTNEED race.
> 
> Yes, that's the current way of injecting a SIGBUS instead of resolving
> the pagefault. And AFAIKs, you're changing that behavior. (I am not
> aware of a user, there could be use cases, but somehow it's strange to
> get a signal when accessing memory that is mapped READ|WRITE and also
> represented like this in e.g., /proc/$PID/maps). So IMHO, only the new
> behavior makes really sense.

I agree, I'm not sure how other people think on ABI stability, but...
for my own preference I don't worry much on ABI breakage for a problem
like this.

Thanks,

-- 
Peter Xu

