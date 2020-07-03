Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE3F20885
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGCWM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGCWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:12:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF4C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:12:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTut-004r8S-IE; Fri, 03 Jul 2020 22:12:19 +0000
Date:   Fri, 3 Jul 2020 23:12:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200703221219.GV2786714@ZenIV.linux.org.uk>
References: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:10:08PM -0700, Linus Torvalds wrote:

> Yeah, the "stac" instruction isn't hugely fast, and serializes the
> pipeline, so it's a nasty 20 cycles or something.
> 
> But for chissake, this
>  (a) happens approximately never
>  (b) is after a fault that took a thousand cycles
> 
> so the trivial thing to do is to just say "yeah, you need to add the
> STAC when your optimistic thing failed and you have to fall back to
> the byte-at-a-time tail case".

Not the problem I'm concerned about, really.  However, I would really
like to lift stac/clac into the *callers* of raw_copy_from_user()
et.al. and fold them into user_access_begin/user_access_end there.

And that's where the rules become very interesting - raw_copy_from_user()
is not "succeed or fail" thing, it's "tell me how much has been left
to copy" one.  Put it that way - here we really do have outputs on
fault.

PS: I hope to kill __copy_from_user()/__copy_to_user() outside of
arch/* this cycle; not much is left by now.  So I'm not talking about
lifting stac/clac out into the wild - it will merge with access_ok
into user_access_begin/end.
