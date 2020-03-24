Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38004C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F22D20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmaPzGpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCXNgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:36:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgCXNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:36:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id u59so20655834edc.12;
        Tue, 24 Mar 2020 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMB75Qkz8yI3t1WgLX4NDid7APvWxFWZwvhtkRGYDD0=;
        b=YmaPzGpXLGUa5XCjv+/RdXu1YOk3nivWvqRjx/vlBo4hqqJMk61wmNSN10Iul77Nvo
         E2L8DGlsGEt1ZD8RNEtVTvW8atC1lJhwwbwWlVmw0Kle33ZWDgaUBzU4LXO6eNZ2+t/3
         7DOFjDXJpe06e+edi5OVIv5ZrmN3GgBmYGQk9Gh9Gdc3HQYrcGeRwPDfduTjETjLmLC0
         W4ghmX+aNoJ9x1cnG7XrpgydcXceO9B0t87y35x/4tvjwkUofUE8CKAZbbP35QzShhcL
         KxnbtZtkYvIV9nmhS+8rEJgSTDL46IbvmxBicE2mgMB+B9Ke6u0ZBK8Ou7pw41gMrIAy
         aD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMB75Qkz8yI3t1WgLX4NDid7APvWxFWZwvhtkRGYDD0=;
        b=aYPKJktJkhyeb78u1aYJlAeJWIQya4BI1Mih/VBbLdmAx+t6y6EvpzBIUODXEzEjIh
         +vg2y3uRegA2V3CKl08gUpAD7JjEa0KtZA7D2ZSR7rx3G3Tj7Em71VAiPC8683P2zq6E
         S1aqgSEfem0FzuuqdKmNMuxKU67eXZqw/Pcmm5dMEUWEcIX77xLJevjKRgAeWgnDdBby
         4huBFNOvDuBUDCGpswwnfUGAwlBdgoGeh50njiK/J7dDgvZt7d9HKHSO3wa7LPmPrFUN
         aOPjhzp0bBOjhQOgHr9cnsW4nLKhNHQY5COQuNmvQpVoOIxWgxy8sTClSLjqX2kP2QQN
         RF4w==
X-Gm-Message-State: ANhLgQ2+E6n8UFJc8TEzBbibV/H20INxEd983ETjQsFTZthCDqA3CJqO
        RO8U2UAGxE7Hi3Hn+CED3tZNbI04zjuixBsBnssJ8tl1
X-Google-Smtp-Source: ADFU+vscfGIZKpwjX0dEGgS35+1q/HihwK1k2Qfxg2EzIk59b8orP/i57EWa5pCCRT3SkfBE+JjbKeYPuy25TYl1VEA=
X-Received: by 2002:a50:f743:: with SMTP id j3mr26864098edn.22.1585056962133;
 Tue, 24 Mar 2020 06:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200310023550eucas1p10797f834d7dc16f634cf644011462393@eucas1p1.samsung.com>
 <20200310023536.13622-1-hslester96@gmail.com> <1f5e6f52-c638-f73e-cf9d-88eb641a010d@samsung.com>
In-Reply-To: <1f5e6f52-c638-f73e-cf9d-88eb641a010d@samsung.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 24 Mar 2020 21:35:51 +0800
Message-ID: <CANhBUQ1JV3drHn-HO2urK-Q7yUNtLhk09UuBG7F=qV7Lid=0ww@mail.gmail.com>
Subject: Re: [PATCH v3] video: fbdev: vesafb: add missed release_region
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 8:01 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 3/10/20 3:35 AM, Chuhong Yuan wrote:
> > The driver forgets to free the I/O region in remove and probe
> > failure.
> > Add the missed calls to fix it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v3:
> >   - Revise the commit message.
> >   - Add an error handler to suit the "goto error" before request_region().
> >   - Revise the order of operations in remove.
> >
> >  drivers/video/fbdev/vesafb.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> > index a1fe24ea869b..c7bc9ace47d4 100644
> > --- a/drivers/video/fbdev/vesafb.c
> > +++ b/drivers/video/fbdev/vesafb.c
> > @@ -439,7 +439,7 @@ static int vesafb_probe(struct platform_device *dev)
> >                      "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
> >                       vesafb_fix.smem_len, vesafb_fix.smem_start);
> >               err = -EIO;
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >
> >       printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
> > @@ -458,15 +458,17 @@ static int vesafb_probe(struct platform_device *dev)
> >
> >       if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
> >               err = -ENOMEM;
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >       if (register_framebuffer(info)<0) {
> >               err = -EINVAL;
> >               fb_dealloc_cmap(&info->cmap);
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >       fb_info(info, "%s frame buffer device\n", info->fix.id);
> >       return 0;
> > +err_release_region:
> > +     release_region(0x3c0, 32);
>
> This is incorrect.
>
> The cleanup order should be the reverse of the probing order.
>
> Also request_region() return value is not checked by the driver
> (there is a comment that it can fail and is optional):
>
>         /* request failure does not faze us, as vgacon probably has this
>          * region already (FIXME) */
>         request_region(0x3c0, 32, "vesafb");
>
> so what would happen in such case? It seems that unconditionally
> doing the release will result in freeing the I/O region owned by
> the other driver (vgacon)..
>

Maybe we can add a field to represent whether the request succeeds?
request_region() returns source *, we can store it and check whether
it is null when
we are going to call release_region().

> >  err:
> >       arch_phys_wc_del(par->wc_cookie);
> >       if (info->screen_base)
> > @@ -481,6 +483,7 @@ static int vesafb_remove(struct platform_device *pdev)
> >       struct fb_info *info = platform_get_drvdata(pdev);
> >
> >       unregister_framebuffer(info);
> > +     release_region(0x3c0, 32);
> >       framebuffer_release(info);
> >
> >       return 0;
> >
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
