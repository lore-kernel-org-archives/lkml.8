Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBAC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C98B20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGNHwj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:52:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40622 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id c25so12363325otf.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GnEuOKgk5NDFLsvpeWRSzwDF6EpvyIkpFCLXT7y40fg=;
        b=Ru/EkcpZp5Q1sliZV8lhYgDjQpdie0MgXwvYsd9HTupHaPEyt7LyL3WKF+oa4w5S7p
         i/d9EJzxp+WxYpbfNpvyek0itowNn9UBUkKXjYl4XafDc/jJ49Q5VpVdFUxJ53KNiu1K
         lPyqgvqNw20/48kmiPMY9Iq1KkeSTx0hcTghfHRzDJExReQIxFJ6mVZ/IHjnx68VZvr6
         KTY33zfTS2ELlNLvSdJxlJygHWydjd93Gnjhr32P1OchN3QvOZvDzkR5To6dAU+TVoVn
         2PCcPBusnXhORWn/eKWqtZUxqc2+y+9JM41UuHw0l285nRH9VO327orkS8Mo471Hjt+Q
         BAcQ==
X-Gm-Message-State: AOAM532XQPRZUTqBvec6BHeqqZYXNTMqiW0l0Gmtz7ORyGG36a1UgQDn
        sxvYcLLbWqiXxij1f0U5py6YLfkrK7CJP4Qs1tE=
X-Google-Smtp-Source: ABdhPJzdS12a/uWolHgEC3gpYiGBybd4Zi8ZYldU0JBDZ5G9jsxfax+2eUWX3ZtMac7Nle8TPmpzfzv5dWFvCLG7AEM=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr2954831otl.145.1594713156044;
 Tue, 14 Jul 2020 00:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-2-lee.jones@linaro.org>
 <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com> <20200714074629.GG3500@dell>
In-Reply-To: <20200714074629.GG3500@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jul 2020 09:52:24 +0200
Message-ID: <CAMuHMdVW_MzdDQk4f0RN-FsaedEr8WHREuTHxymWGpx3CmDX0Q@mail.gmail.com>
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

Hi Lee,

On Tue, Jul 14, 2020 at 9:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 13 Jul 2020, Geert Uytterhoeven wrote:
> > On Fri, Jun 26, 2020 at 3:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > We need to ensure there's a place for the NULL terminator.
> >
> > But who's filling that space with a NUL (not NULL) terminator?
> >
> > > Fixes the following W=1 warning(s):
> > >
> > >  In file included from include/linux/bitmap.h:9,
> > >  from include/linux/nodemask.h:95,
> > >  from include/linux/mmzone.h:17,
> > >  from include/linux/gfp.h:6,
> > >  from include/linux/umh.h:4,
> > >  from include/linux/kmod.h:9,
> > >  from include/linux/module.h:16,
> > >  from drivers/misc/c2port/core.c:9:
> > >  In function ‘strncpy’,
> > >  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
> > >  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
> > >  297 | #define __underlying_strncpy __builtin_strncpy
> > >  | ^
> > >  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
> > >  307 | return __underlying_strncpy(p, q, size);
> > >  | ^~~~~~~~~~~~~~~~~~~~
> > >
> > > Cc: Rodolfo Giometti <giometti@linux.it>
> > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/misc/c2port/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > index 33bba18022892..80d87e8a0bea9 100644
> > > --- a/drivers/misc/c2port/core.c
> > > +++ b/drivers/misc/c2port/core.c
> > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > >         }
> > >         dev_set_drvdata(c2dev->dev, c2dev);
> >
> > c2dev is allocated using:
> >
> >         c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
> >
> > hence the allocated memory is not zeroed.
> >
> > >
> > > -       strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> > > +       strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> >
> > strncpy()
> >   1. does not terminate the destination with a NUL if the source length
> >       is C2PORT_NAME_LEN - 1,
> >   2. fills all remaining space in the destination buffer with NUL characters.
> >
> > So c2dev.name[C2PORT_NAME_LEN - 1] always contains an uninitialized
> > value.
> >
> > Now, it seems the only caller of c2port_device_register() passes
> > "uc" as the name.  Which means in practice c2dev.name[] will be
> > NUL-terminated. However, the last byte will still be uninitialized, and
> > if the buffer is ever copied to userspace, your patch will have introduced
> > a leak.
>
> Quite right.  Good spot.  I must have made the assumption that the
> destination buffer would be pre-initialised.  Not sure why it's not in
> this case.  Seems like an odd practice.
>
> So we have a choice.  We can either enlarge the destination buffer to
> *actually* allow a full length (32 byte in this case) naming string,
> or zero the buffer.
>
> Or even both!
>
> Do you have a preference?

Do we know if the buffer or full c2dev struct is ever copied to userspace?
If it may be copied => kalloc().
If it will never be copied => strlcpy() (no NUL-padding, only NUL-terminator).

Oh, and there is a newer one on the block (which I always have to lookup),
which is preferred over strlcpy() and strncpy(): strscpy().
And reading lib/string.c, there's strscpy_pad(), too ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
