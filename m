Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D57C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DF920748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS78i4Mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGVpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:45:30 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42135 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:45:30 -0400
Received: by mail-il1-f196.google.com with SMTP id f16so4763735ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJS9snVu5vDf/p1WAVPSGxLik8Jf/0ksqz7dpeYuVlU=;
        b=fS78i4MiF11WQ1eDDbkUkpEmIGiB3eNrqvl2Sjls0ugnNCKQdcxHdy8D3OYKN57QZi
         HK6gOz+s4zjZhzR/EWwXOwOfG/3Gpym9YFE1h6wppOMa4bDPRnF9PzM8sJ177pPDVYR5
         RYidyWH+WJerrXxcPWO/BACpmG4MAo01QmTEcosV31B5JvDvdXdjKCHg/0QmQf55tzyS
         owA2AJaRV6amevWuhgRpujkKGdFvNoSvqataB8Mh794PrVxfZmOAHaiXMFQoww6HNaiZ
         BPtQPDQaVYgXsASeCgnoF8PTB8FpHlRERGFVsif2FiC7SOO6pHNdlYT4DKMi6IMYlNE3
         uqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJS9snVu5vDf/p1WAVPSGxLik8Jf/0ksqz7dpeYuVlU=;
        b=dJbkXVQNCRjkbc/X+5ZLrxeeNZoRWbnmspwwp8StdUISzmbEN+1pkifohb6cYfHix3
         YdlFbmOjj2vE4mN0xnKLPZUNWwPEzveTVRkqV8NlD+XXbacuZhYCMyZ59WOp95I4DKDD
         aW2qkxkWjIXN1W8in9KXkPj+U6r1dkfEGOhmb2zttU/5nnPyCCTfYMfgk+bWnWuBs0M1
         CN0Fvdwn96ifGMQIH//dlrY1GuMqhGizBiiIUoL38bgf6SnZuy44IeTlEi383iXKGKUl
         mc9KeGqk6ZIpyzqRD5DI6D+/bs+5ImmF+rWfLuGyYm1lvN04TnNk+TDmmDBuH8PtpLhK
         SkMA==
X-Gm-Message-State: AGi0PuZVBLYb1PgJckCWfFmqB1BFRu3zHjArHt+4o3R1hHpe6vyBrbo/
        m29L/wwOCqmCcfUcnFzUKx71QiNSMgU29uwylDg=
X-Google-Smtp-Source: APiQypIk7sK06ovZiI9ghrHVkTSvsz4DdDORxM5bo/v1aXjKvh12EaqR8XUUxTCqIdAx/5g689RLOukfPlticxjl1pw=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr4417557ilh.282.1586295927057;
 Tue, 07 Apr 2020 14:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com> <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
In-Reply-To: <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 7 Apr 2020 23:45:14 +0200
Message-ID: <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 8:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 7:07 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Wed, Feb 19, 2020 at 6:37 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, Feb 19, 2020 at 7:13 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > > >
> > > > I don't see what security concern is addressed by obfuscating NULL
> > > > and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> > > > of sites where %p is used (over 10000) and the fact that NULL pointers
> > > > aren't uncommon, it probably wouldn't take long for an attacker to
> > > > find the hash that corresponds to 0.  Although harder, the same goes
> > > > for most common error values, such as -1, -2, -11, -14, etc.
> > > >
> > > > The NULL part actually fixes a regression: NULL pointers weren't
> > > > obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> > > > dereferencing invalid pointers") which went into 5.2.  I'm tacking
> > > > the IS_ERR() part on here because error pointers won't leak kernel
> > > > addresses and printing them as pointers shouldn't be any different
> > > > from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> > > > debugging based on existing pr_debug and friends excruciating.
> > > >
> > > > Note that the "always print 0's for %pK when kptr_restrict == 2"
> > > > behaviour which goes way back is left as is.
> > > >
> > > > Example output with the patch applied:
> > > >
> > > >                             ptr         error-ptr              NULL
> > > > %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > > > %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > > > %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> > > > %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> > > > %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000
> > >
> > > ...
> > >
> > > > +/*
> > > > + * NULL pointers aren't hashed.
> > > > + */
> > > >  static void __init
> > > >  null_pointer(void)
> > > >  {
> > > > -       test_hashed("%p", NULL);
> > > > +       test(ZEROS "00000000", "%p", NULL);
> > > >         test(ZEROS "00000000", "%px", NULL);
> > > >         test("(null)", "%pE", NULL);
> > > >  }
> > > >
> > > > +/*
> > > > + * Error pointers aren't hashed.
> > > > + */
> > > > +static void __init
> > > > +error_pointer(void)
> > > > +{
> > > > +       test(ONES "fffffff5", "%p", ERR_PTR(-EAGAIN));
> > > > +       test(ONES "fffffff5", "%px", ERR_PTR(-EAGAIN));
> > >
> > > > +       test("(efault)", "%pE", ERR_PTR(-EAGAIN));
> > >
> > > Hmm... Is capital E on purpose here?
> >
> > Yes.  It shows that for %pE an error pointer is still invalid.
> > %pe is tested separately, in errptr(), and the output would have
> > been "-EAGAIN".
> >
> > > Maybe we may use something else ('%ph'?) for sake of deviation?
> >
> > If you look at the resulting file, you will see that null_pointer(),
> > error_pointer() and invalid_pointer() exercise the same three variants:
> > %p, %px and %pE.
> >
> > This is somewhat confusing, but there seems to be some disagreement
> > between Pavel and Rasmus as to how the test suite should be structured
> > and I didn't want to attempt to restructure anything in this patch.
>
> Sorry, I meant Petr of course.
>
> Rasmus, who had to deal with mips defining EDQUOT to 1133 by special
> casing that in lib/errname.c, reminded me that error codes are a mess:
> EAGAIN is different on alpha.  Rather than picking another error code
> that is the same on all architectures, let's just use explicit -11.
>
> error_pointer() should be:
>
>         test(ONES "fffffff5", "%p", ERR_PTR(-11));
>         test(ONES "fffffff5", "%px", ERR_PTR(-11));
>         test("(efault)", "%pE", ERR_PTR(-11));
>
> I'll wait for more feedback and respin (or perhaps this can be
> fixed up while applying).

Hi Petr,

Bump, as I don't see this in linux-next or other public branches.
The discussion was split between several threads, revolving around
the vision for how lib/test_printf.c should be structured, but the
fix itself wasn't disputed.

Could you please pick it up for 5.7-rc1?  If you want to restructure
the test suite before adding any new test cases, v1 doesn't have them.
Other than the test cases, the only difference between v1 and v2 is
added reviews and acks.

Thanks,

                Ilya
