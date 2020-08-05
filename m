Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B061A2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clorqv+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHEUBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHEUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:01:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924EC061575;
        Wed,  5 Aug 2020 13:01:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so41841721wrl.4;
        Wed, 05 Aug 2020 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFMazUp0MhwJbVuexgj1bxt76f5CLnr6BJ4vAddg9SU=;
        b=clorqv+GMwdktNqZ6yyQxXrKzFF6/uB+b5UtHOzV5SpjRSNFQ89UimVPAVq4+9+NSo
         OHRqMlxYcEasQ3TVdW5ps6BHjWd7Y0TElNh/rAhBHZJ9VXFG8ud6KZAiF1Ik40MEn3ux
         JSH7uR2kmM+6HCKQgIn6onU0fuQqfGIHGZrKkx5raOUaLR3nJCgCUm9y4bsf45vpFb7R
         GAb5WCzsUSZJ3JhpIul+FGKcCtEklbMpGNS7tuionEjy3dJ/JTOmY2ZUws3eyk7qoPBo
         UZv5Xc+GIR7hK6+W5zAO0YoeyZJX+f00gcwsw5G1mNngdt/2pMvtz+osrtNJ0cK/KS7a
         r9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFMazUp0MhwJbVuexgj1bxt76f5CLnr6BJ4vAddg9SU=;
        b=Gxj7OhdhflMYfslkwFpW1OdxXNA5W+7ue8LRItzDr+2ePLcOzMSLAFyLAK0URjaSY1
         mpcw8BZR0jugra0aByU7JmG75MQkHXAx6sepQdaI0aPkakQL8sn0LtYjKZFzlYxILYO8
         B+azBSvL0Y3Wd+mz8tMoCBlXa2LsLuHCe25DIuqHGm3ocpuhUMzP0meaYroFwCUJwv9P
         LnFUzGAQcLbtQQHAMSCEMuJFTJPpK9h90hEWyuPxF0AZTGIm3o1m8KzO89fks4m1KPju
         HIP0QvqhW3YTN1AdNHc277Auv2GlDGL3XFpYQryYb6X9AaCX0BsFkDMVWcf9Ih+w8Fgc
         ZrlQ==
X-Gm-Message-State: AOAM532tc7PusHfT/s/HJB24fmSShfS3xSaHNq5A5nEecSo31lY69w9D
        ZCNOotoCDS4ieh+vlQZLGx1XHe8s6wLmxhvrGkA=
X-Google-Smtp-Source: ABdhPJzcEbloQmJvxKNefm95pR63lEvoWfrv/5u8FdjvGjUP4tRNqqhD2adAS9zjFX5NZBZdKixnLqEcd/X7qdyfync=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr4356598wrs.419.1596657693122;
 Wed, 05 Aug 2020 13:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200805113510.18277-1-colin.king@canonical.com>
In-Reply-To: <20200805113510.18277-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 5 Aug 2020 16:01:22 -0400
Message-ID: <CADnq5_NA9f2N3xkH4WAdDEP+0-5W0LkmTRy3yXqFdnWQmfsVmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:35 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This is already fixed.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 49d4514aa6ed..c68369731b20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2010,7 +2010,7 @@ static int psp_suspend(void *handle)
>
>         ret = psp_tmr_terminate(psp);
>         if (ret) {
> -               DRM_ERROR("Falied to terminate tmr\n");
> +               DRM_ERROR("Failed to terminate tmr\n");
>                 return ret;
>         }
>
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
