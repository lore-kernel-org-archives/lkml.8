Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8161621582
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSGWB+49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNIBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:01:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:01:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so3907187wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ztT/QpJ6PrCphActN8ZP+HT90Nds35MNzsbH5sIelU=;
        b=gSGWB+49lMVbaphzeSLTo9w7GB7qEMwC4bbiMp1OgiArWtvWIKNyyi/2Aq3I95jJ79
         dPty4eSAc7AwGcGkdCXiQrwmvm/qEHrEGNB2oxj9fmJOZEytDX2nv7ctd2xQVlggFJ10
         yZLg0Ve/YIXNOcO8YqKf795Uu3r4g3QcQpnp6ftWay8TlSfLZpDN5psMA1Rw8sYRV0cO
         WAbOCyPTdp7V/khUNKoljVY0LQ42tKizHWU426sN/mWb0YzGqGNWNGOIxKvfsSeIpaRI
         ZIloyx4VcMk1Iz44hjlLrm3kRAbw5mc9qSN84T2yxFD0W/hb+DhhiwEYUevNgtR+lCqh
         TN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ztT/QpJ6PrCphActN8ZP+HT90Nds35MNzsbH5sIelU=;
        b=YZeJt/pfS4m9Sv3/D2WMi8gW6zhu+9mB9VfG/bGjpe3Q2Uw2u7fwW7M+6rygEHuKgx
         7Yk0VlTqSjSuzGhdUheYidaimW8VfaBzQK7YvmPPhzPn4gnoxmyop2ICClmY3i3y+Dwl
         +AHotnOhBOKiKHJJpwLkUqx4fwR1O4JpHiGnqZbbKzb5slf+1pZTsQVkLYCAGH/JpRab
         1FSkFh0/RhiIVKUWQeLuUBMP8z/JUEcahHqYYQcw5/+fhsuAcWB7u2lKHb3x47VlS/u2
         vG6ycZZFphhDO3ZkMcNWfM3oeLLaNI+Anaab79IqZMQ2JsoN5MsOXYX9NJfoEVHzMj+4
         VTjw==
X-Gm-Message-State: AOAM531MiJszR6uwGg+zuVZjlHeylJj4riG7KUYW+3YJNca5+pQWz+oT
        WZqHzEHgNoW4VW4vz71iWWXl3w==
X-Google-Smtp-Source: ABdhPJzeN2SHrdqPIt1LbkEDBs+YbZAAr6ZyG989rcpJQDX84Mi5m2wsg8bqV9/RfQG/IQu7KXu5wg==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr2942928wmg.113.1594713674837;
        Tue, 14 Jul 2020 01:01:14 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id e17sm26518093wrr.88.2020.07.14.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:01:14 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:01:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Rodolfo Giometti <giometti@linux.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/10] misc: c2port: core: Ensure source size does not
 equal destination size in strncpy()
Message-ID: <20200714080112.GJ3500@dell>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-2-lee.jones@linaro.org>
 <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com>
 <20200714074629.GG3500@dell>
 <CAMuHMdVW_MzdDQk4f0RN-FsaedEr8WHREuTHxymWGpx3CmDX0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVW_MzdDQk4f0RN-FsaedEr8WHREuTHxymWGpx3CmDX0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Tue, Jul 14, 2020 at 9:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 13 Jul 2020, Geert Uytterhoeven wrote:
> > > On Fri, Jun 26, 2020 at 3:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > We need to ensure there's a place for the NULL terminator.
> > >
> > > But who's filling that space with a NUL (not NULL) terminator?
> > >
> > > > Fixes the following W=1 warning(s):
> > > >
> > > >  In file included from include/linux/bitmap.h:9,
> > > >  from include/linux/nodemask.h:95,
> > > >  from include/linux/mmzone.h:17,
> > > >  from include/linux/gfp.h:6,
> > > >  from include/linux/umh.h:4,
> > > >  from include/linux/kmod.h:9,
> > > >  from include/linux/module.h:16,
> > > >  from drivers/misc/c2port/core.c:9:
> > > >  In function ‘strncpy’,
> > > >  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
> > > >  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
> > > >  297 | #define __underlying_strncpy __builtin_strncpy
> > > >  | ^
> > > >  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
> > > >  307 | return __underlying_strncpy(p, q, size);
> > > >  | ^~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Cc: Rodolfo Giometti <giometti@linux.it>
> > > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/misc/c2port/core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > > index 33bba18022892..80d87e8a0bea9 100644
> > > > --- a/drivers/misc/c2port/core.c
> > > > +++ b/drivers/misc/c2port/core.c
> > > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > > >         }
> > > >         dev_set_drvdata(c2dev->dev, c2dev);
> > >
> > > c2dev is allocated using:
> > >
> > >         c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
> > >
> > > hence the allocated memory is not zeroed.
> > >
> > > >
> > > > -       strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> > > > +       strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > >
> > > strncpy()
> > >   1. does not terminate the destination with a NUL if the source length
> > >       is C2PORT_NAME_LEN - 1,
> > >   2. fills all remaining space in the destination buffer with NUL characters.
> > >
> > > So c2dev.name[C2PORT_NAME_LEN - 1] always contains an uninitialized
> > > value.
> > >
> > > Now, it seems the only caller of c2port_device_register() passes
> > > "uc" as the name.  Which means in practice c2dev.name[] will be
> > > NUL-terminated. However, the last byte will still be uninitialized, and
> > > if the buffer is ever copied to userspace, your patch will have introduced
> > > a leak.
> >
> > Quite right.  Good spot.  I must have made the assumption that the
> > destination buffer would be pre-initialised.  Not sure why it's not in
> > this case.  Seems like an odd practice.
> >
> > So we have a choice.  We can either enlarge the destination buffer to
> > *actually* allow a full length (32 byte in this case) naming string,
> > or zero the buffer.
> >
> > Or even both!
> >
> > Do you have a preference?
> 
> Do we know if the buffer or full c2dev struct is ever copied to userspace?

I don't know that, but I think we should err on the side of caution.

> If it may be copied => kalloc().

Do you mean kzalloc()?

> If it will never be copied => strlcpy() (no NUL-padding, only NUL-terminator).
> 
> Oh, and there is a newer one on the block (which I always have to lookup),
> which is preferred over strlcpy() and strncpy(): strscpy().
> And reading lib/string.c, there's strscpy_pad(), too ;-)

Let's not get too crazy. ;)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
