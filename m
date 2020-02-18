Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8820C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB952176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD2zBTBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRLQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:16:20 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37945 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgBRLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:16:20 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so16985335ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 03:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdRs4CSk1sjEx2XGYnd0uv2adtZQecUaYs/TF44cHQQ=;
        b=iD2zBTBdLkMqLy+ZjFu4qXkv3YiYq5r1sn8vLGZMFr9DkR4f3HsqMlxI9DVyv55eMY
         c9ZPi1WODHCWNuCA+uHXjKPA6T2IUqgOEsJ6dBILTW0caDfEilc3wKtaswqJU7w4vGW8
         Ly7nC04wHJEaqpYeZxuxEwXmp/RZfFSAI2P7FdZyIaZnJZJQl36c2Af27Xeyub/6Mw5S
         zWKqaSDNACtXlRFkln2wsbINcweW6bsEh+UEun4DIKX9B+5podBteKK7fCE3o4R2O/2y
         Piw7It+D0hSuatOE8LqpMMetYdS1rTBYh7yPM4WCq3gMIzyuE/wXQs5n/D2Ft9eLcKm9
         zg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdRs4CSk1sjEx2XGYnd0uv2adtZQecUaYs/TF44cHQQ=;
        b=jH2xP/1wHAn6KauYCl5GD53b1VnS24rJgS+jRfUnfwqT7ThixfwFe6jG64c0JilrjG
         /tpFXlK/0ApiAXGlEsULqnKLaUnQNweZouPTf1Q1b5hgg6kRYLwQzzUBwwjjzDFvl9AP
         EXc/wyu4aX/HLgV8GLBuJpJC8oE7KLwWEeOXirakhglcfjdlLWJrZarxYOP8WZGbfpkm
         LX0kVQhgjMI/+4J8maA/DAvRIqOlttpb118gys7h10nr/xFS4fMEbAhDLSwKE3mdQZN8
         sTEuHASOu7H0ulOCIFdfC2uceT1ngvXbZUBY863cyGOybSW3O6N6wHJmxEd8NKaf3RAF
         K2cg==
X-Gm-Message-State: APjAAAVg6MHBJjULjGuvnf591uZ7G2ya+nZgnj1nVkih6jSnsgb7kpWN
        Wmdt71iqBjb1WkHah7KAEz7TSwkwPeOft5DxnD0=
X-Google-Smtp-Source: APXvYqxDk98RG3lKRN3GccvRjsezOiRKS5m6gqa9fln/q5fLvi+1vW1oE63xiA1qqyNyP0/uoX51wu9+QVWE030B0nc=
X-Received: by 2002:a92:3a8d:: with SMTP id i13mr19835911ilf.112.1582024577946;
 Tue, 18 Feb 2020 03:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com> <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
In-Reply-To: <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 18 Feb 2020 12:16:43 +0100
Message-ID: <CAOi1vP-854iSypqYKLQQLgRsaHStzaiJD2JQ-i+KDLgrFC1PaA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:33 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2020-02-18 01:07:53, Ilya Dryomov wrote:
> > On Tue, Feb 18, 2020 at 12:47 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Feb 17, 2020 at 11:28:03PM +0100, Ilya Dryomov wrote:
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
> > > This seems reasonable. Though I wonder -- since the efault string is
> > > exposed now -- should this instead print all the error-ptr strings
> > > instead of the unsigned negative pointer value?
>
> It would make sense to distinguish it from a hashed value that might
> be in the NULL or ERR range as well.
>
> The chance is small. But it might safe people from spending time
> on false paths.

Yeah, when the obfuscation patch went in, NULL was "(null)", but
that got dropped later in an argument that "(null)" should only
be printed on dereference attempts and also in an effort to make it
consistent with %pK.  I don't agree with that because "(null)" dated
back to 2009 and %pK has always been a special case, but I decided
to go with the minimal fix to avoid bike shedding.

For error pointers, at least on 64-bit they are easy to distinguish
because the upper 32 bits of the hash are cleared.

Thanks,

                Ilya
