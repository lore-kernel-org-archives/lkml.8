Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413952176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595226223;
	bh=FWQE8h03YB9otNyLDGP6oLxadjk+HVDXF0TxF12WqIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jPXXfEk0JRiEoubVAdv2aBJevXSSSCnaZ85mtzy+DjGTuVgvrPeCSGaehHOJsdR4f
	 UlxeCVGDLo5WywX4up1VkJelET8l5V9xNj7GV+2vVyDdrwVPGxmV665Vkl3fxoGa00
	 ZEAh4yvM18yEKfTKd/0Wz5XIwGgSOtKxXdW7Q0kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGTGXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTGXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:23:41 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C3A22B4E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595226220;
        bh=FWQE8h03YB9otNyLDGP6oLxadjk+HVDXF0TxF12WqIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6CsRWmFx27wtggInTT+Eq+PnmXSOe5CsXBg3NBRz61gGiaIMdiV76/qiUkgmi+h1
         c0sRMJ9XLnRa7w3G/x6xd/GtE1Bcw/PRr4L+DuHDfsM3mdIRc4/8GqQJ1WhgtV/txG
         6oVh8G/RIIXd1O52ajeHlosg3+uAtckpswC7Cocg=
Received: by mail-oi1-f174.google.com with SMTP id r8so13585016oij.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:23:40 -0700 (PDT)
X-Gm-Message-State: AOAM532q2CfJruKIJf9kR44cbbuwf5ID62AVMCXNLVOlM4aKBCpwbPun
        /oOHqpJrqx8GT1tYawp0uMgF1CdZtMovT2XE5sY=
X-Google-Smtp-Source: ABdhPJx2eZPX+Du0h3MntSi8Lx2ZwOblQJP5TQZfjG06lTvBIQu5Px4XC0ruV12geeyFMovJ9du/6fBwtK0/5GNoES4=
X-Received: by 2002:aca:f257:: with SMTP id q84mr17293654oih.174.1595226220136;
 Sun, 19 Jul 2020 23:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200708054354.25283-1-maochenxi@eswin.com> <mhng-8695bbb1-2ef2-409f-a458-3eb68d87495f@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-8695bbb1-2ef2-409f-a458-3eb68d87495f@palmerdabbelt-glaptop1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Jul 2020 09:23:28 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEAwuuR_tENNQ-_fTFHkh7g+hiH38SM=yYmoOu6ipU3tw@mail.gmail.com>
Message-ID: <CAMj1kXEAwuuR_tENNQ-_fTFHkh7g+hiH38SM=yYmoOu6ipU3tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: Enable compiler optimizations
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     maochenxi@eswin.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chenxi.mao2013@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 at 07:45, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 07 Jul 2020 22:43:54 PDT (-0700), maochenxi@eswin.com wrote:
> > Enable ARCH_HAS_FAST_MULTIPLIER and ARCH_SUPPORTS_INT128 for better
> > code generation.
> > These 2 configurations works fine on GCC-9.3 and GCC-10.1
> >
> > Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
> > ---
> >  arch/riscv/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 128192e14ff2..f21b7e5188ca 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -26,6 +26,8 @@ config RISCV
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> >       select ARCH_WANT_FRAME_POINTERS
> >       select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> > +     select ARCH_HAS_FAST_MULTIPLIER
> > +     select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
>
> IIRC int128 is only supported on 64-bit targets, and we already have this under
> RV64I but with a different set of requirements.  It looks like everyone has a
> different set of requirements, but I feel like CC_HAS_INT128 is the right way
> to go.  I'm not sure why we have the version check there.  Ard: do you know why
> we would need both?
>

That looks like copy/paste from the arm64 tree to me, where the names
of the libgcc routines were changed at some point, and we only support
the newer ones in the kernel.

> The fast multiplier one looks fine to me.  They're supposed to stay
> alphabetical, though.
>
> >       select CLONE_BACKWARDS
> >       select COMMON_CLK
> >       select EDAC_SUPPORT
