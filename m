Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C9C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57592206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX/nnTzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgCLOKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:10:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41875 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:10:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14so7669459wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ew4nctO4indXSHhLzfgYmvH3/95PcDt5dya905io4s=;
        b=sX/nnTzF3WpKLW62aZlNhg/tTlQc74J7QTe1pBr91d8+JK2+VEiYuqwttW48ushB4x
         i3KDywYEXlpUVblBDddQq9yAhpfBBfUBL2gFgMksYr9BFi0NRWSEfBLfg1jZbBrXegBH
         hiR5L63dnbJuHzhV5khA5kWHnb6YFMboh134KqQmjWahLl88dQ061x4subDiaAU/iLMK
         lSEl6pYsL1shARFfb7TwcRm8bqMgXOSyKPbmBUJtI5Nsoq9uq2US5HIFzpIa3VxPOBbB
         n+Y8sFibTJ+s1gY8tMX6ufWMSjxFw7aow0lwiXR3841o2GcXk5J9eG6VTkAYL0sJo8Yt
         rudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ew4nctO4indXSHhLzfgYmvH3/95PcDt5dya905io4s=;
        b=BLsXuiZFX3IgtS0//AijjMWifEFp+AXPb1veE3JXndvUTqPiyyCuHcWyDJmKDIDaiN
         zF8Y33+wPuw17Dy6/rqkfP6FysY1t9h1ry+c+EwwHgkUjsb5HFXt0/K05CMqONj/wtT9
         oZtevdEBfz8zBamJCLIfh4Ig/znJFkXRlwCmTx99yZOO7sI5GqbMF27GIJ+Or7fBqVDM
         MkCb8QtyIDv89y7j7+W0448AVeDUYVTt8IE8LuBHrLTtuNiaG0IkWbkhnuawdgcIAWuh
         IkSbeUXyhRqaYb4OIVB8gUUe5lZ65dUC+zzY0DTM4/XU/gvyXAyFOEhhAAUrpYZwHSmR
         YG9g==
X-Gm-Message-State: ANhLgQ0pq7ahb6fD6LiDZ09J6EKpDjxqnwwWHtxlg9Vtu3Ix7uuvQAym
        h7vYhx0xPjFfugwUGxcowKxPbXfZhg+0TB6iecs=
X-Google-Smtp-Source: ADFU+vu2HXAwbqlqKOCUAswlE7mxU7DuLJWJDNNP8K82VB8pUBhvZNzs6p6b0qoJdIatEFawHfMSI05gTzYSHQzNFMU=
X-Received: by 2002:adf:c5c8:: with SMTP id v8mr6917160wrg.111.1584022239536;
 Thu, 12 Mar 2020 07:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <c9f6b726f857935502a4bfb026e27d9e6e5f7e72.1583896349.git.joe@perches.com>
In-Reply-To: <c9f6b726f857935502a4bfb026e27d9e6e5f7e72.1583896349.git.joe@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:10:28 -0400
Message-ID: <CADnq5_MistiCrp=jRXqpuu03zTYb+Av8EFq2Dkwjvo5_+PrK0w@mail.gmail.com>
Subject: Re: [PATCH -next 025/491] AMD POWERPLAY: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index bf04cf..fc5236c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1250,7 +1250,7 @@ static void smu7_set_dpm_event_sources(struct pp_hwmgr *hwmgr, uint32_t sources)
>         switch (sources) {
>         default:
>                 pr_err("Unknown throttling event sources.");
> -               /* fall through */
> +               fallthrough;
>         case 0:
>                 protection = false;
>                 /* src is unused */
> @@ -3698,12 +3698,12 @@ static int smu7_request_link_speed_change_before_state_change(
>                         data->force_pcie_gen = PP_PCIEGen2;
>                         if (current_link_speed == PP_PCIEGen2)
>                                 break;
> -                       /* fall through */
> +                       fallthrough;
>                 case PP_PCIEGen2:
>                         if (0 == amdgpu_acpi_pcie_performance_request(hwmgr->adev, PCIE_PERF_REQ_GEN2, false))
>                                 break;
>  #endif
> -                       /* fall through */
> +                       fallthrough;
>                 default:
>                         data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
>                         break;
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
