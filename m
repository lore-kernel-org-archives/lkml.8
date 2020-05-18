Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8414CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5931020756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOdNevU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgERU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:58:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B26C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:58:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k5so4799069lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRgohj4ZV7BAqug+Up6EM0XNiUu7ZgBs3u6nUNC3XVM=;
        b=rOdNevU/0mLEdSxCbmh65V2KFMBeoX//d0FtXPHjZ8d9daBS8aYWdyHgpcqgGnTI34
         QACNCLwNTer3Xdk2mYreZ/8bieP7gG4rNZsMHonf/mfI/NXQg8eXQdBK93azmIjHz5kR
         HKFluM3XIKkNA96y/QJyispsiw7mGOYH2kvpzm3OATveSrYAtGpzXCIJ8JVq2OTYmxNS
         X1KAVninjF+PklHw217wXvsCV0/Ugi4UKa7UBDBQ+p6OMcMGnsnhAO1DqDZQHBsBsp8d
         00D5NwNEEJQXEAMJhPvzhUj10L+QzKTHDVYavpLzWy/8eelKEBtAV8UWleNILT29Gr9/
         pjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRgohj4ZV7BAqug+Up6EM0XNiUu7ZgBs3u6nUNC3XVM=;
        b=n+dRvPeO/+Xds5M9M3wEDXekmf/Eh2PkQl8sTjl8rhXrOZXnXsu1RUWRA7fHmD5C66
         viGgMQ/mGrgtP56ctA9SKuUqnjx2GXfn9OrIWN0xX1Wfp7YBPD1t8uB/xKIjlXYc7kWi
         BKkLCVdlcTCLiF7vQxJ2a/VWk6lsx4I89I9cXGc1CRkiPJIOMx47Yz7/az4DEUB6IGjw
         jbC4EYW9+6N8G4lyGW2L0slnyVLM5+ZWyPCWx3YGyY5HKLIbYQiwYn5uSnWtvfQ4i/Pa
         jc0kYA1QcIRGRxbKm695hIlUrOtL8wdve+o31z6XX26+I9M9l0hhMs6/j1oUOY7Hf6WI
         g80A==
X-Gm-Message-State: AOAM531aH3RCYtYSy2Wd7D+tmMy7KVJKMkF46O37T0nof5SgbZWfAKH2
        ul3i91Cz/gJSynjZPXJlUmGNKrF0kDfgi8L+rHp7L4je
X-Google-Smtp-Source: ABdhPJz0uicoFSCahdZXLSYMWd5wQ4xkgjldsqXDe1+/Xhg5qmkvdblvgGEByl8zYDmZjNVc8BMpJF8C7muKhSE+qpA=
X-Received: by 2002:a05:651c:1a5:: with SMTP id c5mr11319490ljn.217.1589835523866;
 Mon, 18 May 2020 13:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
 <20200518201737.GV16070@bombadil.infradead.org> <CAFqt6zbcn5kEbtY1fod4yy_PETKX8zVM2NjsY0HHyOixiu2q4w@mail.gmail.com>
 <975cc333-e9f4-29e4-db0e-00ea8b8a7c25@nvidia.com>
In-Reply-To: <975cc333-e9f4-29e4-db0e-00ea8b8a7c25@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 May 2020 02:36:45 +0530
Message-ID: <CAFqt6zZoFBkvkZKOc9mbGVO6_Gst+0k=wpjmXYSKvFru=HgczA@mail.gmail.com>
Subject: Re: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing
 write flag
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 2:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-18 13:44, Souptick Joarder wrote:
> > On Tue 19 May, 2020, 1:47 AM Matthew Wilcox, <willy@infradead.org> wrote:
> >>
> >> On Tue, May 19, 2020 at 01:28:23AM +0530, Souptick Joarder wrote:
> >>> The idea is to get rid of write parameter. Instead caller will pass
> >>> FOLL_WRITE to __get_user_pages_fast(). This will not change any
> >>> functionality of the API. Once it is upstream all the callers will
> >>> be changed to pass FOLL_WRITE.
> >>
> >> Uhh ... until you change all the callers, haven't you just broken all
> >> the callers?
> >
> > All the callers have called the API with either 1 or 0.  I think, it's
> > not going to break
> > any of the callers.
>
> Maybe so, but it's still "wrong" to do that, because it only works more
> or less accidentally. That is, it works in spite of a type safety
> violation. So we don't want to do that sort of thing unless there is
> a compelling reason.
>
> In addition to that, I am at the exact moment putting together a minor
> refactoring of this function, because I need a FOLL_PIN variant:
> __pin_user_pages_fast(), as part of my work to change over a few dozen
> gup call sites to pin_user_pages*().
>
> (In fact, I was wondering whether to stick with the "write" parameter, for
> the new __pin_user_pages_fast(), or go with gup_flags. That could go either
> way: gup_flags provides a nicer API, but "write" matches the existing
> callers.)
>
> So in other words, if you do go out and change all the call sites (there only
> seem to be about 7, outside of gup.c, actually), that's going to conflict
> a little bit with what I'm doing here.
>
> So, how would you like proceed? If you want to do the full conversion
> (which really should include the call sites), it would be easier for me
> if you based it on my upcoming small patchset, which I expect to post
> shortly (later today).

Sure, I will wait for your patchset :)

As there are only 7 callers of the __get_user_pages_fast(), I prefer to do
full conversion in a single commit. But if it is not preferred way, I would go
as per feedback.

> >>
> >>> -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >>> -                       struct page **pages)
> >>> +int __get_user_pages_fast(unsigned long start, int nr_pages,
> >>> +                     unsigned int gup_flags, struct page **pages)
> >>>   {
> >>>        unsigned long len, end;
> >>>        unsigned long flags;
> >>> @@ -2685,10 +2692,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >>>         * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
> >>>         * because gup fast is always a "pin with a +1 page refcount" request.
> >>>         */
> >>> -     unsigned int gup_flags = FOLL_GET;
> >>> -
> >>> -     if (write)
> >>> -             gup_flags |= FOLL_WRITE;
> >>> +     gup_flags |= FOLL_GET;
> >
>
