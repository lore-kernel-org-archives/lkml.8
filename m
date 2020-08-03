Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B672075B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DefaKfGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHCENY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHCENY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:13:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:13:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so21974363iow.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKUq/09yys4sflqmrLiIWtDtY45NuaZPyhKbOjzDqNQ=;
        b=DefaKfGI1MDSo2amOyXhNeK+74EnbqXJroVxkuLakvpi7bDIfG9uwfA6pJraRu/cxl
         QYI7qZyCzzsKIycfiTLSbmngKLLuUZ34cPtvhCiJ6gIwv1xBYXpNQx7uvFfQ0kJw732a
         l2q5UALhHB7iJI+mtunTomwrr1eA7vtODEui/zV1wsNOePlzwtDh0CMMqW8Vkdw801aO
         +W+iNFkQA4MukuBi7WY/+/NRE9PG/A1uwxxoYK4RkzgSfS/iW76/ntTRwrHvrqHaJ4aM
         iYrGyXEUU3yug+G9qP2rhGbru8+QgxZC0Qy3B2dOKJNjGHd019orAlVYEpEZWJ7wJURI
         jvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKUq/09yys4sflqmrLiIWtDtY45NuaZPyhKbOjzDqNQ=;
        b=BUhmVMRPqutR3typwzodzwEIGuk0UlAlkOa2w1ZhsLcpxMmPO7DV3dZpW2xXUATunc
         vuEgdd80eOD03SvpCLVmV5tosC5ZgFnib8rM0YLZ44/NU16lqfezLwJRDujOAsmkFvSz
         oKXJASxutDgmOn0DZ1/Y5U+J5sa0lNrJ3Jw/NDlq2KAEPBb/w4JyTEQ++aLgGy8jNiLK
         CL5aBHaUQP422ZEPi8DAWmJvfun7ICa7S5gVAz9VFiM9b1EeSqrjI8Rdjdka0auFhok0
         Vfq4vMAk8jOf46/7Yvmnq4+vU8GX/msr+wpEbSCTHSWdNKZKA7Vn4/u0L/c1Itmn6OrM
         O/JQ==
X-Gm-Message-State: AOAM532WWUjNKNU/0M62IptG6vOpKesGVKFzGzIheUmJvP4IuGEzK/34
        vn85ZSaDY+tDzCbVdTm4/bmSFbsXLYLonrfJgA==
X-Google-Smtp-Source: ABdhPJzBU2LEqOGgB4tXJMlQukquOs2+1BK0Opeemx0ePqtJVO7uSXjBaZKk/NzBC9DmR7ptHqtF1o96xRXkpAoAdNM=
X-Received: by 2002:a05:6602:2246:: with SMTP id o6mr10117511ioo.35.1596428003100;
 Sun, 02 Aug 2020 21:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <1596097609-14118-1-git-send-email-kernelfans@gmail.com>
 <CAKwvOdnThb=Sv2v1K3w0DAJBZFiEp2Z0Y=NbQ9kEuK1nsQqJBw@mail.gmail.com>
 <CAFgQCTsYTwpv6oCGLH5JTjt+1jPAZ7XjBm6sDoCPRnjrRPhvTQ@mail.gmail.com> <CAKwvOdn6xZV6pMUcvjH=WRk1JpQ8nAV8mhCj7jezmA=RXdV7sw@mail.gmail.com>
In-Reply-To: <CAKwvOdn6xZV6pMUcvjH=WRk1JpQ8nAV8mhCj7jezmA=RXdV7sw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 3 Aug 2020 12:13:11 +0800
Message-ID: <CAFgQCTv2_fAa3w1+J+gXSuVWLLN9vv1xf_rvBg7Er3oAVm491g@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: strip debug info
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:18 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Jul 31, 2020 at 2:36 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Fri, Jul 31, 2020 at 7:11 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Thu, Jul 30, 2020 at 1:27 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > >
> > > > It is useless to keep debug info in purgatory. And discarding them saves
> > > > about 200K space.
> > > >
> > > > Original:
> > > >   259080  kexec-purgatory.o
> > > > Stripped:
> > > >    29152  kexec-purgatory.o
> > > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > Cc: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Cc: Steve Wahl <steve.wahl@hpe.com>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > To: x86@kernel.org
> > >
> > > I don't see any code in
> > > arch/x86/purgatory/
> > > arch/x86/include/asm/purgatory.h
> > > include/linux/purgatory.h
> > > include/uapi/linux/kexec.h
> > > kernel/kexec*
> > > include/linux/kexec.h
> > > include/linux/crash_dump.h
> > > kernel/crash_dump.c
> > > arch/x86/kernel/crash*
> > > https://github.com/horms/kexec-tools/tree/master/kexec/arch/x86_64
> > > that mentions any kind of debug info section.  I'm not sure what you'd
> > > do with the debug info anyway for this binary.  So I suspect this
> > > information should ok to discard.
> > >
> > > This works, but it might be faster to build to not generate the
> > > compile info in the first place via compile flag `-g0`, which could be
> > > added `ifdef CONFIG_DEBUG_INFO` or even just unconditionally.  That
> > > way we're not doing additional work to generate debug info, then
> > > additional work to throw it away.
> > What about:
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index 088bd76..7e1ad9e 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
> >  # make up the standalone purgatory.ro
> >
> >  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> > -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> > +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
> > -fno-zero-initialized-in-bss -g0
> >  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
> >  PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
>
> I tested your patch but still see .debug_* sections in the .ro from a few .o.
>
> At least on
> * setup-x86_64.o
> * entry64.o
>
> If you add the following hunk to your diff:
> ```
> @@ -64,6 +64,9 @@ CFLAGS_sha256.o                       += $(PURGATORY_CFLAGS)
>  CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
>
> +AFLAGS_REMOVE_setup-x86_$(BITS).o      += -Wa,-gdwarf-2
> +AFLAGS_REMOVE_entry64.o                += -Wa,-gdwarf-2
> +
Go through man as and gcc, and can not find a simpler method than your
suggestion.
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
> ```
> then that should do it.  Then you can verify the .ro file via:
> $ llvm-readelf -S arch/x86/purgatory/purgatory.ro | not grep debug_
> (no output, should return zero)
Thank you for your good suggestion and I will update V2

Regards,
Pingfan
