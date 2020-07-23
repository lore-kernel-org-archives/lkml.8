Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5BFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752D62065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieT93Cda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgGWUX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:23:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD45C0619DC;
        Thu, 23 Jul 2020 13:23:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so6339482wmf.5;
        Thu, 23 Jul 2020 13:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ic3jTqBcuk4A2YnKQnoJUoi8ZVAuMeAUsxIP8au8VqE=;
        b=ieT93CdakDSdYVpLpHmyLQvPa9yuKZSLL6sCJMJiabdIduu39BfQVsyevEzx4NrHuv
         zpYfdrMOFqKetrD2mjQXWl7EEGY/3j/T8uM2M5qeMfDlSbYFpXTSb+zwZ9X+B1Abi4vF
         s2t9KD3qnbzlt9gQ0DI2YlEX2c5LKImAQ5eCMcBs0mxk19IPUso7yVQq31LkaRsd4xH/
         pAAQ4e6vXFZM1IxTSQfTs5Q98a7yEUN4jW9sQzKcIFsyc3PgkthOGxArOO0s6/UBqgEM
         7RwM4vmbb23BM7A4aNW2kdyo/6YIydu/ZNXdKY1FioSuNqdiaeev9qYRebUXJ3PPAlhu
         h1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ic3jTqBcuk4A2YnKQnoJUoi8ZVAuMeAUsxIP8au8VqE=;
        b=Gw6Hvq23rPdul1uq5ijMijnMOSlp9OTnfNj2hollF/GI6qPWpWXczpH+6pTOVY/NqE
         wjMRVyXzkThXSAekmGAPfOQIwGWjzcih301Sa4qRHArvo2PS0idDTbd3lPXQGM/2tbhQ
         Niwqe4aWA4Ve0QZaM5Pa/MxSXe4bMNhLl3OirbVELlxvOmhcQ/hZGvySDU6XWVD+xFcM
         VXaiFkQlLiunstApA7HdZzemWznxO6ZNb1Fpw3apsqIH6JmXv2lPb4Kof/dj+y2dhygT
         6Wt1LfMFIZnI8ZzEpEUaYH15qiL7E/qIXJUXLbaxdIODgGiCLb9o0NW6QK6IcvRmyA8v
         RVtA==
X-Gm-Message-State: AOAM531d4GYk774QF6O27yVolSwgx7GpWc9dalFTXfeoYPDvY1pse8q9
        mOLce3gCsUFdnMVq0tb6brVPPzrQZCPWo1ctMdMnLg==
X-Google-Smtp-Source: ABdhPJy1tsbBRn7UN6iAjHTn7BzaU6FZXUYje9C8iI+iChyo2GYaMNOzXLHpF+2C2xvdYtvzOURwGwbq/RlvI/UVP30=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr2311976wmj.56.1595535804824;
 Thu, 23 Jul 2020 13:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200723143637.991988-1-colin.king@canonical.com>
In-Reply-To: <20200723143637.991988-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jul 2020 16:23:13 -0400
Message-ID: <CADnq5_NicLnGDbk6XsT4Ux1nPNNgDu84kAPJfGJANQ9YWrcFuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant initialization of
 variable result
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

Applied.  Thanks!

Alex

On Thu, Jul 23, 2020 at 10:36 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index 5d83e8174005..0853bc9917c7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -1017,7 +1017,7 @@ enum dc_status dce112_add_stream_to_ctx(
>                 struct dc_state *new_ctx,
>                 struct dc_stream_state *dc_stream)
>  {
> -       enum dc_status result = DC_ERROR_UNEXPECTED;
> +       enum dc_status result;
>
>         result = resource_map_pool_resources(dc, new_ctx, dc_stream);
>
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
