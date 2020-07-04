Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E40206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGDAuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:50:13 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B9C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 17:50:13 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrWNT-004w6G-Cd; Sat, 04 Jul 2020 00:49:59 +0000
Date:   Sat, 4 Jul 2020 01:49:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200704004959.GY2786714@ZenIV.linux.org.uk>
References: <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703210237.GS2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:02:37PM +0100, Al Viro wrote:

> PS: I'm still going through the _ASM_EXTABLE... users on x86, so there
> might be more fun.  Will post when I'm done...

Lovely...  Not directly related to that, but... WTF?

arch/x86/lib/csum-copy_64.S:

        /*
         * No _ASM_EXTABLE_UA; this is used for intentional prefetch on a
         * potentially unmapped kernel address.
         */
        .macro ignore L=.Lignore
30:
        _ASM_EXTABLE(30b, \L)
        .endm

...
        ignore 2f
        prefetcht0 5*64(%rdi)
2:

(and no other users of 'ignore' anywhere).  How could prefetcht0 possibly
raise an exception?  Intel manual says that the only exception is #UD if
LOCK PREFETCHT0 is encountered; not here, obviously.  AMD manual simply
says "no exceptions".  Confused...

Incidentally, in the same file:
SYM_FUNC_START(csum_partial_copy_generic)
        cmpl    $3*64, %edx
        jle     .Lignore

.Lignore:
....

And it had been that way since "[PATCH] Intel x86-64 support merge" back
in 2004, where we had
@@ -59,15 +59,6 @@ csum_partial_copy_generic:
        cmpl     $3*64,%edx
        jle      .Lignore
 
-       ignore
-       prefetch (%rdi)
-       ignore
-       prefetch 1*64(%rdi)
-       ignore
-       prefetchw (%rsi)
-       ignore
-       prefetchw 1*64(%rsi)
-
 .Lignore:
....
@@ -115,7 +106,7 @@ csum_partial_copy_generic:
        movq  56(%rdi),%r13
                
        ignore 2f
-       prefetch 5*64(%rdi)
+       prefetcht0 5*64(%rdi)
 2:                                                     
        adcq  %rbx,%rax
        adcq  %r8,%rax

What's going on in there?  According to AMD manual, prefetch and prefetchw
can raise an exception (#UD), if
PREFETCH/PREFETCHW are not supported, as
   indicated by ECX bit 8 of CPUID function
   8000_0001h
Long Mode is not supported, as indicated by EDX
   bit 29 of CPUID function 8000_0001h
The 3DNow! instructions are not supported, as
   indicated by EDX bit 31 of CPUID function
   8000_0001h.
so these at least used to make some sense, but why leave that thing at
the place where old prefetch became prefetcht0 and what is that comment
in front of 'ignore' definition about?  Exceptions there had never
been about unmapped addresses - that would make no sense for prefetch.

What am I missing here?
