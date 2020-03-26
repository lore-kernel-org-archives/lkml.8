Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008820714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKw+PWvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCZWJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:09:28 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36669 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgCZWJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:09:28 -0400
Received: by mail-yb1-f196.google.com with SMTP id i4so3504925ybl.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kn2WIN8QO5W0o3GwWRwvCngYE1iUlvZV7DjAfzZNk4Y=;
        b=SKw+PWvCw12GGiUc78HNQOrdcBLILk9gtKEUUBLb5YgvnMEBi9QQlBJw/px2g4zxkb
         lVy4BzBzdo6zSNY9ReR388SUKDBrjGHX12X7HjcGACPWYgF+MmAji9E8oY2bSVqZQHUQ
         aDJmKRwQkXvzXv2kU+1/5jBylz001PwVYBu7J73fzTbuAE6E9t00F1gYYzMqd4CyuJxI
         1Dp1Cp0T1cZlI22IYQ7A6m0MmC9UfSCFOrBQeuEYoSxB9/fjRy5fFfNRYP5/dY0Dj/zN
         EdL//hQQnI8e0RXG2vhOKhqokNsWyMAMv7vJtJH+HMmYIMHKqHgh+GaYwit4MCRI+57U
         3Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kn2WIN8QO5W0o3GwWRwvCngYE1iUlvZV7DjAfzZNk4Y=;
        b=bor1SYfTZ1Xgn7zG/lLXs7MUZNqzxz7HBNQAhju9RnaqrNRLwkrlpwPkzrHRppknVW
         6M81e5XZE8P4KI3e9X9ijTti00aH4uDLURv9EzY5vRZqxwwe9UCF0uCjIGjoV9iT75+S
         /Ds06qPeA286A0szmTUJPX92UoZA5L2NdNfaKSrpAlXfefDlN+qsWgW248q4AGXKmDgW
         f/ffQ9VlTdUI5Z1PEf5zsoTll41ciDrK8m+hWQdY4lzmjdWLCR6tfMPjCFxIiCPv/kjF
         KvOk6ilILCyEWBEK5WfqqieVk45j8BY9lrRQI7weHl6pj6w6FbyUQWv6wIi1yBYMMDRF
         zDWg==
X-Gm-Message-State: ANhLgQ0F0oVsDqU7Q3k1jalPObZkkZIzevHTeb+whWtriGVxUthSNwi8
        MmhvBLBRvFTbHfNCB0dO7q8MNmauSYWPx8jS45wRAw==
X-Google-Smtp-Source: ADFU+vsiuvYkGOAcQrTLEN7AeDPDUJv6pbNL7GNXF8gjitkY112bG3MVqrYPV4cBnfMV0soJ5jlaDndiEYR2Ne48WyE=
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr16214330ybf.446.1585260566392;
 Thu, 26 Mar 2020 15:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200326070236.235835-1-walken@google.com> <20200326070236.235835-2-walken@google.com>
 <20200326175644.GN20941@ziepe.ca> <20200326180621.GK22483@bombadil.infradead.org>
 <20200326180916.GL22483@bombadil.infradead.org>
In-Reply-To: <20200326180916.GL22483@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 26 Mar 2020 15:09:13 -0700
Message-ID: <CANN689GNvU68nQUmR-NJg8To3-8w7f+Hu6s9jAW8ZeKV21JAbA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mmap locking API: initial implementation as rwsem wrappers
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think we strongly need an API for such assertions at this
point. There are actually a number of them (mostly the lockdep form)
being handled in the last patch renaming the mmap_sem field.

If a new form of lock is introduced in the future, it is doable to
implement it in such a way that lockdep assertions will work on it (I
have that working in my range locking patchset). For a range lock you
would probably want to add a new API anyway so that the assert can
verify that the specific range is locked, but IMO there is no strong
justification for new assertion APIs until we get there.

If there is no opposition to replacing rwsem_is_locked with
lockdep_assert_held, then I think that is workable. mmap_is_locked()
only has 5 call sites, so that's not a very large change.

On Thu, Mar 26, 2020 at 11:09 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Mar 26, 2020 at 11:06:21AM -0700, Matthew Wilcox wrote:
> > On Thu, Mar 26, 2020 at 02:56:44PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Mar 26, 2020 at 12:02:29AM -0700, Michel Lespinasse wrote:
> > >
> > > > +static inline bool mmap_is_locked(struct mm_struct *mm)
> > > > +{
> > > > + return rwsem_is_locked(&mm->mmap_sem) != 0;
> > > > +}
> > >
> > > I've been wondering if the various VM_BUG(rwsem_is_locked()) would be
> > > better as lockdep expressions? Certainly when lockdep is enabled it
> > > should be preferred, IMHO.
> > >
> > > So, I think if inlines are to be introduced this should be something
> > > similar to netdev's ASSERT_RTNL which seems to have worked well.
> > >
> > > Maybe ASSERT_MMAP_SEM_READ/WRITE/HELD() and do the VM_BUG or
> > > lockdep_is_held as appropriate?
> >
> > I'd rather see lockdep_assert_held() used directly rather than have
> > a wrapper.  This API includes options to check for it beind explicitly
> > held for read/write/any, which should be useful.
>
> ... oh, but that requires naming the lock, which we're trying to get
> away from.
>
> I guess we need a wrapper, but yes, by all means, let's level it up
> to put the VM_BUG_ON inside the wrapper, as that means we can get the
> mm dumped everywhere, rather than just the few places that have done
> VM_BUG_ON_MM instead of plain VM_BUG_ON.



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
