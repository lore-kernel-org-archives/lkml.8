Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D40C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D2320801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0bVDSlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:23:15 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36028 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:23:14 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so21224793iln.3;
        Wed, 19 Feb 2020 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGngLDQbpsAufC+vN/662a3UH3A2uSByCjnMwkjEXbU=;
        b=K0bVDSlAeZ+cV8BYIIlNBAokck4JA7othBQVjHjqgahBKM6hvMLrRxc8Pvp6HQogaE
         p5LYexw+7R2VD14Z7tmNlG2asjlNh/tQArz1bDsvfYQX3f8z3fVqSDJBsSdD3cOrcm1q
         JLNOn6NukaONTWjQtgYqMSx7lJS+cvsvcfo/OuM1WdS3UjY81/5PBes+O11p/ve9o114
         CVZjR9eXjEDRKVSWW4xa3V/3gicfYeqLTckvdhAKPhaFIV/hmkwN/StbztV40KrzfrJW
         ni3pvhrX95urbSUZfYcxUma4bO442+wjM6WSHHTJ4NgfRWgvEHcqSZBogR20Kz5t2oBx
         zOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGngLDQbpsAufC+vN/662a3UH3A2uSByCjnMwkjEXbU=;
        b=i8QUCThf8gqVj0ns2qifGs2bkF/hM4Vhqog4xuHqsZJhJmdUELOJgKb8uRt5ZIGh4R
         GhWcCUySB9/uj/Vg0sFqH5i+vnGhaAIwd6dYVx/k5R5i5uHOh6Cw1vEe4H/AQLC1No6W
         1IplznVQXAp2v4UP3oW/uA0NbjsrbhwU7mIT7q/MLg3UK7WoPSv7mLlnifuAv3gWd6YF
         hQSm1O2UROSyRgJc2cXs30LzNP960I72nScdhAsy2EVMvM+raEzhBsTXBsGWCGSIO4EC
         zb020RzJKDDwuVRthD6Ze4E+S/GlC7orgrriD1HUzGppYaitnZ1Wocx+2gfNR599SMdC
         vJcA==
X-Gm-Message-State: APjAAAUd5uqyfhws6QUNPRTr9rC8WmQk9R/3tVpFDs6H2Artw4VHHivp
        678kORvD94UasyqR0wnz+elwD+bqclBQ9PzB0gg=
X-Google-Smtp-Source: APXvYqyLsL36ItksCPZerVnrn9TvANn/FrLVPPCRLzGXiUlqmZBEgfajic9eRskjLz2SvFSt1PJDWkre/W/BGTnY1ic=
X-Received: by 2002:a92:3991:: with SMTP id h17mr18908735ilf.131.1582132994133;
 Wed, 19 Feb 2020 09:23:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk> <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk> <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk> <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
In-Reply-To: <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 19 Feb 2020 18:23:40 +0100
Message-ID: <CAOi1vP_n-29hPnbeZH7-sb6=_OCPgUgkz-GeWLJw_L1P-CvCww@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 4:40 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 19/02/2020 15.45, Petr Mladek wrote:
> > On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:
> >> On 19/02/2020 14.48, Petr Mladek wrote:
> >>> On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
> >>>> --- a/lib/vsprintf.c
> >>>> +++ b/lib/vsprintf.c
> >>> The test should go into null_pointer() instead of errptr().
> >>
> >> Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
> >> way. But I should add a #else section that tests how %pe behaves without
> >> CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.
> >
> > OK, we should agree on some structure first.
> >
> > We already have two top level functions that test how a particular
> > pointer is printed using different pointer modifiers:
> >
> >       null_pointer();     -> NULL with %p, %pX, %pE
> >       invalid_pointer();  -> random pointer with %p, %pX, %pE
> >
> > Following this logic, errptr() should test how a pointer from IS_ERR() range
> > is printed using different pointer formats.
>
> Oh please. I wrote test_printf.c originally and structured it with one
> helper for each %p<whatever>. How are your additions null_pointer and
> invalid_pointer good examples for what the existing style is?
>
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 649)
> test_pointer(void)
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 650) {
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 651)  plain();
> 3e5903eb9cff7 (Petr Mladek      2019-04-17 13:53:48 +0200 652)
> null_pointer();
> 3e5903eb9cff7 (Petr Mladek      2019-04-17 13:53:48 +0200 653)
> invalid_pointer();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 654)
> symbol_ptr();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 655)
> kernel_ptr();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 656)
> struct_resource();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 657)  addr();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 658)
> escaped_str();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 659)
> hex_string();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 660)  mac();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 661)  ip();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 662)  uuid();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 663)  dentry();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 664)
> struct_va_format();
> 4d42c44727a06 (Andy Shevchenko  2018-12-04 23:23:11 +0200 665)
> struct_rtc_time();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 666)
> struct_clk();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 667)  bitmap();
> 707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 668)
> netdev_features();
> edf14cdbf9a0e (Vlastimil Babka  2016-03-15 14:55:56 -0700 669)  flags();
> 57f5677e535ba (Rasmus Villemoes 2019-10-15 21:07:05 +0200 670)  errptr();
> f1ce39df508de (Sakari Ailus     2019-10-03 15:32:19 +0300 671)
> fwnode_pointer();
>
>
> > I am open to crate another logic but it must be consistent.
>
> So yeah, I'm going to continue testing the behaviour of %pe in errptr, TYVM.
>
> > If you want to check %pe with NULL in errptr(), you have to
> > split the other two functions per-modifier. IMHO, it is not
> > worth it.
>
> Agreed, let's leave null_pointer and invalid_pointer alone.
>
> >>>> BTW., your original patch for %p lacks corresponding update of
> >>>> test_vsprintf.c. Please add appropriate test cases.
> >>>
> >>> diff --git a/lib/test_printf.c b/lib/test_printf.c
> >>> index 2d9f520d2f27..1726a678bccd 100644
> >>> --- a/lib/test_printf.c
> >>> +++ b/lib/test_printf.c
> >>> @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
> >>>  static void __init
> >>>  null_pointer(void)
> >>>  {
> >>> -   test_hashed("%p", NULL);
> >>> +   test(ZEROS "00000000", "%p", NULL);
> >>
> >> No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
> >> (where one of course has to use explicit integers and not E* constants).
> >
> > Yes, it would be great to add checks for %p, %px for IS_ERR() range.
> > But it is different story. The above change is for the original patch
> > and it was about NULL pointer handling.
>
> Wrong. The original patch (i.e. Ilya's) had subject "vsprintf: don't
> obfuscate NULL and error pointers" and did
>
> +       if (IS_ERR_OR_NULL(ptr))
>
> so the tests that should be part of that patch very much need to cover
> both NULL and ERR_PTRs passed to plain %p.

I sent v2 of my patch with the update to test_printf.c.

I see your point about one function for each %p variant, but since
it's already been disrupted with null_pointer() and invalid_pointer()
and also because test_hashed() has a comment which implies that it
must be called after plain(), I piled on by adding error_pointer().

Thanks,

                Ilya
