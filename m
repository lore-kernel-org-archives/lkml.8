Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEFCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C412083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tARFDEDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgHSNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgHSNem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:34:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A233DC061757;
        Wed, 19 Aug 2020 06:34:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v22so17744384qtq.8;
        Wed, 19 Aug 2020 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=qLSpTi/wS0rqA92hZ8N392gIFPLza+42A+sZ/4jgGW8=;
        b=tARFDEDu4L/h45Sv181tJOBAaGo5hWdYuKz7LbjjA7zsJNQg2liG7Jqi4H04EBqek7
         QiOc5ial+L99+YozupYXwwnKQ83y6rl5/rwOAvCVtV21DycqJdCVt+4k2qcfgG2xgl/+
         zNRz9P28edyMgfmW9d+MT9mKn7Wl0rWx7rHJIBumKOdxgazp58leQffXdDoFjnRp54s5
         W/Yuq0V09tD/y+dPCHjbAI7MB62UcENQi/PeVCumtlh5WGXnwSgXIAtbV4poRRF/zlMj
         IzkFG/MWDr9R4MIEWddtTmPPQ8LW/ukQUwLORB5M9aUQMssO2VFO62q4fR4+k5V8AY3o
         0UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=qLSpTi/wS0rqA92hZ8N392gIFPLza+42A+sZ/4jgGW8=;
        b=JC2jMXnYsWDjtMuKHEmUe75jk6ZQED+pH1c4iI8b5333wHXhE0e0ROdJPAZWM/Fr/y
         fl47L6J4++kRzvddejzUHZ6Vf/evwPC5noJriZl+r4zLJQPX+wNOoqdfr0m7aKiJR75a
         7Ou13jEQ7KcwE1ZbXmSbUllpMiEBj4G+wJb0vuHSarq1GPCRMuc5InCOS4KBMzRUJDb8
         Dp+jdrUK+IJQHMzcDCDg4TijNwtZWHXBZcE2gqww3zCNHVkUw1s5eSW03jBdYJu/3WuL
         rzCbKkS0XoRBlyIB8o19sXHShmhfyDADACNx63/tJyVaLH22aO9XPP7hOtc12mHRH7CZ
         BYSA==
X-Gm-Message-State: AOAM5335FY7i/9BUTHveCdPs+jgOY3Hg71BKGHjMS184mqVjMPplGnyW
        K7hciFA3F1OBqBMfSKgIrcs=
X-Google-Smtp-Source: ABdhPJxZ6tLtod9Bd8h/Lib1oZIPTALtdhWpL9hIdLs2sjZPkZ6Uq1PB6TK3ctSFsXM6dpa/VIOEPw==
X-Received: by 2002:ac8:6bce:: with SMTP id b14mr22359452qtt.255.1597844080873;
        Wed, 19 Aug 2020 06:34:40 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id y26sm25829334qto.75.2020.08.19.06.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:34:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "Linux-sh list" <linux-sh@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Date:   Wed, 19 Aug 2020 09:23:47 -0400
Message-Id: <C510813DTTYI.1PZXLO9Y2FRLM@atris>
In-Reply-To: <CAMuHMdVYeAqLHuW2fjQk7HQbnGJhY7YJcksMddn_6Cp61cd-AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed Aug 19, 2020 at 5:09 AM EDT, Geert Uytterhoeven wrote:
> Hi Liam,
>
> On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com>
> wrote:
> > The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> > the following issue on SuperH:
> >
> >     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy=
/ti/phy-tusb1210.ko] undefined!
> >
> > Add support for cmpxchg on u8 and u16 pointers.
> >
> > [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > ---
> >
> > Hi,
> >
> > This was reported by the kernel test bot on an architecture I can't
> > really test on. I was only able to make sure the build succeeds, but
> > nothing more.
> > This patch is based on the __cmpxchg_u32 impletmentation and seems
> > incomplete based on the different cmpxchg headers I can find.
>
> Indeed. This version is suitable for non-SMP machines only.
> BTW, it looks like this version can be replaced by the one in
> asm-generic?
>

Thanks for your feedback I'll have a look at the asm-generic functions
and try to use those instead.

> >
> > Do these function need to be impletmented in each header
> > simulataneously?
>
> Yes, we need them for all variants.
>

Okay, I'll look into that. Would you recommend a good way to test these
changes?

> >  arch/sh/include/asm/cmpxchg-irq.h | 27 +++++++++++++++++++++++++++
> >  arch/sh/include/asm/cmpxchg.h     |  5 +++--
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cm=
pxchg-irq.h
> > index 07d3e7f08389..918c4153a930 100644
> > --- a/arch/sh/include/asm/cmpxchg-irq.h
> > +++ b/arch/sh/include/asm/cmpxchg-irq.h
> > @@ -51,4 +51,31 @@ static inline unsigned long __cmpxchg_u32(volatile i=
nt *m, unsigned long old,
> >         return retval;
> >  }
> >
> > +static inline unsigned long __cmpxchg_u16(volatile u16 *m, unsigned lo=
ng old,
> > +       unsigned long new)
> > +{
> > +       u16 retval;
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +       retval =3D *m;
> > +       if (retval =3D=3D old)
> > +               *m =3D new;
> > +       local_irq_restore(flags);
> > +       return (unsigned long)retval;
> > +}
> > +
> > +static inline unsigned long __cmpxchg_u8(volatile u8 *m, unsigned long=
 old,
> > +       unsigned long new)
> > +{
> > +       u8 retval;
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +       retval =3D *m;
> > +       if (retval =3D=3D old)
> > +               *m =3D new;
> > +       local_irq_restore(flags);
> > +       return (unsigned long)retval;
> > +}
> >  #endif /* __ASM_SH_CMPXCHG_IRQ_H */
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxch=
g.h
> > index e9501d85c278..7d65d0fd1665 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -56,8 +56,9 @@ static inline unsigned long __cmpxchg(volatile void *=
 ptr, unsigned long old,
> >                 unsigned long new, int size)
> >  {
> >         switch (size) {
> > -       case 4:
> > -               return __cmpxchg_u32(ptr, old, new);
> > +       case 4: return __cmpxchg_u32((int *)ptr, old, new);
> > +       case 2: return __cmpxchg_u16((u16 *)ptr, old, new);
> > +       case 1: return __cmpxchg_u8((u8 *)ptr, old, new);
> >         }
> >         __cmpxchg_called_with_bad_pointer();
> >         return old;
>
> Gr{oetje,eeting}s,
>
> Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something
> like that.
> -- Linus Torvalds

Thanks for your time,
Liam
