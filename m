Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86158C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E0920781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHMmhLBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404544AbgFXPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:19:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B7DC061573;
        Wed, 24 Jun 2020 08:19:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v3so2703598wrc.1;
        Wed, 24 Jun 2020 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Py6R13MD/ALi+lmKz+0wD4Voo520rKERVOmYa94FmgM=;
        b=WHMmhLBrGsTKq8yguQB2bjx3E8JorBYdumZsxQYbxblYDAb8jiPDC9IByepKx+eccf
         A5h7Tlqxva0/EkSd32fHC2vvXjDnYlQw4RseSVvOxbp7Juf4pL7awzGRSAf9IzCzGIDM
         CPee79NMTwFDmyScJR/rHTnO+4ExhnAmEuTlQWu21xxH34an6xtftGYQLJGfuzsCr002
         MKZ21DNsuBIYBUKHkN0jphHx0ASZun96Ch6VbyQ109D59xnKGMvdJDqX8uVfq/OSqWcl
         S1rXrgUcmvjggtekDWmBBge8j7P7zTP1+3dUem26Xg5YY488gkAkSSBhNTni+U/DZFRv
         UWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Py6R13MD/ALi+lmKz+0wD4Voo520rKERVOmYa94FmgM=;
        b=lnpwesRw6+qt35dkSDM6+JWoUp0NTsm7OG3MzTHwg1SIh3yZwHqSlhb35ugdESwVSj
         Qq/HPDxBGvvgCyoGjxejuAtTbsrKm2szwyLCbpgfs8m2wtnapkGO2hHGnRnf3GcWWFPL
         kWR7ps9nnaU17qoXFAbAXx5lHPOsCAKDb07BGTLGUsnh2f0xNZQvUHsvBXnEz5pHORWq
         WNBYXpqltt6L3uj4V6+FcIia/+YZO4vsOc/ogm6+5qm7Nqjsv3pLbdojnKT8dDRaiEWb
         cD8KpSbveMoMvaRv32F2ZNnE+qtPaSdcoABZIUtXo/8eoFrMS+ww1ENYB9Ry+rJJo5ce
         yOaA==
X-Gm-Message-State: AOAM533R3BJiZJtVtsA8ccjYfvlw7RE3sMMOj22jAHn1k3jC6Cb7kBpV
        bNEBgSkgHyO2dboRljLcKKsvncH9f4xZSr3dgj0oIQ==
X-Google-Smtp-Source: ABdhPJzkiAB8rak7/EF7xQt5xkZIsOH0iRZ9o4lt3W5kLDwG6kLpL6P22IQui3lFLPjKWXPAPlyPVqKx8E1Jd9qgHCc=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr4633910wrw.374.1593011967560;
 Wed, 24 Jun 2020 08:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624120710.10957-1-colin.king@canonical.com>
In-Reply-To: <20200624120710.10957-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 Jun 2020 11:19:16 -0400
Message-ID: <CADnq5_NGQzU6rrrqO4iXTHPSxpAt-w0ayxfrS0jj3K8u38f3hg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix array out-of-bounds read and write issues
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

Applied.  Thanks!

Alex

On Wed, Jun 24, 2020 at 8:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an off-by-one bounds check on the index into arrays
> table->mc_reg_address and table->mc_reg_table_entry[k].mc_data[j] that
> can lead to reads and writes outside of arrays. Fix the bound checking
> off-by-one error.
>
> Addresses-Coverity: ("Out-of-bounds read/write")
> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index 134aa2b01f90..86ac032275bb 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -4351,7 +4351,7 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
>                                         table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
>                         }
>                         j++;
> -                       if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
> +                       if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
>                                 return -EINVAL;
>
>                         if (!pi->mem_gddr5) {
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
