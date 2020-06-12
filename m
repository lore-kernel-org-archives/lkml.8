Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A688CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FE6206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fopozOD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgFLPYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:24:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296BC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:24:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so10150797wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdrA1iXEBobTaCltTFCacW9YJrABdUKyjxuRObbJj7Q=;
        b=fopozOD8Q9Z316h4yVtPKbKc4/uZH8jo/Yv8Ed+vhZ2zQeOnNIBp9uuZ3U7aHsCENZ
         Hk/OB/Jw+k4+xKCd61Eybax+nVK94EPdXXonB+vQHqFF1Q4BOHDnZSUL1MdaBRxPxr+Y
         GqWlriaM/FTUdVrsgIZnkaCQhATCDCZ7RvqsmAxaz+uNfcewFS6su67gOj3XcHr6BDkl
         o5okfVLgoB+TN7NAdJwRNQsiE3XNI3NVs91y+Gb/BwjP2eUdYIP+qYTFmWWMmPosv5+A
         YHx94AkQtK5nH45f79IQw+yy+vjGFBKc8SeSQIkgx5MqP3dMhtbi98OFtObjwTQqTwwj
         4Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdrA1iXEBobTaCltTFCacW9YJrABdUKyjxuRObbJj7Q=;
        b=LQJF19Yhr+TSBVv4AH4x+ngkpctR0A0Y0u7mjl6wIMbphdn7jzPwuV26MlwitRDkmu
         jioONGWHDtxIyErhccJ+0gvqgnrnnzFbSw3hnfBUW5FY/Oa2wRmzUGU+NELYPPC8cIMC
         i76KWSQW6D3dvjB/yibOG963z4SNb+o3cdALHzePEVvtW6VymLRDm96KdFmuW30uWms1
         IKIdi5SKKFxkx0aJKC7Q6/AP2dPb8v0pQnqDDRpzRUZ5uq6guJRaAjp1t7Bta9WXMx5X
         ty6jOeyu1c8njQtiRiXd4JXS/M54GdWKYxRAgOqre6hw12B6eUJaYdhuv5xsqfeuWKnk
         JXeA==
X-Gm-Message-State: AOAM533C6iH4Bd0zD2pEG/NDBzEtY60ATunVWRrsBSnxW4ztEyR+ANln
        U9D2BqIqxdOG33uZp/XAiL6JBEF7gXQQw22JtMc=
X-Google-Smtp-Source: ABdhPJw/HQbjV25QRzQyt5NHirKIUr0sdJ8NaQMgtbOdZDHffLIShgu8/5/AFDXmgcgg3APrFmdNsuef1af5bjqGHh8=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr16355895wrp.419.1591975493465;
 Fri, 12 Jun 2020 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200612122825.10450-1-bernard@vivo.com>
In-Reply-To: <20200612122825.10450-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Jun 2020 11:24:42 -0400
Message-ID: <CADnq5_M2V3g9AA2HpL_XEbRvLW=BWUbiE=RpZa2YKnTX24Zqkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: remove unnecessary conversion to bool
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 9:22 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In function is_support_sw_smu, remove unnecessary conversion
> to bool return, this change is to make the code a bit readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Vega20 support was removed from this code path so the patch is no
longer relevant.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8c684a6e0156..3e1cfb010378 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -568,7 +568,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>  bool is_support_sw_smu(struct amdgpu_device *adev)
>  {
>         if (adev->asic_type == CHIP_VEGA20)
> -               return (amdgpu_dpm == 2) ? true : false;
> +               return (amdgpu_dpm == 2);
>         else if (adev->asic_type >= CHIP_ARCTURUS) {
>               if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
>                         return true;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
