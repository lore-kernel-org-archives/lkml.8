Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448BC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F9F20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de06OTPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgDGN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:26:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35466 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgDGN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:26:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so3089226oto.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=chd5WzCy0W5BZwZMM5n5siOhfZK7euPR7nF8zWDeFKg=;
        b=de06OTPjR8XQn557+eG8TJFSc2cmK5ZXvu3hkZ/51UvlISseAXqJcWlh4n3jupOgug
         JbmcwNB8WQ/LP5DNePw7HGRnEH+y/l7ZxsTFDPJ2q1S8/CyjWMt1+y1prk0vHZIXUl/D
         46tXIf8fo9m1uFv3yA2xtyCikAPviSXgWrz8p9jlOuiBnVMVjagm8rnyLiSwpFXm91UI
         TGDjW1vyHIg0CVVzn94GA8ja75Nenr9GMkuW5A12+WLm7p8Pn0lRNgM5urrXepv96557
         knql0La/884zBwDExkSzw9/P3413EzeL6j/kTr4JM4qZnqaeoTkQPVtvYh/pzX+vDLK3
         Ka7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=chd5WzCy0W5BZwZMM5n5siOhfZK7euPR7nF8zWDeFKg=;
        b=XG8/eN8Jg9E0VWcs6NM8EwcEemwz/hjYOB7MWOuW87VOR71GQXedQCfgRZis6gOVcq
         Eqc7arsakQQaGTI/Saqjq3W3BSH5z2wRu8sBkOGkv6IQzVAv7am0vNRimP2cxvMULxHZ
         eNa6h5EhjeaG4nmRbC5B/abeyrhYxmOde5dnqPsBxu1OyRGDVVRW8anVaERHgofzcBdJ
         koeeRHlrhu6wU+jVSQoYb8zcxc0HNeiMzj0dcDux1w5Fxg686w6y9frUsjlZzahZKp3s
         acfX6HiadaadnOZ3C+os5rYCGIR5jhSokhhcuit4iXww8Mt3Nj2Ya7pe3wlBBFWm1G8z
         zYrw==
X-Gm-Message-State: AGi0PuaqenFmDgshQkLxHcBwHrQEB0C7MWCYGIq1hlb2u33J0iADhRvJ
        7UxuDDXrU54fjeDfbm3eDCHanQnTz3IlTY2cY5Bw0tmcTZBOBA==
X-Google-Smtp-Source: APiQypJZWdNWLCr8c7kvNmiyUNyP8+q2DylC9N8N3tNEL0K144FrAEg+MPdooShGhw/fVijitpe8PMglbX8QxeHfbSU=
X-Received: by 2002:a9d:6c19:: with SMTP id f25mr1553187otq.371.1586265997194;
 Tue, 07 Apr 2020 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200114134101.159194-1-liumartin@google.com> <20200224033941.GB211610@google.com>
In-Reply-To: <20200224033941.GB211610@google.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 7 Apr 2020 18:56:25 +0530
Message-ID: <CAO_48GEPKk64uepCqZEc=6XGiv4tZnPHv=RZdwzKPuUqOxjpow@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: support 32bit DMA_BUF_SET_NAME ioctl
To:     Martin Liu <liumartin@google.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     minchan@kernel.org, surenb@google.com, wvw@google.com,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, jenhaochen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Daniel, your comments here, please?

On Mon, 24 Feb 2020 at 09:09, Martin Liu <liumartin@google.com> wrote:
>
> On Tue, Jan 14, 2020 at 09:41:01PM +0800, Martin Liu wrote:
>
> CC more MLs for winder review.
>
> > This commit adds SET_NAME ioctl coversion to
> > support 32 bit ioctl.
> >
> > Signed-off-by: Martin Liu <liumartin@google.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index ce41cd9b758a..a73048b34843 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/mount.h>
> >  #include <linux/pseudo_fs.h>
> > +#include <linux/compat.h>
> >
> >  #include <uapi/linux/dma-buf.h>
> >  #include <uapi/linux/magic.h>
> > @@ -409,13 +410,32 @@ static void dma_buf_show_fdinfo(struct seq_file *=
m, struct file *file)
> >       dma_resv_unlock(dmabuf->resv);
> >  }
> >
> > +#ifdef CONFIG_COMPAT
> > +static long dma_buf_ioctl_compat(struct file *file, unsigned int cmd,
> > +                              unsigned long arg)
> > +{
> > +     switch (_IOC_NR(cmd)) {
> > +     case _IOC_NR(DMA_BUF_SET_NAME):
> > +             /* Fix up pointer size*/
> > +             if (_IOC_SIZE(cmd) =3D=3D sizeof(compat_uptr_t)) {
> > +                     cmd &=3D ~IOCSIZE_MASK;
> > +                     cmd |=3D sizeof(void *) << IOCSIZE_SHIFT;
> > +             }
> > +             break;
> > +     }
> > +     return dma_buf_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> > +}
> > +#endif
> > +
> >  static const struct file_operations dma_buf_fops =3D {
> >       .release        =3D dma_buf_release,
> >       .mmap           =3D dma_buf_mmap_internal,
> >       .llseek         =3D dma_buf_llseek,
> >       .poll           =3D dma_buf_poll,
> >       .unlocked_ioctl =3D dma_buf_ioctl,
> > -     .compat_ioctl   =3D compat_ptr_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +     .compat_ioctl   =3D dma_buf_ioctl_compat,
> > +#endif
> >       .show_fdinfo    =3D dma_buf_show_fdinfo,
> >  };
> >
> > --
> > 2.25.0.rc1.283.g88dfdc4193-goog
> >



--=20
Thanks and regards,

Sumit Semwal
Linaro Consumer Group - Kernel Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
