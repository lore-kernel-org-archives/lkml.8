Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF554C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE4A206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBpXJX53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGLXex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgGLXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:34:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA6C08C5DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:34:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w6so13382599ejq.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVOtLwv/Cvl11tUYp50SksGWhQhY11SC0NIkGuc8zKg=;
        b=pBpXJX539broCTWH17WgpJDxoLP0paWSlvb8A7h3fxHZadJbhqRCNtCFP25mX7XEJ4
         /kwaDuWKopj4I8eO8SAvDGZq6F9j25nSGRAO0y6X2NGnu7izoh9SZwvHn6KFIILHenua
         VZeZFZ0bZYIFUV+EEZeOEkkM7qjxY5RJIoRAIP4Ic1GB+xDjTjYg3z0lEPuNawED7EbA
         MonmBQTmlvtQCqFgEnrnwFndAHCUOPLKAGIG3XWpeW0/Qr4qA0bZxFzdTlAkI2KH7b0F
         rBajQRa/6JbzOq5B4AwXzh5PM1ZTZhssUaqSkDgJ7Yz0lPtz7xwa3hLHTGAXQMnzERV6
         /O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVOtLwv/Cvl11tUYp50SksGWhQhY11SC0NIkGuc8zKg=;
        b=RTKKKbWVu0aq/bIww8dT4MZSIS1VrwET0siSM5TRFheWndOKtMfiquvGZym4tkyyPl
         wmbPM3KgHtmlqwlvNpW76cn289rvVhMMSG5d8+bVK/1qLN72quX+MxWqL6JHZEjcTK/c
         08Bg9jYJuzPSgww3ILh0LnwoMHvJE4E0IZq3i8DC3GgSIgt1C+HcNuVT/XvZyc3r0B99
         +Sw0Zo+Vx5ZqumAlb/7Pb/HYJ1q8xWUoHZf4G4gQ7ZHo3W6A+r0QZ8YphICwTgHrXVPS
         mjo7YWhpup0mG1s0FvWwZFuLiStyyVMb36Pi4erIrlBHfQJcMUA99QjJV0kcJjiLrO8r
         EDeg==
X-Gm-Message-State: AOAM531fd21SRuS9Iig93IJqHGmGPwoZ0I3BgPrmCbRsPQZxRl5DhngZ
        MyQR2Hp+zTjLyJ2i9ZzQm9f3mxFzHORVL9gB5a0yPQ==
X-Google-Smtp-Source: ABdhPJytFy6lsxbxptEBJHanuAZiQiJRjagWMLPmEYrRnXLJYMLE9doc2W4BiVdJO1Ek3tqEEHDclPE0n0pEuhpOHu8=
X-Received: by 2002:a17:906:94c4:: with SMTP id d4mr69283452ejy.232.1594596890894;
 Sun, 12 Jul 2020 16:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
In-Reply-To: <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Sun, 12 Jul 2020 16:34:39 -0700
Message-ID: <CABCJKuedpxAqndgL=jHT22KtjnLkb1dsYaM6hQYyhqrWjkEe6A@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 9:32 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Thank you very much for sending these changes.
>
> Do you have a branch, where your current work can be pulled from? Your
> branch on GitHub [1] seems 15 months old.

The clang-lto branch is rebased regularly on top of Linus' tree.
GitHub just looks at the commit date of the last commit in the tree,
which isn't all that informative.

> Out of curiosity, I applied the changes, allowed the selection for i386
> (x86), and with Clang 1:11~++20200701093119+ffee8040534-1~exp1 from
> Debian experimental, it failed with `Invalid absolute R_386_32
> relocation: KERNEL_PAGES`:

I haven't looked at getting this to work on i386, which is why we only
select ARCH_SUPPORTS_LTO for x86_64. I would expect there to be a few
issues to address.

> >   arch/x86/tools/relocs vmlinux > arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs --abs-relocs vmlinux
> > Invalid absolute R_386_32 relocation: KERNEL_PAGES

KERNEL_PAGES looks like a constant, so it's probably safe to ignore
the absolute relocation in tools/relocs.c.

Sami
