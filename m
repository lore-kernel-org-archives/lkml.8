Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A0C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598A921655
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxSScwYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEGTgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGTgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:36:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:36:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so7798588wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPW4CK7OR/eqFHRLBEIEsrbWm8BRZpXSUtYnRNfi4pY=;
        b=qxSScwYWuPpzH/RkFnyM8ln4aSwLFEWBqwRkfBedY18y68OZBuf1kLVFgmm8q67GfK
         lfMsP0PgZju31IV8YWMyuhuHc70Q57Z9V7UpGW0u+GVK8tOa6ksQ7FU3wVZSBxY4GQv+
         wdlVOqiEDLmllXeykL9RpUZxPfoRB7WbOETGRVijjlH+237kMDJUjGhgN6Ca5dZN8LMN
         82o5yexw2JTQaAlJ0gt0ussG6jh95rRWJINwZdq417OpIZCXYbDXHC57Ngkj7ri01/he
         CgC4nfliK8Y97BGY5iVfauqn/Tzg7d1+xLB1e1k39eMhMYyZq5XA4pdY2u1iglQmaljN
         jPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPW4CK7OR/eqFHRLBEIEsrbWm8BRZpXSUtYnRNfi4pY=;
        b=GIjb60qtxxNimj/4WVO1rEPRhkcPmhxpL9q4rnF1/WSDL6qJKTHQbg6LchhttiOSyi
         V84GPo9y4hBLMBX+61qfepwm+fbD+WR3IPWox/2kUjQwc7ONPQQIBKuGtF8CU3uHGnSk
         edQxzdIqTUkIg03Ys9vt9FnMZXcOvwnsh2cssNgAum/WqnBcUSHmBoZYG7zlSKQx0nDh
         1Gto76znE9qusQUmJOIVI6fUk5RqUWa5DpZ6UjSsdu25Zc5sPOZa7Gu2Ks9oj4p35Hzp
         o9UbIA+I7zx6jSbXP8hvplbIy3HiNmAe6Gz2y89P3R/HruqLgt4OzqWwVtxeg/S3rVR4
         Ww+Q==
X-Gm-Message-State: AGi0PubB4y00CJ0jDYAooPcVfhsLBHkmX1liK9nZLNAHhBFApWJWptiz
        mwRgu5MA2FJBIPNb13kF1e7ZTZNLX5gWmJNuDcPg/A==
X-Google-Smtp-Source: APiQypIWrV496/a3WjEusmf1TVTRkBkRygVkQbDUmrGwf/7VmDoeDd8rPT3/q4WtU2IvlD+T9H8BWLV2ZhjgmPYM5ek=
X-Received: by 2002:adf:ee86:: with SMTP id b6mr18453318wro.419.1588880169326;
 Thu, 07 May 2020 12:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200507110703.37509-1-yanaijie@huawei.com>
In-Reply-To: <20200507110703.37509-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 May 2020 15:35:58 -0400
Message-ID: <CADnq5_PRtJmgacP57MHH0uDjnWCd1bc_7g4KK9-NW6VACjXBXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove variable "result" in dcn20_patch_unknown_plane_state()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied thanks!

Alex

On Thu, May 7, 2020 at 9:35 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c:3216:16-22:
> Unneeded variable: "result". Return "DC_OK" on line 3229
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 4dea550c3f83..3c0090797866 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3228,8 +3228,6 @@ static struct dc_cap_funcs cap_funcs = {
>
>  enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_state)
>  {
> -       enum dc_status result = DC_OK;
> -
>         enum surface_pixel_format surf_pix_format = plane_state->format;
>         unsigned int bpp = resource_pixel_format_to_bpp(surf_pix_format);
>
> @@ -3241,7 +3239,7 @@ enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_stat
>                 swizzle = DC_SW_64KB_S;
>
>         plane_state->tiling_info.gfx9.swizzle = swizzle;
> -       return result;
> +       return DC_OK;
>  }
>
>  static struct resource_funcs dcn20_res_pool_funcs = {
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
