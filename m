Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264102063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unKP9RXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgDMJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727886AbgDMJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:29:41 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:29:41 EDT
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2511C008617
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:24:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t11so7983987ils.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9xxTNwOkKebXQdrj7e3IgHeXx4Dib7AVZXHCVRHOH8=;
        b=unKP9RXbUz90EHX5WxmTHsCCH9XxfAAbFg3/LOMgsay5e07ojds+iWLocS9bocDjY5
         tF0EHr8PudIxMzaJUrJsstirJaTCRARtPuGZErdINVTgp/tIVjm6B+9v8z43zZRgOIlR
         +BBtl8OihBbqPgRdtuqFmSVfk/Uk5wnwNSQoSrfuy/mFosmpBsVUIlAOEV3trFpyultB
         2eUehxYDp0vPgi4JPqyHdocBceIejRErvV9FbU/tCjto5YWzg+u/wh+eyEb8hs/Pe5ss
         PB12xiNU6ldMIz/e2wjYRL9KxBXMJMPnXx99JlgwhLnjcNV5Pl8yVhy980/PsVGC8BQU
         h7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9xxTNwOkKebXQdrj7e3IgHeXx4Dib7AVZXHCVRHOH8=;
        b=r5vPFroo9eU7/E6pLbF0mPymiquXOdfs/6twms2Lii7E/O9KJYBH9DdZ1zVDURXFGo
         jCDeg7Z8l+0LiBezKtUF3gp7AzcKGP1rEKoC6mskCvu6/8sc/i/6/SYgXoh4o99ne80f
         YlY8jsOFU0CFiK2gUUu2jQ6RDJqkiglWE85+GdnVN+qezgDatJOEUQXniovu72fWn2x9
         kFgAkVB+9B33iscBj1UuAi5FfnZDuIW1LkR7RbmC50JHlDMBXCiECOlHqfBfXdaou/Fq
         WJw5wh+5IOQ6NP8LxU9mwW60OzgepV5/EPW5t/7IRj5MT/+tY7WGc/6FFVnJFK6DW3/m
         xvMA==
X-Gm-Message-State: AGi0PuaJ0eBTfMvpPX9Wm45+jKDSI09U6ht06al5g4c63966gqOkcS9Z
        dkmteQHIQSom4CZqpl7ArFVBN5VhHk3MPrvxoN4=
X-Google-Smtp-Source: APiQypL9UBtedvu07pcimMLGLeAhVL4l87I0tDC2GNz5jhpG1yZQGooCRdGQL/IIHIImGUgpbOKUlz6y3o46fEO6s3M=
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr15430488ilg.143.1586769876957;
 Mon, 13 Apr 2020 02:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
 <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
 <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com>
 <20200408150643.GD3676135@smile.fi.intel.com> <CAHk-=wgndVg4U2rh_6e8YBuhN+78wEiyTuCRTqfWuSZzGC6f_w@mail.gmail.com>
 <0fd21b6115b647baac23ee926b4c76f8@AcuMS.aculab.com>
In-Reply-To: <0fd21b6115b647baac23ee926b4c76f8@AcuMS.aculab.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 13 Apr 2020 11:24:30 +0200
Message-ID: <CAOi1vP9p4dC1HfzmgP_GR=p4p8LWfxPQTGfHf3QaCFp6vF-V2Q@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Apr 10, 2020 at 11:40 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> > Sent: 08 April 2020 17:23
> > On Wed, Apr 8, 2020 at 8:08 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > For the better understanding the current state of affairs I suggest to respin
> > > new version after rc1 and we will see again.
>
> If the hash of a pointer ends up being one of the values that
> wouldn't be hashed, perhaps it should be hashed again.
> That will remove any possible confusion.

Hi David,

That seems sensible, but out of scope of this patch IMO.

My goal was to fix a 5.2 regression for NULL pointers.  I tacked on
IS_ERR pointers because they aren't actual addresses either and hashing
them makes zero sense.  Although simple to implement, I'm afraid that
introducing additional rounds of hashing would drag this patch further
(it's already got bogged down in the test suite structure discussion).

Thanks,

                Ilya
