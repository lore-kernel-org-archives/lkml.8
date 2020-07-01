Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37135C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B8C20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593632155;
	bh=h/qGA0uJIyucVWo5pdfqwk4i7o/Le4zazDXXTgInWw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XR32nVd/dbBchNxTKSm3HwjNONBfl/BcZqkKBLuhIjPFLUNFNPzgRlktMIOITVET6
	 f0rPoJvDpuUT4v7XIvdbdYLMeqZK6799GcYKB3trOwMFX1PSGPEkOKbogktbcpoKWf
	 qqgaZLNVHs5Qav/XrWU2VJPm9oZnhUQ2kDqXet+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGATfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGATfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:35:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95678C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:35:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s9so28589890ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzdMv7QzaIMMiuSv3LueAMzlxlY0Kgapf7U+sbKvloM=;
        b=bm9HbbW76FxBf2fTQ1FmcTy0zoJuqDZi8QrOZtWv0eBokcsJpN2U7+OEORIZs+msq7
         wnw8QVVH3XOwPsszpIZ/hw8IZtRI/FkQC/u+RM6ePqiAeiYDGeHfeyeKKws9Ko9SyLxO
         t2AQy31595SCpzTV/Qh2yxpEDfiljNKG34fMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzdMv7QzaIMMiuSv3LueAMzlxlY0Kgapf7U+sbKvloM=;
        b=Pxm7rllUXp6mLAtmJIZ53v96B3AFCtHug1IFjvVBGqiFHchJMJwrmUp0E0zmvdz/Ea
         Ci0fN0ZgIX2G6HdkA+yxAOm2qAe5hR/WryxC3xQwei+JxXcj+dTng4N3AknKwcyyhh90
         6siS7VcjHudlVRfBQAJRQzgrEBxvVzC09tw/FFtL4v0m1iXzmFH8BdR9ejH32Ii7UWdc
         t3SR6DYnZ/rOS8mCMFOwnAnmfw6h63vNU4MtXQtxSrCj6pTv3XIMo/3RmBAoqf3U4fDa
         XMxZVzB1aXcrjO6u7kFgEthnB63Axs8s653D9mEFoZBJGot4bD/SxYCUMV7uFkpCcn3g
         cbyA==
X-Gm-Message-State: AOAM531oEr5UdZwOGF70N8EFxd2Bip+7VaSxapc80GeYDPqgpE6J44CU
        io8gCxZjbE8d78baPSMc88eVv4kaF+k=
X-Google-Smtp-Source: ABdhPJxmjAVEcKX9q+JmsGfrxA6eAanZC+q1YhBCeQmNN6lEAb+ix/BEo6iUeDdXOo0mtocSRT1Pig==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr2545271ljg.91.1593632150572;
        Wed, 01 Jul 2020 12:35:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j4sm2385905lfb.94.2020.07.01.12.35.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:35:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h22so21484900lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:35:49 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr9104701lji.70.1593632149097;
 Wed, 01 Jul 2020 12:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <CALCETrXLcyuVT2JCrb0d-5Oq8aRLrERUdhRfGLxVZyYYo3BoBQ@mail.gmail.com>
In-Reply-To: <CALCETrXLcyuVT2JCrb0d-5Oq8aRLrERUdhRfGLxVZyYYo3BoBQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 12:35:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
Message-ID: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:29 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Do we really want the exception handling to do the CLAC?  Having
> unsafe_get_user() do CLAC seems surprising to me, and it will break
> use cases like:
>
> if (!user_access_begin(...)
>   goto out;
>
> ret = unsafe_get_user(...);
>
> user_access_end();
>
> check ret;

That's not how unsafe_get_user() works.

unsafe_get_user() always jumps to the error label, it never returns a
value. So the code is actually now what you claim above, but

    if (!user_access_begin(...)
       goto out;

    unsafe_get_user(..., out_fault);
    user_access_end();
   .. this is good, use the value we got..

out_fault:
    user_access_end();
out:
    return -EFAULT;

And that's _exactly_ why I'd like to make the change: because that
means that the error label for a user access failure is exactly the
same as the error label for the "user_access_begin()" failure.

So with my suggestion, that "out_fault" label and extra
user_access_end() would go away, and only "out" would remain.

So my suggestion actually simplifies the use cases, and your example
was literally an argument _for_ the change, not against it.

That's not why I started doing it, though. The real simplification is
inside the low-level implementation.

Right now __get_user_nocheck() does this:

        __uaccess_begin();                                      \
        __get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err);       \
        __uaccess_end();                                                \
        (x) = (__force __typeof__(*(ptr)))__gu_val;                     \
        __builtin_expect(__gu_err, 0);                                  \

because __get_user_nocheck() internally does *not* use the jumping
version (yet) because of the fact how gcc can't do "asm goto" with
outputs.

And it's actually _important_ that the assignment to "x" is done
outside the user access region (because "x" can be a complex
expression).

But look at what happens if we change things to use a exception jump
instead of that __gu_error value.

Then we want the code to become this:

        __uaccess_begin_nospec();                                       \
        __get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_label);     \
        __uaccess_end();                                                \
        (x) = (__force __typeof__(*(ptr)))__gu_val;                     \
        __gu_ret = 0;                                                   \
__gu_label:                                                             \
        __builtin_expect(__gu_err, 0);                                  \

and that actually looks nice and understandable, and the compiler will
also have a really easy time turing any subsequent test of the return
value into a trivial "we know the fallthrough case returned zero"
because instead of setting "__gu_err" much deeper and dynamically (and
with other code in between), it gets set right before the return from
that statement expression macro.

Btw, all the "it makes it easier to implement" is doubly true in all
the low-level asm code too. Go look into arch/x86/lib/{get,put}user.S
right now, and see how the error cases all have two different
entrypoints, and we have code like

SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
        ASM_CLAC
bad_get_user:
        xor %edx,%edx
        mov $(-EFAULT),%_ASM_AX
        ret
SYM_CODE_END(.Lbad_get_user_clac)

where that "Lbad_get_user_clac" label is used for the exception case,
and the "bad_get_user" label is used for the "bad address" case.

So it
 (a) makes it easier for users
 (b) makes it easier to implement
 (c) will actually make it easier for compilers to optimize too

Now, if the exception does *not* do the "stop user accesses", we have
to continue doing the two different failure targets (both in C code
and in asm code), and for the __get_user_nocheck() case where we use
"asm goto" with outputs, we can do things like this:

        __uaccess_begin_nospec();                                       \
        __get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_label);     \
        __uaccess_end();                                                \
        (x) = (__force __typeof__(*(ptr)))__gu_val;                     \
        __gu_err = 0;                                                   \
        if (0) {                                                        \
 __gu_label:                                                            \
                __uaccess_end();                                        \
                __gu_err = -EFAULT;                                     \
        }                                                               \
        __builtin_expect(__gu_err, 0);                                  \

which certainly works, but I think you'll admit it's ugly (note that
nice "if (0)" trick to get the separate error case that does that
__uaccess_end() that can't be done in the common end part because that
complex access has to be done after closing the user access region).

So this is why I'd like to change the rules. A user access fault would
close the user access window.

              Linus
