Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283EFC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C2C20737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGpjzi6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgDATqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:46:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38076 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgDATqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:46:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5so1361521edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDYFWwG5flntp97b88on6sYpgUC/rxAqQ/L1X05Q2Y8=;
        b=dGpjzi6GwvvCec51TnXDdpXd+0m3oIiwIijO/19xa9UypRtXpTCzMhD7eM+fXIuGtv
         dFBrg/oyRNH1N9k7vZotCedcwdg7ILb36lEfL4CNo6ixsljQRQAtNEvwncd3D8VkP5Pz
         Ay5i4z20Xz3sL079o1Fp/91T59OT5lMz6ZLC1AIJOeETeBIKZ/bMZ+rzzwDQ08LXZ9Xh
         +lC7TC7zPU4KcfkjC9mWroB/JNf8Ow62X4ilmapc6T/oj8293D/rKJD4jDEhNWqk185R
         VL4vpAZN55wY2jFCuFmuo/kK43Qi5y6pHKu+lBeJ+49i0afGTNULd9mWgGkD+v0PdjND
         bF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDYFWwG5flntp97b88on6sYpgUC/rxAqQ/L1X05Q2Y8=;
        b=aXz5yCnEVE8FF9OyzaqZgSu9nXuXPkIRdO+hYcIp4rRyevwsEHcfwsvzzIYPRJv6xT
         ffvlNncKpw+VzrNQ8lTsAug9/fy2Duw5CY4+esBXcNDK+J/QGqtTgSte/DhrU3y/Ksbc
         NDdqvI0vxelqFqQ7lRT7C0ZIG/JEvTdg6/0yea/cFruFLmu9SvW8UwYSskNAYftAtYew
         0PxlvvD9W9VzF4KXzH+K8FnfzweLs1si4bQS6NNnAlZFt+xD0Cp983kwpsbBYbbK8SO9
         HmWYe60J4n4CB9gLE7XXq/CdW88IUWHNRQhlz0rZiyKq7+DZrKBS2VRqH5uF0IKg2q4o
         M+hA==
X-Gm-Message-State: ANhLgQ0iqqhtRK2MTP1l4TfofuRi/GBvI2qZOr0kbmW5MBQ/fUA7rGk1
        4h9Ke2gT5S0SalgIKMqxmqHMGU7qwf0lPmF6lQUJoQ==
X-Google-Smtp-Source: ADFU+vtFmg+PUX6cVJUPBUJt7yTxhmxMXZBBAh3pFjqIqgMHIsreksLL/Wt7u6Z4D0jOXbmRQ68BJHXIiaU2OQ3l/9A=
X-Received: by 2002:a05:6402:1c8f:: with SMTP id cy15mr18161415edb.200.1585770370445;
 Wed, 01 Apr 2020 12:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box> <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
 <20200328123336.givyrh5hsscg5cpx@box> <CAHbLzkqU1Aoo+SS3H=i6etT9Njfjk017M3vyCLeTptmGGFGRXw@mail.gmail.com>
 <20200331140828.zv6ssffwys25d2t4@box>
