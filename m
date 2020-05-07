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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E43C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0AD208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfblUmOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEGTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:42:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCACC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:42:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z8so7847221wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gckpwq9UyhdYM7Snuci6fAgZatJZQE5/xPkNXtAqPXU=;
        b=FfblUmOZXnlJN7hCY+NKlWXlXO24/IXplyKaWph6ieK2NVQDlzMlM3g2CYtfwTHdfL
         ztEmLuU6qUGvsHMXuyHy9pTnpDKrNKu4fy5L4z5ghG2WOstzt8+p3cR4X7T/Um/omBSQ
         OaaRpAVDiN1DN4OZPc5YNK9rcHz93V2MBdXgQ15+4U9NXB1aHBoo6+Lm3WLKIDgyNqbq
         aH8nt8y3caCzE4pPMEEBJj9sNQBjJ4/VjNyxOzjUu24+Cs51JRnMFkCDInclzLva8fF8
         EyUIJPRenaZ8+GW0sGe9jYuFdNUKcdK6tWGsKNOzre69ELk/Qo3MS0uE3gOzJ2/ISwYN
         cRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gckpwq9UyhdYM7Snuci6fAgZatJZQE5/xPkNXtAqPXU=;
        b=ndwdl/v1AajtQiQK4eUODQRzRzIGAD96bgLN16ZRP/00p4a/mT/wQYKIiax8VsmCdb
         ICNDgF5wNnOtO48Mt/mr0/c47+DiPqfx118In04Tq9YmnvqIH/RUTi5vDd4As4gpO+zt
         hseZMc7OeYmQOz5zvNdjQOX6b0TE6/yQMaCS6gWgC7a8xgHWFtyZW/tyvr57FFbuWvOV
         LqobFZPDWZfmSIVDp36yVIidnZoUSo3breAFp6wLooSmgN4v2mknLZd3xqMnGy+lq/3C
         aJ/euqZZ3k+p3+3syY9JjGLBA4r0Wnbe+jNzV73SX48p8ZozVsITPGpjWnsl6So8gTaU
         Uvww==
X-Gm-Message-State: AGi0PuZ/EyUPPYoQC+4lbBlx55nkpUkJsjAw9wol4S9u1WgLKMg+/lFO
        vQjYodOKrpbhe1+OtJhHbRvLw2msQEIpqc8HWLk=
X-Google-Smtp-Source: APiQypL+8STjCF7ijbtEAlezcdp9vJ09CwLfmp0u9W0uVql+wV3veMDwYgsVGQiJW9eEMtjCo9WaAXWBE7ce29TPt6I=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr664269wrr.111.1588880564696;
 Thu, 07 May 2020 12:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200507135023.33073-1-chenzhou10@huawei.com>
In-Reply-To: <20200507135023.33073-1-chenzhou10@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 May 2020 15:42:33 -0400
Message-ID: <CADnq5_M89XN26AwzRr+F0DJAP7Xz_2FWcO09iUrS2ArkFbK1cQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove duplicate headers
To:     Chen Zhou <chenzhou10@huawei.com>
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

On Thu, May 7, 2020 at 11:27 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 9ef9e50a34fa..1db592372435 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -13,7 +13,6 @@
>  #include "core_status.h"
>  #include "dpcd_defs.h"
>
> -#include "resource.h"
>  #define DC_LOGGER \
>         link->ctx->logger
>
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
