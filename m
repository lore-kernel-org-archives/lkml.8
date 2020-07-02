Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C43421534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGBU7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:59:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:59:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr6IQ-004AR1-1t; Thu, 02 Jul 2020 20:59:02 +0000
Date:   Thu, 2 Jul 2020 21:59:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200702205902.GP2786714@ZenIV.linux.org.uk>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:32:34PM -0700, Linus Torvalds wrote:

> Ugh, the above is bad anyway.
> 
> It doesn't use _ASM_EXTABLE_UA, so it won't warn about the noncanonical cases.

FWIW, the address is inside a sigframe we decided to build, so noncanonical
addresses shouldn't occur in practice.

> Yeah, it would need to be turned into a "jump out" instead of just "jump over".
> 
> Which it damn well should do anyway.,
> 
> That code should be taken behind a shed and shot. It does so many
> things wrong that it's not even funny. It shouldn't do stac/clac on
> its own.
>
> At least it could use the "user_insn()" helper, which does it inside
> the asm itself, has the right might_fault() marking (but not the
> address check), and which can be trivially changed to have the fixup
> jump be to after the "ASM_CLAC".

I'm not sure it's the right solution in this case.  Look at the call chain
and the stuff done nearby (that __clear_user(), for example)...

I'm not saying that this code is not awful - it certainly is.  But it's
not that simple, unfortunately ;-/
