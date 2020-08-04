Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA7522B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hSRc18DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHDJbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgHDJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:31:42 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:31:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o21so15050944oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bx8QnSbD21aKEv4HPh/WQgnpCovb+oX4WSI/yUidvUA=;
        b=hSRc18DI12vibI2y/PhLUpEH+n2WEK43Hx+65fY+/xoVAy8Nk+iOU1wBQlXk53IF+q
         am4mS9n9SJASS+m1vHXi9FxNsGa2Z/5oejaQoiErvncEZ9HLXEK9RJfWfdRctFk5aNT8
         eXpK2q6Ga41ilbw3cwzfxFdgg0/zYkp4LetcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bx8QnSbD21aKEv4HPh/WQgnpCovb+oX4WSI/yUidvUA=;
        b=tUSeNgaHfkbBLHK3/FFA0mk4frBWE1SdKv/mRck5P0H3pk9LaEUH+wsCAJuXW6ioW1
         8dbU54x6yiPO2ywrKigswIlj595mXXkjKIXl9CygKeP+XClIU7EbkC3JhG7atCTwWS28
         itZqofTWfZauonGtvcspKjvmCvIFa9hJmeTKbkeI7ZalxuJlzftMIAM26eTLkmKFZoSU
         SDav9/gFskZE8iBOTZ2JnwkhIQh9dFjvFxgSxkJ6IvcSWI7nd5TY7ODHuAenT8BwG8PQ
         4YQCtNif9H3EF/RZ2C31bw+lho1rgG7AeFrUgs1U8HIFnkAwW0UgNEdaupj2k84MgTov
         nisw==
X-Gm-Message-State: AOAM531r4esnnCAjO8ZLEFXNjeZB5mVAHrMZL3dUObZs3nO2VpuBTfxS
        lB5SRUN9cj9phd3CH1JXvBb/ptCB4/w+N32goXO/35/Q
X-Google-Smtp-Source: ABdhPJwdpUdLPhrTPAaU7NeuwyRn6hE1IzDc4jwEglS1bZDZpyn1A79/YYbgME6XqG72lThDZ7VnwRdmnDyTYRZ8hEI=
X-Received: by 2002:aca:ab87:: with SMTP id u129mr2628735oie.128.1596533501194;
 Tue, 04 Aug 2020 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200730144830.10479-1-paul@crapouillou.net> <20200730144830.10479-4-paul@crapouillou.net>
 <20200730152958.GB1474381@ravnborg.org> <6RIAEQ.2KRLCE1YRKKB1@crapouillou.net>
In-Reply-To: <6RIAEQ.2KRLCE1YRKKB1@crapouillou.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 4 Aug 2020 11:31:29 +0200
Message-ID: <CAKMK7uFfS0XuGAeT0t_UF7f0gALUK-BHFVsk4w_u9BjoeFtNYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/ingenic: ipu: Only enable clock when needed
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 06:21:05PM +0200, Paul Cercueil wrote:
>
>
> Le jeu. 30 juil. 2020 =C3=A0 17:29, Sam Ravnborg <sam@ravnborg.org> a =C3=
=A9crit :
> > On Thu, Jul 30, 2020 at 04:48:30PM +0200, Paul Cercueil wrote:
> > >  Instead of keeping the IPU clock enabled constantly, enable and
> > > disable
> > >  it on demand, when the IPU plane is used. That way, we won't use any
> > >  extra power when the IPU is not used.
> > >
> > >  v2: Explain the reason of this patch
> > >
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > And thanks for the quick update!
>
> Pushed to drm-misc-next. Thanks!

Hi Paul,

Maybe I'm mixing up people, but iirc you're the one very much interested
in running fbdev userspace. Did you think about building up a set of
regression tests in igt (which we could eventually even run on something
like vkms for hw-free regression testing) so that we make sure fbdev keeps
wroking?

Defacto drm_fb_helper.c has become the fbdev reference implementation
already anyway (e.g. with stuff like stanardizing vblank waiting
behaviour), so this would only be the next logical step.

Also adding Bart.

Cheers, Daniel


>
> Cheers,
> -Paul
>
> >
> >     Sam
> >
> > >  ---
> > >   drivers/gpu/drm/ingenic/ingenic-ipu.c | 23 ++++++++++++++++++++---
> > >   1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > >  diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> > > b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> > >  index 7dd2a6ae4994..fc8c6e970ee3 100644
> > >  --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> > >  +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> > >  @@ -49,6 +49,7 @@ struct ingenic_ipu {
> > >           struct regmap *map;
> > >           struct clk *clk;
> > >           const struct soc_info *soc_info;
> > >  +        bool clk_enabled;
> > >
> > >           unsigned int num_w, num_h, denom_w, denom_h;
> > >
> > >  @@ -288,12 +289,23 @@ static void
> > > ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
> > >           const struct drm_format_info *finfo;
> > >           u32 ctrl, stride =3D 0, coef_index =3D 0, format =3D 0;
> > >           bool needs_modeset, upscaling_w, upscaling_h;
> > >  +        int err;
> > >
> > >           if (!state || !state->fb)
> > >                   return;
> > >
> > >           finfo =3D drm_format_info(state->fb->format->format);
> > >
> > >  +        if (!ipu->clk_enabled) {
> > >  +                err =3D clk_enable(ipu->clk);
> > >  +                if (err) {
> > >  +                        dev_err(ipu->dev, "Unable to enable clock: =
%d\n", err);
> > >  +                        return;
> > >  +                }
> > >  +
> > >  +                ipu->clk_enabled =3D true;
> > >  +        }
> > >  +
> > >           /* Reset all the registers if needed */
> > >           needs_modeset =3D drm_atomic_crtc_needs_modeset(state->crtc=
->state);
> > >           if (needs_modeset) {
> > >  @@ -578,6 +590,11 @@ static void
> > > ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
> > >           regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CH=
IP_EN);
> > >
> > >           ingenic_drm_plane_disable(ipu->master, plane);
> > >  +
> > >  +        if (ipu->clk_enabled) {
> > >  +                clk_disable(ipu->clk);
> > >  +                ipu->clk_enabled =3D false;
> > >  +        }
> > >   }
> > >
> > >   static const struct drm_plane_helper_funcs
> > > ingenic_ipu_plane_helper_funcs =3D {
> > >  @@ -761,9 +778,9 @@ static int ingenic_ipu_bind(struct device *dev,
> > > struct device *master, void *d)
> > >           drm_object_attach_property(&plane->base, ipu->sharpness_pro=
p,
> > >                                      ipu->sharpness);
> > >
> > >  -        err =3D clk_prepare_enable(ipu->clk);
> > >  +        err =3D clk_prepare(ipu->clk);
> > >           if (err) {
> > >  -                dev_err(dev, "Unable to enable clock\n");
> > >  +                dev_err(dev, "Unable to prepare clock\n");
> > >                   return err;
> > >           }
> > >
> > >  @@ -775,7 +792,7 @@ static void ingenic_ipu_unbind(struct device
> > > *dev,
> > >   {
> > >           struct ingenic_ipu *ipu =3D dev_get_drvdata(dev);
> > >
> > >  -        clk_disable_unprepare(ipu->clk);
> > >  +        clk_unprepare(ipu->clk);
> > >   }
> > >
> > >   static const struct component_ops ingenic_ipu_ops =3D {
> > >  --
> > >  2.27.0
>
>

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
