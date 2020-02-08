Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE0AC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E67520726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SO93iRw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHIzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 03:55:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35664 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgBHIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 03:55:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so4519258oie.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYQGK6YXfcZc98jtf4E/uGifjg8qJuSxlB3RUf5LzII=;
        b=SO93iRw417Yoski/EyoEHUBuzH4+hduutcUTwTVnt6bZfgQ2f0QSp/1fS+w7xvyL7a
         H6ANRscSn1szpp3VfSBq3vWHi+IrHLGmTTqqUz7YHd+1h8wMNpEGbz7eUN6u61Jk69+3
         hy69FvKnhSqSWLxHtnaPjX9Wo20zQ/exzSfCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYQGK6YXfcZc98jtf4E/uGifjg8qJuSxlB3RUf5LzII=;
        b=DOx+KNBFHJSevoaGUKb0rrtm1+RFghMuKnLHWFUAUmS2U6Oza7asSqqNv/JosQd0my
         wuT/hkW4VLXXhQJChFDV9dWBpKijcFpPHfww+K2cwHjYkoShJ+8ZpI8YeQcgKWnEmXST
         ZnI9zS4j5wLEBLdYmOEhxtL1Oi8SS6QiRZrBciR8P74NQKG64pBNzD2NyIQFF5SVmJWT
         +oOY6Nnuq73lCV3GnbGSdNMBogSKweW06UBeJBixp5uI/kqcL3MqUzWWGmm/vTR6I4+C
         kbDAKaWUca+QB28jYXAtspII1AMn1O6AhYC29l/ePfJlXZhsDOkSfl6EjCNnKBkFbktc
         245g==
X-Gm-Message-State: APjAAAV+PzbvGqGaoHmKO08lTAhWC5LvKJsUhpmbqEDv+h5Novlv9Wi7
        kk7bK3vuAWeCXF3KO0wvTVzwbQ==
X-Google-Smtp-Source: APXvYqzR893+XUAT+CRl88sAB98jXGqIGMtzSW1DZHEa2pjtSW1v5WRpxBzEmQHXJ8CYw5h1l5C2Rg==
X-Received: by 2002:aca:c70b:: with SMTP id x11mr4907987oif.29.1581152114456;
        Sat, 08 Feb 2020 00:55:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n17sm2063897otq.46.2020.02.08.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 00:55:13 -0800 (PST)
Date:   Sat, 8 Feb 2020 00:55:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: rename missed uaccess .fixup section
Message-ID: <202002080054.CBBE423@keescook>
References: <202002071754.F5F073F1D@keescook>
 <CAKv+Gu8Wt-QX1+9E+QCk30CAttkXP2P5ZKQACqeMDFGeQ9FCKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8Wt-QX1+9E+QCk30CAttkXP2P5ZKQACqeMDFGeQ9FCKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 07:54:39AM +0000, Ard Biesheuvel wrote:
> On Sat, 8 Feb 2020 at 02:02, Kees Cook <keescook@chromium.org> wrote:
> >
> > When the uaccess .fixup section was renamed to .text.fixup, one case was
> > missed. Under ld.bfd, the orphaned section was moved close to .text
> > (since they share the "ax" bits), so things would work normally on
> > uaccess faults. Under ld.lld, the orphaned section was placed outside
> > the .text section, making it unreachable. Rename the missed section.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/282
> > Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
> > Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
> > Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")
> > Cc: stable@vger.kernel.org
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Reported-by: Manoj Gupta <manojgupta@google.com>
> > Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

> As Nick points out, the *(.fixup) line still appears in the
> decompressor's linker script, but this is harmless, given that we
> don't ever emit anything into that section. But while we're at it, we
> might just remove it as well.

Agreed. I'll send a separate patch for that.

-Kees

> 
> 
> > ---
> > I completely missed this the first several times I looked at this
> > problem. Thank you Nicolas for pushing back on the earlier patch!
> > Manoj or Nathan, can you test this?
> > ---
> >  arch/arm/lib/copy_from_user.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> > index 95b2e1ce559c..f8016e3db65d 100644
> > --- a/arch/arm/lib/copy_from_user.S
> > +++ b/arch/arm/lib/copy_from_user.S
> > @@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
> >
> >  ENDPROC(arm_copy_from_user)
> >
> > -       .pushsection .fixup,"ax"
> > +       .pushsection .text.fixup,"ax"
> >         .align 0
> >         copy_abort_preamble
> >         ldmfd   sp!, {r1, r2, r3}
> > --
> > 2.20.1
> >
> >
> > --
> > Kees Cook

-- 
Kees Cook
