Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECEAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2767F208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPr+dIxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgEGTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:30:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF2C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:30:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so8154273wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jGYOOG4S+IK7R44bCL3+15LUjSoFWbm06GQmQafymao=;
        b=BPr+dIxCL0jDNcVQt3hNyJAuVwcsOxXmOs9FqE3yG9VpGEq+FpKGlpRBK57fBvG6F/
         aRkKHypMvY+BP6sU6lsPSWMxsi06QS5K5OyIktWb4hy6DeiW3QuUDAtULyEBeXJPK5me
         7wG8Jc7yfrxu3A0wwnvGan/lfOm0c8l0AVO73JZqjuEIxwm2O8cmUQWFyI/sg11T7hBk
         C0QaBv4El1L/Wyx4jKks4a2Wh065ei5N4uA0YQTp97/+/xzS7m83Mojs3LjdEeispGQH
         pGR8cJb4r/XTY+FVYiz/12744k8+P1XFYEmGTrVcyWrY5DcBN7T/+WtR4h0V3ulLkz9e
         9H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jGYOOG4S+IK7R44bCL3+15LUjSoFWbm06GQmQafymao=;
        b=d6YLx9Y5aVwJ6IQjWHur2TtcQmVUi1O0Pp0C3GjnIJw7wiHQ4VFQsIQN9lvihgId5i
         /BYhL4g9SgHkvYojCeWOC/ourkwCQzR/ML2ln0ucY/2QfLjlZ/QMXMbQrQ3URA90XlCk
         0Ijsswh37MDxmNujlaF4iHpueJywBUz0FXGUC7fPhVj2fAKrgCNJ+YwQfyzJIV0b0866
         cQolfe1D49XKHQb7BMIxurkUfkhhu4mFe6G2aSd21YNEOH/TlB4xtqYa5OgtYg51gtpg
         UKuLTJoz72vOhZQo9l84xHDendUxwKKz5IQm+zo7CGI/QR7cClr2h22l2zEZn8azlIBb
         yKDQ==
X-Gm-Message-State: AGi0PuZj2IrZPQm1KunN1Ux5ZUuT6IzVFZBaCp76KeUIQCtVb7Y+NMz/
        vP1NYRP82WbvJvdg3n3kEAdcROGpMO79Hf8Jg5YeQQ==
X-Google-Smtp-Source: APiQypLnMsHWUZ6AfhRaSweuuZ87qO7HYZJOhLG/9tAmkvJKbUc1IyeP/3LjoUiO1CfjhY1d0AEiW7yO0tQ4gRzGJ04=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr11699140wma.70.1588879829872;
 Thu, 07 May 2020 12:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200507091311.10898-1-bernard@vivo.com> <462b6a26-2c25-f83a-887e-6d3a30072e71@amd.com>
In-Reply-To: <462b6a26-2c25-f83a-887e-6d3a30072e71@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 May 2020 15:30:18 -0400
Message-ID: <CADnq5_NfHc0FWCcANbKmDXCxF5BjcCMM6WzJzsZr=yTnhYwxJg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ori Messinger <Ori.Messinger@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 5:22 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 07.05.20 um 11:13 schrieb Bernard Zhao:
> > There is DEVICE_ATTR mechanism in separate attribute define.
> > So this change is to use attr array, also use
> > sysfs_create_files in init function & sysfs_remove_files in
> > fini function.
> > This maybe make the code a bit readable.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied with a minor change to make the array const to fix the build.

Alex

> >
> > Changes since V1:
> > *Use DEVICE_ATTR mechanism
> >
> > Link for V1:
> > *https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Fpatchwork%2Fpatch%2F1228076%2F&amp;data=3D02%7C01%7Cchristi=
an.koenig%40amd.com%7C073b9043be5346b3c90c08d7f266e6fb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637244396096735223&amp;sdata=3DPjFsYvmw2pvVisZ6TzM=
qOyoSr0m3DsFN%2F0q%2B%2FfBxACg%3D&amp;reserved=3D0
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 43 ++++++-------------=
-
> >   1 file changed, 13 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 82a3299e53c0..57bbc70662ff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -148,6 +148,15 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO=
,
> >   static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
> >                  amdgpu_mem_info_vram_vendor, NULL);
> >
> > +static struct attribute *amdgpu_vram_mgr_attributes[] =3D {
> > +     &dev_attr_mem_info_vram_total.attr,
> > +     &dev_attr_mem_info_vis_vram_total.attr,
> > +     &dev_attr_mem_info_vram_used.attr,
> > +     &dev_attr_mem_info_vis_vram_used.attr,
> > +     &dev_attr_mem_info_vram_vendor.attr,
> > +     NULL
> > +};
> > +
> >   /**
> >    * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
> >    *
> > @@ -172,31 +181,9 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_typ=
e_manager *man,
> >       man->priv =3D mgr;
> >
> >       /* Add the two VRAM-related sysfs files */
> > -     ret =3D device_create_file(adev->dev, &dev_attr_mem_info_vram_tot=
al);
> > -     if (ret) {
> > -             DRM_ERROR("Failed to create device file mem_info_vram_tot=
al\n");
> > -             return ret;
> > -     }
> > -     ret =3D device_create_file(adev->dev, &dev_attr_mem_info_vis_vram=
_total);
> > -     if (ret) {
> > -             DRM_ERROR("Failed to create device file mem_info_vis_vram=
_total\n");
> > -             return ret;
> > -     }
> > -     ret =3D device_create_file(adev->dev, &dev_attr_mem_info_vram_use=
d);
> > -     if (ret) {
> > -             DRM_ERROR("Failed to create device file mem_info_vram_use=
d\n");
> > -             return ret;
> > -     }
> > -     ret =3D device_create_file(adev->dev, &dev_attr_mem_info_vis_vram=
_used);
> > -     if (ret) {
> > -             DRM_ERROR("Failed to create device file mem_info_vis_vram=
_used\n");
> > -             return ret;
> > -     }
> > -     ret =3D device_create_file(adev->dev, &dev_attr_mem_info_vram_ven=
dor);
> > -     if (ret) {
> > -             DRM_ERROR("Failed to create device file mem_info_vram_ven=
dor\n");
> > -             return ret;
> > -     }
> > +     ret =3D sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attr=
ibutes);
> > +     if (ret)
> > +             DRM_ERROR("Failed to register sysfs\n");
> >
> >       return 0;
> >   }
> > @@ -219,11 +206,7 @@ static int amdgpu_vram_mgr_fini(struct ttm_mem_typ=
e_manager *man)
> >       spin_unlock(&mgr->lock);
> >       kfree(mgr);
> >       man->priv =3D NULL;
> > -     device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
> > -     device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
> > -     device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
> > -     device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
> > -     device_remove_file(adev->dev, &dev_attr_mem_info_vram_vendor);
> > +     sysfs_remove_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
> >       return 0;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
