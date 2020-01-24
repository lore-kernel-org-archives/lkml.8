Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D622072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0XBSqcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbgAXSjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:39:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42055 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbgAXSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:39:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so426947oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ur5wn0jQUUm7psVtxYzvB782IVJQCdtTuuwvxJbzuK4=;
        b=X0XBSqcNCxk9PTnmv5MWAedQ+6T4i53cVWfLpwz1c3deUfX8Cr6FZx55tbRy/FE2Xj
         XCkDMkBOHkWzAxaz2jThEzrMq12iF7BAl+HXbHoDnuh3rSdhuX9Ei5I+0uZasJs/cwGa
         vIeQbkoQfPe1B/oysaOerxWrTNsBpjpl0wleGNziPsxbH+L1jTuYhG61A1ri0f2nCuLN
         ha1+lp5thUPnpXh7j5SRghbVAwkb5JkF8P3IN1chc0+llDqzr2kIC/cXOna9vaaYJtew
         wH4qE54VTohWkCzb9BJd2Fv7XV3NFrVYBrJON/BWmyfV48nM9djYonAGr//PdVBjKkQv
         cy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ur5wn0jQUUm7psVtxYzvB782IVJQCdtTuuwvxJbzuK4=;
        b=mEELfb9DLFi9xjfOWCGHSU2J8q2KtG9iFd8U+ZuO9lHtpwCtmaa3TP6bHD47myJw4h
         WLxr4jAqeMw6CDvJS8WNj+NSRYRmtoEDfnM4GXYAu6CBuiWXxQtlpmkTS5iWTuFak6VS
         GWyMgT48NZHqBfJy/HtonVBM01OL19rxbLopc/an5AkZUhnTstaGAbgvcnCVevWd38iF
         XVEorkKfz4yMbIvCRlFKMXpY6CqaydjHsR4tMkWuuHTIjdQ/2SvjkoHKC9WavmkM2X7t
         7LGcsHKbygSQt1B7mybsjMZooG6XbKlYVdeTE09bioi8SyVQGTpJlfuCHHU57clHaJmt
         5ySA==
X-Gm-Message-State: APjAAAWEKXas/34w2xbpq4y1KLswiXHEPcyfA/5f3iq7AER2yhyziZOX
        ROu1+X4UDYtkFejCtLwwFeDjdj+C8v2a/yK4FPA=
X-Google-Smtp-Source: APXvYqwE2svQq9XxuHw0G4MW4VIcqvGyEo2etKveL2u1hVTbuluJ/3vyslNOBm1w8ygDsvsLJb15KLXoH+FzN0BmwPU=
X-Received: by 2002:aca:f507:: with SMTP id t7mr129477oih.156.1579891187238;
 Fri, 24 Jan 2020 10:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20200124181811.4780-1-hjl.tools@gmail.com> <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
In-Reply-To: <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 24 Jan 2020 10:39:11 -0800
Message-ID: <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Don't clare __force_order in kaslr_64.c
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:24 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
>
>
> > On Jan 24, 2020, at 10:18 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > =EF=BB=BFGCC 10 changed the default to -fno-common, which leads to
> >
> >  LD      arch/x86/boot/compressed/vmlinux
> > ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definiti=
on of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): firs=
t defined here
> > make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/comp=
ressed/vmlinux] Error 1
> >
> > Since __force_order is already provided in pgtable_64.c, there is no
> > need to declare __force_order in kaslr_64.c.
>
> Why does anything actually define that variable?  Surely any actual refer=
ences are just an outright bug.  Is it needed for LTO?

It is needed by GCC 10 without LTO.

--=20
H.J.
