Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E45C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAFA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKSiivlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC3Sl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:41:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43804 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgC3Sl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:41:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so21977471edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82V2uiPsUi/5h2Z1obVyGYc68C87qoYt95tk3QJZeQc=;
        b=FKSiivlFGGLxFugSuEF2WX8g4AFNohF4Go4nX5riJP4GbsCOoKGmNMm4OlgdyqzU7s
         qglZ7MRKIuIAF+SVGzkGuXJhfPzZfc0am3r0uedhhkA08rS09+ltmyVSZuZQtYOWz0BE
         mIBlIXE8f9y06jv1ClIkCFe/r/xKMJ4z5XrdDzLVsHgDciPhu8UxFJxoB8NqMAvOQ5a6
         tBEzBdy+qM9TSdk7xhqhvz4ZJKTpc60TU2qyHR9CSAyqm+xgApdtzbT56CLg8Jg9Um8K
         YzUdgA4PhKnGaBbKTzl7raIJOo1Um6eGQskJ/er4RacA8ZPJdJePOEmlAN86CQrv9B3S
         APtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82V2uiPsUi/5h2Z1obVyGYc68C87qoYt95tk3QJZeQc=;
        b=iJN4k2uUbvmVWIGEJk6482sGWhmhGA9oEsTd1PmSCiyTeqELc+e8fZyoXQzccD0GEz
         SQ8rSdCzfklu0LhrUWXQP5h5eeL+zlB6/166B10CvzihyKspEs1RN4LkHdtrQ0kD/ELr
         xNGjmgRDqV9Ap4c6BKuTgUCqZUFVSvrlfa/PP740sVcG2Z4nP0sK4CSWDSNS751VOoc1
         8X+wWX6UICtjEpFaTChEaLEE6HD0nKaUqk0DbZq7S167roF7/ARQgYtb4DtXxR2fhieM
         6qzJ428yDone9LN8GLkABxIgc/rjvhESDu2iUTCcuwAawhpAzTQaLTzG975zeb/wZ2Nv
         /kRw==
X-Gm-Message-State: ANhLgQ1zB3cZ8Q9jDattz7Entidg8v3J2zz+750LXQXeNu58L7MvD5Cg
        fhv+MK6wp/o5VaI/Dzl1wi+dG202/7ygr1lw3n8=
X-Google-Smtp-Source: ADFU+vucxesQpx/pSt0ehsZzFwIuKyh+AB6mHBuwVgiT12sXj9/fSUvh1uUCw9ngYmsMM5saUV6HaYenqm4OhrNYV7E=
X-Received: by 2002:aa7:d384:: with SMTP id x4mr6375157edq.256.1585593717445;
 Mon, 30 Mar 2020 11:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box> <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
 <20200328123336.givyrh5hsscg5cpx@box>
In-Reply-To: <20200328123336.givyrh5hsscg5cpx@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Mar 2020 11:41:44 -0700
Message-ID: <CAHbLzkr0X=P-xcAV7XsnfBgKz_jk-7dzYn0MMPxrN1jp4dMoqQ@mail.gmail.com>
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

On Sat, Mar 28, 2020 at 5:33 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Mar 27, 2020 at 09:17:00PM -0400, Zi Yan wrote:
> > > The compound page may be locked here if the function called for the first
> > > time for the page and not locked after that (becouse we've unlocked it we
> > > saw it the first time). The same with LRU.
> > >
> >
> > For the first time, the compound page is locked and not on LRU, so this VM_BUG_ON passes.
> > For the second time and so on, the compound page is unlocked and on the LRU,
> > so this VM_BUG_ON still passes.
> >
> > For base page, VM_BUG_ON passes.
> >
> > Other unexpected situation (a compound page is locked and on LRU) triggers the VM_BU_ON,
> > but your VM_BUG_ON will not detect this situation, right?
>
> Right. I will rework this code. I've just realized it is racy: after
> unlock and putback on LRU the page can be locked by somebody else and this
> code can unlock it which completely borken.

I'm wondering if we shall skip putting the page back to LRU. Since the
page is about to be freed soon, so as I mentioned in the other patch
it sounds not very productive to put it back to LRU again.

>
> I'll pass down compound_pagelist to release_pte_pages() and handle the
> situation there.
>
> > >>>     if (likely(writable)) {
> > >>>             if (likely(referenced)) {
> > >>
> > >> Do we need a list here? There should be at most one compound page we will see here, right?
> > >
> > > Um? It's outside the pte loop. We get here once per PMD range.
> > >
> > > 'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:
> > > it's just the last page handled in the loop.
> > >
> >
> > Throughout the pte loop, we should only see at most one compound page, right?
>
> No. mremap(2) opens a possibility for HPAGE_PMD_NR compound pages for
> single PMD range.
>
>
> --
>  Kirill A. Shutemov
>
