Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97577C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7649D22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ky+5aSNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgGaSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:18:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD33C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:18:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so8812675pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbXSGUlk5K+rosVCGnHMWYKXgwhTW/dZ9Iv4aQo63G4=;
        b=Ky+5aSNqyiDcZugeQZTH3Do3UZQcyebJt6Nldlxn3w/tcqN4toBuB+wKtWOm1CrBHG
         pUMd15SHiL8TT4cF0+/zTO4rjztSENzPx5e1VOuk2drg4/gjSDSFhrYJaeUr7HUA+iDu
         ab1biNrQ2jC9R0lgiRNyn3WHgJrBuco88x9+G6EKIaCLJ7uFBS/Hv+yxg9S1v34tssE1
         xviGhSY+xXb69KNverTfEJmrYSSbdc17/N235WRj8PUQtWTpKi/XDzuxBCkxFHBeU7CS
         Ox2Vx6pFeBN/w3LyZ5gLpcf6UZOQtW5pR5QMghfFUfZnj7zRqAI1wc/QNwpgZloxkZCR
         i4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbXSGUlk5K+rosVCGnHMWYKXgwhTW/dZ9Iv4aQo63G4=;
        b=QW8+xUvL/0wtWE3TIkHJZy/ijfps2yko2AY1B+I2yO+uc6z2faDS0JOdetd7E5BK6F
         471nH2JPCGhxSKCsreG1pWIKtf5i/Ad6sBIqJt5Q69wEs8L6oZ7Q5hCLyy6iNuockM5S
         JPa5Vq5+k1G1zjkrxC35NWkzY4jdWIrIOGPVsirnc4Ig/6w0E1gIqLk16tHdHs100dSS
         H05+kdKII78cYqr41BVBL6QLg48BZs7AfFIEpjcdwQ3+hRw/+uvrkp+TqxVd0EA7tvwr
         bDSd//L2kpPK+lbO39rmWxeos6MqCnqiqPHf+Be6+d7/PX9f0/s2N0145CLE/sPU5LOn
         6sXQ==
X-Gm-Message-State: AOAM532+v8Em7IwzUQFKSByX/+iovlDZjDE4zqVu9sd7DszS6dBGHAc4
        WfJDBZZOeUMv2ksU+3R0d1B0Jf4A60onyH3jaKFi1A==
X-Google-Smtp-Source: ABdhPJzYUwu+pRpMIynG86g4KWTZ55uMT6TJjEcQrDKVUEBHTizvYlW3PfeZV3KilYxNfpqboySN1iCB6j2p/UuPIaQ=
X-Received: by 2002:a62:3405:: with SMTP id b5mr4778667pfa.169.1596219510038;
 Fri, 31 Jul 2020 11:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <1596097609-14118-1-git-send-email-kernelfans@gmail.com>
 <CAKwvOdnThb=Sv2v1K3w0DAJBZFiEp2Z0Y=NbQ9kEuK1nsQqJBw@mail.gmail.com> <CAFgQCTsYTwpv6oCGLH5JTjt+1jPAZ7XjBm6sDoCPRnjrRPhvTQ@mail.gmail.com>
In-Reply-To: <CAFgQCTsYTwpv6oCGLH5JTjt+1jPAZ7XjBm6sDoCPRnjrRPhvTQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Jul 2020 11:18:18 -0700
Message-ID: <CAKwvOdn6xZV6pMUcvjH=WRk1JpQ8nAV8mhCj7jezmA=RXdV7sw@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: strip debug info
To:     Pingfan Liu <kernelfans@gmail.com>, Steve Wahl <steve.wahl@hpe.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
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

On Fri, Jul 31, 2020 at 2:36 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Fri, Jul 31, 2020 at 7:11 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Jul 30, 2020 at 1:27 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > It is useless to keep debug info in purgatory. And discarding them saves
> > > about 200K space.
> > >
> > > Original:
> > >   259080  kexec-purgatory.o
> > > Stripped:
> > >    29152  kexec-purgatory.o
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Arvind Sankar <nivedita@alum.mit.edu>
> > > Cc: Steve Wahl <steve.wahl@hpe.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > To: x86@kernel.org
> >
> > I don't see any code in
> > arch/x86/purgatory/
> > arch/x86/include/asm/purgatory.h
> > include/linux/purgatory.h
> > include/uapi/linux/kexec.h
> > kernel/kexec*
> > include/linux/kexec.h
> > include/linux/crash_dump.h
> > kernel/crash_dump.c
> > arch/x86/kernel/crash*
> > https://github.com/horms/kexec-tools/tree/master/kexec/arch/x86_64
> > that mentions any kind of debug info section.  I'm not sure what you'd
> > do with the debug info anyway for this binary.  So I suspect this
> > information should ok to discard.
> >
> > This works, but it might be faster to build to not generate the
> > compile info in the first place via compile flag `-g0`, which could be
> > added `ifdef CONFIG_DEBUG_INFO` or even just unconditionally.  That
> > way we're not doing additional work to generate debug info, then
> > additional work to throw it away.
> What about:
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 088bd76..7e1ad9e 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
>  # make up the standalone purgatory.ro
>
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
> -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)

I tested your patch but still see .debug_* sections in the .ro from a few .o.

At least on
* setup-x86_64.o
* entry64.o

If you add the following hunk to your diff:
```
@@ -64,6 +64,9 @@ CFLAGS_sha256.o                       += $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_string.o                        += $(PURGATORY_CFLAGS)

+AFLAGS_REMOVE_setup-x86_$(BITS).o      += -Wa,-gdwarf-2
+AFLAGS_REMOVE_entry64.o                += -Wa,-gdwarf-2
+
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
                $(call if_changed,ld)
```
then that should do it.  Then you can verify the .ro file via:
$ llvm-readelf -S arch/x86/purgatory/purgatory.ro | not grep debug_
(no output, should return zero)
-- 
Thanks,
~Nick Desaulniers
