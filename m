Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBB2C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C12070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6eTQuzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD3Qck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgD3Qcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:32:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DDC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:32:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z6so2687636wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ugyb7Zb4Sysj1bxwGzOmKe/PaiDp8wxsBq9DmhoL44E=;
        b=j6eTQuzQbAwpZE/KG4Vb3yRnsgDC26xftMT2jvjHHgv2Ry9OmS0pTf+OOaX89NT7xR
         a6ye+t2bVtIHykJbMOPy5/zJM6YGO1023NU/VCkNr9A861zyXkMeCkiNnwU7yHmSKAmD
         cBkNlVPk7QQbKMdbAd5LIvfvE3URtUsecxEIDZB9UMbeAn+lluUEzBc+m8U215//CGsG
         Mje7KcnpQBmmm1f4M5+qYKrpGAwQ/nLtmFc4WgQbM2+oNW8Eaw4oxV8xLrOo3wkzHDDd
         I8e3hdaH1py0yn6TeFgl1G2KLhNEZ9+QsoUQQ3PK0n6SrJ479pmtaX1QQm3DiT/LlhnY
         wPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ugyb7Zb4Sysj1bxwGzOmKe/PaiDp8wxsBq9DmhoL44E=;
        b=emnxwZcJpNtJABU5WIWqWOBpq+bOurKFT7ok1ruWFiE1Vz/0AxQhhA2iDhWGTIH9XH
         m9QJEuONZcqHMS3WjQt1+wwgnYDx2ja6v5YTHIFJt8omEJIkjlj9eYDl96oz1Z3/frFp
         gBhWjTE1NeYe3oSQITAIHKO9JRdLPoOTUfrgDHmKmAaCds1NKMHqbytP/XsNC0gM1UWQ
         0m5DkzqtCdsotJb2ZurwmRbMmACXXrUmKjoUWT8SjXEcaN1xdWQ10an5pz1rOaCsmo4R
         Bw8bv3qLizND5e3LRm7raiUZoo2c8l4q+m/dPqWVY8ZXoqtc49bgaaP9GGyTF8FmW719
         5q3A==
X-Gm-Message-State: AGi0PubqdMm/hnxtSuw/KrQM3jcl89YEMByg+0WKaioiNDEdtpoDcm/o
        dSTRGrTyCvEjDPyjuC+Jk28+GFzBbI0Pxc+7VDw=
X-Google-Smtp-Source: APiQypKrZHvtErC3cKfTsi/zEKLQ6xIA3UZ+0B7fI1AaibkS6bXo92M3dum2wwZ1ZNScd8GlY0v15RO8THKXaBE6uGQ=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr3960280wme.79.1588264357899;
 Thu, 30 Apr 2020 09:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <1588218962-75747-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1588218962-75747-1-git-send-email-zou_wei@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Apr 2020 12:32:26 -0400
Message-ID: <CADnq5_Nawk027_tzc4WChRcPaZqJtorQTy=YrFFdKL-C7+ScKw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix unsigned comparison to zero
To:     Zou Wei <zou_wei@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Apr 30, 2020 at 3:33 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c:1398:60-61:
> WARNING: Unsigned expression compared with zero: j >= 0
>
> Fixes: 238387774232 ("drm/amd/display: fix rn soc bb update")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index ceaf70a..419cdde 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -1384,7 +1384,8 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>         struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
>         struct clk_limit_table *clk_table = &bw_params->clk_table;
>         struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
> -       unsigned int i, j, closest_clk_lvl;
> +       unsigned int i, closest_clk_lvl;
> +       int j;
>
>         // Default clock levels are used for diags, which may lead to overclocking.
>         if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
