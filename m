Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F6AC11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2920828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXJzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:55:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:38056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXJzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:55:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D88EAC0C;
        Mon, 24 Feb 2020 09:55:02 +0000 (UTC)
Date:   Mon, 24 Feb 2020 10:55:01 +0100
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
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
Message-ID: <20200224095501.ds7pbjwj2izmcvus@pathway.suse.cz>
References: <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
 <20200220125707.hbcox3xgevpezq4l@pathway.suse.cz>
 <CAOi1vP8E_DL7y=STP5-vbe_Wf5PZRiXWGTNV3rN96i4N2R3zUQ@mail.gmail.com>
 <20200221130506.mly26uycxpdjl6oz@pathway.suse.cz>
 <cec0c65b-5b5d-6268-dae0-1d4088baab76@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec0c65b-5b5d-6268-dae0-1d4088baab76@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-02-22 00:52:27, Rasmus Villemoes wrote:
> On 21/02/2020 14.05, Petr Mladek wrote:
> > On Thu 2020-02-20 16:02:48, Ilya Dryomov wrote:
> 
> >> I would like to see it in 5.6, so that it is backported to 5.4 and 5.5.
> > 
> Sorry to be that guy, but yes, I'm against changing the behavior of
> vsnprintf() without at least some test(s) added to the test suite - the
> lack of machine-checked documentation in the form of tests is what led
> to that regression in the first place.

I would not call this regression. It was intentional. The change in
5.2 unified the behavior for the other %p? modifiers. I simply did
not care about plain %p because it was already crippled by the hashing.

I am fine with the proposed change. But the more I think about it
the less I want to rush it in for 5.6. The proposed patch changes
the behavior again:

Value           Output v5.1       Output v5.2      Proposal

NULL                       (null) 00000000<.hash.> 0000000000000000
fffffffffffffffe 00000000<.hash.> 00000000<.hash.> fffffffffffffffe
ffffffff12345678 00000000<.hash.> 00000000<.hash.> 00000000<.hash.>

I do not want to change this in rc phase. I would really like to wait
for 5.7.


> But I agree that there's no point adding another helper function and
> muddying the test suite even more (especially as the name error_pointer
> is too close to the name errptr() I chose a few months back for the %pe).
> 
> So how about
> 
> - remove the now stale test_hashed("%p", NULL); from null_pointer()
> - add tests of "%p", NULL and "%p", ERR_PTR(-123) to plain()
> 
> and we save testing the "%px" case for when we figure out a good name
> for a helper for that (explicit_pointer? pointer_as_hex?)

In this, case I would prefer to fix the tests properly first. There
have been only few commits in lib/test_printf.c since 5.2. And they
should not conflict with the changes proposed at
https://lkml.kernel.org/r/20200220125707.hbcox3xgevpezq4l@pathway.suse.cz
So it should be easy to backport as well.

If you want, I could sent the cleanup patch properly for review.

Best Regards,
Petr
