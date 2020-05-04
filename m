Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6031C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9463820658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvHUZNe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgEDUzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:55:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:55:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so78260wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D74sKgkjH8kEt1DBLxWzvZF+Obr5z/6LSX69jqkqQw8=;
        b=HvHUZNe65rDYdW4kKTWoeqknOC1SQWoSE8cIVsqrb86YZT6cata1M3ML3uHUNzbBKo
         X0DsxVHHB6e+2nV7y6OCfjmxdZGCoI0JP8mZpgg4q5Rh2wAjiKVoYi93uu+V+7GgefZX
         MtJEwSslqt6DWRLbeKOW54pHSHXY7qzbOUQP0Yg1Cbn/ITDWTS91tt2YmGZIfS+w1+DI
         /mO3lCOlfL5krGrqb1mCStLgIhz7KlrkVY9+z8jcR7ys/IIWbcxK3vFg3HDbiTdiZg4X
         YwcqHqylvpDWQRA3P3CK8c6i6rX9ZFGzSuSIkFzZSNEuXBnIyPZeEU2dFafZLrI5HKnp
         E57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D74sKgkjH8kEt1DBLxWzvZF+Obr5z/6LSX69jqkqQw8=;
        b=Gx5ZqQKUUtMzKWwyXl8mD1gm6PBKJwoFjwCYygWzYnSwfx0+wz7RxLkf7zWc5GWsNu
         3FX0DrxVxNRxc6R1YjhyMTlF6Zxdq7NTIoBZEuzas9Y059djvP4Is3c3XfAqkcHNZb8E
         dC91qc9lzgDrsKFFzX78ITj/bXs7a5bKMG3stz+rUGLxBbGr/1Jvkrsedjv692bPn2C4
         EhFm8y/c9Ld6joYvcIrhXWl/LzT55/KC9BKXE8E8FvvKHeDj9tAU3cdNdBkRBaW5BtKp
         Ymi2gt/57zvaF1B+cpD+Re7jhEoYTGeS5fn9kB/V2dZ1fFKeOwSFTT4RiHKqs8jvVK8t
         AgpA==
X-Gm-Message-State: AGi0Pub5zzOD0hsIK42Pz6HLu3hWjWMucKS3b56CF1fS9CO7aQCU0PZl
        cvzs7XWzwi4Ce3SEU1PLu7rzcyENP32dtcTs6GMvwQ==
X-Google-Smtp-Source: APiQypLEqt41go0K6FSI41aP25wXmLXUEZ/h96Kj/ynd2shsYPGH60k9MDypR3NiiQ0YH7znFbTDOvS5DtN4lfu61iE=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr16270788wma.70.1588625733293;
 Mon, 04 May 2020 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200504113213.40403-1-yanaijie@huawei.com>
In-Reply-To: <20200504113213.40403-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 May 2020 16:55:22 -0400
Message-ID: <CADnq5_Ogi0eYn-U_171Pi71EhVOm7_htoT7-ROaSWyOT8_FQWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused variable 'ret' in dm_suspend()
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

Applied.  Thanks!

Alex

On Mon, May 4, 2020 at 9:20 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1574:5-8: Unneeded
> variable: "ret". Return "0" on line 1586
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9c2a07626d2c..2b7588371170 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1571,7 +1571,6 @@ static int dm_suspend(void *handle)
>  {
>         struct amdgpu_device *adev = handle;
>         struct amdgpu_display_manager *dm = &adev->dm;
> -       int ret = 0;
>
>         WARN_ON(adev->dm.cached_state);
>         adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
> @@ -1583,7 +1582,7 @@ static int dm_suspend(void *handle)
>
>         dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>
> -       return ret;
> +       return 0;
>  }
>
>  static struct amdgpu_dm_connector *
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
