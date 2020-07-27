Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95789C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FAC20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvXZRTq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgG0SMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgG0SMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:12:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB92C061794;
        Mon, 27 Jul 2020 11:12:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so15271761wro.2;
        Mon, 27 Jul 2020 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+cjMJexAD4hVslCLfZxYw0xSj4v32Cg73ix8mAo6lQ=;
        b=rvXZRTq8JQeLezn3Y8PtrvIvpSkDiBHveZhfRmIRsSBeDJZnjKqBGy+QWwELGHHK9h
         IcMm8HWjNIwnu3YVdbwj7AmtnCfpAhFZ+Rpc4w8N91b/7XRDjPtMUQxHAY+v6x5JU1nS
         3XcXWMQ8Z6v41HCiM/COJFtN8CNp79O9B+gMY9IdeHjA7WwIXl3acZ7NJYKKF2pW6le1
         9956/PiAmuH96Npac+3FjCpIR1YH8sTu6ZSf+wTE+16ZZ4Wm2B1q9cjwtZTrnH27vFLU
         Os2LTJRtUv0ccsrNI3bsAmwtod5CkcmTpMeDKKx+aTuxVAdxyuvYtKYrRed634svN5W2
         SgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+cjMJexAD4hVslCLfZxYw0xSj4v32Cg73ix8mAo6lQ=;
        b=qq7G3SgGR7kOnfXrQfxqFwOxK/OuoXzma4U7I3ST2E2L1GlVjes1Uxq4mezZjy7hx5
         nkAIfhVgdHkKUT+7+MuVM+pMstmdYwl2ND1+U2w11PFB5wuQDGcFZlrkohscb1hjgyoe
         ZKYiJ8hEUUR8yeVDljolzTebJigAZ4IcgN50fIkNdD9H6HHyZd0tvMR1GuUdfUrbeQZ/
         3c8+iXDtpoRCZuO0uWDOgsyuQIjoC32rwmrYQonP3H1lCMY2/idVVpmkn+oLs/2FlW9J
         vGBWaXVlaldkEPhYT9z6cgkIcW+/Q6MwnCmmngqULEIV/aJxU01k/t8e/1LVO3CpuZm1
         FYSQ==
X-Gm-Message-State: AOAM533gHrys5Ac8UysKXYDfih6ujTdw/uXgKlq+oXYuTHxT5TOjZb60
        TQCYAoA4rwHi4RLOvmWTB0u4O7JL714DDl9+BF8=
X-Google-Smtp-Source: ABdhPJwFtDW1X9++0RKW78h+dwtCDaX++VHQCmLYontPEXnwlgS2w9CTdMWsfkGtAl4r3B+vtG4bXra770bQd6VRpaY=
X-Received: by 2002:adf:a351:: with SMTP id d17mr21027063wrb.111.1595873530004;
 Mon, 27 Jul 2020 11:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200727103436.50793-1-christophe.jaillet@wanadoo.fr> <898acaf6-9975-40b1-1104-586b64689ccd@gmail.com>
In-Reply-To: <898acaf6-9975-40b1-1104-586b64689ccd@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jul 2020 14:11:58 -0400
Message-ID: <CADnq5_OqdUxSKv21pg9o=a_dwyW7-j3URy+BYHrS+ubzuA-7NQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: avoid a useless memset
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 27, 2020 at 9:41 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.07.20 um 12:34 schrieb Christophe JAILLET:
> > Avoid a memset after a call to 'dma_alloc_coherent()'.
> > This is useless since
> > commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_=
*")
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_gart.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/rad=
eon/radeon_gart.c
> > index b7ce254e5663..3808a753127b 100644
> > --- a/drivers/gpu/drm/radeon/radeon_gart.c
> > +++ b/drivers/gpu/drm/radeon/radeon_gart.c
> > @@ -85,7 +85,6 @@ int radeon_gart_table_ram_alloc(struct radeon_device =
*rdev)
> >       }
> >   #endif
> >       rdev->gart.ptr =3D ptr;
> > -     memset((void *)rdev->gart.ptr, 0, rdev->gart.table_size);
> >       return 0;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
