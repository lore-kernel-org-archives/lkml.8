Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15825C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F50207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0KRmVU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWVjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:39:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWVjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:39:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so4854477wrl.13;
        Thu, 23 Jan 2020 13:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcgCOt08ESne+tYHU6zwz+Uk0GGpvUG34jW5hND2KP8=;
        b=q0KRmVU2sUjnBvb4qvh2OEJINZpXn9noQIvxIE69SLeV/GEO/eu1lzkAlV/+zuW6wB
         wpiBZQyCrtBKdMJ5QWE6RhC3Fh6nPl3vXmESKni5iyNkfF1PaVFBTNpAg86lcjSaWh69
         mdbNe4Zs1rBH2AANOpEnTbwQCcgFGfAJ4tFW4LoG4EorFH9340W2ImqDS7E433CvOfYc
         /1s+k3mc8znMZ6jQNoHtmUxBV+FDlES4Rotwrqz6/wtJdw0naYJlpdU/tpkz8Us7noyw
         MSsus3NVQuh/jbqDN6HF4IfSBN2QiVokCpm89hhpgrmA/5dmsDw13hB42R1EemZQwUdW
         P+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcgCOt08ESne+tYHU6zwz+Uk0GGpvUG34jW5hND2KP8=;
        b=udSQALTrVqcg20cLD+NAcS1hwocT3bG8K89rYplda2qA3tW/INj+iM+msHcuI0MLOo
         w4Q58t2yK1xwSQhKJEcVrwljWT1Gvi4Mf06gK8Y1MrrsbgGcSJchOsbQzY99GQswqFfZ
         NSj7gY0F48hs03NLY0dBeh7v/tHBEyM9eYS5KRhsXOKh3usckR+edU8jegwtMpBSPqiN
         1+3jhkGqtxOk99IpsnYX5tQ+dz/mDyUd5P7GQIuQcGpipP6GRcaTjJrt/GFBRagl4TYV
         lrh4oyYbdjUhR6EgsFtHs0e5FJaQ5Z95H3P64/s68dTZHHdWR2Ikr7gyiZcA1/BMsmsO
         0EIQ==
X-Gm-Message-State: APjAAAXUAc3hGaFs7d+ao7TQ2OH69IPt8IgIHOWfZL6/EXza+6Cx4mbG
        S6Mwl1TMKKUdHdOZCyN7J5pagSkbPJqE8tayg1k=
X-Google-Smtp-Source: APXvYqwyoTgYy4ctf0PLUzPnRY8IPNUxXoBdOgVGKMbrmgEQQz7/8JgA9GdcqM2NRA60zyf9FJXevk5qAuK+53xj0IE=
X-Received: by 2002:a5d:5491:: with SMTP id h17mr106054wrv.374.1579815550332;
 Thu, 23 Jan 2020 13:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123002216.2832146-1-colin.king@canonical.com>
In-Reply-To: <20200123002216.2832146-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jan 2020 16:38:57 -0500
Message-ID: <CADnq5_PxfM2i0BxpKtOUeL2+hxLUbwocyWNmd9qzXnOesJfuWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake "to" -> "too"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 7:22 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index ceb0dbf685f1..59ddba137946 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -652,7 +652,7 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
>
>         if ((addr + (uint64_t)size) >
>             (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
> -               DRM_ERROR("BO to small for addr 0x%010Lx %d %d\n",
> +               DRM_ERROR("BO too small for addr 0x%010Lx %d %d\n",
>                           addr, lo, hi);
>                 return -EINVAL;
>         }
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
