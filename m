Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7EEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF1F2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpb0URCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgDHNn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:43:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40397 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgDHNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:43:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so5499163wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JeVxarE1Z1RiJROhmbNs4AI7L5YmBuO9l5ang6+c2c=;
        b=Lpb0URCll2uC4ADQJYY7mI50YUF0YKFj5Wty4cYMWCdeGVhx0fncfLWtomod/N9nPY
         F7HrkukZfy+0cuzfU1yzdg6gXZJGJiwbqWb2wZgIq2PKb/IEFLjIIHLYCjx4IQgUiiFv
         tThQFvsr9XYztxj0ojy5TkKXV4gAdTSDwMuo/RtBCqroxK3K1sdaqzWn26369aphBCID
         Q12SF0uW+aQh2s9rkMb5hrd6CUXdp72uGQULxsMa+vNe/aPCczKtclvPZVayDlWpX5BV
         3QjhurMMZIbBiiwBfZd2QkytcEt1327ymh4+gbsbeEuBUGYMRCfhtYuX57h4ZWOOH4DM
         gCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JeVxarE1Z1RiJROhmbNs4AI7L5YmBuO9l5ang6+c2c=;
        b=aybSfo7GyVxtDux8vcFvSOc50KU7gPE1j4rLcjzBsxuYQZADo/N6ah1hR4NRSmaC1n
         Q5+ErveaDL5N3S6Tgl296c57FtHQ91E27dkAaBeSLvmP0UUSCCcQHXd6m2amNc30avoG
         RfSf10AjXCwzj+w3GR+xsVF3mrjjrt4b7lzLnha1KHi3XOtWCd6mCKVYg3ZiYhfHzxys
         M02Dpu6FW0HpbUzqm4uOm09qkGfM3XAGfP7OJmMGABEWDy8/Q7PZbjh5NfLnB3k34pFy
         n4DMqsAkqontxrwUdYwzAgQ2CTiW4uS67d+xWtPawdT7qfzQny4UCKEHqlNh4Enmu9+E
         ft6w==
X-Gm-Message-State: AGi0PuaGfBenBdR4KsL0iHjrbKw4tV6rVmiSG6ZelDXJYMx5L6UOS5Ob
        TjGrKhuzx2XhGXpu2HRVhpx5pF/PmJP8EBpRz2c=
X-Google-Smtp-Source: APiQypKVw6l28/vf8DOlr+wvkyILlmlKHHNxDPwytq39w6kUSGnC9oKbQ4hvvCKuyfTXtGZzV1ALzsk2hRmrkhxMRGY=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4851682wme.79.1586353435428;
 Wed, 08 Apr 2020 06:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182618.2488-1-mail@aurabindo.in>
In-Reply-To: <20200407182618.2488-1-mail@aurabindo.in>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Apr 2020 09:43:44 -0400
Message-ID: <CADnq5_OCkhjVoJ8L-KHOo-2b-thAAcSCHoeJc-DsR7j-8ZX7Yw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu_kms: Remove unnecessary condition check
To:     Aurabindo Pillai <mail@aurabindo.in>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 2:30 PM Aurabindo Pillai <mail@aurabindo.in> wrote:
>
> Execution will only reach here if the asserted condition is true.
> Hence there is no need for the additional check.
>
> Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 60591dbc2..9fedfa531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -179,12 +179,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>         /* Call ACPI methods: require modeset init
>          * but failure is not fatal
>          */
> -       if (!r) {
> -               acpi_status = amdgpu_acpi_init(adev);
> -               if (acpi_status)
> -                       dev_dbg(&dev->pdev->dev,
> -                               "Error during ACPI methods call\n");
> -       }
> +
> +       acpi_status = amdgpu_acpi_init(adev);
> +       if (acpi_status)
> +               dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
>
>         if (adev->runpm) {
>                 dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
