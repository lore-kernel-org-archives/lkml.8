Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3DC3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA9F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwYXZte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBQDGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:06:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35548 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:06:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so16794900wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cx8bYfsqZHEBN+LcrqEn91kHMUPX248+/kSe0EtzOjI=;
        b=ruwYXZteNffd+ZcnR8MnG6XKuHjOgL3w4AuJMJEoEFkjuSRH0t2BcQ8JHOmh0hX6qF
         G2n5wDARowKxOfJ42ZT1x2+IkdCe2CG18H0qEF9iAa4MPDApqdUYbtQO6S3rdakzjfZt
         sK0puqA0Zg/N62ywd9xmVgHgqTJUDI8rC8Nx0kq6VIlcWNtMqUnX0tFgNgzSlBDHZoyu
         sO+rpdNkalcNOWzZV6vy3VKKttAcfFhJRQtR8KMbyQhSu8ckJ2AuxsKIuOHCEozDO20e
         NQUZwa0RP7Y8/dV9o9yn/nV2Y0l3X4LZTMC/o+U4GGHlGl+Ny+hHPSG863AbslxCi6ly
         o8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx8bYfsqZHEBN+LcrqEn91kHMUPX248+/kSe0EtzOjI=;
        b=otQvOdrVV9kuswTCfGKO0cUHA8hnJWfy0LzHnrLNYiy7PwDRliEngZEItWsTTpt1Lr
         FeM6ld+pGlQOmGEoOyVmpvbpoDU38ZZiCQvqberHVGZoGIGtmy3KoVvEZHi6zQ1fM3bm
         qJis5WCCkO6/ME/kHGoTkQhDxNkxTAwhAqbcq7Y0+U34nor3xbiLBczB9HX2bvwXo+BS
         MgL6ebkuLHrDRFov2npblWN3BkIqMRYTOtShgeUaD3XdwPv5lAdtHW6QM6Ue14V2dh/k
         A94s3hkZYW3pwJjDax5MvflSPyU0K6n9nXuml4m+dSXp72+vc/nzERuwlf9wGhbBsnxM
         gXJQ==
X-Gm-Message-State: APjAAAXFLb0Jvj+Eq7ZZZDsFLt28nbWyssNpf9hVLAz6RvOJVUfTZnV0
        uym/mzWaam2oRVuXpdl8jaqd8V5H5ishC4hwCzo=
X-Google-Smtp-Source: APXvYqyAj/3k/mEe/d98HCwptA/CAFJaPIjw4KXgpMOHvjOEibSODQv5nvA+mZW6Hg2aGgIiorGJjDCtj1Zjxg7UPGw=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr19043442wmi.21.1581908773251;
 Sun, 16 Feb 2020 19:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20200215035026.3180698-1-anarsoul@gmail.com> <CAKGbVbvEDYJ19KVWXN0k-5niXLjmPYvxGJQ2-3GWTyYyFkH0Gw@mail.gmail.com>
In-Reply-To: <CAKGbVbvEDYJ19KVWXN0k-5niXLjmPYvxGJQ2-3GWTyYyFkH0Gw@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 17 Feb 2020 11:06:02 +0800
Message-ID: <CAKGbVbvPPowjVixjyfBF=z=6y5GDEsV3d-2pzdRWK7pt3ewRew@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix recovering from PLBU out of memory
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

applied to drm-misc-next.

On Mon, Feb 17, 2020 at 9:20 AM Qiang Yu <yuq825@gmail.com> wrote:
>
> Looks good for me, patch is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Regards,
> Qiang
>
> On Sat, Feb 15, 2020 at 11:50 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > It looks like on PLBU_OUT_OF_MEM interrupt we need to resume from where we
> > stopped, i.e. new PLBU heap start is old end. Also update end address
> > in GP frame to grow heap on 2nd and subsequent out of memory interrupts.
> >
> > Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/lima/lima_gp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
> > index d1e7826c2d74..325604262def 100644
> > --- a/drivers/gpu/drm/lima/lima_gp.c
> > +++ b/drivers/gpu/drm/lima/lima_gp.c
> > @@ -224,8 +224,13 @@ static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
> >         }
> >
> >         gp_write(LIMA_GP_INT_MASK, LIMA_GP_IRQ_MASK_USED);
> > +       /* Resume from where we stopped, i.e. new start is old end */
> > +       gp_write(LIMA_GP_PLBU_ALLOC_START_ADDR,
> > +                f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
> > +       f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2] =
> > +               f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size;
> >         gp_write(LIMA_GP_PLBU_ALLOC_END_ADDR,
> > -                f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size);
> > +                f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
> >         gp_write(LIMA_GP_CMD, LIMA_GP_CMD_UPDATE_PLBU_ALLOC);
> >         return 0;
> >  }
> > --
> > 2.25.0
> >
