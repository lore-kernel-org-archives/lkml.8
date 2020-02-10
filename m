Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B688C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BEE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="G4uXB900"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgBJOLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:11:19 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35634 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBJOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:11:19 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so7703835iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX0VcA61hup+M1eG33dRqyta/5/xteIuWl8koiSPDi4=;
        b=G4uXB900exoea2ii7+OFpaGuRK0OPIwrn5b/qyL1D2Q9SXUY52mV/GbNkHjMPnchAM
         ph7SyUwqgpei3jx8lD4a2qYiY8mhLmqs3rciAPdjTSxjBZSlhSwL+K5ny5rILoVPrv3K
         J48MqqhzBHWtUo3Y0ytkyzGLqroOVBCzNr/sxerxfodFVtmee1wXpdhLvt3EBdk3LnPN
         3WT9oeSCayoMbkTRIdriomu+/UmKLxQ5ZKy7yrZbimr7zSx9r6ju33sS2XOZyJiYvUUs
         oP2DGX5M3gjG49im59BCr2dlcbr00eT7960geinWms86EIHtLSGo6OUV128LQvBM4LRW
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX0VcA61hup+M1eG33dRqyta/5/xteIuWl8koiSPDi4=;
        b=GOjXLd2KBDbXshCNX2igQHt8qdex4GT84rewm0QeqygWGA+0aWKpJKuFT4hKEk0vhV
         1mTkmDohp6rF+zOXEmyacys96FJ3Oqfj58SVA5id4JurToXA6DYq7wJsk+2GmJ6+LSUf
         JBF66XX+KfajmcncpcGlZwbK2dJudoOfydsZwjUSDA/gUGcM5CZwb/iAcqhNxcIIEK63
         lUCiOQA5vaUWAtQJdAdNKo68nomCEXwr+ZzfIuK//Jp6FPlnNRXSX9jlHXbNQF4jJrup
         uvQ32Ty/5xvVu1D/fmS0qP+VPjcOcZpB2uMKwf2PgvGggYPxQkl5Z5m69xXKNY12zZ0b
         8sDQ==
X-Gm-Message-State: APjAAAXLExq6p3+WSSYsreB4+uVySm8fsMprASaygXXh1xnpfEEzxDkI
        JunVXEh7wtp2qsOowuOlXPSopYisZXXvDodzDzFYLg==
X-Google-Smtp-Source: APXvYqwvxGWSdp4d4hKFIroc+x/DYVtfIyyldKkT3VpcOseZggDqKWwOctEN63TfW1gHDPo2n3ZDqZMJVhAWtbOk4dE=
X-Received: by 2002:a6b:f206:: with SMTP id q6mr9531130ioh.264.1581343878489;
 Mon, 10 Feb 2020 06:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20200206140140.GA18465@art_vandelay> <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
 <1581064499.590.0.camel@mtksdaap41> <1581303187.951.2.camel@mtksdaap41>
In-Reply-To: <1581303187.951.2.camel@mtksdaap41>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 10 Feb 2020 09:10:42 -0500
Message-ID: <CAMavQKLqr=a=WZKFfC2sEBcskjX+k-82a3V3XVk7LQLzpAMaBg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Find the cursor plane instead of hard
 coding it
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Evan Benn <evanbenn@chromium.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 9:53 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Evan:
>
> On Fri, 2020-02-07 at 16:34 +0800, CK Hu wrote:
> > Hi, Evan:
> >
> > On Fri, 2020-02-07 at 15:23 +1100, Evan Benn wrote:
> > > The cursor and primary planes were hard coded.
> > > Now search for them for passing to drm_crtc_init_with_planes
> > >
> >
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> Applied to mediatek-drm-fixes-5.6 [1], thanks.
>

Hi CK,
Thanks for picking this up. Before you send the pull, could you please
reverse the order of these 2 patches? Evan's should come before mine
to prevent a regression.

Sean

> [1]
> https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.6
>
> Regards,
> CK
>
> >
> > > Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > > ---
> > >
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > index 7b392d6c71cc..935652990afa 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > > @@ -658,10 +658,18 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
> > >
> > >  static int mtk_drm_crtc_init(struct drm_device *drm,
> > >                          struct mtk_drm_crtc *mtk_crtc,
> > > -                        struct drm_plane *primary,
> > > -                        struct drm_plane *cursor, unsigned int pipe)
> > > +                        unsigned int pipe)
> > >  {
> > > -   int ret;
> > > +   struct drm_plane *primary = NULL;
> > > +   struct drm_plane *cursor = NULL;
> > > +   int i, ret;
> > > +
> > > +   for (i = 0; i < mtk_crtc->layer_nr; i++) {
> > > +           if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_PRIMARY)
> > > +                   primary = &mtk_crtc->planes[i];
> > > +           else if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_CURSOR)
> > > +                   cursor = &mtk_crtc->planes[i];
> > > +   }
> > >
> > >     ret = drm_crtc_init_with_planes(drm, &mtk_crtc->base, primary, cursor,
> > >                                     &mtk_crtc_funcs, NULL);
> > > @@ -830,9 +838,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> > >                     return ret;
> > >     }
> > >
> > > -   ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> > > -                           mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
> > > -                           NULL, pipe);
> > > +   ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, pipe);
> > >     if (ret < 0)
> > >             return ret;
> > >
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
