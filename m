Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC060C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 10:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CD021775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ4fq6KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHKFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 05:05:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgBHKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 05:05:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so797893plm.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0xgMzVvnquxmSoa8b2un9FhUW2CIcx5JEQW64zzoig=;
        b=PZ4fq6KOA2eSPnd8W1jJK5kxEPyXhpQZdTSgiW9rPSj7pjzydNU4g4mL3m0aSpop3p
         eCrxeox3Bi/EKLVS6i6WlTUEf0cmzdtTUbm6VtjaXVx2qDKM529O5dYcHj8qru6dDStg
         LfLirUhLJ6HiRByfmjyF46wF+itXbGMcs/8uCAqFLX6/xHd8eXc1BqU3wBnCEhLmx3mv
         VuAFnYUM4cZwPbY+iFrJS65cndVXbI0VP22VBDfPeXvKPtxi9VHX39h/tqXagI7ORcbd
         l9w/jTVBhsGT1zNjRWkQ4xbaAn2z3Ot9S8AYiWjd0u1KkCGqssyiU5lZPNPbWi5WaORV
         QvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0xgMzVvnquxmSoa8b2un9FhUW2CIcx5JEQW64zzoig=;
        b=MNsgmQ8vaco+iA2GIaayDrkTM9uw8p3M/v66RBneRyKLJNA0vu5IJ69cz2W+OTGYkj
         WmP4slxkjAnTgho+G7ygkIUGj3MsWxaHPChUK4PqCy9Yn2yaaU6akcMnnhE++0itMl4v
         Pwq/SfFOFlsgtm3irG3Y1UvUdkDqiDJ/dsDGiAxzIE2JNuhpT4IoqPeOLfYKYAIVo4+0
         pfRZAtzgJ2jsBXtjFehce1C7q2oYHG8+UxI5pHQ3fWAuYZIXtXm9b/Q/PDsW37YmER+U
         JKrfXC1WgoTVs2ZEWCaWh+d1oA1G0hHxTh0ej7ymJCAWCIsAyaCI/wZ+TvO4BT7ThG2n
         NREQ==
X-Gm-Message-State: APjAAAVKqIkU6eLAvduxvfu8yhV5/73UojzOzuVjHGGP8tmk0h8a/OLx
        y1E/+DwTWQp3AUE5i3j5uf5oz++TEjmQgFbOdU9lAQ==
X-Google-Smtp-Source: APXvYqxXWxSlNnqFbe1ZxZDLLlJsZxLfb+81FRMw436skzvn6kDV8tMhJX7FfWNtEj0p1I676ybBxWjSlGtlqEv7XqA=
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr9439882pjk.134.1581156305061;
 Sat, 08 Feb 2020 02:05:05 -0800 (PST)
MIME-Version: 1.0
References: <202002071754.F5F073F1D@keescook> <CAKv+Gu8Wt-QX1+9E+QCk30CAttkXP2P5ZKQACqeMDFGeQ9FCKA@mail.gmail.com>
 <202002080054.CBBE423@keescook>
In-Reply-To: <202002080054.CBBE423@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 8 Feb 2020 10:04:53 +0000
Message-ID: <CAKwvOdmchUkLLQMjagJ1cxa3CwFaAgH8gZcMVNny9Fb0iDVi8A@mail.gmail.com>
Subject: Re: [PATCH] ARM: rename missed uaccess .fixup section
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 9:55 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Feb 08, 2020 at 07:54:39AM +0000, Ard Biesheuvel wrote:
> > On Sat, 8 Feb 2020 at 02:02, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > When the uaccess .fixup section was renamed to .text.fixup, one case was
> > > missed. Under ld.bfd, the orphaned section was moved close to .text
> > > (since they share the "ax" bits), so things would work normally on
> > > uaccess faults. Under ld.lld, the orphaned section was placed outside
> > > the .text section, making it unreachable. Rename the missed section.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/282
> > > Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
> > > Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
> > > Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Reported-by: Manoj Gupta <manojgupta@google.com>
> > > Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks!
>
> > As Nick points out, the *(.fixup) line still appears in the
> > decompressor's linker script, but this is harmless, given that we
> > don't ever emit anything into that section. But while we're at it, we
> > might just remove it as well.
>
> Agreed. I'll send a separate patch for that.

Sure, in that case
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> -Kees
>
> >
> >
> > > ---
> > > I completely missed this the first several times I looked at this
> > > problem. Thank you Nicolas for pushing back on the earlier patch!
> > > Manoj or Nathan, can you test this?
> > > ---
> > >  arch/arm/lib/copy_from_user.S | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> > > index 95b2e1ce559c..f8016e3db65d 100644
> > > --- a/arch/arm/lib/copy_from_user.S
> > > +++ b/arch/arm/lib/copy_from_user.S
> > > @@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
> > >
> > >  ENDPROC(arm_copy_from_user)
> > >
> > > -       .pushsection .fixup,"ax"
> > > +       .pushsection .text.fixup,"ax"
> > >         .align 0
> > >         copy_abort_preamble
> > >         ldmfd   sp!, {r1, r2, r3}
> > > --
> > > 2.20.1
> > >
> > >
> > > --
> > > Kees Cook
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
