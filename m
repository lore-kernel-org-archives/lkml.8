Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D684C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFCD2137B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuYNfoCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgFZVg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgFZVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:36:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE16C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:36:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so5483768pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOBEqR855rhbveUnTuLRVA8ObPjWG2Dhr4Uq2zMSwAY=;
        b=PuYNfoCyPSJ5Ee12cr1CtUbfE7ZlRGryAVARIshAUVXzmAnVWRFHzikYNNfSyo7a7F
         a06g/eRMdwxj9OXD7QRHNxSF7eKxvk1j1lPH9PmdRDDg6kx4ZLd+rlLkMX+stfkvFRSo
         3uYlvf2dcAbiq0b0Zur+XdSPJAOs7pyrko97x1g/OZZE5SAbKoR5//4HR0kMgybCUEcJ
         qH5fO1qNpQUu5shtcqTXZ6i3vFopLDbDxc6vz9okSZ89qSoU9m5SXNS+uZg1J+VAhXel
         mr1ancCaFIkK6ML+TUbpPKLFTOYu+NWJSaza3sWtRul6uvMdRWqHryQVHiXRHQ42JOKB
         D6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOBEqR855rhbveUnTuLRVA8ObPjWG2Dhr4Uq2zMSwAY=;
        b=EZfWuCI78RcWgnsMLvUk9vxb+R1tRznRke6aXUDQZ4fKZnbQ/q0lADejGSB1C8z8tD
         riY8GmTwi6jFMuUoi4ilTtpBw3HuAj/coyuOeFe9SFrl2OJVTYq99YvC1GQSUz7239R7
         ctvp6wLYFBCFReWAm2p5Vxu9sx0LIzo8mH1VwcRGAC182eU2x7Lmvziv172nFg7fwvZH
         jYVLYZ1UvjkI6vmMrPjXiYB1GZ/AONq9sD0ztfCcIRM5GVa67/9sWvhudpsQl6QbTu5w
         /2pmZkyo6kDiEqL43A3CdMe5Hs/8bdGTPsg1ZNNYQ92YE4X1xoJtrItyTZn2tQwKN1T1
         zHjA==
X-Gm-Message-State: AOAM5338ZZXlrOTvZBNXSNfVWJ8Y+qyF8c/mQ5gbFzF8fY577s/HhZnt
        Mh6jYQW3cCqIWBVCEg4GUUI9WhAGCAr+Tu9UPgk7NQ==
X-Google-Smtp-Source: ABdhPJzhTb+JgbH2pUdHbU3Lcn5mzANDYeWl9ZkkpeEFXuFi9qIgBYbbGiM0JwDKX1RI84GCkYbTlow0BnrH3GGtPow=
X-Received: by 2002:a62:7e95:: with SMTP id z143mr4569412pfc.108.1593207416783;
 Fri, 26 Jun 2020 14:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200622204915.2987555-1-keescook@chromium.org>
 <20200622204915.2987555-2-keescook@chromium.org> <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
In-Reply-To: <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Jun 2020 14:36:44 -0700
Message-ID: <CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 5:03 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 22, 2020 at 1:49 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > --- a/arch/arm/kernel/vmlinux.lds.h
> > +++ b/arch/arm/include/asm/vmlinux.lds.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#include <asm-generic/vmlinux.lds.h>
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  #define ARM_CPU_DISCARD(x)
> > @@ -37,6 +38,13 @@
> >                 *(.idmap.text)                                          \
> >                 __idmap_text_end = .;                                   \
> >
> > +#define ARM_COMMON_DISCARD                                             \
> > +               *(.ARM.attributes)                                      \
>
> I could have sworn that someone (Eli?) once told me that this section
> (.ARM.attributes) is used for disambiguating which ARM version or
> which optional extensions were used when compiling, and that without
> this section, one would not be able to disassemble 32b ARM precisely.
> If that's the case, we might not want to discard it?

Yep, looks like ELFObjectFileBase::getARMFeatures() in
llvm/lib/Object/ELFObjectFile.cpp does exactly that and more.
https://github.com/llvm/llvm-project/blob/8808574e7438c8768b78ae7dd0f029385c6df01d/llvm/lib/Object/ELFObjectFile.cpp#L359-L441
https://github.com/llvm/llvm-project/blob/8808574e7438c8768b78ae7dd0f029385c6df01d/llvm/lib/Object/ELFObjectFile.cpp#L159-L287

As a test, let's do:
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71 defconfig
(so armv7)
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71
(then pick any random object file)
$ llvm-readelf -S arch/arm/kernel/bugs.o | grep attri
  [15] .ARM.attributes   ARM_ATTRIBUTES  00000000 0000f7 000037 00      0   0  1
$ llvm-readelf --arch-specific arch/arm/kernel/bugs.o | grep -A 2 CPU_arch
        TagName: CPU_arch
        Description: ARM v7
      }
And let's see if this actually has a difference on the disassembly.
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71
(full build, since we're talking about linker script changes for vmlinux)
$ llvm-objdump -d vmlinux > prepatch.txt
(apply your patch)
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71 clean
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71
$ llvm-objdump -d vmlinux > postpatch.txt
$ diff -u prepatch.txt postpatch.txt | less

No difference. Eh. Checking again with arm-linux-gnueabihf-objdump, it
seems some constants are slightly different for `movw`'s though.  Not
sure what's that about.

If I enable CONFIG_THUMB2_KERNEL=y, is where things become
interesting. llvm-objdump produces wildly different disassembly before
vs after removing .ARM.attributes.  There's also lots of decode errors
in the disassembly.

Repeating the thumb2 test with GNU objdump, I only see slight
differences in constants values for operands to `movw`.  So it looks
like GNU objdump doesn't rely on .ARM.attributes to disambiguate
between ARM vs THUMB2 instructions like llvm-objdump does.  We can
probably improve llvm-objdump, but I'd rather not discard this section
for now.

(also, I didn't test armv6, v5, etc, but those might be interesting
tests, too, should we want to discard this section.  Also, I think we
can explicitly specify --triple=thumbv7-linux-gnueabihf to
llvm-objdump, but I'd prefer it if my disassembler did the work for
me, since I'm lazy)

(oh man, the bytes are printed with different endianness between
arm-linux-gnueabihf-objdump and llvm-objdump...guessing that's a bug
in llvm).

--
Thanks,
~Nick Desaulniers
