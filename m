Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1820890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593812519;
	bh=bpZjGfQKrKS6KNmx3IUauu8TOTfvDgOH+NShifVoLG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Z++0p7+bmUsNxSKhYewDYZxL43gkPSH2JykhnK94iXLf1UAmYQF13/eCbnDbFIwL
	 /lpJlGsNvc0c70bBu/v8F5IoYvtqFoj5xDqyFs9+RznirNLGW51SBPh/qoXe7lgPWj
	 C1iCJj/2JLhpS1UjQkIrlbDfctCEdpEYVGjRn+ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGCVl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgGCVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:41:57 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4429820BED
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593812516;
        bh=bpZjGfQKrKS6KNmx3IUauu8TOTfvDgOH+NShifVoLG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hgl8YWMbRH3+fldivO7im6NZF9fJ6s9iX2FjcuN05k3xUhBydSHZdL3DejPIRCFut
         32dL7ax8Del9eIy196Fsn8Lys1zNbSQNr6zM2+bcMJ3IM7FVdrBF2BrYVCVv9cFytZ
         YwJvUbM+7hLkPXyLIWoo287xtguW+kO2zNc+Ncq8=
Received: by mail-wr1-f44.google.com with SMTP id s10so34068745wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:41:56 -0700 (PDT)
X-Gm-Message-State: AOAM530XuVn1aR4QR81xbZqqRGRFghGgUVJkSOjMWjh04NPPCD7t1Oq1
        Mw0jF7RN9VppzO+0Ap2Wkd0ATSIFq/jfZfJtFcBCnA==
X-Google-Smtp-Source: ABdhPJwuIUZ9xfx4aKLnJWkC3vxFHnQSr+RRjl6pdgA88sPg4ACjJkthg1gtU3OzTj8hrKW9tf+UcTKpdbAhtRC4AP0=
X-Received: by 2002:adf:f707:: with SMTP id r7mr37948364wrp.70.1593812514812;
 Fri, 03 Jul 2020 14:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk> <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 3 Jul 2020 14:41:43 -0700
X-Gmail-Original-Message-ID: <CALCETrUpmTqHbZ_XtGhOqFQ4iWQ5bSqppXsHzaGVGdGqBCra0Q@mail.gmail.com>
Message-ID: <CALCETrUpmTqHbZ_XtGhOqFQ4iWQ5bSqppXsHzaGVGdGqBCra0Q@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 2:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 3, 2020 at 2:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Actually, for more serious problem consider arch/x86/lib/copy_user_64.S
>
> What? No.
>
> > In case of an unhandled fault on attempt to read an (unaligned) word,
> > the damn thing falls back to this:
> > SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> >         movl %edx,%ecx
> > 1:      rep movsb
> > 2:      mov %ecx,%eax
> >         ASM_CLAC
> >         ret
> >
> >         _ASM_EXTABLE_UA(1b, 2b)
> > SYM_CODE_END(.Lcopy_user_handle_tail)
>
> In the case of "we did an unaligned word at the end of a page, we took
> a fault, and now we have to start all over", the _least_ of our
> problems is that part of "starting over" would now imply doing a
> "stac" again.
>
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
>
> It's particularly trivial since objtool would statically find all
> these places, since it would warn about the ASM_CLAC without a STAC
> (that's assuming Josh's patch, of course).
>

I still feel like the ex_handler-automatically-does-CLAC thing is an
optimization that isn't worth it.  Once we pull our heads out of the
giant pile of macros and inlined functions, we're talking about
changing:

stac
1: mov something, somewhere
2: clac
... exception table entry pointing to 2 ...

to

stac
1: mov something, somewhere
clac
2:
... exception table entry pointing to 2 ...

Now maybe the pattern:

if (get_user(...))
  goto bad;

gets a bit improved because we don't need to emit a fixup that does
clac; jmp.  But on the flip side, the jump folding pattern looks
better like this:

unsafe_uaccess_begin();
if (unsafe_get_user(...))
  goto fail;
if (unsafe_get_user(...))
  goto fail;
unsafe_uaccess_end();

fail:
  unsafe_uaccess_end();

than like:

unsafe_uaccess_begin();
if (unsafe_get_user(...))
  goto fail;
if (unsafe_get_user(...))
  goto fail;
unsafe_uaccess_end();

fail:
  /* not unsafe_uaccess_end(); because unsafe_get_user() has
conditional-CLAC semantics */

And we really really do not want to ever see this:

int err;
unsafe_uaccess_begin();
err = unsafe_get_user(...);
if (err == 0)
  unsafe_uaccess_end();  /* WTF?!? */

So I feel like this is all putting the cart before the horse.  Can we
make everything work sanely without the automatic CLAC and then, if it
actually improves something, add an optional ex_handler_uaccess_clac
for the cases that benefit?  I'm totally fine with burying:

unsafe_get_user_jump(..., error_label);
error_label:
  /* we know unsafe_uaccess_end() already happened here */

in an inline function here if it meaningfully improves code
generation, but this is counter-intuitive code and I think we should
treat it as such.

--Andy
