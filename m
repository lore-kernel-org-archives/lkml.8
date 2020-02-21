Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E2C35655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308C1206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBUNFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:05:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:42484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgBUNFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:05:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BFE13B149;
        Fri, 21 Feb 2020 13:05:07 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:05:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
Message-ID: <20200221130506.mly26uycxpdjl6oz@pathway.suse.cz>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
 <20200220125707.hbcox3xgevpezq4l@pathway.suse.cz>
 <CAOi1vP8E_DL7y=STP5-vbe_Wf5PZRiXWGTNV3rN96i4N2R3zUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP8E_DL7y=STP5-vbe_Wf5PZRiXWGTNV3rN96i4N2R3zUQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-20 16:02:48, Ilya Dryomov wrote:
> On Thu, Feb 20, 2020 at 1:57 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2020-02-19 16:40:08, Rasmus Villemoes wrote:
> > > On 19/02/2020 15.45, Petr Mladek wrote:
> > > > On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:
> > > >> On 19/02/2020 14.48, Petr Mladek wrote:
> > > >>> On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
> > > >>>> --- a/lib/vsprintf.c
> > > >>>> +++ b/lib/vsprintf.c
> > > >>> The test should go into null_pointer() instead of errptr().
> > > >>
> > > >> Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
> > > >> way. But I should add a #else section that tests how %pe behaves without
> > > >> CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.
> > > >
> > > > OK, we should agree on some structure first.
> > > >
> > > > We already have two top level functions that test how a particular
> > > > pointer is printed using different pointer modifiers:
> > > >
> > > >     null_pointer();     -> NULL with %p, %pX, %pE
> > > >     invalid_pointer();  -> random pointer with %p, %pX, %pE
> > > >
> > > > Following this logic, errptr() should test how a pointer from IS_ERR() range
> > > > is printed using different pointer formats.
> > >
> > > Oh please. I wrote test_printf.c originally and structured it with one
> > > helper for each %p<whatever>. How are your additions null_pointer and
> > > invalid_pointer good examples for what the existing style is?
> >
> > I see, I was the one who broke the style. Please, find below a patch
> > that tries to fix it. If you agree with the approach then I could
> > split it into smaller steps.
> >
> > Also it would make sense to add checks for NULL and ERR pointer
> > into each existing %p modifier check. It will make sure that
> > check_pointer() is called in all handlers.
> >
> >
> > > So yeah, I'm going to continue testing the behaviour of %pe in errptr, TYVM.
> >
> > OK.
> >
> > > >>>> BTW., your original patch for %p lacks corresponding update of
> > > >>>> test_vsprintf.c. Please add appropriate test cases.
> > > >>>
> > > >>> diff --git a/lib/test_printf.c b/lib/test_printf.c
> > > >>> index 2d9f520d2f27..1726a678bccd 100644
> > > >>> --- a/lib/test_printf.c
> > > >>> +++ b/lib/test_printf.c
> > > >>> @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
> > > >>>  static void __init
> > > >>>  null_pointer(void)
> > > >>>  {
> > > >>> - test_hashed("%p", NULL);
> > > >>> + test(ZEROS "00000000", "%p", NULL);
> > > >>
> > > >> No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
> > > >> (where one of course has to use explicit integers and not E* constants).
> > > >
> > > > Yes, it would be great to add checks for %p, %px for IS_ERR() range.
> > > > But it is different story. The above change is for the original patch
> > > > and it was about NULL pointer handling.
> > >
> > > Wrong. The original patch (i.e. Ilya's) had subject "vsprintf: don't
> > > obfuscate NULL and error pointers" and did
> > >
> > > +     if (IS_ERR_OR_NULL(ptr))
> > >
> > > so the tests that should be part of that patch very much need to cover
> > > both NULL and ERR_PTRs passed to plain %p.
> >
> > Grr, I see. I was too fast yesterday. OK, I suggest to fix the
> > structure of the tests first. All these patches are for 5.7
> > anyway.
> 
> My patch fixes a regression introduced by 3e5903eb9cff ("vsprintf:
> Prevent crash when dereferencing invalid pointers" in 5.2, which
> made debugging based on existing pr_debugs (used extensively in some
> subsystems) very annoying.
> 
> I would like to see it in 5.6, so that it is backported to 5.4 and 5.5.

OK, it would make sense to make the patch minimalist to make it
easier for backporting.


> Please note that I sent v2 of my patch ("[PATCH v2] vsprintf: don't
> obfuscate NULL and error pointers"), fixing null_pointer() and adding
> error_pointer() test cases, which conflicts with this restructure.

IMHO, v2 creates even more mess in print tests that would need
to be fixed later.

If we agree to have a minimalist patch for backport
then I suggest to take v1. We could clean up and update
tests later.

Rasmus, others, is anyone against this approach (v1 first,
tests later)?

Best Regards,
Petr
