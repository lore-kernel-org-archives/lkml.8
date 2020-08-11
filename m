Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F2BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2A820781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7FSA5Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHKUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:03:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgHKUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jNptQhxyuodID2c61xEau00cpAGE8qA8J2RIxddJcM0=;
        b=C7FSA5UeCte8qBu1Y6Gxn2N+Tuw9TQKOHqACuLZL+Sa1VJTpNRchHOcR1LRW7uO/Qu3VRz
        4KRxs1uZc1Uc6XtIBioz68yUBnd2TwTJAF+OvjTGQriHX9OjibHKoD+NsQhl4rgjYp3Nys
        FcCeowC1ZwOtJ8v4nmt+yAqd03L9l+4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-fIf977bjMd67zixRZ4QAIw-1; Tue, 11 Aug 2020 16:02:59 -0400
X-MC-Unique: fIf977bjMd67zixRZ4QAIw-1
Received: by mail-qt1-f199.google.com with SMTP id r24so10652379qtu.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNptQhxyuodID2c61xEau00cpAGE8qA8J2RIxddJcM0=;
        b=c3T2fI/sgbsLVHxpuTeaFV5p3+s1R/RqqTbfVfTy3+rwFOxWlGL808+6O7/SQ3mKE/
         n7GG2iThu84jbNP/ur60jJ7dB9dVtimJyLZhP02IQCxguzLGlBKkhxdUIILen24ub/V8
         n6BLpVQnvg76Fkk/BZusagwl7rbsA/k7uxXsstDwyEjDVngcciHA0dPjupz34bs/pVbc
         FKSvhk2PWzDI+og579tw5dEKWQQbDs90ACFAJt/S7BIJfFpZpEz5WE/KHdwNjdeqoybP
         oZjELOBw9Ti0hQWxQYujuDs4O4dJ6rmu13ImR3yJBzETylZ62/QPIpCImLYTBhpqyWQw
         zvMA==
X-Gm-Message-State: AOAM530LTPNW+99mSKARPaMeXj3W56yW/dV8OGcmDQcaTbBkvnMTIVsQ
        FMshsmxo+vMdfDJ5i2z1FfeCjA9XuoR3DVAMncY6bx6m8q5VEo+MEJz8HzZ5BwM+PrZX+8HHCvk
        6zAx9oqLYAwFc8DSLsr0P2Au3
X-Received: by 2002:ad4:438e:: with SMTP id s14mr3094784qvr.18.1597176178942;
        Tue, 11 Aug 2020 13:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI0IGhFUZG7V4UiixOy1/PB6mY5Rqwr4p0YouLirqRFRy/mbq4l43/heNwgpaVqklKCfBMKQ==
