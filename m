Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FFC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1608B2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWIfYWNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgBSTWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:22:41 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46182 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBSTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:22:41 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so21501112ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml1MOyX82nSja1VpXVmwy2WTtqE+i8Eb83IXuucGSCI=;
        b=nWIfYWNkB9QhIwJaslwkx6i/R9ZPE365epjTHhQygQQSrEMa9PBLnvx4F5Dr0lXFKN
         b05KlMVQ4LNnzDyIwhKFmnAyqZURfvO5KPlbqKQOl5UUc7CIDlgH+nFTvKYrzas33C6D
         2cuSxe1UgWt5GPoYwo8K99kvg+7RWDIuw1tvoVhpF+RwoP40MJT7fTxO69770GdBCnL6
         xeH7D2iIvai/DZhXnbhgH5gV/WSWG2t85EXmhgETbLhaQQ4xd/OSi7slI7BoOQT1Uakc
         eELKJnmoWTz/WP2vJW16fwfi9LxexEWMuRrqssZ0dpsajF0+G/PaG1BdTmY/ukZR65uD
         cQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml1MOyX82nSja1VpXVmwy2WTtqE+i8Eb83IXuucGSCI=;
        b=fe+RwdQc32j6Wgsag/Om8E/7EdrBOE8vNks7DvxPR2FAvRfNxJyfEeUGxG6u0fqwl5
         qrVBJ3oo9Y3Dkb2EIWSHnPLOE/fmpce7FjyGO+JnrJhbFYN4SRw28h1pBafa09SCHsAX
         4zj43v+UZPVfJq50x64nJ/aL5W7THxEREk1DSD2etCl/8OY32+71bMZDAFx6PnPI7HzO
         Va3MkIuy7WrvP6nV8kQpkRBjbafyFhfFCdqj9lWIYm/7xm49ELi4Vyyixwt7aYV+yjWx
         6XZU0tGovgKpLv2MseG0E4ZiBSwQ2LsbKMzBNZbvsfmfCs0C7sLFsK9NebgVnWeiEJWz
         UIYA==
X-Gm-Message-State: APjAAAWuSH3eirIwQVQspfE80rZcsdZ/NX9lUc1Tiyz/5QJY1n3XvxEg
        fvrEeysprzAT/21sbmZBEkIsW8vrwCBm3tBevYg=
X-Google-Smtp-Source: APXvYqxrDLQt40xRKej4K0PZCiMjI+y2gHlu4+VJmMz79iJuBIQJK6okXDNFJI7Gt+oOapOxnMEtlavBbN0FojuMcQ4=
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr24578181ilq.282.1582140160551;
 Wed, 19 Feb 2020 11:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
In-Reply-To: <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 19 Feb 2020 20:23:06 +0100
Message-ID: <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 7:07 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 6:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Feb 19, 2020 at 7:13 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > >
> > > I don't see what security concern is addressed by obfuscating NULL
> > > and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> > > of sites where %p is used (over 10000) and the fact that NULL pointers
> > > aren't uncommon, it probably wouldn't take long for an attacker to
> > > find the hash that corresponds to 0.  Although harder, the same goes
> > > for most common error values, such as -1, -2, -11, -14, etc.
> > >
> > > The NULL part actually fixes a regression: NULL pointers weren't
> > > obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> > > dereferencing invalid pointers") which went into 5.2.  I'm tacking
> > > the IS_ERR() part on here because error pointers won't leak kernel
> > > addresses and printing them as pointers shouldn't be any different
> > > from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> > > debugging based on existing pr_debug and friends excruciating.
> > >
> > > Note that the "always print 0's for %pK when kptr_restrict == 2"
> > > behaviour which goes way back is left as is.
> > >
> > > Example output with the patch applied:
> > >
> > >                             ptr         error-ptr              NULL
> > > %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > > %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > > %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> > > %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> > > %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000
> >
> > ...
> >
> > > +/*
> > > + * NULL pointers aren't hashed.
> > > + */
> > >  static void __init
> > >  null_pointer(void)
> > >  {
> > > -       test_hashed("%p", NULL);
> > > +       test(ZEROS "00000000", "%p", NULL);
> > >         test(ZEROS "00000000", "%px", NULL);
> > >         test("(null)", "%pE", NULL);
> > >  }
> > >
> > > +/*
> > > + * Error pointers aren't hashed.
> > > + */
> > > +static void __init
> > > +error_pointer(void)
> > > +{
> > > +       test(ONES "fffffff5", "%p", ERR_PTR(-EAGAIN));
> > > +       test(ONES "fffffff5", "%px", ERR_PTR(-EAGAIN));
> >
> > > +       test("(efault)", "%pE", ERR_PTR(-EAGAIN));
> >
> > Hmm... Is capital E on purpose here?
>
> Yes.  It shows that for %pE an error pointer is still invalid.
> %pe is tested separately, in errptr(), and the output would have
> been "-EAGAIN".
>
> > Maybe we may use something else ('%ph'?) for sake of deviation?
>
> If you look at the resulting file, you will see that null_pointer(),
> error_pointer() and invalid_pointer() exercise the same three variants:
> %p, %px and %pE.
>
> This is somewhat confusing, but there seems to be some disagreement
> between Pavel and Rasmus as to how the test suite should be structured
> and I didn't want to attempt to restructure anything in this patch.

Sorry, I meant Petr of course.

Rasmus, who had to deal with mips defining EDQUOT to 1133 by special
casing that in lib/errname.c, reminded me that error codes are a mess:
EAGAIN is different on alpha.  Rather than picking another error code
that is the same on all architectures, let's just use explicit -11.

error_pointer() should be:

        test(ONES "fffffff5", "%p", ERR_PTR(-11));
        test(ONES "fffffff5", "%px", ERR_PTR(-11));
        test("(efault)", "%pE", ERR_PTR(-11));

I'll wait for more feedback and respin (or perhaps this can be
fixed up while applying).

Thanks,

                Ilya
