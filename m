Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85420C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D72D208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiCg8nGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaJ7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgHaJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:59:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:59:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y2so1777786lfy.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZDyp3YFdZVXnA9zj6mRLZpFoGXWq1/L5Ulr34SDMq8=;
        b=MiCg8nGNu+VfRhhFOU9X80Cr5JC543609Dm9tZTKSV9EPB7lbHdjYy+mZmTeKEK1Y0
         IAJC3QAvNhIsPISdtlGUw354JQEqtc2twkuBAayVXouk+89vdhxLS1SsWVB1enKdFSlR
         7XfL96NmruikjoIXZqzB8yUgnrypzUjwl4TCAzmZa2f87dtQR2Et2IyDuQrkVfcKEInv
         hEpf5Kl4prHCKP+4kj+JlGSlpkG1ncz3GziIvcyAuhs4YWkLXScfhylVDFyxa9hOPGj5
         4G0ydKIWryQ82+G02rYSXDaq7FhjTDISKfG1MMa1ILYwNXMDxEqwP610qxcRboNv9Bc/
         s+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZDyp3YFdZVXnA9zj6mRLZpFoGXWq1/L5Ulr34SDMq8=;
        b=pfqBKQqo6y2Wd4CZJe0wtD/hJ1PVLs8bMFg8aMf4L08sAoN9hIRoFTokIOji9udmvC
         vnHCRT/gYbUNttia514+M0BL01ojSiRhs8bIeIU+wi+xCdhjrt3kY13ZlxK9WmVTBNOu
         MoSDHkDPm/79wLq8GvmPy2/5H/1a95qY11OzK1BVgSEtCtKkE4Y8dfxnVg2P6OU5tXMH
         A4av7FQW6XY0o4zvI3Pdb24yqihiypHg1f4rsE3aKhL8/lm6V79uRRdsIOoJl6za5arc
         bWWU3pKHgp3chGvt1eupwANgixpdRSkT+ogvKex8zK+lJhN8ZoczUcCJ3aCv7uema0m9
         dT+Q==
X-Gm-Message-State: AOAM533ECM3gbBwvkIOE5HBziL0VUZ8N6NAx6ambEe4YfLoGEs4NVt2c
        eV20e+xdyRuRj12uf6g+HRjCDphcG/n/VbdxoeQXycYAdQPmQQ==
X-Google-Smtp-Source: ABdhPJym3Z3hy4cI8cw/qwa/lo6GDiRMgx9UkTYrxhh31+i4hUGC0KkoOCXy0vNAWH1pJhx9kxIon0J+y619jkiozbY=
X-Received: by 2002:ac2:5298:: with SMTP id q24mr334931lfm.164.1598867953047;
 Mon, 31 Aug 2020 02:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com>
 <alpine.LSU.2.11.2008302225510.1934@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008302225510.1934@eggly.anvils>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Aug 2020 11:58:47 +0200
Message-ID: <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid() hack
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 8:07 AM Hugh Dickins <hughd@google.com> wrote:
> On Thu, 27 Aug 2020, Jann Horn wrote:
>
> > The preceding patches have ensured that core dumping properly takes the
> > mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
> > its users.
>
> Hi Jann, while the only tears to be shed over losing mmget_still_valid()
> will be tears of joy, I think you need to explain why you believe it's
> safe to remove the instance in mm/khugepaged.c: which you'll have found
> I moved just recently, to cover an extra case (sorry for not Cc'ing you).
>
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
> >
> >  static inline int khugepaged_test_exit(struct mm_struct *mm)
> >  {
> > -     return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
> > +     return atomic_read(&mm->mm_users) == 0;
> >  }
> >
> >  static bool hugepage_vma_check(struct vm_area_struct *vma,
>
> The movement (which you have correctly followed) was in
> bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
> but the "pmd .. physical page 0" issue is explained better in its parent
> 18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")
>
> I think your core dumping is still reading the page tables without
> holding mmap_lock

Where? get_dump_page() takes mmap_lock now:
<https://lore.kernel.org/lkml/20200827114932.3572699-7-jannh@google.com/>

I don't think there should be any paths into __get_user_pages() left
that don't hold the mmap_lock. Actually, we should probably try
sticking mmap_assert_locked() in there now as a follow-up?

> so still vulnerable to that extra issue.  It won't
> be as satisfying as removing all traces of mmget_still_valid(), but
> right now I think you should add an mm->core_state check there instead.
>
> (I do have a better solution in use, but it's a much larger patch, that
> will take a lot more effort to get in: checks in pte_offset_map_lock(),
> perhaps returning NULL when pmd is transitioning, requiring retry.)

Just to clarify: This is an issue only between GUP's software page
table walks when running without mmap_lock and concurrent page table
modifications from hugepage code, correct? Hardware page table walks
and get_user_pages_fast() are fine because they properly load PTEs
atomically and are written to assume that the page tables can change
arbitrarily under them, and the only guarantee is that disabling
interrupts ensures that pages referenced by PTEs can't be freed,
right?

> Or maybe it's me who has missed what you're doing instead.
>
> Hugh
