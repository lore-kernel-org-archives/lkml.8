Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D70C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879624672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgBTRc6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:32:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32850 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:32:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so3229077vsa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FQc9DcjywetNpCF4Lbw4T0x+cYC+tfLtotoC3/DL5NA=;
        b=t1SVsJ6ptsGzlQQe8yAvc5y7R4/NMISZ1HD4UF8nZgaWq2bLbf+l1QKOfkKIzaxxK7
         0qk4vWX0RG1EylGWqR38mCXxs/0YkXsfMzQdcg7pMrCGU2V6KHdGDFTxi6ywwFjGuYS7
         wbIItvVnDpsnjKw/Hp+wYgnWTks2i1cdoEspclp2vs5zZ4xwleolPY2d//ziTnU8nDmy
         zENWK7Kjsfm6gRPoHR+D7CdZFQZ15d1dAVSE8MZZw6pjmUYZVzPAUSJ/MGMiJUzenpt3
         hrQVTjNYYcQ98K/f9FQYH7NU7s6sodRDuoj26+SGCDs9qUQMspb9F52S+8pKgEF/lc+S
         zRjg==
X-Gm-Message-State: APjAAAUMNV7S0CM8bRwmdUYbAEkjglqZkM2bpF3fjxCYnHwOnr/SJ10d
        7xeJY2Cs7Yz45QZ6z71FJJPIBNhdy43wf3XVSKyokdkz
X-Google-Smtp-Source: APXvYqx4kt7MHHbKi0SjwgZkjp+H3tuQgvLnGV4lQ1Qi1dUUjvSAWJLZlwr3QRTs60UyN+0mHesS993+k7i+NF7ntmI=
X-Received: by 2002:a67:f412:: with SMTP id p18mr18444585vsn.207.1582219976717;
 Thu, 20 Feb 2020 09:32:56 -0800 (PST)
MIME-Version: 1.0
References: <dac89843-5258-5bed-ee86-7038e94e56da@qubes-os.org> <c94ce223-56d5-e31a-2a2c-59defb988b28@qubes-os.org>
In-Reply-To: <c94ce223-56d5-e31a-2a2c-59defb988b28@qubes-os.org>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 20 Feb 2020 12:32:45 -0500
Message-ID: <CAKb7Uvh8Ob592LOizH9FGZz5ag=VJ3R=dh0G5iZSg2-JzWZFMQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nv50_disp_chan_mthd: ensure mthd is not NULL
To:     =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frédéric,

It appears Ben made his own version of this patch (probably based on
the one you added to the kernel bz), and it's already upstream:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.6-rc2&id=0e6176c6d286316e9431b4f695940cfac4ffe6c2

Cheers,

  -ilia

On Thu, Feb 20, 2020 at 12:19 PM Frédéric Pierret
<frederic.pierret@qubes-os.org> wrote:
>
> Hi,
> Is anything missing here? How can I get this merged?
>
> Best regards,
> Frédéric Pierret
>
> On 2020-02-08 20:43, Frédéric Pierret wrote:
> > Pointer to structure array is assumed not NULL by default. It has
> > the consequence to raise a kernel panic when it's not the case.
> >
> > Basically, running at least a RTX2080TI on Xen makes a bad mmio error
> > which causes having 'mthd' pointer to be NULL in 'channv50.c'. From the
> > code, it's assumed to be not NULL by accessing directly 'mthd->data[0]'
> > which is the reason of the kernel panic. Simply check if the pointer
> > is not NULL before continuing.
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206299
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frédéric Pierret (fepitre) <frederic.pierret@qubes-os.org>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> > index bcf32d92ee5a..50e3539f33d2 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> > @@ -74,6 +74,8 @@ nv50_disp_chan_mthd(struct nv50_disp_chan *chan, int debug)
> >
> >       if (debug > subdev->debug)
> >               return;
> > +     if (!mthd)
> > +             return;
> >
> >       for (i = 0; (list = mthd->data[i].mthd) != NULL; i++) {
> >               u32 base = chan->head * mthd->addr;
> >
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
