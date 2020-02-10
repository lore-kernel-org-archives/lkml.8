Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D7FC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865742168B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/fyo5zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJUpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:45:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34449 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:45:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so7842138otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfSzqarGyzjK5g9zOwnGoHsxJ7bhaam0WuaTghWmBsA=;
        b=R/fyo5zVfADZJo7Tpjb53UIIzvJfGoUB7gqXf4ge2dEpoAr00vAxg/cyCQto0McPQg
         BB8PlP8GEEWafyvg6+WW/zlF61EgAnWKiNAvF5LnMMEpiwTfOoDQlljP836tExcPaeVC
         VD+Hr8l2gbCc66iuQmK2FhlJ4KUSeKFBfseMg7rgO3d7ViGoJrshrue4PD0YleIpV651
         bzkn+ZvFBPYWctmQqOFrqi5tu7uzY29cXz5jrrGXlS1I0rT4dKaB9nuLt7Zcm2zQ/UGJ
         Vs+GbjT7i8M7BSTubXeGEQ9Ze/zr57PexYSVxz0kic/riC1dqfDi1tfLnzvwx0tRg6JQ
         zTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfSzqarGyzjK5g9zOwnGoHsxJ7bhaam0WuaTghWmBsA=;
        b=asojKSv3NiBKFFCk4eOi09pnrVbIlSBUvA1Facvbg896RZ6Bba/0/zTA9x6fmIvAhQ
         l9o/Ae5SRnot5oBzujrw8GSop6Wf3X63mOmU2YmtY2QB7L8yb1HkqNzK9cbUps8m2IZz
         1AHbnZ9g8Ji5hlQwn1erE5HJTpBFKnSRmzComqKrg9pNfmMH3EFuhS3rudEc3dz756NP
         d4zcC897rg1/jBKRIHVPgflWbEMAknAj3VsOrHDbV19juX5GL0IUXn2uAniWTEQIBODv
         mui4OXAPycKeZr4vIbdSrubHeTNIxhPpx7PpHJwNqprZN8N0YBwGZoQ9f7yvt7690EdF
         VGBQ==
X-Gm-Message-State: APjAAAUBDbGVhlAYszH2WRj2gGrezeIPGfy7POPS7ohMP0tk6fqcgePZ
        y2uJ9CVtS4bvi6DnMb6RTqMGZFeYqMhHx3BdJ6DJ2IMv
X-Google-Smtp-Source: APXvYqwBjO/aq81r8LsHvtE2wRaMmsPC5G4CPsZNmX+aOkG4bL6R8zoX0XKD50lPzkBLgCL+Sve6rCWVwdOQuCyA8vw=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr2628214otq.17.1581367509151;
 Mon, 10 Feb 2020 12:45:09 -0800 (PST)
MIME-Version: 1.0
References: <1581354029-20154-1-git-send-email-cai@lca.pw> <20200210172511.GL8731@bombadil.infradead.org>
 <1581362448.7365.38.camel@lca.pw> <20200210192155.GM8731@bombadil.infradead.org>
 <1581366529.7365.49.camel@lca.pw>
In-Reply-To: <1581366529.7365.49.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 21:44:58 +0100
Message-ID: <CANpmjNOHNp3hSk85F3yJeM9dyU6ias2sxSvF+oegyQC=8XJ+cQ@mail.gmail.com>
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 21:28, Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2020-02-10 at 11:21 -0800, Matthew Wilcox wrote:
> > On Mon, Feb 10, 2020 at 02:20:48PM -0500, Qian Cai wrote:
> > > On Mon, 2020-02-10 at 09:25 -0800, Matthew Wilcox wrote:
> > > > On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > > > > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> > > > >                 if (page->index >= max_idx)
> > > > >                         goto unlock;
> > > > >
> > > > > -               if (file->f_ra.mmap_miss > 0)
> > > > > +               if (data_race(file->f_ra.mmap_miss > 0))
> > > > >                         file->f_ra.mmap_miss--;
> > > >
> > > > How is this safe?  Two threads can each see 1, and then both decrement the
> > > > in-memory copy, causing it to end up at -1.
> > >
> > > Well, I meant to say it is safe from *data* races rather than all other races,
> > > but it is a good catch for the underflow cases and makes some sense to fix them
> > > together (so we don't need to touch the same lines over and over again).
> >
> > My point is that this is a legitimate warning from the sanitiser.
> > The point of your patches should not be to remove all the warnings!
>
> The KCSAN will assume the write is "atomic" if it is aligned and within word-
> size which is the case for "ra->mmap_miss", so I somehow skip auditing the
> locking around the concurrent writers, but I got your point. Next time, I'll
> spend a bit more time looking.

Note: the fact that we assume writes aligned up to word-size are
atomic is based on current preferences we were told about. Just
because the tool won't complain right now (although a simple config
switch will make it complain again), we don't want to forget the
writes entirely. If it is a simple write, do the WRITE_ONCE if it
makes sense. I, for one, still can't prove if all compilers won't
screw up a write due to an omitted WRITE_ONCE somehow. [Yes, for more
complex ops like 'var++', turning them into 'WRITE_ONCE(var, var + 1)'
isn't as readable, so these are a bit tricky until we get primitives
to properly deal with them.]
