Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B6C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C3B20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAOSAIrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:29:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47012 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:29:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id s23so141185plq.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzgH14cowT5NOH2YXPfOKwZ5lmbgMroAquim/LRzAhU=;
        b=aAOSAIrDkWpEGky9IFQuA9uSBE7wYOQC1JT+2Lomjz0H2gpHXbajlsuxjJY141ilSs
         0SVNnp7eUpSGuOJaB51JSw5Qb7ncbxEZkFXirUuxNWDRdtiy6mX1o+R8oqE1LKu4o5Az
         +51gBKE4XoL5lzxsnG2lEX0jzlRQQtKrW93SJBxbpy6tljYhpCOJHNT56045vXxYclwY
         PcfmYmgQTRlDIkEHZ2x4SZtDz2DFng1OhlpAikNsiWTatdywAXHrUIDnBlkBTt9UGXcx
         boCxCjkEfSaxgndpiWGg9fGFoaRnRX36sxYo9wVWP1yj1xrBZ6OciIwG0K68fXJcXNpA
         6Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzgH14cowT5NOH2YXPfOKwZ5lmbgMroAquim/LRzAhU=;
        b=crs6S2g+Kh+jQXs910UHsOQ9yxQCBJ2Qo9hLx6FmvUS7zVeYKNmnrssRrOAcCRIcnd
         Ul3RTAJ06kPZnJSfezSrx4ZHXCNsViqnCtSFbwV/GGJFXanNfg/3fDBpLtVrArw6TA9H
         UEnzh+tiTD/o71nufBldvT7/MFHRNR4UTM4Hpf8fcDhTiNDiGIaYekFzETU6VNcqzBXE
         KWODonGB/49OQ3rCgItMZ7asT5J+zlkfQNpDdS741NCv4dPb14717SqMpqjvgPmBbocK
         Yx6ajwDogDVT34HvvXH5ejcmVmpejKpuRANhFaVj5PF0y7IeGXonX+73bJFc4mfnMsU0
         37ZA==
X-Gm-Message-State: AGi0PubSr/IEqQNN6FcJW4E/GqU4t518wHi8IZWjZ5t44z5yTzjWFUbB
        5BYWfXKiWN6UeHwJqNKjKQEjexS42RBD4BiheMq0xQ==
X-Google-Smtp-Source: APiQypLF/CdpZAklvMFqIklRIEpiQeUL7pAjbidBTqoMrPy2xCykMhf18DMZSOzLEu/DbCHvnC8toMDYZVc9oAWVC64=
X-Received: by 2002:a17:90b:3783:: with SMTP id mz3mr579681pjb.27.1586197786666;
 Mon, 06 Apr 2020 11:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135603.483964896@infradead.org> <20200324142245.819003994@infradead.org>
 <20200406010859.bcfouhukcgmg2on7@google.com> <20200406110438.GJ20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200406110438.GJ20730@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Apr 2020 11:29:36 -0700
Message-ID: <CAKwvOd=hjh_MXDR05A5A8W3NwYSAwzf_ALYKyiAD4nRo1caKqA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 09/17] x86/static_call: Add out-of-line static
 call implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 4:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Apr 05, 2020 at 06:08:59PM -0700, Fangrui Song wrote:
> > On 2020-03-24, Peter Zijlstra wrote:
>
> > > +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                  \
> > > +   asm(".pushsection .text, \"ax\"                         \n"     \
> > > +       ".align 4                                           \n"     \
> > > +       ".globl " STATIC_CALL_TRAMP_STR(name) "             \n"     \
> > > +       STATIC_CALL_TRAMP_STR(name) ":                      \n"     \
> > > +       "   jmp.d32 " #func "                               \n"     \
> > > +       ".type " STATIC_CALL_TRAMP_STR(name) ", @function   \n"     \
> > > +       ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > > +       ".popsection                                        \n")
> > > +
> > > +#endif /* _ASM_STATIC_CALL_H */
> >
> > Hi Peter,
> >
> > Coming here from https://github.com/ClangBuiltLinux/linux/issues/974
> >
> > jmp.d32 is not recognized by clang integrated assembler.
> > The syntax appears to be very rarely used. According to Debian Code Search,
> > u-boot is the only project using this syntax.
>
> *groan*... I was going to use it in more places :-/
>
> > In March 2017, gas added the pseudo prefix {disp32}
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=86fa6981e7487e2c2df4337aa75ed2d93c32eaf2
> > which generalizes jmp.d32  ({disp32} jmp foo)
>
> That's all well and cute, but I can't use that because its too new. Not
> until we raise the minimum gcc/bintils version to something that
> includes that.

If it seems like it would be useful, let us know.  If it doesn't have
some ridiculous baggage or inconsistency or unspecified behavior,
we're generally happy to do so.  We have finite resources so knowing
where to focus our attention helps us sort the never ending TODO list.
It's not easy to predict which feature we'll need to drop everything
to implement next, so any help there would be much appreciated.

>
> > I wonder whether the instruction jmp.d32 can be replaced with the trick in
> > arch/x86/include/asm/jump_label.h for clang portability.
> >
> > % grep -A2 'jmp.d32' arch/x86/include/asm/jump_label.h
> >         /* Equivalent to "jmp.d32 \target" */
> >         .byte           0xe9
> >         .long           \target - .Lstatic_jump_after_\@
>
> Sure, but I was hoping to move away from that since all assemblers
> should now support jmp.d32. Except of course, you have to go ruin
> things.
>
> The thing is, jmp.d32 reads so much nicer than the above crap.
>
> Also, I still need a meta instruction like:
>
>         nopjmp $label
>
> what works just like 'jmp' but instead emits either a nop2 or a nop5.
> I tried various hacks to get GAS to emit that, but no luck :/
>
> The only up-side from that new syntax is that I suppose we can go write:
>
>   {disp8} push \vec
>
> without gas shitting itself and emitting a 5 byte push just because..
> Except of course we can't, for the same reason I can't go around and
> use:
>
>   {disp32} jmp
>
> in the above code.
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200406110438.GJ20730%40hirez.programming.kicks-ass.net.



-- 
Thanks,
~Nick Desaulniers
