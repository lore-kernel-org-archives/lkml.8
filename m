Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F8C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9F021775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tus7bxqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgD2PX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD2PX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:23:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E33C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:23:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so5192062wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ty18jkh7zkBHOD6czGW8SkI58aj/+4PBnyEc+GD/orI=;
        b=tus7bxqLbV6hNyOMoOR6rWwDXhsBMRK+6jioSAfK0KlwrSwSOr0fmUyBIRvGaBMJ3D
         J+JlxtgqA3bkzn5APaglpsmiIS6twFCJ3AGHR5NZDxsBKV4m7NcmKV4qvCZkCiCLHj0F
         wVoQWAC+k03amUFqge3cecu7wfI7kFyy9QCAe9F0i/n0P6dtZnLi+UdaSFW/3XXvzdXs
         TUbRmLQoCXCdOo1JndE/p4Fgcxzj2LoOcuMtDw1VvF15eL/AOqIuI98VYfVmRkbb39Db
         n62qJSCybrymus8vXGkZZxI/36eSFoxKIoJO96tDCyBieKuVk79quKpuUGc0iTWLojHU
         Mn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ty18jkh7zkBHOD6czGW8SkI58aj/+4PBnyEc+GD/orI=;
        b=ruvvcOFE9l0IOt7IWGZYYlIpdcZYCyFWhr8j/tQ3Sfo7j8eHKvteA+WitK4d0rxcpU
         Ye2s4rGa+0LMOGcIeIRPVTXzZp67TPgzMw0gaq7TYk6FI+ldM8L94BVXwkY6592S6gAW
         CWppUGdeOlymrDWaS3P3OItzkkhn/Nmi2Ala5KZ7k5cuEcQ0j1tIbB/Hj0h8QR1zIr/V
         YC7upzQspig0XM80bCi+G165NS3mzCLsN/zxbvoOhuqlIbz/YAkjKu8aSFygpXXA9emt
         MimUsft2EPOhIM5F0ahceUmlRsgBMwUO7Z3HD6iJ2Byz/J7E/1PjEVUTe/XS1hhnkOwT
         hX8g==
X-Gm-Message-State: AGi0PuYsqQdQKjofQs22udIBbRU1k1ERDE7H0HPjtEUvuxf9LMbbsTAl
        1/9vsbSgr3SpIyUPaQE/9CXLkTCcAtVpavF1jsr62g==
X-Google-Smtp-Source: APiQypIiNPHG4tyU4vIdIHmmJj7Iq3g5WXyRokunvJVlTuVMH/ieeXBCWNyF731wp2ksSFgu4BuTKHLynCFHmZpLiIs=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr3795755wma.70.1588173804710;
 Wed, 29 Apr 2020 08:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200428063101.25556-1-yanaijie@huawei.com>
In-Reply-To: <20200428063101.25556-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Apr 2020 11:23:13 -0400
Message-ID: <CADnq5_MR5ZmcGXi70KAoqpHthhzCsyJfH4ZaXvjVDO5z9CLD3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate assignment of
 dcn21_funcs members
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 8:46 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> exit_optimized_pwr_state: first occurrence line 86, second occurrence
> line 92
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> optimize_pwr_state: first occurrence line 85, second occurrence line 91
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_attribute: first occurrence line 71, second occurrence line
> 89
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_position: first occurrence line 70, second occurrence line 88
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_sdr_white_level: first occurrence line 72, second occurrence
> line 90
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> index 8410a6305a9a..fe64bcb49456 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> @@ -85,11 +85,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
>         .optimize_pwr_state = dcn21_optimize_pwr_state,
>         .exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
>         .get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
> -       .set_cursor_position = dcn10_set_cursor_position,
> -       .set_cursor_attribute = dcn10_set_cursor_attribute,
> -       .set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
> -       .optimize_pwr_state = dcn21_optimize_pwr_state,
> -       .exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
>         .power_down = dce110_power_down,
>  };
>
> --
> 2.21.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
