Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDEEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C7621741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvdo489W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBGUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:42:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34853 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:42:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so973702edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qme74oUO2AjF1HKgLPSJvL4CSEChV51xdiVyhj0IraY=;
        b=bvdo489WkazsFr8MyNsmtfFBn7DsQljQXJ/HOxxSWabU4r6rIEsNpz737+aAgQboHv
         1gx4Yxk1LbZYkC1W9yfgri+0wFxWOnx8qJ7BuCUbOGkyCIMgZwhZlLN8gGCOhRb/SeqT
         q4Y20cVFpjN7cHiDrws7RJEuz+CgdcIfo5GiOF/ezfmFqGAoj6+A4t3f2KUfZBo6LCAM
         TrQGLfTWFH/fwntXGaEhHmzCqCf33+HAfHS28QIf3nfNr7iKy1yp4pWofrcOB8fC5lRW
         CQL5fCArFohre7uLi8GcE8/5B6mcBcK87J7IAYiICzOary8Eqlj4kD4YSxN9f4yVxSKG
         VsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qme74oUO2AjF1HKgLPSJvL4CSEChV51xdiVyhj0IraY=;
        b=YwArPAuQgNTU9+BFeddSlNFTpk6ggVN4AlN959ZCTiqxMZtD3eAmKNmCpZkpYecvSR
         I0bUhyF5MGuR5bV2bCjxfFJhC+2pQRH/TUcRLYqf1uY5T9R2FNutgegP+xoYm8/e3lhd
         3iRAf5XtqJbH9rdML7GYzWE3S+ryAyjX3jIsrGFOrxFZrdET8wYGmxWhtIkO2us0nvGs
         NW15jYhHrxLn6y3xsszRvapLLrxJ+nKxP6mfuHgCiXRE2hfEy0c00qfTlmUMTdta0kX5
         cPZ3w6SweCV+nIG8CSnPAjYCBJ1823dnDrdTLbiSeI/DbZ9N29btigoQIsVTnKcEnv8B
         V5tw==
X-Gm-Message-State: APjAAAXWI1cFd+77XkouO/YfodCRkeui7tIjMhlRueKAqJHg73NSxEJY
        X6s6t5PMrkwvzNN1IoEz9j1HbZcqlJ0G6Fo4WuOdhw==
X-Google-Smtp-Source: APXvYqxd/3AgJCgsBd9lmKhLRCgoBs7ng3LZam3gp52WRCLUPvXrvw3OIwH4OX3lHJRvQnfg33LmrMwxq7BZX3LCu1k=
X-Received: by 2002:aa7:d355:: with SMTP id m21mr690593edr.312.1581108161876;
 Fri, 07 Feb 2020 12:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box> <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
 <20200203130940.enfvdsbn42hhoaki@box>
In-Reply-To: <20200203130940.enfvdsbn42hhoaki@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 7 Feb 2020 12:42:15 -0800
Message-ID: <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,
I started a new thread https://lkml.org/lkml/2020/2/7/640 for my v4
patch. But I wanted to quickly address your comments. Regarding the
concern around the rmap, no changes actually need to be made. If we
were to unlink_anon_vma(vma) and then set vma->anon_vma = NULL, that
would be fine but then as soon as there was a fault the same anon_vma
would be attached since it's a private anonymous mapping. So there is
really nothing to do regarding the rmap.

I considered the two flag approach but since I could not come up with
a concrete use case of MREMAP_MUSTMOVE I decided to just leave the
single MREMAP_DONTUNMAP flag, the two flag approach would be only for
clarifying the operations so I'm not sure it's worth it. (Still trying
to come up with a better name). But I've attached a man page diff to
the latest patch.

Thanks,
Brian

On Mon, Feb 3, 2020 at 5:09 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Feb 02, 2020 at 05:17:53AM +0100, Brian Geffon wrote:
> > On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > > Any better options for the flag name? (I have none)
> >
> > The other option is that it's broken up into two new flags the first
> > MREMAP_MUSTMOVE which can be used regardless of whether or not you're
> > leaving the original mapping mapped. This would do exactly what it
> > describes: move the mapping to a new address with or without
> > MREMAP_FIXED, this keeps consistency with MAYMOVE.
> >
> > The second flag would be the new MREMAP_DONTUNMAP flag which requires
> > MREMAP_MUSTMOVE, again with or without MREMAP_FIXED.
> >
> > What are your thoughts on this?
>
> Sounds reasonable.
>
> MREMAP_DONTUNMAP doesn't really convey that you move pages to the new
> mapping, but leave empty mapping behind. But I guess there's only so much
> you can encode into the name. (Patch to the man page should do the rest)
>
> --
>  Kirill A. Shutemov
