Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45782C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207CA2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj0O+fpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGJVBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGJVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:01:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3AC08C5DC;
        Fri, 10 Jul 2020 14:01:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z2so7229210wrp.2;
        Fri, 10 Jul 2020 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+r5bXWhv/RQ5xFOE17P6y/DtE6DdUph31T/6lnjgyI=;
        b=Xj0O+fppYfdFYtGXu/8QJhYwJ7qRKnFTirnizTXoFo5bZj6n94L2JJj0BdRzJwzAb5
         xZRyrEv3g4yyg5OvsM4snf2LCqod8codoTvAxrPCUxbIvksvMH1AU8WPvenGlYrpxSQf
         6BjZ3/b3VUh3+MkQZawapsKpjwcb2Ex6HXUZFheK4SJDgNSlkTZm5VxobjBO1AQ5WX5K
         aaZGH6qaz17M8SlXpxudD5NTY4oJewCMG4Q6skZFj/xPz2y1jeXWQLe2zCpIrQxxh940
         SMoOyMYtdW1UeDYAgsdG/e20KOUC8x8x3GL5LKFyb7Zb02f8D42khsD14r13TK76VWQc
         2R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+r5bXWhv/RQ5xFOE17P6y/DtE6DdUph31T/6lnjgyI=;
        b=BxEhAZZtDDsyBzqANkTnCFRYrLUEhQwx4vuxe0tuyokzdVJAFNsUPr8jnGq0SmTNBa
         gMALJmNNKIdOmUYg7XYrWx9ETbzA5Z9hBBhBIM1FAmyAMGVEEZpOUhSdxnvPIMrr3TF7
         dY6LN7ctMpJIeHqeQN0oyHjXTAQ1bcFh8AYmuAY2oLe7XXUKqXBY9gcX6pjxX8A4TfEG
         gQgxAWekABIPsrRZ7Fh3Nof+EHC0TTVlPhtHU9C2+jUV6CaxzuMSV8Qi+H9xFr3gcoxL
         Gl1PS8uSBKyxUWjQBKooV2YVCjLVM5G0cLTY3k5P6iaV2qWcfqowjYB2adym9Lhu73xI
         Z5lQ==
X-Gm-Message-State: AOAM531W+LW7u+2Q9f6ljlp5rhgejWWpm05QR3EtL2zFzjdDp4IhuCoJ
        VPMFgdVgFX/JbuFh4+orywzdkQooxAriDsWVlSw=
X-Google-Smtp-Source: ABdhPJypPwO8Bo/INW0FnA8A7BrNDcU34sqKrdYu805RwMp6HxYo7wINlncuUBXunFISVe1eQrqua5IIzU9mGV+XpdY=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr68186470wrl.362.1594414891375;
 Fri, 10 Jul 2020 14:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200710083758.3304139-1-colin.king@canonical.com>
In-Reply-To: <20200710083758.3304139-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Jul 2020 17:01:19 -0400
Message-ID: <CADnq5_MWvu0JDbBMR1_wDqozxMahX6uAJBppTLKwPLOmdtTGSQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
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

On Fri, Jul 10, 2020 at 4:38 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e20695b44dbe..40706334f7a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1984,7 +1984,7 @@ static int psp_suspend(void *handle)
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
