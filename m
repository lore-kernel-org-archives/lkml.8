Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA2C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3913620678
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd++4M9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgAKKfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:35:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42495 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgAKKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:35:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so2403838pfz.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2td1h3C8GfYA2cMzdn9SMLDmT5nhRRi2kbKs4hQRobg=;
        b=bd++4M9YYDiSV07yTNggKok9KGoJkQ2oVZM1zvijXTKQXgLBseiahwBgw08PIDQT/3
         LcUEIDGBYETQZ1MMhlyitkmQUGHVu/wkDbtwlRn0e39+qLrXQZhv9RsaoujkYjaakxUg
         ScwnZk+7TU+3C525Oqyvdd/qcp4rSSyZEQ6PeFF/dPhsoXE9OCHw7pMwQILtx+Ruooia
         FmJC4qotLotY5exrVYy6iuSBxFRLBorbAWeJ4F6i0H0AQKo8j9Ikz3w3sX4+XkiidSz6
         P/ZF/7tk+G73eYI5ojNzt8a1wtIFv8j/5vVGZ/q79VNtxMiK3gYX83ZcihnzB82u+2Fm
         xlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2td1h3C8GfYA2cMzdn9SMLDmT5nhRRi2kbKs4hQRobg=;
        b=YXvyisW+1r5hV+33+9BzYH6H19zBHbN34/rtswA1hdpwlKISoReZ+yWzq/4FBNEyRk
         XubBEjaFhsQ7mUSUeTYbS6PJ461fX3RoPgV55FwXwMKH6Fdk7B+1m1yGRNaMso+Piyw0
         koax0cCvdyd7FIj9ir8H/2RAoEdS6XXwKy2BWwg2H5TK382vMEmf6SBu4L3nmelXaTQk
         Gyk2vrF8YFJBy5QAN/C4Tfcvs1/ffVGpwmkGPIS4tT642s6iNFYcEl2NBpivramoRQOh
         5pfwa5J6Ip8U1UjyjiYeRrBFzW9wXXtg/HgKRr2GkmByebH4fCdvboXqODl+syH6My8J
         hzbg==
X-Gm-Message-State: APjAAAU5PeWML0UJbKlrSbkJNFNoK6hfrtycE4DkXg1mf5LcwM8Jcw6O
        6OM68aWPH4mvB/jrmHXeD8/aeS/OuTIdF3oxTYw=
X-Google-Smtp-Source: APXvYqwsByikKWHcE0cHf5FLuEJsP8l/mImFQJfTbF+Ocaj7fZiGoLkYnChzCH9HCDKCB80699t46Be4lAtgCaxvyCs=
X-Received: by 2002:a65:5242:: with SMTP id q2mr9988753pgp.74.1578738951304;
 Sat, 11 Jan 2020 02:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20200110225602.91663-1-samitolvanen@google.com> <202001110830.00B8USV0024843@sdf.org>
In-Reply-To: <202001110830.00B8USV0024843@sdf.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jan 2020 12:35:39 +0200
Message-ID: <CAHp75VcWryeiN_bwJjFk=RO1k+H5q7h6_3oGArf1XzF-6dNxKg@mail.gmail.com>
Subject: Re: [PATCH] lib/list_sort: fix function type mismatches
To:     George Spelvin <lkml@sdf.org>
Cc:     samitolvanen@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrey Abramov <st5pub@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 10:31 AM George Spelvin <lkml@sdf.org> wrote:
>
> >  typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> > -             struct list_head const *, struct list_head const *);
> > +             struct list_head *, struct list_head *);
>
> I'd prefer to leave the const there for documentation.

Not only. It's useful to show that we are not going to change those parameters.

> Does anyone object to fixing it in the other direction by *adding*
> const to all the call sites?

Agree.
Actually we have cmp_r_funct_t which might be used here (I didn't
check for the possibility, though).

>
> Andy Shevchenko posted a patch last 7 October that did that.
> <20191007135656.37734-1-andriy.shevchenko@linux.intel.com>
>
> (You could also try taking a second look at why __pure doesn't work,
> per AKPM's message of 16 April
> <20190416154522.65aaa348161fc581181b56d9@linux-foundation.org>)

Hint: When you post Message-Id you may prefix them with
https://lore.kernel.org/r/ which makes search a bit more convenient
and faster.


-- 
With Best Regards,
Andy Shevchenko
