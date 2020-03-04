Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42183C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADFA21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2zkK61c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgCDSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:35:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53670 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:34:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id g134so3307030wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DRq31dVT2gcFH3XXRtqpgig/7H0t/mX4ebDUqxQJAM=;
        b=K2zkK61c2TNW7EUI2Xo/xumazBlU352yLQ8Je3IUqoaUeb9Fj5WXxGXfTelu0rxweA
         ObkurjlXbq7kKvzJnlUaYK6MV23HpRq6o1fADQJq2vWs3oshVhduVquYNUyMlbMYahbR
         PJNMcUIuLJjo0nH4eGvCiHgv9H88OuZBtXnHYx0c6QNe8ti5T6nUJumoJ+iaU1oYEtW/
         4XVPJyD7oyY/uIF7GI9fhE0iAysskUb+HW/wCTDhfvCkO9CtdEV+kJ3CdqWGoIK5RDyh
         H9wNzAlUkJ+wFWngJvKmHcfSdLHeWE2EDmbaKbD+6zLEyJl9mQmr7XeO58/PNZ/OR9Y9
         rjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DRq31dVT2gcFH3XXRtqpgig/7H0t/mX4ebDUqxQJAM=;
        b=TX95L4maTWB5EaQTK36pEvH6UK/+LqO9IgCDcGmgktXpq4PCpr4fN7HbyxgTF9MGcJ
         WvKE5J2x7gybZfnOYfz0tpL8/a98bPBS3ByHwxbPRVIsxg7wgPkUeWOPIa79i9WoDLQ/
         EivO0tuegR3lD9rChht/E41RynuF33kiFqr9alk2AuMe5DmI0evk/cxIv/AH4uqqPTHm
         G46jnk2xtSnoNP6EeKwB05BZ86uoL14HoebFGQNzzCy3CmWZQqAvTIvzDyGo96Z9OvpW
         lshEvG36lAdQjzoIar0J5X3iVCudP6WvXmZND+u0SPS80onayA/3XvdSNeCeVtSk3S1+
         2OJg==
X-Gm-Message-State: ANhLgQ1r+Gh3dlpHWA8nUIcVM0d5EwhCiil3dyFJmRwiM/AIYACwKS8u
        qIfSu/ZBTs1OZNV/lXYLO9Gt5DzoukXXRZazVWQ=
X-Google-Smtp-Source: ADFU+vuqsD45qASCZnH8XxkPs5xXkVU9VR6SGpBNUzkMJaS9wuU7zXFDdGM4NqqOgbJGLMQvM56J9z4ljMWTDVqqPO4=
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr4934184wmk.56.1583346897405;
 Wed, 04 Mar 2020 10:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20200302224217.22590-1-natechancellor@gmail.com>
In-Reply-To: <20200302224217.22590-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 Mar 2020 13:34:46 -0500
Message-ID: <CADnq5_Me3VGP=WfDuSfwC705b_XVENyn6q9SRU7=pXW-2xEdvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove pointless NULL checks in dmub_psr_copy_settings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 5:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:31: warning:
> address of 'pipe_ctx->plane_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                          ~ ~~~~~~~~~~^~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:56: warning:
> address of 'pipe_ctx->stream_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                                                   ~ ~~~~~~~~~~^~~~~~~~~~
> 2 warnings generated.
>
> As long as pipe_ctx is not NULL, the address of members in this struct
> cannot be NULL, which means these checks will always evaluate to false.
>
> Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
> Link: https://github.com/ClangBuiltLinux/linux/issues/915
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 2c932c29f1f9..a9e1c01e9d9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -144,7 +144,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>                 }
>         }
>
> -       if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
> +       if (!pipe_ctx)
>                 return false;
>
>         // First, set the psr version
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
