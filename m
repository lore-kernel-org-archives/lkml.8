Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF029206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkctowPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHKVXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:23:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgHKVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597181030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6z1vHuJOvjpnFLCUTJl63b/aAkybtG4+Mbh9hm5Rsk=;
        b=AkctowPpKQP61xTh1HFummwRxmQb5o94Og9yEK99PrpcXCyN3a+VTi9Vo39sO+LSlB1Q6L
        Xjq7I0SnO/pdq1WjhzW7YybpIITz/5de/xdiOK6WHL14RAP03TBVFXQYCUc1dhvdoIaxMI
        pd9oKKHcG32kbcXkzB0Jl9nrYKXAoGc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-qremSwMnMyyuJRBkD0jl6Q-1; Tue, 11 Aug 2020 17:23:48 -0400
X-MC-Unique: qremSwMnMyyuJRBkD0jl6Q-1
Received: by mail-qv1-f70.google.com with SMTP id l18so10555758qvq.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6z1vHuJOvjpnFLCUTJl63b/aAkybtG4+Mbh9hm5Rsk=;
        b=gJkVb5nOzktXldDlGU6+kFd0Uh9cn02zwlaFk5Z/t1gFLFFgw5abovwbJTJi3kPaJ6
         ROn3Eyos5+kmjda1nXTdRybvQyHhYCa4aQGvz4gjt3HpPf2kpJSR4n0KBHO9ZykZ/ixv
         mDc3gH7fTesRbQkMMQbKhc82RcELVdg6R6CKYKCPSGeXj3NZF3dAufMTaHniwNI+H/F5
         jfvVmoiPa9JO7SOVIKrgvvUXyGoytnNlp+bFg0HYcyOugYMbqHi8wW9RIbm8LgM7jDhk
         9Ryfj615lRJSJ2O1GrTsc9/HZnIj2qBKJCR+eaLb/akW+lav2FiBWcC43Hh1xUAqRTIJ
         cP3A==
X-Gm-Message-State: AOAM533yqEJ7ba0Y0qWxEIy/szfNStjJwA2wdDBW9eUBZivDbZuk6itp
        1iGCHHq7NGxjmr/Ko/gaPdCY5JqoU9iu5E07CypQT5EoCXTew0BjlIHsN6FDdX9cUtFJH2Umw++
        j8D6UvcPNQHzv00IGYBgZ9/EP
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr3165239qkk.205.1597181028222;
        Tue, 11 Aug 2020 14:23:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4azdTX11/G2/Mcb6L23xIFk+cVBW364WU9IrApUJARrd8X5lfsWug3kFeSqX6zf1EY+TJfQ==
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr3165208qkk.205.1597181027753;
        Tue, 11 Aug 2020 14:23:47 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 20sm24028qtp.53.2020.08.11.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:23:46 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:23:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200811212345.GD6353@xz-x1>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAG48ez0dJh=-J2RNcam4Q353Lq_ZT+kfkHzTKGgwCvea-eQLqg@mail.gmail.com>
 <20200811200256.GC6353@xz-x1>
 <CAG48ez1w5HZxUNPGEsDfLGFCoA-Knpr4jvAAtZMDyEsts6Hyng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1w5HZxUNPGEsDfLGFCoA-Knpr4jvAAtZMDyEsts6Hyng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:22:00PM +0200, Jann Horn wrote:
