Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15336C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E789120707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGuzgciR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgHZNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgHZNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:45:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36495C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:45:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so1878426wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++y7/K31LPJngXEb//+paNGMvF79bvnqTxG0ZZl/pyQ=;
        b=HGuzgciRBqpk93tftVYp8/pBWAnJfTd05f9qK3uR5cedrE8qBeZeUKfSEBopDI/bkD
         jJKkw1KbGfmLS6eMSwn8soRusFl+v6czYv98W0Ac6ECtjnskM06BuG+216I+UXiXtNU5
         T0zajnuQOPLN6rub/ottCNDWzAHNI4ij/mLWAmprx2S+85WDSuQgaRraBPNdJR2bVtEF
         hriV2QK/gcK0aANLnSoi+J5WDdySEFXC/kyGGq1W3uEoHnRp4dp+rVORfMByABi/ldwN
         07rEoKOqiZ0HAnlveDS/DYiI6ukKAKfPzEHlwPMTz9zwVfhTzl4fgK5KczRbvpzpJH2l
         cFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++y7/K31LPJngXEb//+paNGMvF79bvnqTxG0ZZl/pyQ=;
        b=nMd4Yhz9ojdnuytOf/AGmquyLPN8jUtHDaACNj5kx4MGBT0OTE6akBlQn2awZZTWQn
         0F3yAjAvE0Pnui8WGHrb0l+tT6qgabnp3OgBv6TwyIZPbPzP5r2J4uiL5S1ZEXhvuvq5
         6thOpA54yXsRU3/63vWn5S1Q4+BdvxNXbeiUg8rhuUsbWCm5KJcLSxJcjK2c6NS90zHk
         q1MnJ8m+t8H+NTzqDmZnpPi8tYFTSobkDPIAvKhro0qMTllHZhKBSIawA6uGZ7j+86zj
         /gad3xTojh0rlHwzYcMqVcKJdumDB5/D9ioO7RWUn/z0ymKtKuHeEtaof7y4eB3M8l+r
         /Pnw==
X-Gm-Message-State: AOAM532W2e3+oGl/RxibA1jiCb1Yv7eJl69htv4rx6xiQUP7jUQIjEyz
        rk7Lael1S6S4lWIcmjYPfol5dcQWgwG2rNABhuI=
X-Google-Smtp-Source: ABdhPJyWLZf68RNxOWOSnhdQdEdsARIS1o2p7/AZSaEeiSmSPPJ3xUskhAhaxBnxVSxkyAMdrF4A8Zw/JIKcxfqlQNw=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr15374902wrt.362.1598449522813;
 Wed, 26 Aug 2020 06:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200826132501.11564-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200826132501.11564-1-dinghao.liu@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 Aug 2020 09:45:11 -0400
Message-ID: <CADnq5_NxEGXboksEV61XpixU+Vwj8q9A=cTvz_-BeapwN59+Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Stylon Wang <stylon.wang@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 26, 2020 at 9:37 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When amdgpu_display_modeset_create_props() fails, state and
> state->context should be freed to prevent memleak. It's the
> same when amdgpu_dm_audio_init() fails.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df9338257ae0..2476e40c67ef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2834,12 +2834,18 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>                                     &dm_atomic_state_funcs);
>
>         r = amdgpu_display_modeset_create_props(adev);
> -       if (r)
> +       if (r) {
> +               dc_release_state(state->context);
> +               kfree(state);
>                 return r;
> +       }
>
>         r = amdgpu_dm_audio_init(adev);
> -       if (r)
> +       if (r) {
> +               dc_release_state(state->context);
> +               kfree(state);
>                 return r;
> +       }
>
>         return 0;
>  }
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
