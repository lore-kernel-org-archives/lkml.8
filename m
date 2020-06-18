Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F72520773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEAbYtXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgFROhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgFROhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:37:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B1C06174E;
        Thu, 18 Jun 2020 07:37:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n70so4679751ota.5;
        Thu, 18 Jun 2020 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BX2MczfwnklIekhyvJJ0NhkC58hgUYRasxuG2CoUtI=;
        b=nEAbYtXy/1I1In7K0fSkRnbxclDKPE5x+iwVmDxh5JN/AktyUce1FVefh+UH+8tA59
         D0+mklaklftZsz0TvqqJ7MjWoRLIt8OV3+1Fu8JsFhjL2/T+yHgfNK0eWq09CIH8E8bT
         EXht2WVfhgfZyC3FP+lG5cQMDLf0/wc75OfpBnmGWqqzcbiEpiPHxI5FZOh8bQIQgnMO
         b4eJxbLoIPn3SempL/oXznqAsWSTsu9ZWU3SiAvatJSxuZ+SiInzCS4aWSCnLFHNpeOK
         KzJAgIQ9O/0nDGYgiv3yxkiNtzUYdWRsHXl0hNIbdgik/8oeEiQJM4vpFDhBFFq2BiIm
         CGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BX2MczfwnklIekhyvJJ0NhkC58hgUYRasxuG2CoUtI=;
        b=j87iLZ/KcGbDWY/XpuWHWTv6dMVhUv2JkTCkcR48mVDIPmtFZ9w6aOPl/9x0D7WZ1R
         yEGeNGR6YZKAer7Tc1V/y461fKju78UUjARPXFZlcRthrZ/ZdpqCARsRBJQon2yVpuJT
         jK3VUmZF75ULceWmVypy1id69rbJ3M0a9PFf/EhsQwwY6o1a2AFFdZk6261sYaVnhlXP
         ysxr5PEPcGE8vqttL0LsDdS/3ut+HAcZYrIu3espfnhPV10UXYJZmdiA0/+DwJf1QBqh
         LTy96AMdGvKpJqzl/9SQAUtPjJGEdA6zgJjKJdfE2sYz3AZLaVmy14rbiviwJPD1488c
         cBLg==
X-Gm-Message-State: AOAM531HNWM1PKqlDYh8QUtZ2FOBPGtMXBM4MiR0fizFvZpznj7VUiPf
        Th3ivaMFma5Y2knWzNrmcHJiLiakKWDaYBpyuCMVMwJ68QRN5A==
X-Google-Smtp-Source: ABdhPJwk6h8WIc7fO0xkSvAHrVqw51KS1v1wJFRZWH9JfYKzyXGeklPjICyAGIVoOBMnL4iwQ5OwV0yElfyM/8k0NS4=
X-Received: by 2002:a05:6830:2054:: with SMTP id f20mr3572787otp.358.1592491022659;
 Thu, 18 Jun 2020 07:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200618100400.11464-1-colin.king@canonical.com>
 <20200618121405.GJ159988@e110455-lin.cambridge.arm.com> <5d08fbec-75d8-d9a9-af61-e6ab98e77c80@canonical.com>
 <20200618142106.GK159988@e110455-lin.cambridge.arm.com>
In-Reply-To: <20200618142106.GK159988@e110455-lin.cambridge.arm.com>
From:   Garrit Franke <garritfranke@gmail.com>
Date:   Thu, 18 Jun 2020 16:36:51 +0200
Message-ID: <CAD16O86ebsDkwbnuw2G04YZWfukqxJ=_Tex5OT07icEpfPdQNw@mail.gmail.com>
Subject: Re: [PATCH] drm/arm: fix unintentional integer overflow on left shift
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, newbie here.
Can the BIT macro be safely used on other parts of the kernel as well?
Just using git grep "1 <<" returns a ton of results where bit shifting
is used the old fashioned way.

Am Do., 18. Juni 2020 um 16:23 Uhr schrieb Liviu Dudau <liviu.dudau@arm.com=
>:
>
> On Thu, Jun 18, 2020 at 01:50:34PM +0100, Colin Ian King wrote:
> > On 18/06/2020 13:14, Liviu Dudau wrote:
> > > On Thu, Jun 18, 2020 at 11:04:00AM +0100, Colin King wrote:
> > >> From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Hi Colin,
> > >
> > >>
> > >> Shifting the integer value 1 is evaluated using 32-bit arithmetic
> > >> and then used in an expression that expects a long value leads to
> > >> a potential integer overflow.
> > >
> > > I'm afraid this explanation makes no sense to me. Do you care to expl=
ain better what
> > > you think the issue is? If the shift is done as 32-bit arithmetic and=
 then promoted
> > > to long how does the overflow happen?
> >
> > The shift is performed using 32 bit signed math and then assigned to an
> > unsigned 64 bit long. This if the shift is 31 bits then the signed int
> > conversion of 0x80000000 to unsigned long becomes 0xffffffff80000000.
> > If the shift is more than 32 bits then result overflows and becomes 0x0=
.
>
> You are right, I've missed the fact that it is signed math. Not very like=
ly that
> we are going to ever have 30 or more CRTCs in the driver, but Coverity ha=
s no
> way of knowing that.
>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>
> I will pull this into drm-misc-next today.
>
> Best regards,
> Liviu
>
> >
> > Colin
> >
> > >
> > > Best regards,
> > > Liviu
> > >
> > >> Fix this by using the BIT macro to
> > >> perform the shift to avoid the overflow.
> > >>
> > >> Addresses-Coverity: ("Unintentional integer overflow")
> > >> Fixes: ad49f8602fe8 ("drm/arm: Add support for Mali Display Processo=
rs")
> > >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > >> ---
> > >>  drivers/gpu/drm/arm/malidp_planes.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/a=
rm/malidp_planes.c
> > >> index 37715cc6064e..ab45ac445045 100644
> > >> --- a/drivers/gpu/drm/arm/malidp_planes.c
> > >> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > >> @@ -928,7 +928,7 @@ int malidp_de_planes_init(struct drm_device *drm=
)
> > >>    const struct malidp_hw_regmap *map =3D &malidp->dev->hw->map;
> > >>    struct malidp_plane *plane =3D NULL;
> > >>    enum drm_plane_type plane_type;
> > >> -  unsigned long crtcs =3D 1 << drm->mode_config.num_crtc;
> > >> +  unsigned long crtcs =3D BIT(drm->mode_config.num_crtc);
> > >>    unsigned long flags =3D DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | =
DRM_MODE_ROTATE_180 |
> > >>                          DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | =
DRM_MODE_REFLECT_Y;
> > >>    unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> > >> --
> > >> 2.27.0.rc0
> > >>
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
