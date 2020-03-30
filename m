Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3464DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E61B2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ2sqeTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgC3Su4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:50:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38219 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3Suz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:50:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so22059822edq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uq6i06ZRPQUaQNiRIjd3mMYsSETxbSCVlPPKZNi2Fmg=;
        b=MZ2sqeToqwXrscQMskj6uYIRmD406jk1egY6bWS2RndDTKDwoV3uYQhinlkJmG8z1v
         yYw7dzwM0VyXScUrjZavK8X5ZZelKwaleN74tPlxP6phHfBb/W6DlC4rLqrrDz42zaxn
         FJC3DNBU4E95w+aoOPVZZP+fZcwLdFa2mlb6V0/7i+fJOKJ3NSc7KXSunLtx4/HhMiic
         UI9z58gIXTc38SAPtiQX5joMBrtceuQZLhjkrn1tYVHZTLRuZzDpYuA9Zj5Ou6PpgFpr
         le8TqGIdC31vFF6X7zYuzTArvuxDtlve5pIlkW5eHANO1e3k4WAr3n8tzJF3UvLT99pF
         8Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uq6i06ZRPQUaQNiRIjd3mMYsSETxbSCVlPPKZNi2Fmg=;
        b=AV8XDLYtvOO21P3OUjaY/kDgRm8pTdTaaOuIR/u7F/PtTVaCB6inGfRvrnVS2U1pkM
         41rBAQ/y6qY6rSQdqTd3HI5IBuygeT4iL3EoLqhGJSYxdxia6Oe0RzpRh7iLbwE+tcUA
         0DVzDhAVjcEuk46SVNC4Bwr6hSZq8/21V6J5gZMKCLl/hFUtAPnlbQjRe+2++mgXSaQa
         Gmlr/YpLblB9Z1lfc3QO22KkMcQj0ZW+JeTVrq8YCpeOBdepXyE6bne1cthSwmfeUVPo
         RhcDCadiazxFy4e3q/WTk3tm1KBYONfCwfxkk3d6ZaEOncLN5Tcz5UtzjqmFdKfN1J92
         4UCg==
X-Gm-Message-State: ANhLgQ0zaM3fFMh/jCPrmzEAh7yQvforLQtEPWXVrM2aL6qjqa98tl+3
        rKZwDInIpDZpykA+ODj/MaZYXEYsizY6usphR8Y=
X-Google-Smtp-Source: ADFU+vuQT/sSZscTjeUisaiLMkmUZGobafKEtxOMGFoQBGQAKBG2rMTI0iCHnv2MLYY0Ke5eLuRBRpb0i2h5glzSD3k=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr12539035edf.372.1585594253518;
 Mon, 30 Mar 2020 11:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com> <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box> <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
 <20200328123336.givyrh5hsscg5cpx@box>
In-Reply-To: <20200328123336.givyrh5hsscg5cpx@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Mar 2020 11:50:41 -0700
Message-ID: <CAHbLzkqU1Aoo+SS3H=i6etT9Njfjk017M3vyCLeTptmGGFGRXw@mail.gmail.com>
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

Do you mean every PTE in the PMD is mapped by a sub page from different THPs?

>
>
> --
>  Kirill A. Shutemov
>
