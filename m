Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3294C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F272076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAVF2FGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbgFXPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404564AbgFXPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE6C061573;
        Wed, 24 Jun 2020 08:16:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so2902824wmo.1;
        Wed, 24 Jun 2020 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34hmditf+vhlxJcmEFkZgWoC7pJeDEW0sX6340LuRHw=;
        b=QAVF2FGrKfQudyBRkn3UEh/QzSSNVI0DOwlhIyVt7j4OWP0Q1EKpaZB7h08BZ34SL5
         xOPUwta5fN7soRtWRKATYZPdLsezxlnLx3C0yP1njOkEOzi5vwQ1wVWsSFYl46UQmRhx
         zTRbOaYgkfnwfMea/9aKyEZMcMEW3De25mZvgPzrdK5mCyi9yvuFwNz7toArk1ExXQGr
         vqzqH9txAcCm0C96sFblR42GmoxJWnINnyVmRpWtXXZ0fR2wTjyAkgdvpiYyxX6KbeWp
         9Y5MzCGn0FT1gQPQ1kvcOhDRGpeAcA5WLfAy9ClOcUCzgBrD76MCrjQM1IcW5VIxPfCx
         GAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34hmditf+vhlxJcmEFkZgWoC7pJeDEW0sX6340LuRHw=;
        b=TLvLBEQKDQ+eq9uzxR4g4k0zNNmff9WKShE3uaNIafUYlvswyqnQDyy748fTR3lk0C
         iGIJnCdYA2lqn+jAnEqvojbcYCbN68L9OWbrTrrxmJFAYrZ9Xm9TdMq/V/D7kf0g+cWY
         /0C58wij8T9tUbRgDzp96GNly6Iana6WvNopmYznSKPm/mRB3+aIw1utfc0Mb8zv/IDi
         JkU/8A7AAoFDu1KJUZacykhJJag6l8amOmnZgDFza4aiiP6kkzSxBTe3L75ehl2vjMpm
         IXPQoBQKOqXYHOVzB89sTePBDgMdVzZYKn1wD5Ryi7U6gtISFGYBHIFl7gqV0CwTvSsO
         mjFw==
X-Gm-Message-State: AOAM533g+OnCgh+z7pl/KXPAasg4heBgqj8f8Vq5MI6vyv2B9RrIq9od
        3E+YJmRY/H1VTfRZ79Eydda22vzPzaC4USUWMpE=
X-Google-Smtp-Source: ABdhPJy1qPZlkbkex+2mcQ3H0P1rh2BMF6aNpxBKJx6viXiD5LP/TMlDpplYwy2FDejjx7BYrjXNvarY9HUElDbSf5M=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr30880941wmy.79.1593011798868;
 Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200624145418.7794-1-colin.king@canonical.com>
In-Reply-To: <20200624145418.7794-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 Jun 2020 11:16:27 -0400
Message-ID: <CADnq5_PySz6YWOMM4kosC_B83i+jsPKmf0puMt3sw2C-hExa3Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: ensure 0 is returned for success in jpeg_v2_5_wait_for_idle
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, Leo Liu <leo.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:54 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the cases where adev->jpeg.num_jpeg_inst is zero or the condition
> adev->jpeg.harvest_config & (1 << i) is always non-zero the variable
> ret is never set to an error condition and the function returns
> an uninitialized value in ret.  Since the only exit condition at
> the end if the function is a success then explicitly return
> 0 rather than a potentially uninitialized value in ret.

We should actually never hit this condition in practice because the
driver won't initialize this module if all of the instances are
harvested, but better safe than sorry.  Applied.

Thanks,

Alex

>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index f74262a22a16..7a51c615d22d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -462,7 +462,7 @@ static int jpeg_v2_5_wait_for_idle(void *handle)
>                         return ret;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static int jpeg_v2_5_set_clockgating_state(void *handle,
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
