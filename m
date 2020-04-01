Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C5C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485820719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDN9Lw4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgDASQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:16:38 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50561 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbgDASQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:16:38 -0400
Received: by mail-wm1-f46.google.com with SMTP id t128so775200wma.0;
        Wed, 01 Apr 2020 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBfUFSmU8zvUnDHqRC5Mz8a2y8QFA/TqUJ1aNUh3AOs=;
        b=XDN9Lw4VT7+8iCHmEh0XU2gv3/ozIxXfd+MR1/SDI305t46ys2PDgbzeKaBYcN4rUk
         fRrkEy0muuSv0VEPcm0VyLhjBG2AB0mvGWxTxfEyW0NlFxvNz575aMEYM6cKDJ2FqHqb
         kP/0EUngflH4WTqE/GHfWBgC7rHFPCseoKaul+RgXxXJYJG7+rIG5sXnFgda1UG5ET3y
         t0yJSCysR6ZF+CoK2kcYjyBY0g7PoJyn+RdSDLKWGxTNQ8c01mqmEiTizuZ1KCGcnv3L
         WvwQZdgHQSN/k0mRsfbAWtvjsLisbSvGKeuexz1hs27OUFNlgHL6anKL9r/65zvHLWh7
         2QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBfUFSmU8zvUnDHqRC5Mz8a2y8QFA/TqUJ1aNUh3AOs=;
        b=ZDjfFcFGSxpECZxD9lEkxzFjw31OYS+rr+ML1RmYDpRo7z2mYzVLlj/pD3JPFYVRtV
         nzynlOZ9Ps7bdty328owhFlEt3KQnNvfuKIWR3is4fr77H3ZB+tgWvQ5nwdOrkgm4X3y
         LkuJ2OUC7sc8usa8ZUM7hZumS/xhh0D9Ugr2r9jywZEa97MVfoJHlX4YDqKn0Rdml2Ha
         PFl7szqK8mFnGyeTKn/O4tmEqNyIc1M+33MFTl0VtaFMVk2CMfGONhkgacbwX+9vRCYQ
         ejToBPWsO+CEL8cUqxn4UVA6WV3bxiznDrFZDVcwR7H+h5PSn9icE0hRAzQSU+f1LO52
         GW9g==
X-Gm-Message-State: AGi0PuZHzSFh4jPeAEJMbbnCs6jdxlxsB8bxX7effnDm82uHdA44zhPR
        lQnvK2I6CzA3aXm5l1c3iNAIN5Ol7xP9EDTKF1w=
X-Google-Smtp-Source: APiQypJ7+9mjMttUBHn6NWR20sM60GQuCanYIuty4mLmSFnz8TD2ROhWoUQ+0V8GY/ltD/73QWIeNZwVmN+k4F1tII4=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr5497490wmo.73.1585764994404;
 Wed, 01 Apr 2020 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200401163545.263372-1-colin.king@canonical.com>
In-Reply-To: <20200401163545.263372-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Apr 2020 14:16:22 -0400
Message-ID: <CADnq5_OZ2Wfqpby69aTXy1OCE25ncMNZ=PqZh=jN7gX1s1h2ew@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/vcn: fix spelling mistake "fimware" -> "firmware"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 12:35 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 328b6ceb80de..d653a18dcbc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -187,7 +187,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                                 PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].fw_shared_bo,
>                                 &adev->vcn.inst[i].fw_shared_gpu_addr, &adev->vcn.inst[i].fw_shared_cpu_addr);
>                 if (r) {
> -                       dev_err(adev->dev, "VCN %d (%d) failed to allocate fimware shared bo\n", i, r);
> +                       dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
>                         return r;
>                 }
>         }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
