Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6A20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583394449;
	bh=uYnZ8RHtPgOP0bMawYXhsO4Ftw7rRBzo1uB+1SPw8Tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J7kO3wjQ9KyzX/5aA0Bo/kakyr0jO4mnmwk7DXoNuym1rxay7GbhyUciJc3DNyYMh
	 FAhXSXrp8I6bROKDgOlVwTSaoiHGit99b2CeU7NMsGwuv6ApTLnLZ4tmtlVh7OwyJ9
	 +hVMwtA7lZw9vH+6l17lq7wJYVQpSN06QdxggzGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCEHr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCEHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:47:28 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEDE208C3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Mar 2020 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583394447;
        bh=uYnZ8RHtPgOP0bMawYXhsO4Ftw7rRBzo1uB+1SPw8Tk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZDPUVnTrYZWbY/bp0iouzuzOe/egonJiJF8W5yqlXcdcvLABGWIM2ZJS/gjqIWWR
         0uoeBC7VjBHmxh5TRw55FaU73855VpMjfK4zV3r3yqOU4Nf4vuL/TyE89uqzcPVsq6
         9gx/CsLPFb8GhZbkTWeQCMIKrLHJWHygL5G+6ow8=
Received: by mail-wm1-f53.google.com with SMTP id e26so4560121wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:47:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ3lblBrbJa5+JaFAJqNp4kMtW3Vk2n3QMp3Y5UL5LrQbkwP2WGR
        dkd2WVRvNP/ck2cs6M+cPh6X6vddgsFF5WVsod2fVw==
X-Google-Smtp-Source: ADFU+vsoa1s+f4+HYz7apQWwuAhfOae5XkffzCXVQ4Bm3Ifg0B2MiPly03//GtukTrjQ7r7KJ3QBW3+/1vaSSpYIGCQ=
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr7771511wmm.40.1583394445713;
 Wed, 04 Mar 2020 23:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20200305055047.6097-1-masahiroy@kernel.org> <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
 <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
In-Reply-To: <CAK7LNATwBALmPjZiY6teac3FcA_BFsBVzwf5cqbVNCZSqGrHJg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:47:15 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
Message-ID: <CAKv+Gu-7GYj5fJjOMRQQiKhA+PYeHYcwcG6sVx5O0Pj2Ufd2rg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 08:39, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Mar 5, 2020 at 4:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 5 Mar 2020 at 06:50, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > drivers/firmware/efi/libstub/Makefile is supposed to create a static
> > > library, which is not directly linked to vmlinux.
> > >
> >
> > This is not true for arm64. Does that matter?
>
>
>
> Yeah, I know.  arm64 vmlinux links it
> (but in a different manner from normal lib.a )
>
>
> Shall I rephrase this paragraph as follows?
>
> drivers/firmware/efi/libstub/Makefile is supposed to create a static
> library, which is not directly linked to vmlinux on ARCH=arm, x86.
>
>
>
> This is just a matter of whether linking
> unneeded lib-ksyms.o or not.
>

How about

"""
drivers/firmware/efi/libstub/Makefile builds a static library, which
is not linked into the main vmlinux target in the ordinary way
[arm64], or at all [ARM, x86]
"""



>
>
>
>
> > > Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
> > > reliably"), any Makefile using lib-y generates lib-ksyms.o which is
> > > linked into vmlinux.
> > >
> > > In this case, the following garbage object is linked into vmlinux.
> > >
> > >   drivers/firmware/efi/libstub/lib-ksyms.o
> > >
> > > We do not want to link anything from libstub/ directly to vmlinux,

and

"""
We do not want to follow the default linking rules for static
libraries built under libstub/
"""

If you agree, no need to resend, I'll fix it up when applying


> > > so using subdir-y instead of obj-y is the correct way to descend into
> > > this directory.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  drivers/firmware/efi/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > > index 554d795270d9..4fd2fa02f549 100644
> > > --- a/drivers/firmware/efi/Makefile
> > > +++ b/drivers/firmware/efi/Makefile
> > > @@ -19,7 +19,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         += efi-pstore.o
> > >  obj-$(CONFIG_UEFI_CPER)                        += cper.o
> > >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> > >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> > > -obj-$(CONFIG_EFI_STUB)                 += libstub/
> > > +subdir-$(CONFIG_EFI_STUB)              += libstub
> > >  obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
> > >  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
> > >  obj-$(CONFIG_EFI_TEST)                 += test/
> > > --
> > > 2.17.1
> > >
>
>
>
> --
> Best Regards
> Masahiro Yamada
