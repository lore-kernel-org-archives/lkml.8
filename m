Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D1C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE342464B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="JiDfGPDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBGR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:29:02 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40621 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:29:01 -0500
Received: by mail-il1-f196.google.com with SMTP id i7so191994ilr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQthra+5Tb+MdByAUBovPY1PsDx5TneOE+jweSiM4d0=;
        b=JiDfGPDAovB+nWhtAim+Qoa8yJlNkdbELjctfRTRJacs8IQcvDG9LBHzFe9BQE3eQv
         dUOCXG2MkvMvtLIh2LL+PXl2A83qDPOOQrPwvxURTxkykvPzQq6O5rtHvJNfil+Wn/Bo
         26tHe3ii1y1hyDj1HOvXvj+PTlB10z9cnA5mkIB6LDRdAOD0NxM3SbGze+LUNFmHgViB
         CyLR7MuxG0ICSeU2tg1kFLHrIKcn4LFjnwP1nfxJIN8EEMoKzlCYC4AZ2/cC3ObGDdgc
         +RCPQknvTwh8bsAvfydBTTSoj58aGw3qrXn7mVRUyXM3ddYoZ1mUnVg0ap2PgDZLn/8d
         xo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQthra+5Tb+MdByAUBovPY1PsDx5TneOE+jweSiM4d0=;
        b=eawIW0c7pAfIeiEK/cfGG7QdvDxZg+6G3oiURngylCdhR6qwYjQw8xI1R/CVSv9mPU
         kMeLmImM5J5qHknUpcRh7OfVrGNwgEo77y+q0gf6ODnXzyLe4Xbw9pndkVcho55ikEyZ
         te83YeI7vdDvCXDsN5lM5tpW0pgJExqWfGglO50RJtkDcCBpsmLuoQHrnTr99EDrXpv3
         0L7lf+RROyv+iKNNNy8ufjZmvsNjMlVpDcQyOo5YnWL6F8BkAF7q1GCABVOWvDUnWzQX
         p0Sj25UoSBS0R0OgKjZN/in5mII6KlqPnDuIoOLboNjPdla0D8stTzH7vpudZ/ac57un
         CYbw==
X-Gm-Message-State: APjAAAWEUFgUbdB1QnYBzs0sTJcH+dYARJCN1HHdWTH5kNIYjpGCJ+lP
        za8FHHUoqHmxBGmpYpBSxXjExXkxbF+7HBpcke6cQw==
X-Google-Smtp-Source: APXvYqwXFhIati6Vp0GDfgQt0l5PZHt8xFRskEGYtNtbtsgxbozzjhsd86PDJjPrBvQAZjGbzw1snCPkeL1BuMgVfjk=
X-Received: by 2002:a92:88c4:: with SMTP id m65mr450018ilh.165.1581096540300;
 Fri, 07 Feb 2020 09:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20200206140140.GA18465@art_vandelay> <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
In-Reply-To: <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
From:   Sean Paul <sean@poorly.run>
Date:   Fri, 7 Feb 2020 12:28:24 -0500
Message-ID: <CAMavQKKZAYgpCLPodWw0pS1na7rthuJy8DkSvexOb+TRKHeKfg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Find the cursor plane instead of hard
 coding it
To:     Evan Benn <evanbenn@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 11:24 PM Evan Benn <evanbenn@chromium.org> wrote:
>
> The cursor and primary planes were hard coded.
> Now search for them for passing to drm_crtc_init_with_planes
>
> Signed-off-by: Evan Benn <evanbenn@chromium.org>

I like it!

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 7b392d6c71cc..935652990afa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -658,10 +658,18 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
>
>  static int mtk_drm_crtc_init(struct drm_device *drm,
>                              struct mtk_drm_crtc *mtk_crtc,
> -                            struct drm_plane *primary,
> -                            struct drm_plane *cursor, unsigned int pipe)
> +                            unsigned int pipe)
>  {
> -       int ret;
> +       struct drm_plane *primary = NULL;
> +       struct drm_plane *cursor = NULL;
> +       int i, ret;
> +
> +       for (i = 0; i < mtk_crtc->layer_nr; i++) {
> +               if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_PRIMARY)
> +                       primary = &mtk_crtc->planes[i];
> +               else if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_CURSOR)
> +                       cursor = &mtk_crtc->planes[i];
> +       }
>
>         ret = drm_crtc_init_with_planes(drm, &mtk_crtc->base, primary, cursor,
>                                         &mtk_crtc_funcs, NULL);
> @@ -830,9 +838,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                         return ret;
>         }
>
> -       ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> -                               mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
> -                               NULL, pipe);
> +       ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, pipe);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.25.0.341.g760bfbb309-goog
>
