Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5102075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrAh2zqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgDHPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:53:06 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33573 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgDHPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:53:06 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so7196427ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvZGibvdFBA551zpY54wJDMqv1FNrib21JtR9KJeHpU=;
        b=BrAh2zqYtuqTiIoh65WWnhD7RQu4nZSkqZMJlJOd8IKGw5bNwJpQmVjO1vRHWx5xeW
         EV81jwHO4+Go7JGhyXoX3JTCM4sC8Liznnbl2V1TZgs2GvIb8CvvjosmTBWj1h2wWSx4
         Rjdp01wco61log7FoLX04jZY0Kk9XRYpXUdw+qLojeShj/R4zqafz2s8VW7WY1qAb8jW
         mucpvg/gYO8df04TB/uydF88XA5QWmo3M/Nyw7BuNJtYckU1qCgk4EfEOAD2AUiiQLEf
         F4oxjb47rEwaPDq60k3ivH/emyV4uOqjPTMHsOGDlak3FNJlxe4vF5ypTVU1GLWQE7Lc
         nkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvZGibvdFBA551zpY54wJDMqv1FNrib21JtR9KJeHpU=;
        b=W548wcG9xBYVJEwkhKd1B/OzFxnBbc9JFTVtc+BFhzFHcPkgUCjeStLhErPdNtn7jq
         nErMI5flILwbKs1Dee0GYlE/5JV2r4SKaTvx9YMGOv7OziAUO9DfGY/YPPAm+LA78+q0
         1S3AGcWhdr7Cu2Jwj8kLY7Z6nMBFlCV2Es2VS78nw5IFD7RV/KWSRGo9v4wX2+CveQAP
         2i7CF81ukZebZY+LqQ4B3yNzrs624Fi/mpHDHi3BV0PoLl0Lu8OOq2M0X4rKnLTiAPgn
         wmCqzlRg9DjO3tlrPGy6GMygT9MuDkfsMBiNEMKHHd28JLll9uCV2jvbt2psrfe8gm/f
         W/ag==
X-Gm-Message-State: AGi0PuZOnYavaCfz3xSrZmvDvDzONDwzpuIUFJpiQxs1a82DdARjCACk
        nrpvhFcw9WBB9s7EHRz/V9lm48RkEjfQnq60JF6GmQjgxghwXQ==
X-Google-Smtp-Source: APiQypLtM2XFsq6ty4ERtciUM0Bz3DEXv4p34A53iYWeDSJ02sokwS5qnzg4zwSKZjNYpUf+mRYWEKhQiODLw2cNjGo=
X-Received: by 2002:a92:849b:: with SMTP id y27mr8024575ilk.215.1586361183371;
 Wed, 08 Apr 2020 08:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
 <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
 <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com> <20200408150643.GD3676135@smile.fi.intel.com>
In-Reply-To: <20200408150643.GD3676135@smile.fi.intel.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 8 Apr 2020 17:52:52 +0200
Message-ID: <CAOi1vP_Dqu7i52_BPmR8N8+svAKMEwqHTOQrNV_228tXo8mHaQ@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 5:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 08, 2020 at 04:38:25PM +0200, Ilya Dryomov wrote:
> > On Wed, Apr 8, 2020 at 12:31 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, Apr 8, 2020 at 12:45 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > > > On Wed, Feb 19, 2020 at 8:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > >
> > > > Hi Petr,
> > > >
> > > > Bump, as I don't see this in linux-next or other public branches.
> > > > The discussion was split between several threads, revolving around
> > > > the vision for how lib/test_printf.c should be structured, but the
> > > > fix itself wasn't disputed.
> > > >
> > > > Could you please pick it up for 5.7-rc1?  If you want to restructure
> > > > the test suite before adding any new test cases, v1 doesn't have them.
> > > > Other than the test cases, the only difference between v1 and v2 is
> > > > added reviews and acks.
> > >
> > > Petr has some obstacles that prevent him to pay attention on this and
> > > actually do anything right now for Linux kernel.
> > > If Rasmus, Sergey, you and maybe others will got consensus here, I
> > > think Andrew can take it thru his tree.
> >
> > Thanks for letting us know, Andy.
> >
> > Other than Petr, two people are listed as maintainers of vsprintf.c:
> > Sergey and Steve.  Both of them were fine with v1 (no tests) and sent
> > their acks.
> >
> > Rasmus, you wanted to see some tests, so I posted v2.  However Petr
> > wanted to restructure the test suite first, and it didn't seem like you
> > him agreed on what exactly that should look like.  Which would you
> > prefer to be picked by Andrew, v1 or v2?
>
> I think it's question to maintainers. I'm a reviewer here.

This question was directed at Rasmus.  Technically he is also a
reviewer, but I wanted to hear from him because he authored the test
suite in question.

Sergey and Steve (who are a listed as maintainers) were OK with v1
which doesn't touch lib/test_printf.c.

Thanks,

                Ilya
