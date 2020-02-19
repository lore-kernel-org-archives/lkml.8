Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E55C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3411E24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBSOqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:46:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgBSOqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:46:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03177ACD6;
        Wed, 19 Feb 2020 14:45:59 +0000 (UTC)
Date:   Wed, 19 Feb 2020 15:45:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
Message-ID: <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:
> On 19/02/2020 14.48, Petr Mladek wrote:
> > On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
> >> --- a/lib/vsprintf.c
> >> +++ b/lib/vsprintf.c
> > The test should go into null_pointer() instead of errptr().
> 
> Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
> way. But I should add a #else section that tests how %pe behaves without
> CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.

OK, we should agree on some structure first.

We already have two top level functions that test how a particular
pointer is printed using different pointer modifiers:

	null_pointer();     -> NULL with %p, %pX, %pE
	invalid_pointer();  -> random pointer with %p, %pX, %pE

Following this logic, errptr() should test how a pointer from IS_ERR() range
is printed using different pointer formats.

I am open to crate another logic but it must be consistent.
If you want to check %pe with NULL in errptr(), you have to
split the other two functions per-modifier. IMHO, it is not
worth it.

Sigh, I should have been more strict[*]. The function should have been
called err_ptr() and located right below null_pointer().

[*] I am still trying to find a right balance between preventing
nitpicking, bikeshedding, enforcing my style, and creating a mess.


> > Could you send updated patch, please? ;-)
> 
> I'll wait a day or two for more comments. It doesn't seem very urgent.

Sure.


> >> BTW., your original patch for %p lacks corresponding update of
> >> test_vsprintf.c. Please add appropriate test cases.
> > 
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 2d9f520d2f27..1726a678bccd 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
> >  static void __init
> >  null_pointer(void)
> >  {
> > -	test_hashed("%p", NULL);
> > +	test(ZEROS "00000000", "%p", NULL);
> 
> No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
> (where one of course has to use explicit integers and not E* constants).

Yes, it would be great to add checks for %p, %px for IS_ERR() range.
But it is different story. The above change is for the original patch
and it was about NULL pointer handling.

Best Regards,
Petr
