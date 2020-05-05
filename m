Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B2C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7C206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVgkpwES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgEEPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729250AbgEEPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:34:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:34:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so3242144wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yua9ORL9JEGiU2wcfBVEpb+8JppevaATHo200kp3UOY=;
        b=BVgkpwESB721jk0UhzYkl1Pz9S/4BrEnvzmCmJmdSLVz37QnDe8ziP2lw49ZzSYs5o
         3hlzQ2wpEz4MvjKCDbTvVXR/pC09koAuDiTcPBGoUPfyAYjuXbwrlJEmxWjMkwZx/Mdk
         +WAhJDD4WG2xXzIAlkDrqr4dYUb2EgrPeIgEijM+DTfiWIWgwWhKKYrJ7EW94VpQENLb
         K5OaXaHjXIR2Gj7BkflF0Fc/c0jSc55mtFTYk5OK69+XiVJjzeoI/9kRX/brLzYJcn9j
         UdRWLxCcU1n9pIXAho4i0Lyr10a3lWkFI5MJE/j4FaQlseCDLt1n8PUJ1IOik9VGSLNC
         W8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yua9ORL9JEGiU2wcfBVEpb+8JppevaATHo200kp3UOY=;
        b=lm+5e+qod5RBl3V2KBp9E0G5ezsNO4F2ydYpUzPsPzpEauaMnVlY8Yvf1uzWZC5Ays
         NtZRRK40yRRBFlwYybmmFm028aF4GLpHfFdRo2h48OSJm229Q+gdOjUj4490qG4cjc6f
         Fw4zd+6sLhfwutH3dlNrKGDHss4aAEauPI71MiR6a6YlcOe/RDK3LGtyd8kQiIBG95Ke
         b2anVbm7nlr1vYeHIdMgH47z7fmckHSOHAtcjzj1Ho4/X0NbzEsvb31TRbRAAEIgV+kn
         3rZEmVajS0lVbhya/ofmaxDlmVOUn/MBziC2wvO4vEbP6PbSY4MR6Ej4tS4mlwfFVPeT
         GL8g==
X-Gm-Message-State: AGi0PuYU7sDPKEaRj9ZUFKHGyPT4ydmA3xKOjhU0RNDfmPf3Bttptbl6
        SmNnT40GznITB2IXXboCCSTNiHIvioFw2wB0yi0=
X-Google-Smtp-Source: APiQypIZyv1/Gdd4zGKaVEPh2LmFuvaSQUbaQwu4n8wF6Du5nkdo3jFXTcxXLrVijJ7Q1XAWZN1GliuXMHOBc1KMb3U=
X-Received: by 2002:a5d:4151:: with SMTP id c17mr4242249wrq.111.1588692851695;
 Tue, 05 May 2020 08:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140208.284473-1-arnd@arndb.de> <6bbd0f78-6f42-968e-2269-0a6279753267@amd.com>
In-Reply-To: <6bbd0f78-6f42-968e-2269-0a6279753267@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 May 2020 11:34:00 -0400
Message-ID: <CADnq5_ObAv11hmNd_2rksCSYZN2BYV=7qKFr=EMyP5Mqb=vRrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:07 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 05.05.20 um 16:01 schrieb Arnd Bergmann:
> > After the structure was padded to 1024 bytes, it is no longer
> > suitable for being a local variable, as the function surpasses
> > the warning limit for 32-bit architectures:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size =
of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larg=
er-than=3D]
> > int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
> >      ^
> >
> > Use kzalloc() instead to get it from the heap.
> >
> > Fixes: a0d254820f43 ("drm/amdgpu: update RAS TA to Host interface")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied.  Thanks!

Alex

>
> We have a bunch of those warnings in the DAL code as well.
>
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 +++++++++++++++++-------=
-
> >   1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 538895cfd862..7348619253c7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_devic=
e *adev,
> >               struct ras_common_if *head, bool enable)
> >   {
> >       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> > -     union ta_ras_cmd_input info;
> > +     union ta_ras_cmd_input *info;
> >       int ret;
> >
> >       if (!con)
> >               return -EINVAL;
> >
> > +        info =3D kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
> > +     if (!info)
> > +             return -ENOMEM;
> > +
> >       if (!enable) {
> > -             info.disable_features =3D (struct ta_ras_disable_features=
_input) {
> > +             info->disable_features =3D (struct ta_ras_disable_feature=
s_input) {
> >                       .block_id =3D  amdgpu_ras_block_to_ta(head->block=
),
> >                       .error_type =3D amdgpu_ras_error_to_ta(head->type=
),
> >               };
> >       } else {
> > -             info.enable_features =3D (struct ta_ras_enable_features_i=
nput) {
> > +             info->enable_features =3D (struct ta_ras_enable_features_=
input) {
> >                       .block_id =3D  amdgpu_ras_block_to_ta(head->block=
),
> >                       .error_type =3D amdgpu_ras_error_to_ta(head->type=
),
> >               };
> > @@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_devic=
e *adev,
> >       /* Do not enable if it is not allowed. */
> >       WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
> >       /* Are we alerady in that state we are going to set? */
> > -     if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> > -             return 0;
> > +     if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {
> > +             ret =3D 0;
> > +             goto out;
> > +     }
> >
> >       if (!amdgpu_ras_intr_triggered()) {
> > -             ret =3D psp_ras_enable_features(&adev->psp, &info, enable=
);
> > +             ret =3D psp_ras_enable_features(&adev->psp, info, enable)=
;
> >               if (ret) {
> >                       amdgpu_ras_parse_status_code(adev,
> >                                                    enable ? "enable":"d=
isable",
> >                                                    ras_block_str(head->=
block),
> >                                                   (enum ta_ras_status)r=
et);
> >                       if (ret =3D=3D TA_RAS_STATUS__RESET_NEEDED)
> > -                             return -EAGAIN;
> > -                     return -EINVAL;
> > +                             ret =3D -EAGAIN;
> > +                     else
> > +                             ret =3D -EINVAL;
> > +
> > +                     goto out;
> >               }
> >       }
> >
> >       /* setup the obj */
> >       __amdgpu_ras_feature_enable(adev, head, enable);
> > -
> > -     return 0;
> > +     ret =3D 0;
> > +out:
> > +     kfree(info);
> > +     return ret;
> >   }
> >
> >   /* Only used in device probe stage and called only once. */
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
