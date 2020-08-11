Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20DE20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVSv7U0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKTHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:07:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:07:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so14760459ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INpDWjNYGP9lfSOGCymtUET262GzdAuaS1/P3+r78GU=;
        b=uVSv7U0lqaY+MWDIFnGK/xEiH3pw+bUSNyy5HsA8O5NMrbaL9iEoPYgpr7QDo2CxdZ
         LYQGqb2+Jj17yXh09A30L+ACHf7ct1ljmoPYYv54336pCL8Loe+mcyuD12Imb/iPVlOM
         dLfoH5LCWIO4WNAlo0eV/DAT2z+zBdFoZIRYOi1ZNC1fJCy3XRicJtzlrMMreH7esT6O
         3W0cL0h1YX6em1CzYMRw+bz4A4ar1kPkSZAR3k9HVYFS4Gg0RThce7Sonw2KY94Ar716
         pY8G+bXyJmupNWBo1z93yooWgRMbnQtKgf7uBynCXq/0YtjHDAfQJkzktCOkPFYbg8WZ
         SJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INpDWjNYGP9lfSOGCymtUET262GzdAuaS1/P3+r78GU=;
        b=SSwjx0xl2tNhESNLomAzSq6ukBgX6V0AW7+YOcUN21fvHFRv5cc8EaBo8kX1EXWMgU
         ceqOFQBmih9rYHIbJi3vNXCMZHCjsTS2bGYRCyiEbGHrn74obncfW4Bdpbbu627Db2TP
         ROGhmNq2dpZ9qxKqRI9TraQGlWatmaRAHeSuvzYrVaAhaCTFxYV0UOKqJ+RPhL6+WUnx
         45w7N2aBTd5XbdgB4cft3IQ5x30kY+gdRoAlLDDzLFRHQIGCUmtbgP8+bEuKJxiIxHG8
         yvMZs5jmxGoUgFii3r0z41cjzkPQYJmRV7qD3fC+zmhrIRh4iZwqBG74GA5+/t1KTzR9
         XUAg==
X-Gm-Message-State: AOAM530S0wEd3aYmdQEzEJv9ne0jtxTNYWaOiRWQwBj1f5mdW/TM9ow6
        V9yP8o5kKdkCu13wTvEKjSB8yD+0YP3eal4Pv08BGQ==
X-Google-Smtp-Source: ABdhPJzMxJ9A4H4kP8Z09SXkhC7ilefcaFnvf1tkDqVFuCdc5ftEr5lDXxI1xWQ4uT4PJnGIgWvLnxjWIqxcAXz/pwo=
X-Received: by 2002:a2e:302:: with SMTP id 2mr3328448ljd.156.1597172864098;
 Tue, 11 Aug 2020 12:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com>
In-Reply-To: <20200811183950.10603-1-peterx@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Aug 2020 21:07:17 +0200
Message-ID: <CAG48ez0dJh=-J2RNcam4Q353Lq_ZT+kfkHzTKGgwCvea-eQLqg@mail.gmail.com>
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

On Tue, Aug 11, 2020 at 8:39 PM Peter Xu <peterx@redhat.com> wrote:
> Starting from commit 17839856fd58 ("gup: document and work around "COW can
> break either way" issue", 2020-06-02), explicit copy-on-write behavior is
> enforced for private gup pages even if it's a read-only.  It is achieved by
> always passing FOLL_WRITE to emulate a write.
>
> That should fix the COW issue that we were facing, however above commit could
> also break userfaultfd-wp and applications like umapsort [1,2].
>
> One general routine of umap-like program is: userspace library will manage page
> allocations, and it will evict the least recently used pages from memory to
> external storages (e.g., file systems).  Below are the general steps to evict
> an in-memory page in the uffd service thread when the page pool is full:
>
>   (1) UFFDIO_WRITEPROTECT with mode=WP on some to-be-evicted page P, so that
>       further writes to page P will block (keep page P clean)
>   (2) Copy page P to external storage (e.g. file system)
>   (3) MADV_DONTNEED to evict page P
>
> Here step (1) makes sure that the page to dump will always be up-to-date, so
> that the page snapshot in the file system is consistent with the one that was
> in the memory.  However with commit 17839856fd58, step (2) can potentially hang
> itself because e.g. if we use write() to a file system fd to dump the page
> data, that will be a translated read gup request in the file system driver to
> read the page content, then the read gup will be translated to a write gup due
> to the new enforced COW behavior.  This write gup will further trigger
> handle_userfault() and hang the uffd service thread itself.
>
> I think the problem will go away too if we replace the write() to the file
> system into a memory write to a mmaped region in the userspace library, because
> normal page faults will not enforce COW, only gup is affected.  However we
> cannot forbid users to use write() or any form of kernel level read gup.
>
> One solution is actually already mentioned in commit 17839856fd58, which is to
> provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
> use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
> "enfornced COW (read) request".
>
> With the enforced COW, we also need to inherit UFFD_WP bit during COW because
> now COW can happen with UFFD_WP enabled (previously, it cannot).
>
> Since at it, rename the variable in __handle_mm_fault() from "dirty" to "cow"
> to better suite its functionality.
[...]
> diff --git a/mm/memory.c b/mm/memory.c
[...]
> +                        * copied due to enfornced COW.  When it happens, we

(typo here and in the huge_memory version)

[...]
> diff --git a/mm/gup.c b/mm/gup.c
> index d8a33dd1430d..c33e84ab9c36 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -870,6 +870,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
>                 return -ENOENT;
>         if (*flags & FOLL_WRITE)
>                 fault_flags |= FAULT_FLAG_WRITE;
> +       if (*flags & FOLL_BREAK_COW)
> +               fault_flags |= FAULT_FLAG_BREAK_COW;
>         if (*flags & FOLL_REMOTE)
>                 fault_flags |= FAULT_FLAG_REMOTE;
>         if (locked)
> @@ -1076,7 +1078,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>                         }
>                         if (is_vm_hugetlb_page(vma)) {
>                                 if (should_force_cow_break(vma, foll_flags))
> -                                       foll_flags |= FOLL_WRITE;
> +                                       foll_flags |= FOLL_BREAK_COW;

How does this interact with the FOLL_WRITE check in follow_page_pte()?
If we want the COW to be broken, follow_page_pte() would have to treat
FOLL_BREAK_COW similarly to FOLL_WRITE, right?
