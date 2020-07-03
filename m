Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638CCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35997206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NKXAWMb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGCD50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:57:26 -0400
Received: from ozlabs.org ([203.11.71.1]:45449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCD5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:57:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49yh4K5vY8z9sR4;
        Fri,  3 Jul 2020 13:57:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593748641;
        bh=0FP7DbOrN/cYY/DD+/5F6Rm6Xxx7RN241hFaijl6Wco=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NKXAWMb4QHaALgYOYJn8VBYhcqM1Ccx5r/41Dij6CfI+ILSzt6mICcoO7imLy8yAK
         zY6i1jt3rTnJMC2k3NqKibN8h/WEecuYt2RoyjR4IoaUSIe4OZalzxh/S8SVY9/IFW
         wnou+hEieLZewmhV5FIuFO6IyDoHZ4aPQRvu/G/N/nRjU0c3Bn7i7WqOC5/c/QxCV1
         gXMBIYLh7sJG4wJwa1KeSOHBp5WBwMu0ozeJI2ds7al0v4o6KiHVfM5IzzmCBNs5XA
         GSrzr4WnMhdCENH8Ho9z70YINABf39djwZu721UsVzLZvQJp1JaPpjMuLIyCs+SXQi
         iLoDrooEgercg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
In-Reply-To: <CAHk-=whNbR76bJSkYKSd4-iHBcksZaw=_3Dy7eELxPVuv5wa5g@mail.gmail.com>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com> <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com> <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com> <87lfk26nx4.fsf@mpe.ellerman.id.au> <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu> <CAHk-=whNbR76bJSkYKSd4-iHBcksZaw=_3Dy7eELxPVuv5wa5g@mail.gmail.com>
Date:   Fri, 03 Jul 2020 13:59:37 +1000
Message-ID: <87eept6yfq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Thu, Jul 2, 2020 at 8:13 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> Isn't it something easy to do in bad_page_fault() ?
>
> Can't the user access functions take any other faults on ppc?

Yes they definitely can.

I think I can enumerate all the possibilities on 64-bit, but I don't
know all the possibilities on all the 32-bit variants.

> On x86-64, we have the "address is non-canonical" case which doesn't
> take a page fault at all, but takes a general protection fault
> instead.

Right. On P9 radix we have an address-out-of-page-table-range exception
which I guess is similar, though that does end up at bad_page_fault() in
our case.

> But note that depending on how you nest and save/restore the state,
> things can be very subtle.
>
> For example, what can happen is:
>
>  (a) user_access_begin()..
>
>  (b) we take a normal interrupt
>
>  (c) the interrupt code does something that has an exception handling
> case entirely unrelated to the user access (on x86, it might be the
> "unsafe_msr' logic, for example.
>
>  (d) we take that exception, do "fixup_exception()" for whatever that
> interrupt did.
>
>  (e) we return from that exception to the fixed up state
>
>  (d) we return from the interrupt
>
>  (e) we should still have user accesses enabled.

Yes.

We broke that a few times when developing the KUAP support, which is why
I added bad_kuap_fault() to report the case where we are in a uaccess
region but are being blocked unexpectedly by KUAP.

> NOTE! on x86, we can have "all fixup_exceptions() will clear AC in the
> exception pt_regs", because AC is part of rflags which is saved on
> (and cleared for the duration of) all interrupt and exceptions.
>
> So what happens is that on x86 all of (b)-(d) will run with AC clear
> and no user accesses allowed, and (e) will have user accesses enabled
> again, because the "fixup_exception()" at (d) only affected the state
> of the interrupt hander (which already had AC clear anyway).
>
> But I don't think exceptions and interrupts save/restore the user
> access state on powerpc, do they?

Not implicitly.

We manually save it into pt_regs on the stack in the exception entry. On
64-bit it's done in kuap_save_amr_and_lock. 32-bit does it in
kuap_save_and_lock.

And then on the return path it's kuap_restore_amr() on 64-bit, and
kuap_restore on 32-bit.

> So on powerpc you do need to be more careful. You would only need to
> disable user access on exceptions that happen _on_ user accesses.
>
> The easiest way to do that is to do what x86 does: different
> exceptions have different handlers. It's not what we did originally,
> but it's been useful.
>
> Hmm.
>
> And again, on x86, this all works fine because of how exceptions
> save/restore the user_access state and it all nests fine. But I'm
> starting to wonder how the nesting works AT ALL for powerpc?
>
> Because that nesting happens even without
>
> IOW, even aside from this whole thing, what happens on PPC, when you have

I'll annotate what happens for the 64-bit case as it's the one I know
best:

>  (a) user_access_begin();
         - mtspr(SPRN_AMR, 0)	// 0 means loads & stores permitted

>      - profile NMI or interrupt happens
         - pt_regs->kuap = mfspr(SPRN_AMR)
         - mtspr(SPRN_AMR, AMR_KUAP_BLOCKED)

>      - it wants to do user stack tracing so does
>                 pagefault_disable();
>        (b)         get_user();
                     mtspr(SPRN_AMR, 0)
                     ld rN, <user pointer)
                     mtspr(SPRN_AMR, AMR_KUAP_BLOCKED)
                     
>                 pagefault_enable();
>    - profile NMI/interrupt returns
       - mtspr(SPRN_AMR, pt_regs->kuap)
       - return from interrupt

>  (c) user accesss should work here!
>
> even if the "get_user()" in (b) would have done a
> "user_access_begin/end" pair, and regardless of whether (b) might have
> triggered a "fixup_exception()", and whether that fixup_exception()
> then did the user_access_end().
>
> On x86, this is all ok exactly because of how we only have the AC bit,
> and it nests very naturally with any exception handling.
>
> Is the ppc code nesting-safe? Particularly since it has that whole
> range-handling?

Yeah I think it is.

The range handling on 32-bit books follows the same pattern as above,
except that on exception entry we don't save the content of an SPR to
pt_regs, instead we save current->thread.kuap. (Because there isn't a
single SPR that contains the KUAP state).

cheers
