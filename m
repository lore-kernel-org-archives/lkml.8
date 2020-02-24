Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3497C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D6220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeKTqq/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXVWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:22:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45424 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:22:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so5981038pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bH6EploGU3w+XX+y+9X71Wyht2oE1L8WWitTABuRGD4=;
        b=JeKTqq/Ix2Z64h5hXGhO3BfyYx3eQN8cqoo3ojfGrKXDfsjPGtwJWiXv/pVA5KDLqA
         1woYIXuC5x5EM0WpJUWj6rjG65W+uG3YNEnsX/4VAVWNYxwdmmKr76meSKAU3j/ul047
         mZ/2gZEiXP4neMPeGMjbGdDKc6ZN/vQYxCAszbaO5CU7LQAC4Y7dGqHMydpGyr1gbzjG
         xF+oI+xVoXIuNjGwvk02TSUR41f/ZiQil54xotrFYZYY2WnbnYYBNwbu/cZb7sFay1OM
         fHEan28VIjkYh8sBwrIpGcxGXi4GeORcAOx2nbBFly9XwFpEsG4mBsdahZYcwuxByifp
         aYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH6EploGU3w+XX+y+9X71Wyht2oE1L8WWitTABuRGD4=;
        b=irerlqlJlK6DR6fMPo+aay9JnMn9UsouYT9akUu65EEhDBZYHCcaGW6zU1UfCBP1aN
         KuL2WDcMnUg0lPi6KVr0ug6657Ny0apBm/vUUT2oNByPG+9D8jmBJPQdkB+035iLgnqf
         rsOGmamI6USNeK7dJ/QGMdRTIkPJixAzUnyCNl6a3CIYl+Y3yOKO6AE3XpRmUAwtfdvq
         IQDM5W3/di5S6KUKOAvmm2dY5etpD5bs2Hg91I8FbDogeZlAGx9Hs052zHnskxG8b97N
         k3gjY8e2xIHV4h2BYk6B8X7Wwu2KvuwO31/RdSRg9WI/53Vv8UdwDy2r0JzpG7lCWrGe
         UTAg==
X-Gm-Message-State: APjAAAWk55cC2AbjoyQ/xKp5wGTi/cL5xfqlKuNhK//j4u6cnkAlsLDM
        qVXyfrAMqnobOkLO77F55S7lj3h/6VOJl+FFbm61fA==
X-Google-Smtp-Source: APXvYqzAZ16Zg0jjIROjTgN53DC2hQo3zYxMHYvl5OwyxgB2WLc4rEW2lAgeXD7LRtD548EgaRpOwVMEQ00RQW3MzFM=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr53845033pfa.165.1582579341630;
 Mon, 24 Feb 2020 13:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-2-nivedita@alum.mit.edu>
 <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
 <20200224210522.GA409112@rani.riverdale.lan> <20200224211209.3snqf7atf5h4ywcr@google.com>
 <CAKwvOd=4YAj1yzncXeyDvw4ghuPCHNYU0NMGnYEDwKNozcm-uw@mail.gmail.com>
In-Reply-To: <CAKwvOd=4YAj1yzncXeyDvw4ghuPCHNYU0NMGnYEDwKNozcm-uw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 13:22:10 -0800
Message-ID: <CAKwvOdkoy_oaZP1fxybJu23f+V0fyrESzFO63UZenUDy+5290A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Feb 24, 2020 at 1:12 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2020-02-24, Arvind Sankar wrote:
> > >On Mon, Feb 24, 2020 at 12:33:49PM -0800, Nick Desaulniers wrote:
> > >> On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >> >
> > >> > While discussing a patch to discard .eh_frame from the compressed
> > >> > vmlinux using the linker script, Fangrui Song pointed out [1] that these
> > >> > sections shouldn't exist in the first place because arch/x86/Makefile
> > >> > uses -fno-asynchronous-unwind-tables.
> > >>
> > >> Another benefit is that -fno-asynchronous-unwind-tables may help
> > >> reduce the size of .text!
> > >> https://stackoverflow.com/a/26302715/1027966
> > >
> > >Hm I don't see any change in .text size.
> > >> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > >> > index 98a81576213d..a1140c4ee478 100644
> > >> > --- a/drivers/firmware/efi/libstub/Makefile
> > >> > +++ b/drivers/firmware/efi/libstub/Makefile
> > >> > @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
> > >> >                                    -mno-mmx -mno-sse -fshort-wchar \
> > >> >                                    -Wno-pointer-sign \
> > >> >                                    $(call cc-disable-warning, address-of-packed-member) \
> > >> > -                                  $(call cc-disable-warning, gnu)
> > >> > +                                  $(call cc-disable-warning, gnu) \
> > >> > +                                  -fno-asynchronous-unwind-tables
> > >>
> > >> I think we want to add this flag a little lower, line 27 has:
> > >>
> > >> KBUILD_CFLAGS     := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> > >>
> > >> so the `cflags-y` variable you modify in this hunk will only set
> > >> -fno-asynchronous-unwind-tables for CONFIG_X86, which I don't think is
> > >> intentional.  Though when I run
> > >
> > >It is intentional -- the other case is that we're building for ARM,
> > >which only filters out the regular KBUILD_CFLAGS, so adding the flag for
> > >it should not be necessary. The cflags for ARM are constructed by
> > >manipulating KBUILD_CFLAGS. Besides it may or may not want unwind
> > >tables. 32-bit ARM appears to have an option to enable -funwind-tables.
>
> Ah, right the `subst` from `KBUILD_CFLAGS`.
> Are there other architectures that care about EFI beyond x86 and ARM? IA64?

Looks like while IA64 supports CONFIG_EFI, it doesn't support
CONFIG_EFI_STUB, which controls whether drivers/firmware/efi/libstub/
gets built or not. So that patch should be good to go.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> >
> > clang (as of today) has not implemented the
> > -funwind-tables/-fasynchronous-unwind-tables distinction as GCC does..
> > (probably because not many people care..)
>
> Ah, thanks for the clarification.
>
> >
> > >>
> > >> $ llvm-readelf -S drivers/firmware/efi/libstub/lib.a | grep eh_frame
> > >>
> > >> after doing an x86_64 defconfig, I don't get any hits. Do you observe
> > >> .eh_frame sections on any of these objects in this dir? (I'm fine
> > >> adding it to be safe, but I'm curious why I'm not seeing any
> > >> .eh_frame)
> > >>
> > >
> > >You mean before this patch, right? I see hits on every .o file in there
> > >(compiling with gcc 9.2.0).
> > >
> > >> >
> > >> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> > >> >  # disable the stackleak plugin
> > >> > --
> > >> > 2.24.1
> > >> >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
