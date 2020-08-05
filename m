Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A0220842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob7LksjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHEUDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgHEUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:02:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25505C061575;
        Wed,  5 Aug 2020 13:02:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so7538410wmi.3;
        Wed, 05 Aug 2020 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqgHHRDh2vam44aFxeq1w53pSFB4MdPrZe7uyWVRU6U=;
        b=Ob7LksjGa0aZs2m01xbQZdVjIWBzhBxbIOyXY5wpaHYumy35R2/Jv8jZWVZ++3BKf2
         hbZouCFEhcSFaNgLZEmqKDJiNxTgD46KyhqMEqUalUOcuI/8iBBDsNAv1f9LSypu0+HV
         O5/kvAwENGSK9+4OBYUEi9pLhLYQ0QVhqVkttLF2wuXk3TwpFIuZ1RFcQmG2dmQChgMB
         qFhISD8aO0poYqPAWIRk5VRv6b66jvSXJ45koP/z4TFift2V9l8c+AVQB5+565M9vO28
         9y80Te71+/12ch6t06IdmFVUxwMpFcBb8lsDqFnnOvZ9bRjpwR4fZQ8009W3GfRiK/z6
         BHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqgHHRDh2vam44aFxeq1w53pSFB4MdPrZe7uyWVRU6U=;
        b=ldd+kUjCRuKEheUhAMmpJpks9VCS2xEnmXkdsA4tkEvgLg1f5EcwHiutoSmnPuCavi
         t+4EEW0JyDiI3bc9d2WEN6nhvfh6yV6Tp0c9OSR7Qtgd2sNCd7IedBV6ZZD/FDMUQ0xO
         nzbzTT0mLVB35V6Ya7nwQMQ++vgV+FYQ1s6OFI71SFdxByG0Hdd1d3UfDUX3QuwpRxe/
         SckRCVK8KAFvlm8LOSHpe55raG2gWeEwl4QjO/wUe8+Sd5gfK25i2LaQVEdiRkWuZW85
         68IE8GbfjWJLVFksS++Tj4C6bYZosxJhTjiYhexLzB2g4iB7ZQRQI4I5sdc+wBkRCA2R
         26PA==
X-Gm-Message-State: AOAM531fcoPiv4bXS8++tHRWgG+/txvbGwnl2MtRkJtt3KiJFKqPHfgj
        DL10T4+OBRQNH7LnyZ45QtVOSpbTFGSieQu+pVk=
X-Google-Smtp-Source: ABdhPJz8P1i0SoHVl3LdWEDNvULJHbQrR0s6lAMUuSfOi8apEVNdiVwkn2blV5Qoc4Yy6j5Bas5Un5bqPKqZ9LY5RrY=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr4648351wmh.39.1596657756225;
 Wed, 05 Aug 2020 13:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200805121527.19157-1-colin.king@canonical.com>
In-Reply-To: <20200805121527.19157-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 5 Aug 2020 16:02:25 -0400
Message-ID: <CADnq5_OCQGCEwXN8=74AJck=ctAhbRp_0Hvb1B1hyqA_+3N0ZQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake "paramter" -> "parameter"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
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

On Wed, Aug 5, 2020 at 8:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_warn message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b72aeeb0a226..16e23f053361 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1201,7 +1201,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>
>         if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>                 amdgpu_num_kcq = 8;
> -               dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid paramter provided by user\n");
> +               dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
>         }
>
>         return 0;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