In-Reply-To: <20200331140828.zv6ssffwys25d2t4@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Apr 2020 12:45:58 -0700
Message-ID: <CAHbLzkrxOo7LWKBbaTee5QijoM4Ykv44R8aoSjoA=9noorG0vg@mail.gmail.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 7:08 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Mar 30, 2020 at 11:50:41AM -0700, Yang Shi wrote:
> > On Sat, Mar 28, 2020 at 5:33 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Fri, Mar 27, 2020 at 09:17:00PM -0400, Zi Yan wrote:
> > > > > The compound page may be locked here if the function called for the first
> > > > > time for the page and not locked after that (becouse we've unlocked it we
> > > > > saw it the first time). The same with LRU.
> > > > >
> > > >
> > > > For the first time, the compound page is locked and not on LRU, so this VM_BUG_ON passes.
> > > > For the second time and so on, the compound page is unlocked and on the LRU,
> > > > so this VM_BUG_ON still passes.
> > > >
> > > > For base page, VM_BUG_ON passes.
> > > >
> > > > Other unexpected situation (a compound page is locked and on LRU) triggers the VM_BU_ON,
> > > > but your VM_BUG_ON will not detect this situation, right?
> > >
> > > Right. I will rework this code. I've just realized it is racy: after
> > > unlock and putback on LRU the page can be locked by somebody else and this
> > > code can unlock it which completely borken.
> > >
> > > I'll pass down compound_pagelist to release_pte_pages() and handle the
> > > situation there.
> > >
> > > > >>>     if (likely(writable)) {
> > > > >>>             if (likely(referenced)) {
> > > > >>
> > > > >> Do we need a list here? There should be at most one compound page we will see here, right?
> > > > >
> > > > > Um? It's outside the pte loop. We get here once per PMD range.
> > > > >
> > > > > 'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:
> > > > > it's just the last page handled in the loop.
> > > > >
> > > >
> > > > Throughout the pte loop, we should only see at most one compound page, right?
> > >
> > > No. mremap(2) opens a possibility for HPAGE_PMD_NR compound pages for
> > > single PMD range.
> >
> > Do you mean every PTE in the PMD is mapped by a sub page from different THPs?
>
> Yes.
>
> Well, it was harder to archive than I expected, but below is a test case,
> I've come up with. It maps 512 head pages within single PMD range.

Thanks, this is very helpful.

>
> diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
> index 3a98d5b2d6d8..9ae119234a39 100644
> --- a/tools/testing/selftests/vm/khugepaged.c
> +++ b/tools/testing/selftests/vm/khugepaged.c
> @@ -703,6 +703,63 @@ static void collapse_full_of_compound(void)
>         munmap(p, hpage_pmd_size);
>  }
>
> +static void collapse_compound_extreme(void)
> +{
> +       void *p;
> +       int i;
> +
> +       p = alloc_mapping();
> +       for (i = 0; i < hpage_pmd_nr; i++) {
> +               printf("\rConstruct PTE page table full of different PTE-mapped compound pages %3d/%d...",
> +                               i + 1, hpage_pmd_nr);
> +
> +               madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
> +               fill_memory(BASE_ADDR, 0, hpage_pmd_size);
> +               if (!check_huge(BASE_ADDR)) {
> +                       printf("Failed to allocate huge page\n");
> +                       exit(EXIT_FAILURE);
> +               }
> +               madvise(BASE_ADDR, hpage_pmd_size, MADV_NOHUGEPAGE);
> +
> +               p = mremap(BASE_ADDR - i * page_size,
> +                               i * page_size + hpage_pmd_size,
> +                               (i + 1) * page_size,
> +                               MREMAP_MAYMOVE | MREMAP_FIXED,
> +                               BASE_ADDR + 2 * hpage_pmd_size);
> +               if (p == MAP_FAILED) {
> +                       perror("mremap+unmap");
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               p = mremap(BASE_ADDR + 2 * hpage_pmd_size,
> +                               (i + 1) * page_size,
> +                               (i + 1) * page_size + hpage_pmd_size,
> +                               MREMAP_MAYMOVE | MREMAP_FIXED,
> +                               BASE_ADDR - (i + 1) * page_size);
> +               if (p == MAP_FAILED) {
> +                       perror("mremap+alloc");
> +                       exit(EXIT_FAILURE);
> +               }
> +       }
> +
> +       munmap(BASE_ADDR, hpage_pmd_size);
> +       fill_memory(p, 0, hpage_pmd_size);
> +       if (!check_huge(p))
> +               success("OK");
> +       else
> +               fail("Fail");
> +
> +       if (wait_for_scan("Collapse PTE table full of different compound pages", p))
> +               fail("Timeout");
> +       else if (check_huge(p))
> +               success("OK");
> +       else
> +               fail("Fail");
> +
> +       validate_memory(p, 0, hpage_pmd_size);
> +       munmap(p, hpage_pmd_size);
> +}
> +
>  static void collapse_fork(void)
>  {
>         int wstatus;
> @@ -916,6 +973,7 @@ int main(void)
>         collapse_max_ptes_swap();
>         collapse_signle_pte_entry_compound();
>         collapse_full_of_compound();
> +       collapse_compound_extreme();
>         collapse_fork();
>         collapse_fork_compound();
>         collapse_max_ptes_shared();
> --
>  Kirill A. Shutemov
