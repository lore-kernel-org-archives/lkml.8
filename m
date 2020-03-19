Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA56C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC25520773
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvjcInVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSDLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:11:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45453 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:11:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id i9so864131wrx.12;
        Wed, 18 Mar 2020 20:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PbEVnPMN2MJETRJ/beHdjai+kDkd1vOhYugO2rPEs8=;
        b=bvjcInVk0w5Aga/UGdqj1hEY4Ynhx9oV7IpR4MXUvBalcxgYkpZnSbw3iRV1p9w1OR
         WCQqQbekNyhfkdLKdvCEeTgHK3SOR7ohpnNqJevCFxKOeUbPmxMC310ChfJagsqfybEx
         +ZjRAmDrVsFinrPklnymNG+vOTsNMSyKoV2YdgURGil2t32W0UJGjq1/1VePrcMYEmqg
         Fy1R0IahA7qoJWnBY0LFkzgqqwITnl2fkMeZyKYtHtoz89WunQfe0VR9x5t6WJL89LPP
         z90qJILdBU20Af1HdxivAv7enIyOg+s1edXbwCE/I5okp0tp62kG/yI2VPUG80OydD5v
         VtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PbEVnPMN2MJETRJ/beHdjai+kDkd1vOhYugO2rPEs8=;
        b=WaWstu3G74nKGjBWaIbLsBNEJEMws6r6fZuZmJDw1wqzxVlit9kh65wXtGU/eQta9m
         mDhU5oMbkGgZY3gcNfUWdzuz+Nxr/3M78QZRvLwhdk3RNfJIbIKlKQignzbccf6FGZwS
         aWbERniUpvuwGo13kavotQcatibLWqdcXrC8eQLpxxgaSMyGXP54ARzwzkDTpl0mzAGe
         Hv4nN2n1chnDtTufhOKdlc8y6kXKqbPl34Yj+GebwDlveL/1Cduiuo2Ytj2kdmvYaAr/
         XbTSuNOw7kSL5vkBizzoLtTsB4nL1+bHG1+zdzPZ/6OWPWVkE6cKzyMbk26luXG5I3OS
         PWTA==
X-Gm-Message-State: ANhLgQ2JcX84B0PP/WIp/8KN6cTyU7Z9LmF5uHmJf0UPia2hHvNKBfp9
        WUEUvXN7AJzKGNo8P+wDuVk0+XTVYdvp78aRXNfD3Q==
X-Google-Smtp-Source: ADFU+vugH3dqSBl+xKkWc8E05RpY1YdIeD+1zAQpVyPrfmmrhyEY5oVhwEWdnhf3FHZ/BEBiDfkzNF2Fo8uU0Bx4shk=
X-Received: by 2002:adf:e447:: with SMTP id t7mr1239757wrm.374.1584587458151;
 Wed, 18 Mar 2020 20:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200317114748.388420-1-colin.king@canonical.com>
In-Reply-To: <20200317114748.388420-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Mar 2020 23:10:47 -0400
Message-ID: <CADnq5_NbdBhz+TQ0Ldng8fLjnRmDiuKDhTrqsC0WDt8-0Vq41g@mail.gmail.com>
Subject: Re: [PATCH][next] drm: amd: fix spelling mistake "shoudn't" -> "shouldn't"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 7:47 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in pr_err messages and a comment. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

The relevant code was recently dropped so no longer applies.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d1cdcb404f7c..4bdf425ca6d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -246,7 +246,7 @@ static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
>
>         if (amdgpu_sriov_runtime(adev)) {
> -               pr_err("shoudn't call rlcg write register during runtime\n");
> +               pr_err("shouldn't call rlcg write register during runtime\n");
>                 return;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc2486167e7..2dd40f23ce83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -747,7 +747,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
>
>         if (amdgpu_sriov_runtime(adev)) {
> -               pr_err("shoudn't call rlcg write register during runtime\n");
> +               pr_err("shouldn't call rlcg write register during runtime\n");
>                 return;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index bb77b8890e77..78714f9a8b11 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -316,7 +316,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>  {
>         /*
>          * node id couldn't be 0 - the three MSB bits of
> -        * aperture shoudn't be 0
> +        * aperture shouldn't be 0
>          */
>         pdd->lds_base = MAKE_LDS_APP_BASE_VI();
>         pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
