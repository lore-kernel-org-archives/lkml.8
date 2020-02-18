Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00387C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1BA207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbN5HZC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgBRAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:07:29 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39783 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBRAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:07:29 -0500
Received: by mail-il1-f195.google.com with SMTP id f70so15744757ill.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoFEkHOq5avDm3Itfm0xV4MkPfliVXkfnVI2Cmo7Qwg=;
        b=NbN5HZC3ISPCmrssH0++8OFBF6RtLF1VLm/NyPi5QkMZbwK98B4oUX2UhdZfnfmF2d
         2XT5HnDr4nyg0tjtDSF1U+zvokJt5BPHPQurg5ZVqurw9SpPmk2gn8dpoEM/5TnWDpkQ
         Sd1s2t7e5SbB1Sz4TL1JiXviMmvIRYtXSJvJLyUELr0/FqAcSHwb7FxVQagaKZ3wlvyd
         0qQJ2PjiJAJL9b4hqkMbBfpYcFl7o7utDnZRi9JE8hGyTbr5k94rxM9hqNI5TFGAnzV4
         +Op8PYxBjIy5PvRDCmXuo+yfiPVJWiW9avbXurAeCMhNpsXpa3JqkbB0EN1xjq5MKAYS
         vICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoFEkHOq5avDm3Itfm0xV4MkPfliVXkfnVI2Cmo7Qwg=;
        b=rJ/ehtu+T57DGPqe8wVL2I5d7Mcs5IgFJm59PH467cUH8VYlHyO6h4h5dyu20GOKQq
         wERkFb69xxEZMRO0mEEkRr59ftCu9QWSVmyQ2txV/gQheZWJizX8UptopG/k2s1HEKS9
         RflDCbibAQYQ/f7+35g3gCXHqI8srNbG+IpBCfzUdPfjgxHedrDU5S9HmO5dJccsxEGV
         G0zB2oh6VkiWpOTRsa41/D2MulJjyoIULCISr5GiGhdyvmkP5+w6pYgze2MuuBxvw0zA
         kgCGRrpXXi2ciJzB9jsBi26PlqXHf4AQJQCGhq0VLUoVQa4JeeXQzJFno7T47oMEBMvc
         V8vQ==
X-Gm-Message-State: APjAAAXR6oDdvLyqDKw7QoOcZglNiTuJncJ5OZ23e9k2W/8wFyhjZT/O
        s26djxvvIdcramsW1NERKU9BuRDVIBeH57+v8FamGa9T17k=
X-Google-Smtp-Source: APXvYqzZ3IseYxThnaoGo74JS4UF6XMsBQ9+GMqTIp2aoI2io2YxacywjmNzepSMZW4nquqluS8GhkEY2x0VqH9wysM=
X-Received: by 2002:a92:3a8d:: with SMTP id i13mr17923948ilf.112.1581984448443;
 Mon, 17 Feb 2020 16:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
In-Reply-To: <202002171546.A291F23F12@keescook>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 18 Feb 2020 01:07:53 +0100
Message-ID: <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:47 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 17, 2020 at 11:28:03PM +0100, Ilya Dryomov wrote:
> > I don't see what security concern is addressed by obfuscating NULL
> > and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> > of sites where %p is used (over 10000) and the fact that NULL pointers
> > aren't uncommon, it probably wouldn't take long for an attacker to
> > find the hash that corresponds to 0.  Although harder, the same goes
> > for most common error values, such as -1, -2, -11, -14, etc.
> >
> > The NULL part actually fixes a regression: NULL pointers weren't
> > obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> > dereferencing invalid pointers") which went into 5.2.  I'm tacking
> > the IS_ERR() part on here because error pointers won't leak kernel
> > addresses and printing them as pointers shouldn't be any different
> > from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> > debugging based on existing pr_debug and friends excruciating.
> >
> > Note that the "always print 0's for %pK when kptr_restrict == 2"
> > behaviour which goes way back is left as is.
> >
> > Example output with the patch applied:
> >
> >                             ptr         error-ptr              NULL
> > %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> > %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> > %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000
>
> This seems reasonable. Though I wonder -- since the efault string is
> exposed now -- should this instead print all the error-ptr strings
> instead of the unsigned negative pointer value?

I'm not sure what you mean by efault string.  Are you referring to what
%pe is doing?  If so, no -- I would keep %p and %pe separate.

Thanks,

                Ilya
