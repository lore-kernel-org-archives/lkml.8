Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B94DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C8120899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593720822;
	bh=V1mGD+WcVwqJtI3De7HRKQK2CbpJSCu0TaBaDkLvr5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lcU91NYPZG5iY8ZlE91I+OvbVsVdP/Qs6N21xHMe4MwaM26PXKBlPuU3a2BJLDUAv
	 jKJ4w7fTpjbGhjv/Jdjzq6akzhOPGsocUr37twyODVUQts+A5qAj+GBle4laxmNH66
	 X00SOOrra0bkLXQwMACbS5rcJYneZ6aYJLODsA38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGBUNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:13:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:13:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so33800595ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2cxC2G42fruU9YdkmbCscagSDf6t96aQCpiutnLY+g=;
        b=DplINtv0upehX4JKVd1BaB5fDTBrK0Tpj6XHJusYd3DBT15AFa6OeN3s8ZDNK+FyEi
         mlIaXr4aZ5fRHhgOjj0wMhKdldjgKDPEEFpofCOXVKgG24eXsbrAoVLcOEgjkgZ+O5f9
         /Wsp7kcTOMkLYf+9QrtBTNzYP2+yfpBIicKhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2cxC2G42fruU9YdkmbCscagSDf6t96aQCpiutnLY+g=;
        b=gbAtT43viVqfNRLb55Dy76C8wqNh8ETQeDJ4QBJk3Qoavdo2rG5SjO4U0lg7UVH84I
         HjbcJb5wQ9SbFAhTHnftLtBDhbeRBk7Palb7UdsDfpg3V7U/FlkvPYJiL67qFkgeZz3v
         s9p6FQFKlzT52likPMzvKS0Uea5YXow8ODCSPkHR89tjU5R2lCrsChmZMaZHw0SdYwcr
         J3rs/vZySgEbs5RpDgegw9DQ1yJ+bcGKL/7r6zk97UmRApl1UJeitXUYAXBbTc5WGebW
         TxWyY0JGKd1kR3ksph8qFYo0eMUSORy9PAPzcd7IuFHW3vOQnAy33yZ+haIXPkeaIhgn
         BBCA==
X-Gm-Message-State: AOAM531wPBxtrwR+jPiTQPZnd1wCfo+B1E/ZmtDE8VgzpYzksMqgrTKP
        pbbIg1TC8Ctsi/xq4TidWL79hWUviQU=
X-Google-Smtp-Source: ABdhPJyGY6cOnf4HaQQhbtW6oGwHwMOYnl1P4N57vDYmS1d19yFu3NbyRPlrArPBgIzWwdLqRV5utA==
X-Received: by 2002:a2e:8ed6:: with SMTP id e22mr12900245ljl.426.1593720817527;
        Thu, 02 Jul 2020 13:13:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v3sm3330705ljj.110.2020.07.02.13.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 13:13:36 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h22so26686658lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:13:36 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2566985ljj.312.1593720815949;
 Thu, 02 Jul 2020 13:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
In-Reply-To: <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 13:13:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNbR76bJSkYKSd4-iHBcksZaw=_3Dy7eELxPVuv5wa5g@mail.gmail.com>
Message-ID: <CAHk-=whNbR76bJSkYKSd4-iHBcksZaw=_3Dy7eELxPVuv5wa5g@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Thu, Jul 2, 2020 at 8:13 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Isn't it something easy to do in bad_page_fault() ?

Can't the user access functions take any other faults on ppc?

On x86-64, we have the "address is non-canonical" case which doesn't
take a page fault at all, but takes a general protection fault
instead.

But note that depending on how you nest and save/restore the state,
things can be very subtle.

For example, what can happen is:

 (a) user_access_begin()..

 (b) we take a normal interrupt

 (c) the interrupt code does something that has an exception handling
case entirely unrelated to the user access (on x86, it might be the
"unsafe_msr' logic, for example.

 (d) we take that exception, do "fixup_exception()" for whatever that
interrupt did.

 (e) we return from that exception to the fixed up state

 (d) we return from the interrupt

 (e) we should still have user accesses enabled.

NOTE! on x86, we can have "all fixup_exceptions() will clear AC in the
exception pt_regs", because AC is part of rflags which is saved on
(and cleared for the duration of) all interrupt and exceptions.

So what happens is that on x86 all of (b)-(d) will run with AC clear
and no user accesses allowed, and (e) will have user accesses enabled
again, because the "fixup_exception()" at (d) only affected the state
of the interrupt hander (which already had AC clear anyway).

But I don't think exceptions and interrupts save/restore the user
access state on powerpc, do they?

So on powerpc you do need to be more careful. You would only need to
disable user access on exceptions that happen _on_ user accesses.

The easiest way to do that is to do what x86 does: different
exceptions have different handlers. It's not what we did originally,
but it's been useful.

Hmm.

And again, on x86, this all works fine because of how exceptions
save/restore the user_access state and it all nests fine. But I'm
starting to wonder how the nesting works AT ALL for powerpc?

Because that nesting happens even without

IOW, even aside from this whole thing, what happens on PPC, when you have

 (a) user_access_begin();
     - profile NMI or interrupt happens
     - it wants to do user stack tracing so does
                pagefault_disable();
       (b)         get_user();
                pagefault_enable();
   - profile NMI/interrupt returns
 (c) user accesss should work here!

even if the "get_user()" in (b) would have done a
"user_access_begin/end" pair, and regardless of whether (b) might have
triggered a "fixup_exception()", and whether that fixup_exception()
then did the user_access_end().

On x86, this is all ok exactly because of how we only have the AC bit,
and it nests very naturally with any exception handling.

Is the ppc code nesting-safe? Particularly since it has that whole
range-handling?

                 Linus