> On Tue, Aug 11, 2020 at 10:03 PM Peter Xu <peterx@redhat.com> wrote:
> > On Tue, Aug 11, 2020 at 09:07:17PM +0200, Jann Horn wrote:
> > > On Tue, Aug 11, 2020 at 8:39 PM Peter Xu <peterx@redhat.com> wrote:
> > > > Starting from commit 17839856fd58 ("gup: document and work around "COW can
> > > > break either way" issue", 2020-06-02), explicit copy-on-write behavior is
> > > > enforced for private gup pages even if it's a read-only.  It is achieved by
> > > > always passing FOLL_WRITE to emulate a write.
> > > >
> > > > That should fix the COW issue that we were facing, however above commit could
> > > > also break userfaultfd-wp and applications like umapsort [1,2].
> > > >
> > > > One general routine of umap-like program is: userspace library will manage page
> > > > allocations, and it will evict the least recently used pages from memory to
> > > > external storages (e.g., file systems).  Below are the general steps to evict
> > > > an in-memory page in the uffd service thread when the page pool is full:
> > > >
> > > >   (1) UFFDIO_WRITEPROTECT with mode=WP on some to-be-evicted page P, so that
> > > >       further writes to page P will block (keep page P clean)
> > > >   (2) Copy page P to external storage (e.g. file system)
> > > >   (3) MADV_DONTNEED to evict page P
> > > >
> > > > Here step (1) makes sure that the page to dump will always be up-to-date, so
> > > > that the page snapshot in the file system is consistent with the one that was
> > > > in the memory.  However with commit 17839856fd58, step (2) can potentially hang
> > > > itself because e.g. if we use write() to a file system fd to dump the page
> > > > data, that will be a translated read gup request in the file system driver to
> > > > read the page content, then the read gup will be translated to a write gup due
> > > > to the new enforced COW behavior.  This write gup will further trigger
> > > > handle_userfault() and hang the uffd service thread itself.
> > > >
> > > > I think the problem will go away too if we replace the write() to the file
> > > > system into a memory write to a mmaped region in the userspace library, because
> > > > normal page faults will not enforce COW, only gup is affected.  However we
> > > > cannot forbid users to use write() or any form of kernel level read gup.
> > > >
> > > > One solution is actually already mentioned in commit 17839856fd58, which is to
> > > > provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> > > > use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> > > > "enfornced COW (read) request".
> > > >
> > > > With the enforced COW, we also need to inherit UFFD_WP bit during COW because
> > > > now COW can happen with UFFD_WP enabled (previously, it cannot).
> [...]
> > > > @@ -1076,7 +1078,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> > > >                         }
> > > >                         if (is_vm_hugetlb_page(vma)) {
> > > >                                 if (should_force_cow_break(vma, foll_flags))
> > > > -                                       foll_flags |= FOLL_WRITE;
> > > > +                                       foll_flags |= FOLL_BREAK_COW;
> > >
> > > How does this interact with the FOLL_WRITE check in follow_page_pte()?
> > > If we want the COW to be broken, follow_page_pte() would have to treat
> > > FOLL_BREAK_COW similarly to FOLL_WRITE, right?
> >
> > Good point...  I did checked follow_page_mask() that FOLL_COW will still be set
> > correctly after applying the patch, though I forgot the FOLL_WRITE part.
> >
> > Does below look good to you?
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 9d1f44b01165..f4f2a69c6fe7 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -439,7 +439,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
> >         }
> >         if ((flags & FOLL_NUMA) && pte_protnone(pte))
> >                 goto no_page;
> > -       if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
> > +       if ((flags & (FOLL_WRITE | FOLL_BREAK_COW)) &&
> > +           !can_follow_write_pte(pte, flags)) {
> >                 pte_unmap_unlock(ptep, ptl);
> >                 return NULL;
> >         }
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 4f192efef37c..edbd42c9d576 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1340,7 +1340,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
> >
> >         assert_spin_locked(pmd_lockptr(mm, pmd));
> >
> > -       if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
> > +       if (flags & (FOLL_WRITE | FOLL_BREAK_COW) &&
> > +           !can_follow_write_pmd(*pmd, flags))
> >                 goto out;
> >
> >         /* Avoid dumping huge zero page */
> 
> Well, I don't see anything immediately wrong with it, at least. Not
> that that means much...
> 
> Although in addition to the normal-page path and the transhuge path,
> you'll probably also have to make the same change in the hugetlb path.
> I guess you may have to grep through all the uses of FOLL_WRITE, as
> Linus suggested, to see if there are any other missing spots.

Right.  Moreover, I feel like the enforced cow is not completely done in
hugetlbfs code even without this patch.  E.g., it lacks the proper return of
VM_FAULT_WRITE in hugetlb_cow(), and also the further convertion logics to
translate that into FOLL_COW (which, iiuc, should probably be done in
follow_hugetlb_page()).

I quickly went over the other FOLL_WRITE references and I didn't see any other
suspicious spots besides hugetlb (I only looked at the places that can be
called by __get_user_pages() though; that's the only place we set
FOLL_BREAK_COW after all).  At the meantime we ignored the fast gups for strict
breaking of cow always, so those ones seem ok too.

Thanks,

-- 
Peter Xu

