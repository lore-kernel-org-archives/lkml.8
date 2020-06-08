Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B8FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCEB206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaUV47mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFHUQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:16:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C7C08C5C2;
        Mon,  8 Jun 2020 13:16:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so18831073wru.12;
        Mon, 08 Jun 2020 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Uk3yl1D/RpkBqrAcsQCxgo9zOQry2M3RLC+d4sbwjc=;
        b=KaUV47mtAjCf/bz0YZHKdm++WkOzlNNqKOTlrQl5HMnHCY4tg4SpP9NUUalsTQSIPX
         SbtkTrdwAOQPFfCntH8S42NPOWYQlS+joCK6Cqd5jltJP+L/BTLeXSqjHffJXJY7uw3z
         2n3pO+LVOi3m5d0dG0c0QZ7+H3gzRF9K7nWjTgy9CO4xPwyCdbMmChzGlEeCqrSHnxJm
         fr9udMEvUnGGUq+l+rSOJnhEq7ThCvD7JykrAZg7fYBK9DGaNheE9GgZTdSdEnQm2QoG
         +MiH+IgkcWX8jkW+g16y+d0G2iNcpiv6zpYMG6WNcfvHkiCZViIs5F3SM1AUANx6RNZV
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Uk3yl1D/RpkBqrAcsQCxgo9zOQry2M3RLC+d4sbwjc=;
        b=NyWmzj4wo6/9Mdp/CYbfmd2Xk4KWspaonkE7l3lf5KHMLMyckQAJRea8Row2+Kzk6p
         PbaSDMtTPXlLkfhSO67IAOuqGA3shBr0czmkcxEQ5H2SqcrzlFf/ugv312GOp7emMYtU
         PPHx63kCfaxqPim/fzJTHWy9casm8IUaNFMEX/Tt+0/8H8SH/SLphTnl4QXlXPlRlWoL
         PzFESmY4oGBzBKBosiQ/uGXuQl0+M6F+1iCvt1tV89vURhT7bXkYinJBlRLfLkZtW53f
         k3NlykPtax5f9gFYfmiFkholndXq9m018jgc8kiB6DgX+TlfT6jTmFX+CyT+WxxCSdB9
         ae0A==
X-Gm-Message-State: AOAM532fpXnoGIsZaSGM9DGOHSBoTFozQKGxWeoEo0YAuwTrzArHqgYq
        6t6+oKiw9YTKtwGDkQT0y6JALanSEOyVkrIUq8M=
X-Google-Smtp-Source: ABdhPJx9dJpsk3rcGGUxOzw0jvEvBmj8RgagpHeQThpZRVMrnNVNvHPnxS+rDhvphLPshA4vOZFQRgrWilTTcYy9cq8=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr566434wru.124.1591647417434;
 Mon, 08 Jun 2020 13:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200608141657.GB1912173@mwanda>
In-Reply-To: <20200608141657.GB1912173@mwanda>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jun 2020 16:16:46 -0400
Message-ID: <CADnq5_Mg2kJOmD40VyVNqbKnKU89QaNRLJ7dbre_pLDX2NuXog@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix indenting in dcn30_set_output_transfer_func()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 10:17 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> These lines are a part of the if statement and they are supposed to
> be indented one more tab.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index ab20320ebc994..37c310dbb3665 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -203,9 +203,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>                                         stream->out_transfer_func,
>                                         &mpc->blender_params, false))
>                                 params = &mpc->blender_params;
> -                /* there are no ROM LUTs in OUTGAM */
> -               if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> -                       BREAK_TO_DEBUGGER();
> +                        /* there are no ROM LUTs in OUTGAM */
> +                       if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> +                               BREAK_TO_DEBUGGER();
>                 }
>         }
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
