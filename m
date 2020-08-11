Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C4F20781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8MVtPki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHKUW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:22:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:22:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so14945460ljn.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bh3tCy5UzgI4hQR8udwn4/1GBwUl6KXhMVaKpXn0iLY=;
        b=i8MVtPkiUCuiMoyvBYw7XzvcVsI2ERUjqfP+uqpfkqtyTOtj6Ulvx7Oq8r3ZC/hrxq
         Pfbi8rJQcbAVvRVyPO3JYB7lDbGLW64Nphq7TSh2FHvRtesGXNOWg1NNddYvhnL+X0iB
         o9YI/6/mPkm3uh8VkBRMWeYUr9fPmnQJS/hd6ctQ91vWlBzGQlKn/NNfKUanD9Tj9N81
         ygKGN/gns34+8KRKJl32fmyR/YHnMHz5x0P7LHCBuDgx+xUDC4NGvUwzkHjb2p5cz5T8
         l3rwACP/ybYsQhkKMYOfPf80zbUqu8rOk+aKmM0GAHqC3po/81KHQM8fsXMDQ/VPx6zk
         /TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh3tCy5UzgI4hQR8udwn4/1GBwUl6KXhMVaKpXn0iLY=;
        b=TW1QUR3j4dXOW1+apk5d1POMwlZROzmEyxbsOX3bg9eQ/Sge0DkrhafNnNx7LohfWV
         Pgw47xP9El61zMA1pZ8bSwCYC9XBUao0iSaH6JUjWz+B68Z7v1afSixi+6bkEBY4s2UX
         qwbDa1GBZ47e6lN9FpPyJ3btDcuhn47gWdSDiB392wYFllXQuFonxfUo1i6fpI8o1gWO
         9/rGzwFbl5C7qJUhyKG8zvSe23kfpBcZ+fgG7VpldQG55QXMsK0/dUJ7cO/YRka//8U5
         vKU5z6Q0OYNTIK1DunWkDZxXn3PfTqCF1pefSaD8sH1pHwtWqaaLH7nFboyU1aVyWuqM
         EWWQ==
X-Gm-Message-State: AOAM5300mgs94FeIoBEWcXcMi37EVDXqyai40bt5FT4mhoKCgo9Hx08u
        MiJQPqjv/Wysz78xLNaXdrOSJ5HBbW0ydPfo1q8rFQ==
X-Google-Smtp-Source: ABdhPJzB/6YXytH12zKFc7VZOn2d0j9gU4iNZzEUMWpNu6GshGyjAxK+yylGj8UjV5x3jjvFPVXNbMoXHOnE4RVAvc8=
X-Received: by 2002:a2e:9852:: with SMTP id e18mr3771188ljj.415.1597177346517;
 Tue, 11 Aug 2020 13:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAG48ez0dJh=-J2RNcam4Q353Lq_ZT+kfkHzTKGgwCvea-eQLqg@mail.gmail.com>
 <20200811200256.GC6353@xz-x1>
In-Reply-To: <20200811200256.GC6353@xz-x1>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Aug 2020 22:22:00 +0200
Message-ID: <CAG48ez1w5HZxUNPGEsDfLGFCoA-Knpr4jvAAtZMDyEsts6Hyng@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:03 PM Peter Xu <peterx@redhat.com> wrote:
> On Tue, Aug 11, 2020 at 09:07:17PM +0200, Jann Horn wrote:
> > On Tue, Aug 11, 2020 at 8:39 PM Peter Xu <peterx@redhat.com> wrote:
> > > Starting from commit 17839856fd58 ("gup: document and work around "COW can
> > > break either way" issue", 2020-06-02), explicit copy-on-write behavior is
> > > enforced for private gup pages even if it's a read-only.  It is achieved by
> > > always passing FOLL_WRITE to emulate a write.
> > >
> > > That should fix the COW issue that we were facing, however above commit could
> > > also break userfaultfd-wp and applications like umapsort [1,2].
> > >
> > > One general routine of umap-like program is: userspace library will manage page
> > > allocations, and it will evict the least recently used pages from memory to
> > > external storages (e.g., file systems).  Below are the general steps to evict
> > > an in-memory page in the uffd service thread when the page pool is full:
> > >
> > >   (1) UFFDIO_WRITEPROTECT with mode=WP on some to-be-evicted page P, so that
> > >       further writes to page P will block (keep page P clean)
> > >   (2) Copy page P to external storage (e.g. file system)
> > >   (3) MADV_DONTNEED to evict page P
> > >
> > > Here step (1) makes sure that the page to dump will always be up-to-date, so
> > > that the page snapshot in the file system is consistent with the one that was
> > > in the memory.  However with commit 17839856fd58, step (2) can potentially hang
> > > itself because e.g. if we use write() to a file system fd to dump the page
> > > data, that will be a translated read gup request in the file system driver to
> > > read the page content, then the read gup will be translated to a write gup due
> > > to the new enforced COW behavior.  This write gup will further trigger
> > > handle_userfault() and hang the uffd service thread itself.
> > >
> > > I think the problem will go away too if we replace the write() to the file
> > > system into a memory write to a mmaped region in the userspace library, because
> > > normal page faults will not enforce COW, only gup is affected.  However we
> > > cannot forbid users to use write() or any form of kernel level read gup.
> > >
> > > One solution is actually already mentioned in commit 17839856fd58, which is to
> > > provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> > > use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> > > "enfornced COW (read) request".
> > >
> > > With the enforced COW, we also need to inherit UFFD_WP bit during COW because
> > > now COW can happen with UFFD_WP enabled (previously, it cannot).
[...]
> > > @@ -1076,7 +1078,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> > >                         }
> > >                         if (is_vm_hugetlb_page(vma)) {
> > >                                 if (should_force_cow_break(vma, foll_flags))
> > > -                                       foll_flags |= FOLL_WRITE;
> > > +                                       foll_flags |= FOLL_BREAK_COW;
> >
> > How does this interact with the FOLL_WRITE check in follow_page_pte()?
> > If we want the COW to be broken, follow_page_pte() would have to treat
> > FOLL_BREAK_COW similarly to FOLL_WRITE, right?
>
> Good point...  I did checked follow_page_mask() that FOLL_COW will still be set
> correctly after applying the patch, though I forgot the FOLL_WRITE part.
>
> Does below look good to you?
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 9d1f44b01165..f4f2a69c6fe7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -439,7 +439,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>         }
>         if ((flags & FOLL_NUMA) && pte_protnone(pte))
>                 goto no_page;
> -       if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
> +       if ((flags & (FOLL_WRITE | FOLL_BREAK_COW)) &&
> +           !can_follow_write_pte(pte, flags)) {
>                 pte_unmap_unlock(ptep, ptl);
>                 return NULL;
>         }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f192efef37c..edbd42c9d576 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1340,7 +1340,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>
>         assert_spin_locked(pmd_lockptr(mm, pmd));
>
> -       if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
> +       if (flags & (FOLL_WRITE | FOLL_BREAK_COW) &&
> +           !can_follow_write_pmd(*pmd, flags))
>                 goto out;
>
>         /* Avoid dumping huge zero page */

Well, I don't see anything immediately wrong with it, at least. Not
that that means much...

Although in addition to the normal-page path and the transhuge path,
you'll probably also have to make the same change in the hugetlb path.
I guess you may have to grep through all the uses of FOLL_WRITE, as
Linus suggested, to see if there are any other missing spots.
