Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6D320747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKulzeyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgGARFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbgGARFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:05:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FB9C08C5C1;
        Wed,  1 Jul 2020 10:05:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so23167200wme.5;
        Wed, 01 Jul 2020 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6x/eshQOaZbRwbvxCznlVv+GRJKSzuX5jSo3FaCtmSU=;
        b=bKulzeyyYunFIKmQMOT2guE7blzLGwaJ8xZl+1LMJz0phsVMJhCFr+Klw58atX7WYl
         zIGwQ6MHSTvERrEQFMR/jT/Foaa6ApGYo+Q7SyK7ZH3dEZqQ6wO7QNbKowaoYJ2SeOgj
         QYtPEL7XnXTfRzZ1cwpCd5qdOwrmmWBvUE0BszIHfIQqfM/wVPJqNC5B2dvzVcX6Jb2x
         c4ymmKu1IEpaAtKJGMXncWtGOsnmQRKLH0Qypk6/tfXcvJMvBnl9wJ6QyekHVxV1YnMI
         rtXagRsR3yFqCakOzeHczcbUMfIXrTs5j2imhlgps+oKSb7WRjdWa+ejxQbA9KipgtxJ
         nHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x/eshQOaZbRwbvxCznlVv+GRJKSzuX5jSo3FaCtmSU=;
        b=VDMQX7kGH0PLHsn9nBN3tVTc+dDd8okVXzSA0R6fasihEuEURopsEF4PL0UOGszLuN
         WIYeZPbACZr/HWfIDpHA3KKe0A3Tv4+I2Htw7axhzVH4YcI5KvgSB3PAV7D+ylfvOVsl
         v9JQCXhiiFliCxNSvbGZ7ef/PoAr5QpIFZ2Qm+LWpgP+jVbUhSFzVRNxC5gIAI4XKt0H
         bTi5SWiCNeuBKY2zTYyu/s9IA2Xhpx/nW8NjNsnoiQDQtLZEmtYPK4OsxfMmvT2MgApP
         r5vZhAZ8bbosfQEancHrz4pr+P9sQqLzI5oVw/eu3JgvfZ2ZbpDLfOssRKhGQY0mQ9Vp
         wokA==
X-Gm-Message-State: AOAM530I5aHyiLusNo4LmdoEYcHIZXIrQqpDKxfzzQiQ/aOpCVjZ0oAd
        m93qkh6jAdSmTBbPUrR3bUWbeGhEJJ6LYpl9vr0=
X-Google-Smtp-Source: ABdhPJzxshgznKeS4OzcUe9yhgpPkkzhjMItFOKqHWiAf1fbcSA6G3c357AQw5Fllq4uBWnABuvA9/6nOcmnYDmGQ7Q=
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr26470612wmg.70.1593623134431;
 Wed, 01 Jul 2020 10:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200701145905.551367-1-colin.king@canonical.com>
In-Reply-To: <20200701145905.551367-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Jul 2020 13:05:23 -0400
Message-ID: <CADnq5_PFzyvzCSkj3wHEfyu+yGavbsXuMEsiz+UD5tDeNfavuw@mail.gmail.com>
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

On Wed, Jul 1, 2020 at 10:59 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
> index 1b3474aa380d..d0a23b72e604 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
> @@ -151,7 +151,8 @@ bool edp_receiver_ready_T9(struct dc_link *link)
>         unsigned int tries = 0;
>         unsigned char sinkstatus = 0;
>         unsigned char edpRev = 0;
> -       enum dc_status result = DC_OK;
> +       enum dc_status result;
> +
>         result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
>
>       /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
> @@ -177,7 +178,7 @@ bool edp_receiver_ready_T7(struct dc_link *link)
>  {
>         unsigned char sinkstatus = 0;
>         unsigned char edpRev = 0;
> -       enum dc_status result = DC_OK;
> +       enum dc_status result;
>
>         /* use absolute time stamp to constrain max T7*/
>         unsigned long long enter_timestamp = 0;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
