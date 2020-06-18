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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D02207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtMsv7Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgFRPPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:15:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F75C06174E;
        Thu, 18 Jun 2020 08:15:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so6476931wrp.3;
        Thu, 18 Jun 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzlvT3gaSlLbN4f2sLYshLtTaNcAUW9eRJsVAjGv5Ko=;
        b=qtMsv7AwvP28H04YkN6EWvksFGG0W2yZaMKLxPJQnvzfC1QQON8ZhE78yHS6xPa5XO
         LuiCJ2qpgqvmf7JWSmKmcLlvT7gbb8MNVZ/YDM2iaZ33v2R6E7nQUsOJfPs5r2/er912
         jET4OpIXCXlSDDLNklSrG+fTsA7WWKpAqytffIVZxEGG/s/hALY1Ff+5ZbazpmvDUdDa
         FHHjlmjUR9YhqlQQX+vVZWEjoVcE4rYIGTRG3JaK1ci4Xp9ZPfxugrCG/b7uPn2VzEfP
         PclGgDIyESG5oFxxhN+omK4rA0i7kxs3fnCpe8cVZTjOm68UKcE8YUVyKdNjBCs3LwYy
         CrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzlvT3gaSlLbN4f2sLYshLtTaNcAUW9eRJsVAjGv5Ko=;
        b=KdZoaISSQGFW7mES1d3Kdzb6bUbeM0aBPrreqYT8WrNt1O/bGKBxPE/OGsY9pEakzW
         OhPyUO0oscsaTYI1dzCGBGpD/ie3cM0mzw1xQokkf1xd0BVxoP89opaoxOgvgnTzH3dJ
         718DRCnzyPllw8aqDcBfghIvNRmvyMLGxE8tzulRxFgLZXKY41u8i5tpzXtSlht/YTZk
         9UeeGh+ei5Zrs7cpIeyiF/jnhDdTnyHg70z6J/t5kF7BdGkhxvBxATSEwqdZX0AHWc+b
         MH7G9HiIF4PRSPWRDPZ+W5GC6cC6Q0Q27P4ZF7GIqdWi+pvu0P7yQKBCiUutTlqR7Thp
         sY9w==
X-Gm-Message-State: AOAM532RqoOyO9Ou6/3k5WSLxNJzQsPhLRB10HLzNrN8LlKMV3SNOfhl
        OVkHu1M/uWJgitl5g81gKIXZjq0Afr/XgdSKdzA=
X-Google-Smtp-Source: ABdhPJzZdbx39Ada+O27jmlcsTDezs3Ch1jm0rrsMzDul8XqjyMgpuRoP5sfTmlIH1uh8tBxx7i44dGJ+BtI4f4Dxj8=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr5073030wrq.362.1592493340203;
 Thu, 18 Jun 2020 08:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200618102622.12256-1-colin.king@canonical.com>
In-Reply-To: <20200618102622.12256-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Jun 2020 11:15:29 -0400
Message-ID: <CADnq5_OeVaKbr46WDQ0GcnLd1CE2EbwmRxyVOVqJcqwkJN5qNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove redundant initialization of variable ret
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

On Thu, Jun 18, 2020 at 6:26 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b2cdc8a1268f..58b76d3d7365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1609,7 +1609,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>                 const char *buf,
>                 size_t count)
>  {
> -       int ret = 0xff;
> +       int ret;
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         uint32_t parameter_size = 0;
> --
> 2.27.0.rc0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
