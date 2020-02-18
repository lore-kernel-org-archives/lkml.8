Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91202206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBRKdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:33:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:48148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRKdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:33:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3420B04F;
        Tue, 18 Feb 2020 10:33:47 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:33:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
References: <20200217222803.6723-1-idryomov@gmail.com>
 <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-02-18 01:07:53, Ilya Dryomov wrote:
> On Tue, Feb 18, 2020 at 12:47 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Feb 17, 2020 at 11:28:03PM +0100, Ilya Dryomov wrote:
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
> > This seems reasonable. Though I wonder -- since the efault string is
> > exposed now -- should this instead print all the error-ptr strings
> > instead of the unsigned negative pointer value?

It would make sense to distinguish it from a hashed value that might
be in the NULL or ERR range as well.

The chance is small. But it might safe people from spending time
on false paths.

That said, I am fine to accept the patch as is. It makes sense
and it does not need to be perfect. After all, one motivation
behind the hashed %p was to make it useless and motivate people
to remove it. And I am sure that someone will send a patch adding
error-ptr sooner or later anyway ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
