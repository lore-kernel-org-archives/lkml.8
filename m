Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB22C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9992071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFIBQ86P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgBVXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:33:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46634 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgBVXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:33:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so2433897pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHfmwLnIUqXAiwLNkRBchsGXQLdmwgnefDEPy9uPxHc=;
        b=JFIBQ86PX40lycOJupY2A+tQRN4Xn1ZW5uQjrBrneSel/4FPHMEYdntyDBW7PLo3en
         M+gT6aU+wirPeqLwD8EV1EFoQaQacXkxzkSb+e4UN6N3zf2+RU0HExJpwh1VLpkP9aQH
         LLSd1tMLCOpxMpo0+djX6FzWi4CqPCoF3kYHnKDP2Nzm8hX9U5t/gJsS1BYq/cVOtH88
         f5UGJJy0ZJgc53ORJIHxRukvrC1BPLGIq/n178hrxRa9M2l/yV43qrW1MNhlwRP2d3T/
         BQ5UGnwLbjxObA+adp4VqrGTgSieF82C3aXvz15IgKMc/YisYk5qpd9DZh0n4r5r5RXG
         3LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHfmwLnIUqXAiwLNkRBchsGXQLdmwgnefDEPy9uPxHc=;
        b=HhzEWmO8bdmk6OcJWRepGQL6kQlZoQKzLjx9Ha2DqfvWrRMcUS9XnV/S6+RC0TFVeM
         jR3M3SVWS0z/SZXLvkT3vQ03rq0WNhZ7yYQeYosf5iDc5A9WKamaxeecnuk/79LBtFmM
         6F2Ywpw+aPINsnsbFAVzpt/kBSw27MiNXiavdVC3IDYDZqOcy7RDU/p8yaE/6whYcpwm
         SNBZj0JDBJO1kJIQNNzPgHxEAuJS5GGCqYeWIwcLfzKx0fs4pvtufB7qZoKmy3X1f2yW
         SGSUho76nYZrdU2gjkteSry65jwFlDXBf7y0CfeGPK9sYx1UKnEseK7QfwkVkKMQo4pt
         HpJw==
X-Gm-Message-State: APjAAAVT1FiUKj8fpyXD6Rvz4VKPPLpPgRFZjdQOIasbwH4K2sjnYjLW
        VsMKi4VRXABckQWJqCdN1XBuPIwONAWHRSH1gYullw==
X-Google-Smtp-Source: APXvYqw7vj3n8OT7RmPwbSBOTMJigZLWZDldpo3uNeq93VVpORhmes3kT4E1kaQnPfv7IA9worLvhD52wY6R4lp/ELg=
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr41180763pll.119.1582414412419;
 Sat, 22 Feb 2020 15:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20200222164419.GB3326744@rani.riverdale.lan> <20200222171859.3594058-1-nivedita@alum.mit.edu>
 <20200222181413.GA22627@ubuntu-m2-xlarge-x86> <20200222185806.ywnqhfqmy67akfsa@google.com>
 <20200222201715.GA3674682@rani.riverdale.lan> <20200222210101.diqw4zt6lz42ekgx@google.com>
In-Reply-To: <20200222210101.diqw4zt6lz42ekgx@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 22 Feb 2020 15:33:20 -0800
Message-ID: <CAKwvOdn2pmRqJ+Rs+dhAPJy3hOb4VNn70XB40jcVgTeM8XmeFQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed: Fix compressed kernel linking with lld
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 1:01 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On 2020-02-22, Arvind Sankar wrote:
> >On Sat, Feb 22, 2020 at 10:58:06AM -0800, Fangrui Song wrote:
> >> On 2020-02-22, Nathan Chancellor wrote:
> >> >On Sat, Feb 22, 2020 at 12:18:59PM -0500, Arvind Sankar wrote:
> >> >> Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
> >> >> bzImage") discarded unnecessary sections with *(*). While this works
> >> >> fine with the bfd linker, lld tries to also discard essential sections
> >> >> like .shstrtab, .symtab and .strtab, which results in the link failing
> >> >> since .shstrtab is required by the ELF specification. .symtab and
> >> >> .strtab are also necessary to generate the zoffset.h file for the
> >> >> bzImage header.
> >> >>
> >> >> Since the only sizeable section that can be discarded is .eh_frame,
> >> >> restrict the discard to only .eh_frame to be safe.
> >> >>
> >> >> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >> >> ---
> >> >> Sending as a fix on top of tip/x86/boot.
> >> >>
> >> >>  arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
> >> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> index 12a20603d92e..469dcf800a2c 100644
> >> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> @@ -74,8 +74,8 @@ SECTIONS
> >> >>   . = ALIGN(PAGE_SIZE);   /* keep ZO size page aligned */
> >> >>   _end = .;
> >> >>
> >> >> - /* Discard all remaining sections */
> >> >> + /* Discard .eh_frame to save some space */
> >> >>   /DISCARD/ : {
> >> >> -         *(*)
> >> >> +         *(.eh_frame)
> >> >>   }
> >> >>  }
> >> >> --
> >> >> 2.24.1
> >> >>
> >> >
> >> >FWIW:
> >> >
> >> >Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> >>
> >> I am puzzled. Doesn't -fno-asynchronous-unwind-tables suppress
> >> .eh_frame in the object files? Why are there still .eh_frame?
> >>
> >> Though, there is prior art: arch/s390/boot/compressed/vmlinux.lds.S also discards .eh_frame
> >
> >The compressed kernel doesn't use the regular flags and it seems it
> >doesn't have that option. Maybe we should add it in to avoid generating
> >those in the first place.

Ah, yikes.  For reference, please see my commit:

commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
reset KBUILD_CFLAGS")

I'm of the conviction that reassigning KBUILD_CFLAGS via `:=`, as
opposed to strictly filtering flags out of it or appending to it, is
an antipattern.  We very very carefully construct KBUILD_CFLAGS in top
level and arch/ Makefiles, and it's very easy to miss a flag or to
when you "reset" KBUILD_CFLAGS.

*Boom* Case in point.

I meant to audit the rest of the places we do this in the kernel, but
haven't had the time to revisit arch/x86/boot/compressed/Makefile.

For now, I suggest:
1. revert `Commit TBD ("x86/boot/compressed: Remove unnecessary
sections from bzImage")` as it runs afoul differences in `*` for
`DISCARD` sections between linkers, as the intent was to remove
.eh_frame, of which it's less work to not generate them in the first
place via compiler flag, rather than generate then discard via linker.
2. simply add `KBUILD_CFLAGS += -fno-asynchronous-unwind-tables` to
arch/x86/boot/compressed/Makefile with Fangrui's Sugguested-by tag.
3. Remind me to revisit my proposed cleanup of
arch/x86/boot/compressed/Makefile (which eventually will undo #2). ;)
4. tglx to remind me that my compiler is broken and that I should fix it. :P

> >
> >The .eh_frame discard in arch/x86/kernel/vmlinux.lds.S does seem
> >superfluous though.
>
> Yes, please do that. I recommend suppressting unneeded sections at
> compile time, instead of discarding them at link time.
>
> https://github.com/torvalds/linux/commit/83a092cf95f28696ddc36c8add0cf03ac034897f
> added -Wl,--orphan-handling=warn to arch/powerpc/Makefile .
> x86 can follow if that is appropriate.

Kees has patches for that; I recommend waiting on his series.

> I don't recommend -Wl,--orphan-handling=error, which can unnecessarily
> break the builds.

Agreed. Until we have CI testing with LLD which is a WIP (action item on me).
-- 
Thanks,
~Nick Desaulniers
