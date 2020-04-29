Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7630C83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE4208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/ulaxB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgD2PZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2PY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:24:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88690C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:24:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so2490411wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjOeTQqRQtIBclXH1kdBKnLsff8nhyMZrdrXsY6z7Es=;
        b=X/ulaxB/6Apyr7kAkKvHNrsDORGTl2+KD1I2EjtZJ6rcoKxavRh4Pz1v+jxDYkF3yM
         jbgwPsXVqxiayh1Zdsq31g2GAnoFH6jnKOEBK7lvwRAeP8OUXCmDvUWk3ZWERxNnHbSC
         uZOYe2iDreW/OmCT2Q7XvQFI3IoWyYE1c1HRINaPmkrgzhfSAogxikj0hb/4sUB+Lf9j
         B0SXycfl/w2vRPJoZzjV8eNzbiK3N5P7p7h3x6OBlrkHym0dX0yhy0Q8xcsuCCV3Dq1J
         inYJaAsxoQSeTYfTmsnWnstf8PMLxDRHx81dhHQ6pBG+C7MqBUelxrnePvpoBLbhC2vV
         b9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjOeTQqRQtIBclXH1kdBKnLsff8nhyMZrdrXsY6z7Es=;
        b=F0nFN+q3350AJexJKrp0YFA4jx4Rd/XuwQ6tUzcn49qiXgvi68tnQfueJrZf/Ykwq0
         AlvQkgucHMP6XIhRKr7XnW/Rb+9G84UwUHyMKfFLL7ztM/AIz4htEW3PzovQODWUZ5y6
         PwRcf0F7ZbcgehCQKVnynJDByNkOjWYediJ2IJ47Z6UEd2xNfx/xniyIS4LhIF05uQGp
         T3xcYfm4Lv17fzuo8jNwBt1XUhqjF1fi2sHD2/bqyfXroMT/pL4uP6RFgBwir2E1u4eJ
         VV9WtX+34Q1F2SNf/XVT3zuJkeR+W/XsCEo4qTKPe1oSqtSgABRivHnVwcMRv2kr2BYh
         9OFQ==
X-Gm-Message-State: AGi0PuZ24p5MYCVzTARFQhSuk7YPuOO8IoAkEzDNB8eV3E2E3dXOoRVI
        QE9vJjgeg7Tlth+EiJUxzQRL3UgAZU3NofVNF0c=
X-Google-Smtp-Source: APiQypIxiVdSfHPCe/FFEwwHjoIPW70Czk4NcFBf+IaZVL7iTbl6w4kP4EvAVlbgSK1GlUyyI2j8y5a2IELQqIg8LXI=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr3856407wmh.39.1588173897248;
 Wed, 29 Apr 2020 08:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200428063003.24687-1-yanaijie@huawei.com>
In-Reply-To: <20200428063003.24687-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Apr 2020 11:24:45 -0400
Message-ID: <CADnq5_MvXg0MbLbFVViCf78hyV+xjrnO9=GoSsc7-ScG_-u2ng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: remove duplicate assignment of
 smu10_hwmgr_funcs members
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
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

On Tue, Apr 28, 2020 at 8:47 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> The struct member 'asic_setup' was assigned twice, let's remove one:
>
> static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>         ......
>         .asic_setup = NULL,
>         ......
>         .asic_setup = smu10_setup_asic_task,
>         ......
> };
>
> This fixes the following coccicheck warning:
>
> drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1357:52-53:
> asic_setup: first occurrence line 1360, second occurrence line 1388
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 1cc30f750c26..4f8c1b85e688 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1357,7 +1357,6 @@ static int smu10_asic_reset(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE mod
>  static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>         .backend_init = smu10_hwmgr_backend_init,
>         .backend_fini = smu10_hwmgr_backend_fini,
> -       .asic_setup = NULL,
>         .apply_state_adjust_rules = smu10_apply_state_adjust_rules,
>         .force_dpm_level = smu10_dpm_force_dpm_level,
>         .get_power_state_size = smu10_get_power_state_size,
> --
> 2.21.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
