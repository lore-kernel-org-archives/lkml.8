Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F5C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3372072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Skd5KPmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgBUVJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:09:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42386 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBUVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:09:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id w21so1590202pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUPeoJQT4bo8QV8qvKihcroSkp75IgeOGG1W4e7sFl0=;
        b=Skd5KPmLOe5oAWgkoaQAhCuUl+WupDAuS3+iBV2bvTTT3rS6NfVOxYAHw/8XIxN5If
         RB2NwsC9jldeHpLN9P+oXY7kT29XOqSva4NORrRu37MarwF+9vJuwMHVv9bv/rmz2Zl/
         scJoDDEQrARI0SmgBk5F0m0zuQ/k6aazhojuz+KXiMfMRJN0DQ960YlEpqnDW4ggcFND
         FoNlqleGW3K19KQJSS226/FT7lqBgTzS6+wix7El/j/bqRoYYZ2Et4oMf3OoZROCX9fK
         JDBbCFQbtfD8AZaEQws4/3FFkHQkbf73hS+WNrge2MgCZh2ExijXcKQwQTyr7fcowd0x
         G3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUPeoJQT4bo8QV8qvKihcroSkp75IgeOGG1W4e7sFl0=;
        b=B8n0xfrmb94Kbt4TVqUpIWM08ugEQTbJakepoEAQegj9rw5b3Z6y2/KbRj746+/7i+
         aGVavhLgEXSni7j6hWDjNFH+zxRZgBwGgUI1l5Guy9q7DyE7hqebnT/J4aYLgvFhz+4x
         aJuBiFcQc9Hbu8WuQFa4AT3wU52BMDqHcY3sRhVKN2Z2koUeBdESTtAKPAhjRd77he0y
         7KKopVsyuXTe9DZkr2Fi9aJ9wu9jxr25hURIymBdZx6Prcj76vwKEmvjCQKLg3JTKl5r
         ssy227h54bMxNbGlovXtEr/tP6DtMIW2/egb1eT1vhNwcTP1AAzVd3QncJ7V7DpGLRVm
         tx/A==
X-Gm-Message-State: APjAAAWCkPOD0uSlbaEc2ebsBbr6vxYLBUDbZ0DwiHMjyQrKlygWM8DN
        2wMp2StQYz22u4ncX3fcO5UxghCr/gzVoXh4IN9aDQUjpF0=
X-Google-Smtp-Source: APXvYqxTAEN55Hi4n404sGxe5/oMDfTK3qYhtSibFhpCiew17vX1FZ0iWAA+sEUEDbLslT1dhSUwoqJjOXPGrIC7SLw=
X-Received: by 2002:a65:6412:: with SMTP id a18mr14625753pgv.10.1582319387058;
 Fri, 21 Feb 2020 13:09:47 -0800 (PST)
MIME-Version: 1.0
References: <ab67c7c5a1f96af6d22240e57fc27ba766d4193d.1580943526.git.stefan@agner.ch>
 <20200205235440.GW25745@shell.armlinux.org.uk>
In-Reply-To: <20200205235440.GW25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Feb 2020 13:09:36 -0800
Message-ID: <CAKwvOdkxg8vG4FZAFJehMouUHNqXaKT+J2AWtK7mn2EXJKOE5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: kexec: drop invalid assembly argument
To:     Stefan Agner <stefan@agner.ch>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 3:54 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Feb 05, 2020 at 11:59:26PM +0100, Stefan Agner wrote:
> > The tst menomic has only a single #<const> argument in Thumb mode. There
> > is an ARM variant which allows to write #<const> as #<byte>, #<rot>
> > which probably is where the current syntax comes from.
> >
> > It seems that binutils does not care about the additional parameter.
> > Clang however complains in Thumb2 mode:
> > arch/arm/kernel/relocate_kernel.S:28:12: error: too many operands for
> > instruction
> >  tst r3,#1,0
> >            ^
> >
> > Drop the unnecessary parameter. This fixes building this file in Thumb2
> > mode with the Clang integrated assembler.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/770
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Please drop it in the patch system, thanks.

Hi Stefan, did you add this to the patch tracking system? Looks like a
bunch got accepted, but I didn't see it in:
https://www.armlinux.org.uk/developer/patches/section.php?section=20&page=132

>
> > ---
> >  arch/arm/kernel/relocate_kernel.S | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
> > index 7eaa2ae7aff5..72a08786e16e 100644
> > --- a/arch/arm/kernel/relocate_kernel.S
> > +++ b/arch/arm/kernel/relocate_kernel.S
> > @@ -25,26 +25,26 @@ ENTRY(relocate_new_kernel)
> >       ldr     r3, [r0],#4
> >
> >       /* Is it a destination page. Put destination address to r4 */
> > -     tst     r3,#1,0
> > +     tst     r3,#1
> >       beq     1f
> >       bic     r4,r3,#1
> >       b       0b
> >  1:
> >       /* Is it an indirection page */
> > -     tst     r3,#2,0
> > +     tst     r3,#2
> >       beq     1f
> >       bic     r0,r3,#2
> >       b       0b
> >  1:
> >
> >       /* are we done ? */
> > -     tst     r3,#4,0
> > +     tst     r3,#4
> >       beq     1f
> >       b       2f
> >
> >  1:
> >       /* is it source ? */
> > -     tst     r3,#8,0
> > +     tst     r3,#8
> >       beq     0b
> >       bic r3,r3,#8
> >       mov r6,#1024
> > --
> > 2.25.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200205235440.GW25745%40shell.armlinux.org.uk.



-- 
Thanks,
~Nick Desaulniers
