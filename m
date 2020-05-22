Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C56C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880CE206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Hn3cSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgEVSFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:05:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C0C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:05:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c11so1519439wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HnUAvj8/hcOeu5wap80XKbA2U7OiBYgIef/CmYB0LcE=;
        b=n8Hn3cSXEhsGcYzPiRk9a13J/yYmoVNORbpdvW9NQCNH6z9492FBfQQulIHSIDwPg5
         /RuLl/aQv0LTnd1zyykYtcH3rsySaVW0dGkgmb66yMgVL9VjWhT29Sg9eR6QL9CHihc3
         ZC6ZPAMFqucNMcTvYl3Wasaa3dnmthhWqCOzPvUdBhFd0OUoc6e9znj0JNkb4F9LrYHb
         LeIN9HXGpwGZBuhEJiunQleQS18juPyCWrOZh50rzawJTiikOa/HHwFdPhIuapqPyUKj
         9oXhth3/2P682nA1JUyPhYoEQpSHewlsrd5tU4WhiNJKfAcIwxe72HMlBzqvjc5j9AFx
         er/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnUAvj8/hcOeu5wap80XKbA2U7OiBYgIef/CmYB0LcE=;
        b=uLTucvgI7D3zwesT9VWlUXi5nrFoNMGfr5J0k6TvvxoWV5+niisyBn7VRv+99nXYMU
         AHm23x1J3BEONwmhdpJVLvlQrSAsEn5jfDbUGygcpMfjHZ7EXPZ3YpMB96/ozFXArVeY
         /5v4MpTEgxbI/g6dzrdaCCB0ofreOmBI7qTzzp0z0mfW7uV1EtNvv7wX2Ux4tsi5iNxT
         1EFSReGS1vQdIxbI1CYGXEkXrbu3dYF9hy3We/XAE3p8o7iIL8yci2nIpFDqPcdAlSDk
         VF9TSYckRuM+RhybDgsBoB4I+ehf5dtNOiiKp2+sia3hRKg1CxvjP3ua3uRH0Vbsd0li
         126A==
X-Gm-Message-State: AOAM532bRu6VTLs81swg6vmOIkTOzOv5bNPVCf+F5egxpF9Dk/R3Im0N
        A7X+yW6hDzkDgom+e/iytkU5oHpskyZWr/nmzBk=
X-Google-Smtp-Source: ABdhPJzVEjF74Bvg+XdgYHXOPimWqs5bnL8Tj6Gf7h9YyFb5zQutmPwsVRo8Is5UeRZFmtUyDVFernc7M55zUnleyvY=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4569405wrp.419.1590170731715;
 Fri, 22 May 2020 11:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200522173419.GA2297@embeddedor>
In-Reply-To: <20200522173419.GA2297@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 May 2020 14:05:20 -0400
Message-ID: <CADnq5_Ncx8sa5Z_qykbiXVGPJ0WfwHLsCm45mZFYg=-ciBMxdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/dpm: Replace one-element array and use
 struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 1:29 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance =3D kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length =3D size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
>
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct NISLANDS_SMC_SWSTATE.
>
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex

> ---
> Changes in v2:
>  - Use type size_t instead of u16 for state_size variable.
>
>  drivers/gpu/drm/amd/amdgpu/si_dpm.h | 2 +-
>  drivers/gpu/drm/radeon/ni_dpm.c     | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.h b/drivers/gpu/drm/amd/am=
dgpu/si_dpm.h
> index 6b7d292b919f3..bc0be6818e218 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.h
> @@ -781,7 +781,7 @@ struct NISLANDS_SMC_SWSTATE
>      uint8_t                             levelCount;
>      uint8_t                             padding2;
>      uint8_t                             padding3;
> -    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
> +    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
>  };
>
>  typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_=
dpm.c
> index b57c37ddd164c..abb6345bfae32 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -2685,11 +2685,12 @@ static int ni_upload_sw_state(struct radeon_devic=
e *rdev,
>         struct rv7xx_power_info *pi =3D rv770_get_pi(rdev);
>         u16 address =3D pi->state_table_start +
>                 offsetof(NISLANDS_SMC_STATETABLE, driverState);
> -       u16 state_size =3D sizeof(NISLANDS_SMC_SWSTATE) +
> -               ((NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1) * =
sizeof(NISLANDS_SMC_HW_PERFORMANCE_LEVEL));
> +       NISLANDS_SMC_SWSTATE *smc_state;
> +       size_t state_size =3D struct_size(smc_state, levels,
> +                       NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE);
>         int ret;
> -       NISLANDS_SMC_SWSTATE *smc_state =3D kzalloc(state_size, GFP_KERNE=
L);
>
> +       smc_state =3D kzalloc(state_size, GFP_KERNEL);
>         if (smc_state =3D=3D NULL)
>                 return -ENOMEM;
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
