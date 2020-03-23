Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E27C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6E120774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCWVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:42:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:42:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGUqO-001A1T-Rv; Mon, 23 Mar 2020 21:42:49 +0000
Date:   Mon, 23 Mar 2020 21:42:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 13/22] x86: ia32_setup_sigcontext(): lift
 user_access_{begin,end}() into the callers
Message-ID: <20200323214248.GF23230@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200323183819.250124-13-viro@ZenIV.linux.org.uk>
 <CAHk-=wgQjm2=Z6e9ZLffsNmnc_e2wz_W3SYTD2_EXZT7yYYbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQjm2=Z6e9ZLffsNmnc_e2wz_W3SYTD2_EXZT7yYYbRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:53:39AM -0700, Linus Torvalds wrote:
> On Mon, Mar 23, 2020 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > -static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
> > +static __always_inline int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
> 
> Please rename this at the same time (to "unsafe_ia32_setup_sigcontext()").
> 
> I absolutely _hate_ how we have historically split the "__get_user()"
> calls from the "access_ok()" calls, and then have had bugs when we had
> ways to reach the user access without checking it.
> 
> Yes, we have static checking for the unsafe stuff in objtool now, but
> I still want this to be explicit on the source level too: if you do
> unsafe user accesses, you make it very very explicit in the naming, so
> that you can't possibly even by mistake have a "let's call this
> function withou having done the user_access_begin()" calls.

Umm...  OK, but I wonder if unsafe_... makes the right naming conventions
for such cases.  Note that towards the end of that series we get

#define unsafe_put_sigcontext(sc, fpstate, regs, set, label)    \
do {                                                            \
        if (setup_sigcontext(sc, fpstate, regs, set->sig[0]))   \
                goto label;                                     \
} while(0);

and that's not an uncommon pattern.  We generally have unsafe_...
mean "doesn't return anything, takes a label, needs to be called
from under user_access_begin" and I suspect that it would make sense
to have another recognizable naming pattern for "it must be called
from under user_access_begin() and you need to look at return value".

In this case we could grit teeth and turn that sucker into a macro.
But what about e.g. lifting user_access_{begin,end}() out of
raw_copy_from_user()?  unsafe_copy_from_user() would imply
"all or nothing" kind of calling conventions, like e.g.
unsafe_copy_to_user() currently does.  Which is fine in some
situations, and it's a good helper to have, but we definitely
want a "how much is left to copy" variant as well.

Hmm...  raw_setup_sigcontext(), perhaps, along with the
macro above for unsafe_put_sigcontext()?
