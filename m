Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8918EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E9B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNIDE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:03:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41728 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgGNIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:03:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id a21so12365281otq.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sO75H8Yi9AP6nGiM/pURAA2j/eVJB0AD7UzA5jemaZU=;
        b=Ce9o2hEPMvproraK5pUXLRpvjiHMUx1k6uNHkmyPoChIovdeqoaeHerGzhZiEEIYm4
         a2OzdfNnA+ogo6O0I4fa21zOVPAl2SGmyi4DYwzNiyMkDQy4LiGFJXWaDe4nZK9pDa0f
         4iubiEzJbo+dLhlrecqQHb6KjadBr146uHlrkpUE23QISKVZQ52ljWESSSwZ0JV1ztU7
         MypfNLt1RaHdRgJReSNF25rUnUMlsvmJ3edn+e1ll1H/pOkNdFclhQ57F9VcmVzJWrsI
         Sygm6N8GHVN9s/Ph8lUrxSIPAh+M5/iwE/5SZrTUDPn+o6uB0s1PDJBB2DCEtQ1CdeEJ
         e4Mg==
X-Gm-Message-State: AOAM532X/1HE0WEHb4GvkOAmqUiu+2yqx50E8l2Y0HEkhfJulvHl2ESC
        M0egQthWQVNhS9I6LKtvQx1O4d9m56vzCR+EILI=
X-Google-Smtp-Source: ABdhPJyHqmvb+j+yiJ6OucsmNhvRsJX5An91RzeU9k0jTX5Xx2ryv/3ox1213omc5bxB7fjPoUnY4RkAd9z8TTMyGJ0=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr2980819otl.145.1594713782017;
 Tue, 14 Jul 2020 01:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-2-lee.jones@linaro.org>
 <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com>
 <20200714074629.GG3500@dell> <CAMuHMdVW_MzdDQk4f0RN-FsaedEr8WHREuTHxymWGpx3CmDX0Q@mail.gmail.com>
 <20200714080112.GJ3500@dell>
In-Reply-To: <20200714080112.GJ3500@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jul 2020 10:02:50 +0200
Message-ID: <CAMuHMdUxhvhwD+TzfiFSoZD_vy+UemvpgZ5_uXpY00S5ZLLdNQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] misc: c2port: core: Ensure source size does not
 equal destination size in strncpy()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Rodolfo Giometti <giometti@linux.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:01 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Jul 2020, Geert Uytterhoeven wrote:
> > On Tue, Jul 14, 2020 at 9:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Mon, 13 Jul 2020, Geert Uytterhoeven wrote:
> > > > On Fri, Jun 26, 2020 at 3:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > We need to ensure there's a place for the NULL terminator.
> > > >
> > > > But who's filling that space with a NUL (not NULL) terminator?
> > > >
> > > > > Fixes the following W=1 warning(s):
> > > > >
> > > > >  In file included from include/linux/bitmap.h:9,
> > > > >  from include/linux/nodemask.h:95,
> > > > >  from include/linux/mmzone.h:17,
> > > > >  from include/linux/gfp.h:6,
> > > > >  from include/linux/umh.h:4,
> > > > >  from include/linux/kmod.h:9,
> > > > >  from include/linux/module.h:16,
> > > > >  from drivers/misc/c2port/core.c:9:
> > > > >  In function ‘strncpy’,
> > > > >  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
> > > > >  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
> > > > >  297 | #define __underlying_strncpy __builtin_strncpy
> > > > >  | ^
> > > > >  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
> > > > >  307 | return __underlying_strncpy(p, q, size);
> > > > >  | ^~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Cc: Rodolfo Giometti <giometti@linux.it>
> > > > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/misc/c2port/core.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > > > index 33bba18022892..80d87e8a0bea9 100644
> > > > > --- a/drivers/misc/c2port/core.c
> > > > > +++ b/drivers/misc/c2port/core.c
> > > > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > > > >         }
> > > > >         dev_set_drvdata(c2dev->dev, c2dev);
> > > >
> > > > c2dev is allocated using:
> > > >
> > > >         c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
> > > >
> > > > hence the allocated memory is not zeroed.
> > > >
> > > > >
> > > > > -       strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> > > > > +       strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > > >
> > > > strncpy()
> > > >   1. does not terminate the destination with a NUL if the source length
> > > >       is C2PORT_NAME_LEN - 1,
> > > >   2. fills all remaining space in the destination buffer with NUL characters.
> > > >
> > > > So c2dev.name[C2PORT_NAME_LEN - 1] always contains an uninitialized
> > > > value.
> > > >
> > > > Now, it seems the only caller of c2port_device_register() passes
> > > > "uc" as the name.  Which means in practice c2dev.name[] will be
> > > > NUL-terminated. However, the last byte will still be uninitialized, and
> > > > if the buffer is ever copied to userspace, your patch will have introduced
> > > > a leak.
> > >
> > > Quite right.  Good spot.  I must have made the assumption that the
> > > destination buffer would be pre-initialised.  Not sure why it's not in
> > > this case.  Seems like an odd practice.
> > >
> > > So we have a choice.  We can either enlarge the destination buffer to
> > > *actually* allow a full length (32 byte in this case) naming string,
> > > or zero the buffer.
> > >
> > > Or even both!
> > >
> > > Do you have a preference?
> >
> > Do we know if the buffer or full c2dev struct is ever copied to userspace?
>
> I don't know that, but I think we should err on the side of caution.
>
> > If it may be copied => kalloc().
>
> Do you mean kzalloc()?

Sorry, kzalloc.

> > If it will never be copied => strlcpy() (no NUL-padding, only NUL-terminator).
> >
> > Oh, and there is a newer one on the block (which I always have to lookup),
> > which is preferred over strlcpy() and strncpy(): strscpy().
> > And reading lib/string.c, there's strscpy_pad(), too ;-)
>
> Let's not get too crazy. ;)

The side of caution is kzalloc(), so strscpy() is OK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
