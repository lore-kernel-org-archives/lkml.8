Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC4C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01102073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585505801;
	bh=pSzpTRlriCgM4k/h8B3zFSb4NLIKkBZ4eow4C6fr6Wk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RruMmuZ9H30ztBAX1ScprI3XolvPpbM3SAGo/f1BEfC4mQn7AXsrhMHqPXtpSJSS1
	 zhoGSSKOiOLMp99dYzv5EeS6a8qgGXd74zonuGxAHHYT5z98Yjx2sO8cOnCUQj5hSx
	 hSwGgc2pDyRPVqcXoFLVkYbfINNDfF4RDhioy8mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgC2SQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:16:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41710 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgC2SQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:16:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id z23so12151619lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+p2OwdEH3KOQt7UScUIEx2C+Hv3WCMmiopajHPvFEzc=;
        b=TEnX/1oGd0WrxjO90s1W75xZ4j/3mxfYUZZqQ1cVXy0s5ncLrAPaNiD1TKrNAUIb7b
         1nj9qPlZrlGMa3Eern3Gq9aE89JzCVM/fFIYH9oxprYJTP2bPfnPWAnhKrwl1dYWg+ab
         t63T2jdrZaxiUjhSnoGBD7DiKOpaU6X7/VSkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+p2OwdEH3KOQt7UScUIEx2C+Hv3WCMmiopajHPvFEzc=;
        b=WBWVbipdsdmjmH/as2wkdTaHz3oe2APZMvwZ6D2ucfsyiKgT0xzx16aQVGI9p7Lvwc
         f1izWw3UfqDg2yDwj0rbJ36MZjO4ZepAPTNChPuwqA/Ez4mw6udbLuMFtG7wciqwjPmc
         xSXapiKfV2YOi+DzpnoP29l+QJy6X8570+T3xgghPts+2tJwqxi8ufVqBdDfhXhkCH+G
         WUsqtVTf4VUFi3j45PfRft2O1GBjhmwEpyi72JX9z4xt/NHdJhJP8ncvo8xd42GdyD9s
         DkHKoYq49B41l/7XhQ83j9HiTkMM5lGMS8+lbvhMOu5rG1mYj9UgtzbUcWlplQuNuaRY
         xivg==
X-Gm-Message-State: AGi0PuarIVfOIhbinqifLJRdZ+h3zK8ovHACKhzHGdz0fsuh6bO8NY/U
        j5Gc4bN0JDgM7DyTT79yW8A7qv5I5J0=
X-Google-Smtp-Source: APiQypLX5Pq4x4WZRupDYbV05TKmFgG6O2cgFx0NsXhIpl8CIB0e5fGe9/7MmMTkFdXP5jfRg1gVXQ==
X-Received: by 2002:a19:4c44:: with SMTP id z65mr5953095lfa.203.1585505796419;
        Sun, 29 Mar 2020 11:16:36 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v12sm5870697ljh.6.2020.03.29.11.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 11:16:35 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id n20so12108694lfl.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:16:35 -0700 (PDT)
X-Received: by 2002:a19:7f96:: with SMTP id a144mr5872846lfd.31.1585505795085;
 Sun, 29 Mar 2020 11:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com>
In-Reply-To: <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 11:16:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
Message-ID: <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:03 AM David Laight <David.Laight@aculab.com> wrote:
>
> > That's how get_user() already works.
> >
> > It is a polymorphic function (done using macros, sizeof() and ugly
> > compiler tricks) that generates a call, yes. But it's not a normal C
> > call. On x86-64, it returns the error code in %rax, and the value in
> > %rdx
>
> I must be mis-remembering the object code from last time
> I looked at it.

On an object code level, the end result actually almost looks like a
normal call, until you start looking at the exact register passing
details.

On a source level, it's anything but.

This is "get_user()" on x86:

  #define get_user(x, ptr)                                              \
  ({                                                                    \
        int __ret_gu;                                                   \
        register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);            \
        __chk_user_ptr(ptr);                                            \
        might_fault();                                                  \
        asm volatile("call __get_user_%P4"                              \
                     : "=a" (__ret_gu), "=r" (__val_gu),                \
                        ASM_CALL_CONSTRAINT                             \
                     : "0" (ptr), "i" (sizeof(*(ptr))));                \
        (x) = (__force __typeof__(*(ptr))) __val_gu;                    \
        __builtin_expect(__ret_gu, 0);                                  \
  })

and all it actually *generates* is that single "call" instruction, so
the only code you see from the above mess in the object file (assuming
you don't have debugging enabled that expands "might_fault()" into a
lot of checking code) is something like this:

        call __get_user_4

with the input address being in %rax (which is also the returning
error code), and the value of 'x' being in %rdx.

The above macro looks a bit messy, but that's actually hiding some of
the real complexity (that "__inttype()" thing is a mess of compiler
tricks in itself, as is the magical ASM_CALL_CONSTRAINT thing, along
with the magic that goes into a 64-bit return value on x86-32 which is
implicit in the magical register asm() definition).

The uaccess code is a lot of complex macros and inline functions to
make it all work well.

Al's uaccess cleanups (which should be in the next merge window) help
a _lot_. Not with the get_user() above (that is already about as
simple as it can get), but with a lot of the other crazy special cases
that we had grown over the years.

My current "unsafe_get_user() using clang and 'asm goto' with outpus"
patch is on top of Al's patches exactly because it was cleaner to do
with all of his cleanups.

But that magical asm-goto-with-outputs patch probably won't land
upstream for a couple of years.

I had the unsafe_put_user() patches to use 'asm goto' in a local
branch for almost three years before I made them official. See commit
a959dc88f9c8 ("Use __put_user_goto in __put_user_size() and
unsafe_put_user()") and notice how it has an author date of May, 2016,
but was only committed January 2019.

I basically waited until "asm goto" was something we could rely on
(and used for other reasons).

I suspect something very similar will happen with unsafe_get_user(). I
have a patch if people want to play with it, but right now it's a
"this relies on an unreleased version of clang to even work".

                      Linus