X-Received: by 2002:ad4:438e:: with SMTP id s14mr3094753qvr.18.1597176178618;
        Tue, 11 Aug 2020 13:02:58 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id z197sm18466855qkb.66.2020.08.11.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:02:57 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:02:56 -0400
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
Message-ID: <20200811200256.GC6353@xz-x1>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAG48ez0dJh=-J2RNcam4Q353Lq_ZT+kfkHzTKGgwCvea-eQLqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0dJh=-J2RNcam4Q353Lq_ZT+kfkHzTKGgwCvea-eQLqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:07:17PM +0200, Jann Horn wrote:
> On Tue, Aug 11, 2020 at 8:39 PM Peter Xu <peterx@redhat.com> wrote:
> > Starting from commit 17839856fd58 ("gup: document and work around "COW can
> > break either way" issue", 2020-06-02), explicit copy-on-write behavior is
> > enforced for private gup pages even if it's a read-only.  It is achieved by
> > always passing FOLL_WRITE to emulate a write.
> >
> > That should fix the COW issue that we were facing, however above commit could
> > also break userfaultfd-wp and applications like umapsort [1,2].
> >
> > One general routine of umap-like program is: userspace library will manage page
> > allocations, and it will evict the least recently used pages from memory to
> > external storages (e.g., file systems).  Below are the general steps to evict
> > an in-memory page in the uffd service thread when the page pool is full:
> >
> >   (1) UFFDIO_WRITEPROTECT with mode=WP on some to-be-evicted page P, so that
> >       further writes to page P will block (keep page P clean)
> >   (2) Copy page P to external storage (e.g. file system)
> >   (3) MADV_DONTNEED to evict page P
> >
> > Here step (1) makes sure that the page to dump will always be up-to-date, so
> > that the page snapshot in the file system is consistent with the one that was
> > in the memory.  However with commit 17839856fd58, step (2) can potentially hang
> > itself because e.g. if we use write() to a file system fd to dump the page
> > data, that will be a translated read gup request in the file system driver to
> > read the page content, then the read gup will be translated to a write gup due
> > to the new enforced COW behavior.  This write gup will further trigger
> > handle_userfault() and hang the uffd service thread itself.
> >
> > I think the problem will go away too if we replace the write() to the file
> > system into a memory write to a mmaped region in the userspace library, because
> > normal page faults will not enforce COW, only gup is affected.  However we
> > cannot forbid users to use write() or any form of kernel level read gup.
> >
> > One solution is actually already mentioned in commit 17839856fd58, which is to
> > provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> > use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> > "enfornced COW (read) request".
> >
> > With the enforced COW, we also need to inherit UFFD_WP bit during COW because
> > now COW can happen with UFFD_WP enabled (previously, it cannot).
> >
> > Since at it, rename the variable in __handle_mm_fault() from "dirty" to "cow"
> > to better suite its functionality.
> [...]
> > diff --git a/mm/memory.c b/mm/memory.c
> [...]
> > +                        * copied due to enfornced COW.  When it happens, we
> 
> (typo here and in the huge_memory version)

Right..

> 
> [...]
> > diff --git a/mm/gup.c b/mm/gup.c
> > index d8a33dd1430d..c33e84ab9c36 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -870,6 +870,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
> >                 return -ENOENT;
> >         if (*flags & FOLL_WRITE)
> >                 fault_flags |= FAULT_FLAG_WRITE;
> > +       if (*flags & FOLL_BREAK_COW)
> > +               fault_flags |= FAULT_FLAG_BREAK_COW;
> >         if (*flags & FOLL_REMOTE)
> >                 fault_flags |= FAULT_FLAG_REMOTE;
> >         if (locked)
> > @@ -1076,7 +1078,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >                         }
> >                         if (is_vm_hugetlb_page(vma)) {
> >                                 if (should_force_cow_break(vma, foll_flags))
> > -                                       foll_flags |= FOLL_WRITE;
> > +                                       foll_flags |= FOLL_BREAK_COW;
> 
> How does this interact with the FOLL_WRITE check in follow_page_pte()?
> If we want the COW to be broken, follow_page_pte() would have to treat
> FOLL_BREAK_COW similarly to FOLL_WRITE, right?

Good point...  I did checked follow_page_mask() that FOLL_COW will still be set
correctly after applying the patch, though I forgot the FOLL_WRITE part.

Does below look good to you?

diff --git a/mm/gup.c b/mm/gup.c
index 9d1f44b01165..f4f2a69c6fe7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -439,7 +439,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
        }
        if ((flags & FOLL_NUMA) && pte_protnone(pte))
                goto no_page;
-       if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+       if ((flags & (FOLL_WRITE | FOLL_BREAK_COW)) &&
+           !can_follow_write_pte(pte, flags)) {
                pte_unmap_unlock(ptep, ptl);
                return NULL;
        }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f192efef37c..edbd42c9d576 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1340,7 +1340,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
        assert_spin_locked(pmd_lockptr(mm, pmd));
 
-       if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+       if (flags & (FOLL_WRITE | FOLL_BREAK_COW) &&
+           !can_follow_write_pmd(*pmd, flags))
                goto out;
 
        /* Avoid dumping huge zero page */

Thanks,

-- 
Peter Xu

