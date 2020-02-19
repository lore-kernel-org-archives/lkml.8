Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB2AC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB820801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBSNsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:48:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgBSNsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:48:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97F7CBF3D;
        Wed, 19 Feb 2020 13:48:27 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:48:26 +0100
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
Message-ID: <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
> On 19/02/2020 12.20, Ilya Dryomov wrote:
> > On Wed, Feb 19, 2020 at 9:21 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> Extend %pe to pretty-print NULL in addition to ERR_PTRs,
> >> i.e. everything IS_ERR_OR_NULL().
> >>
> >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >> Something like this? The actual code change is +2,-1 with another +1
> >> for a test case.
> >>
> >>  Documentation/core-api/printk-formats.rst | 9 +++++----
> >>  lib/errname.c                             | 4 ++++
> >>  lib/test_printf.c                         | 1 +
> >>  lib/vsprintf.c                            | 4 ++--
> >>  4 files changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> >> index 8ebe46b1af39..964b55291445 100644
> >> --- a/Documentation/core-api/printk-formats.rst
> >> +++ b/Documentation/core-api/printk-formats.rst
> >> @@ -86,10 +86,11 @@ Error Pointers
> >>
> >>         %pe     -ENOSPC
> >>
> >> -For printing error pointers (i.e. a pointer for which IS_ERR() is true)
> >> -as a symbolic error name. Error values for which no symbolic name is
> >> -known are printed in decimal, while a non-ERR_PTR passed as the
> >> -argument to %pe gets treated as ordinary %p.
> >> +For printing error pointers (i.e. a pointer for which IS_ERR() is
> >> +true) as a symbolic error name. Error values for which no symbolic
> >> +name is known are printed in decimal. A NULL pointer is printed as
> >> +NULL. All other pointer values (i.e. anything !IS_ERR_OR_NULL()) get
> >> +treated as ordinary %p.
> >>
> >>  Symbols/Function Pointers
> >>  -------------------------
> >> diff --git a/lib/errname.c b/lib/errname.c
> >> index 0c4d3e66170e..7757bc00f564 100644
> >> --- a/lib/errname.c
> >> +++ b/lib/errname.c
> >> @@ -11,9 +11,13 @@
> >>   * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
> >>   * on mips), so this wastes a bit of space on those - though we
> >>   * special case the EDQUOT case.
> >> + *
> >> + * For the benefit of %pe being able to print any ERR_OR_NULL pointer
> >> + * symbolically, 0 is also treated specially.
> >>   */
> >>  #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
> >>  static const char *names_0[] = {
> >> +       [0] = "NULL",
> >>         E(E2BIG),
> >>         E(EACCES),
> >>         E(EADDRINUSE),
> >> diff --git a/lib/test_printf.c b/lib/test_printf.c
> >> index 2d9f520d2f27..3a37d0e9e735 100644
> >> --- a/lib/test_printf.c
> >> +++ b/lib/test_printf.c
> >> @@ -641,6 +641,7 @@ errptr(void)
> >>         test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
> >>         test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
> >>         test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
> >> +       test("[NULL]", "[%pe]", NULL);
> >>  #endif
> >>  }
> >>
> >> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> >> index 7c488a1ce318..b7118d78eb20 100644
> >> --- a/lib/vsprintf.c
> >> +++ b/lib/vsprintf.c
> >> @@ -2247,8 +2247,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >>         case 'x':
> >>                 return pointer_string(buf, end, ptr, spec);
> >>         case 'e':
> >> -               /* %pe with a non-ERR_PTR gets treated as plain %p */
> >> -               if (!IS_ERR(ptr))
> >> +               /* %pe with a non-ERR_OR_NULL ptr gets treated as plain %p */
> >> +               if (!IS_ERR_OR_NULL(ptr))
> >>                         break;
> > 
> > FWIW I was about to post a patch that just special cases NULL here.
> > 
> > I think changing errname() to return "NULL" for 0 is overkill.
> > People will sooner or later discover that function and start using it
> > in contexts that don't have anything to do with pointers.  Returning
> > _some_ string for 0 (instead of NULL) makes it very close to standard
> > strerror(), and "NULL" for 0 (i.e. success) seems rather odd.
> 
> I see what you mean, but I don't share your assumption that errname()
> will ever grow callers other than the one in vsprintf.c. But I don't
> have any strong opinion either way. Perhaps this on top of my patch
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -619,7 +619,7 @@ static char *err_ptr(char *buf, char *end, void *ptr,
>                      struct printf_spec spec)
>  {
>         int err = PTR_ERR(ptr);
> -       const char *sym = errname(err);
> +       const char *sym = err ? errname(err) : "NULL";

I like this more than adding "NULL" errname.


>         if (sym)
>                 return string_nocheck(buf, end, sym, spec);
> 
> instead of the change(s) in errname.c? And then the test case for
> '"%pe", NULL' should also be moved outside CONFIG_SYMBOLIC_ERRNAME.

The test should go into null_pointer() instead of errptr().

Could you send updated patch, please? ;-)


> BTW., your original patch for %p lacks corresponding update of
> test_vsprintf.c. Please add appropriate test cases.

Good point. The existing test_hashed() is rather weak
and it did not catch this change.

It would be nice to make test_hash() more powerful.
Anyway, the minimal udpate would be:

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..1726a678bccd 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
 static void __init
 null_pointer(void)
 {
-	test_hashed("%p", NULL);
+	test(ZEROS "00000000", "%p", NULL);
 	test(ZEROS "00000000", "%px", NULL);
 	test("(null)", "%pE", NULL);
 }


Best Regards,
Petr
