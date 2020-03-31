Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE6C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D242071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmopI/9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgCaOiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:38:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46541 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgCaOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:38:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so26213332wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JADBVi0J5qz93W24U2adaMbSQmHxVLtGj9kUvlZL2mw=;
        b=XmopI/9Zqw6A9PeSefGPxVNIf13LCLwxUSam19fXeD6vfy791BKxHimSDr32VJzf/8
         rKgighSLhiTQU1LCvs2ivINb6lMYeUcFcAxS2ynCRIpkG6svgzKb50yvqoDL/o4d6ooI
         y/5yE4Xc955YWoBlO7roQssDgYkuuHfEHz+6DtKQTD9rXkAnu3nUJNASV+a3Qdy9gil5
         XWBD2lPkz/6fhe8yQ5uWBSVzXYqFgZuQhvONxqSF1/oTqlWq++gZXoUP5jw8yqBaDIX+
         0vTQ4f9KXxNICfpP0ytUZ9wlg9iBXEfPa7ae7lTRW+92ZgeyJ/slLwmkmNLQJ4zwZY21
         6k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JADBVi0J5qz93W24U2adaMbSQmHxVLtGj9kUvlZL2mw=;
        b=aR1WaH9u1VUtTxOsGqrk3NWFZ0czLyVlreVlftuj2phnuKgq4arX9E/ShLNXFZFJ+X
         F1Lk/UmQjNkHPViMvdrHxUwPnx5SBNVOwbR/QS9jeeTGwGBsMPWLKrlYyH1an6YSHl7u
         v+q1RBdl/MituIOD4qZVLo6g17eb/up27V2GnnwLUSpqqgc7WVjn369PScU/ZD8liWtQ
         2XFzQ0E/EDTFPK7mOziaF0WIap9Nc7fTmW7UVH/lk3QwUHsUAJ9M5zXG8PvjtDVx9koe
         G3Dzz2LEp+WpWJlwjf0W/vvoLLlJsb5+k7l3zqiivufncggUe9i7PmiEf4FJmysCAp+R
         OS2Q==
X-Gm-Message-State: ANhLgQ0KL0F3xYjBrbZTsvT/Mr+IOm57LA/mKuVHRCVj7LNghGYepq1E
        sa9EOQfPXssrYQNmqk96sg9AgOUDLFvGzq3d1Mo=
X-Google-Smtp-Source: ADFU+vtePjXgkDVvMEpbaF955pZevqw5shIxAyv4Oc72hqk5QsXUDeMDs3KNVqrgcy6TGXOdcybhz8cwW/YAwLtQn34=
X-Received: by 2002:adf:f50d:: with SMTP id q13mr21374343wro.374.1585665479545;
 Tue, 31 Mar 2020 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200330221614.7661-1-natechancellor@gmail.com>
In-Reply-To: <20200330221614.7661-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Mar 2020 10:37:48 -0400
Message-ID: <CADnq5_NQKDHmaVsyEMFcwEcGbo9QCHoC5cZ_3DOO8wNY2e_LDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 64-bit division error on 32-bit
 platforms in mod_freesync_build_vrr_params
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 3:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building arm32 allyesconfig,
>
> ld.lld: error: undefined symbol: __aeabi_uldivmod
> >>> referenced by freesync.c
> >>>               gpu/drm/amd/display/modules/freesync/freesync.o:(mod_freesync_build_vrr_params) in archive drivers/built-in.a
> >>> did you mean: __aeabi_uidivmod
> >>> defined in: arch/arm/lib/lib.a(lib1funcs.o)
>
> Use div_u64 in the two locations that do 64-bit divisior, which both
> have a u64 dividend and u32 divisor.
>
> Fixes: 349a370781de ("drm/amd/display: LFC not working on 2.0x range monitors")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 8911f01671aa..c33454a9e0b4 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -761,10 +761,10 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
>
>         // If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
>         rounded_nominal_in_uhz =
> -                       ((nominal_field_rate_in_uhz + 50000) / 100000) * 100000;
> +                       div_u64(nominal_field_rate_in_uhz + 50000, 100000) * 100000;
>         if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
>                 in_config->max_refresh_in_uhz == rounded_nominal_in_uhz)
> -               min_refresh_in_uhz = nominal_field_rate_in_uhz / 2;
> +               min_refresh_in_uhz = div_u64(nominal_field_rate_in_uhz, 2);
>
>         if (!vrr_settings_require_update(core_freesync,
>                         in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
> --
> 2.26.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
