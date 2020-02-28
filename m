Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5D246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx2MB5km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1WXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:23:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37121 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1WXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:23:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id a141so5011842wme.2;
        Fri, 28 Feb 2020 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0tnqF1kF4eV88+pytdt7G0UCu2eYAnWTlo0vU6Ilok=;
        b=rx2MB5km/YacdI2Ik586qXT79BmH9inBN4Wr/FzXSkLEdCiD2qvcO0iAKj9tpQ+b9o
         eOeaFT6z59c5C0MsNLQwZ4xpyNKXhwR0lmawmtkSmRVSMz8Eid82tOPKKAPIXsWSEmPO
         Ep/yg49pHIyYKQxIIiLHvDXaUEXUnNW+U3feVaDyfzT23aHcA8UhPV6aT0NAAh/89pqB
         eB2nOJ1Tvki+g1Ln2H2lw0bGMtIO7tCudthpjoOXIjruVzC5tRzp02rzEMxz6zvu2n4A
         FBY4s5HMJuKX9X5EozOrjx4WHKC5nIP+3kvr7DTnr//RJjzch83DK72/3FTplxOQCMzA
         taXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0tnqF1kF4eV88+pytdt7G0UCu2eYAnWTlo0vU6Ilok=;
        b=oie5acBEl8HjdsKKy5ndtePzXRb+OLnRrCY+4T2KU/3cAb6n+8/UAFCMUTzqeCKbSv
         hRo7WKs2YLortD1xwWTK/7g307TeMvZpHO5F5txXXpi1r3OXa6fcWKfFHUwZgdJ9+mVr
         Tq6cAww7kywCANdU0juFIwiIeftzkzyfUSuBxlEfj3FV+Ph8aFrLINVY8naAJg7W/f4d
         jQ5EXVJhklxFMJWPQl7TnLJaZ6bcepr3fH0SUxCOoHJVS3Zx51W1u1GZ84atA30DQ2b8
         GIFq6Q56PMLUWdLRTA1uRTklPDYxxTLwQRespNECQq9h4WtDsVzj7SzeMVGzHbCjfdQQ
         cn1g==
X-Gm-Message-State: APjAAAWHSsQ+8OoPciXU8Dq9VxT9e3+8cZnRnPtLAtHwmqYqOkTmOY7w
        Dg871s1X4qS5w7GGwumtz6xtZEuIFDwYDiNk39I=
X-Google-Smtp-Source: APXvYqxGoW/yNi+W5fE8+pSSWwKJBYHjV6hCLJqWEKQbGLWYXEA4cWY6XIX6tGqrsg90SouTwiQNSl6JXdhDeNKvtZ8=
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr6822036wme.56.1582928609436;
 Fri, 28 Feb 2020 14:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20200228131606.65041-1-colin.king@canonical.com>
In-Reply-To: <20200228131606.65041-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Feb 2020 17:23:17 -0500
Message-ID: <CADnq5_M17_MMfy8YqK-wn_aew1ZG2zZtsj7kaK5eM3=Em2zzzA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix indentation issue on a hunk of code
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
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

On Fri, Feb 28, 2020 at 8:16 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are multiple statements that are indented incorrectly. Add
> in the missing tabs.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 5d081c42e81b..2c6db379afae 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -3265,33 +3265,33 @@ bool bw_calcs(struct dc_context *ctx,
>                                 bw_fixed_to_int(bw_mul(data->
>                                         stutter_exit_watermark[9], bw_int_to_fixed(1000)));
>
> -               calcs_output->stutter_entry_wm_ns[0].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[4], bw_int_to_fixed(1000)));
> -               calcs_output->stutter_entry_wm_ns[1].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[5], bw_int_to_fixed(1000)));
> -               calcs_output->stutter_entry_wm_ns[2].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[6], bw_int_to_fixed(1000)));
> -               if (ctx->dc->caps.max_slave_planes) {
> -                       calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                       calcs_output->stutter_entry_wm_ns[0].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[0], bw_int_to_fixed(1000)));
> -                       calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       stutter_entry_watermark[4], bw_int_to_fixed(1000)));
> +                       calcs_output->stutter_entry_wm_ns[1].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[1], bw_int_to_fixed(1000)));
> -               } else {
> -                       calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       stutter_entry_watermark[5], bw_int_to_fixed(1000)));
> +                       calcs_output->stutter_entry_wm_ns[2].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[7], bw_int_to_fixed(1000)));
> -                       calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       stutter_entry_watermark[6], bw_int_to_fixed(1000)));
> +                       if (ctx->dc->caps.max_slave_planes) {
> +                               calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[0], bw_int_to_fixed(1000)));
> +                               calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[1], bw_int_to_fixed(1000)));
> +                       } else {
> +                               calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[7], bw_int_to_fixed(1000)));
> +                               calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[8], bw_int_to_fixed(1000)));
> +                       }
> +                       calcs_output->stutter_entry_wm_ns[5].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[8], bw_int_to_fixed(1000)));
> -               }
> -               calcs_output->stutter_entry_wm_ns[5].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[9], bw_int_to_fixed(1000)));
> +                                       stutter_entry_watermark[9], bw_int_to_fixed(1000)));
>
>                         calcs_output->urgent_wm_ns[0].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> --
> 2.25.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
