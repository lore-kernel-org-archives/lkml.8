Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35820C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D70206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR1rKwJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCLOK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:10:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40082 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:10:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so673571wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9pN5bnfB9UOGPPBmOZ+T30a1QO55ydc2k3sYdmcW5U=;
        b=NR1rKwJFKCpKBdFOSixakBU1LfBZYgL1ja4b92wMexZSj1lE2q5+MuAeq7wwehzMnY
         8mQ1YXCriAfreO0PYg4YDJRnD4rf6rmCHuRhQRand0tnPQ3ETIZJFxRxp6CODcG0oSiV
         alZbg1MInEptTSH0CgCpu2Czb3ME7Whpi2P6m05YH+tZh6HYIz8/vfrBn2bNrCfI4Tz1
         qolgY8dyw1MuANUII0CPwrPGFuQtZ4ozioq4TyDoKqUSOt3V4dxlI+2CCxBMZlKq20aI
         CDWJ0wNZeKSQPLYv42knyfiAoIOLLJrE/glxMsXynLHRF/ge7KbuHQ9D/+jgYxGK9q4S
         lL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9pN5bnfB9UOGPPBmOZ+T30a1QO55ydc2k3sYdmcW5U=;
        b=NSWuqvZYJsUUu79gSYzM2kTlmvJK85d+AeOMqKYjaArh/MVF9bEVo78ZDhqJrtgQLg
         VBd2IY6RRG+t7B7BQN0K8mpfTl8a/C+l6gybNK7lZCCrLIegxUGGafh4hA53lyp+377c
         yShQOEIWAhKa84lPHeEBL7zVxsVvrNpsZJqKpdzO1pPYJIE28WxWlwSO9OYBhYsddEp/
         NECM33kaZAkxjQ8+c3CL5q6R1Dzrll4GQsTntosViAKWtyZNs7iZZTqX3AyOXW0DVeYd
         incNo3xcq0DnMcYKua4+44fx8RBcXnJPJPegR4PRIxc/aXz0UXf6P20kpjHacqe+H6yo
         mNjg==
X-Gm-Message-State: ANhLgQ1FrJBthM4dzXN40iNdxFIuLayTJJcE0boUlwL8BKnX6MOxAL7X
        iXL00RUfQ186UAulmNH4nvTxHRmpo/UKcNW9E3E=
X-Google-Smtp-Source: ADFU+vvHHg5y26BwqZU/LzLm11ufz4kziAJw4cWQh+hWSa1c3vndABADeU8cnh7o+ogAxkbeq1ZNsRjRSjTYi1qMhII=
X-Received: by 2002:adf:f74b:: with SMTP id z11mr11781048wrp.124.1584022225518;
 Thu, 12 Mar 2020 07:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <4ee79adcba4e5ea80b3ef6271caeef6df4bf8ca7.1583896349.git.joe@perches.com>
In-Reply-To: <4ee79adcba4e5ea80b3ef6271caeef6df4bf8ca7.1583896349.git.joe@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:10:14 -0400
Message-ID: <CADnq5_NA+9VhVUGxPcJ8swu=qqPpPA+3-HK9fy5jAg5ko8TfwA@mail.gmail.com>
Subject: Re: [PATCH -next 024/491] AMD DISPLAY CORE: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Leo Li <sunpeng.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks! (link fixed locally).

Alex

On Wed, Mar 11, 2020 at 1:07 AM Joe Perches <joe@perches.com> wrote:
>
> Convert the various uses of fallthrough comments to fallthrough;
>
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 2f1c958..37fa7b 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -267,7 +267,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>                                         && id.enum_id == obj_id.enum_id)
>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>                 }
> -               /* fall through */
> +               fallthrough;
>         case OBJECT_TYPE_CONNECTOR:
>         case OBJECT_TYPE_GENERIC:
>                 /* Both Generic and Connector Object ID
> @@ -280,7 +280,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
>                                         && id.enum_id == obj_id.enum_id)
>                                 return &bp->object_info_tbl.v1_4->display_path[i];
>                 }
> -               /* fall through */
> +               fallthrough;
>         default:
>                 return NULL;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 68c4049..743042 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -645,7 +645,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>                         case AUX_TRANSACTION_REPLY_AUX_DEFER:
>                         case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
>                                 retry_on_defer = true;
> -                               /* fall through */
> +                               fallthrough;
>                         case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
>                                 if (++aux_defer_retries >= AUX_MAX_DEFER_RETRIES) {
>                                         goto fail;
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> index 8aa937f..51481e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> @@ -479,7 +479,7 @@ static void program_grph_pixel_format(
>         case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
>                 sign = 1;
>                 floating = 1;
> -               /* fall through */
> +               fallthrough;
>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
>         case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
>                 grph_depth = 3;
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
