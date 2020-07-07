Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B43C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA8E2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMBw7q2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGGPMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:12:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:12:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so45532953wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gOopT7I1OsIRVZ7gP8eL3IBFb1IUCjqvEssUF76BG4=;
        b=pMBw7q2CFOQfGmvkpqC/zFRqxOWQ1b7p2+cEAWcF3mCdub5F2Ib4bRWeyCUg8D9e/p
         OGctjFDilSnopnt9CwMBPoMjshPumFWLq+24vUZa/F+8z0eQcB5V125GtWHS7J8FCBAi
         olXgEecpuFIpgRHSivW/kY39xGYXlGu1D5YAZkaMvByYxB0WBPXJX21Iay/n/zfvv5B1
         XGan0uHFhRQj6e7e1PtHNfloLwBgxjg7XKveppNjrMStBeWdP3RUa9AbGRv90xmUTNf+
         daK4lBDjMHXd+pKrdwj5T7auAYljz+YtqyjZCcarbyAW5kreekC8mDfKzY3A4oDORsMc
         MWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gOopT7I1OsIRVZ7gP8eL3IBFb1IUCjqvEssUF76BG4=;
        b=GtaKHqm94qai8bJXDEn/BxtdoBd6CLIqmKyflWoqBiCWSahR7zlOKiyNkevYK6EQUA
         GHRZrI562ts3I5Djt6w6h8vu9ot7QYRsABy1Kr3Dir9Z/xu/eAFlJGzKJRqGn5ndXqkA
         etCC+7mmeZ3yCUYRAdCEGBXrnnI5O7wpQuqFN3wYargGvFJ+hbDSvawPQUvJUS3Xtf5O
         53vYirYmXdfrNvtV6MGNBMUe9PGVeRctgxKOF91TCtMSMalMRSdJs887GFqJfBlIA97f
         oruHC+pAfnGMGp6oK2YsjvVUjXDOhQ6J+hP53ODw0N8HRSmsvPfs9f2gwuu9MSbPtyCv
         zfIg==
X-Gm-Message-State: AOAM531ldma/pqIBEFxrEQjTwGMk01iwZwcDV04ALeSrkfTOdIfjn3r8
        AuyXhbuScufi+dzw3MpNJU/iJDG7gRNIxZkrXid3Ng==
X-Google-Smtp-Source: ABdhPJzyL7Ci3JIid8hEd7ueUZ+ZnZ09+gKP6KqRip8QlXnvviomlhUgfqgfQEoWKehK4g+kzJ1CJo+batzFSMZXVBI=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr53383056wrl.362.1594134735494;
 Tue, 07 Jul 2020 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200706122857.27661-1-trix@redhat.com>
In-Reply-To: <20200706122857.27661-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Jul 2020 11:12:04 -0400
Message-ID: <CADnq5_PZEg=tW1Nku_=g4FDbL2qXBf=xz9JuFik0fAR3_SSffQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix double free
To:     trix@redhat.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 6, 2020 at 8:29 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis flags this error
>
> drivers/gpu/drm/radeon/ci_dpm.c:5652:9: warning: Use of memory after it is freed [unix.Malloc]
>                 kfree(rdev->pm.dpm.ps[i].ps_priv);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/radeon/ci_dpm.c:5654:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(rdev->pm.dpm.ps);
>         ^~~~~~~~~~~~~~~~~~~~~~
>
> problem is reported in ci_dpm_fini, with these code blocks.
>
>         for (i = 0; i < rdev->pm.dpm.num_ps; i++) {
>                 kfree(rdev->pm.dpm.ps[i].ps_priv);
>         }
>         kfree(rdev->pm.dpm.ps);
>
> The first free happens in ci_parse_power_table where it cleans up locally
> on a failure.  ci_dpm_fini also does a cleanup.
>
>         ret = ci_parse_power_table(rdev);
>         if (ret) {
>                 ci_dpm_fini(rdev);
>                 return ret;
>         }
>
> So remove the cleanup in ci_parse_power_table and
> move the num_ps calculation to inside the loop so ci_dpm_fini
> will know how many array elements to free.
>
> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index 86ac032275bb..ba20c6f03719 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -5563,6 +5563,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
>         if (!rdev->pm.dpm.ps)
>                 return -ENOMEM;
>         power_state_offset = (u8 *)state_array->states;
> +       rdev->pm.dpm.num_ps = 0;
>         for (i = 0; i < state_array->ucNumEntries; i++) {
>                 u8 *idx;
>                 power_state = (union pplib_power_state *)power_state_offset;
> @@ -5572,10 +5573,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
>                 if (!rdev->pm.power_state[i].clock_info)
>                         return -EINVAL;
>                 ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
> -               if (ps == NULL) {
> -                       kfree(rdev->pm.dpm.ps);
> +               if (ps == NULL)
>                         return -ENOMEM;
> -               }
>                 rdev->pm.dpm.ps[i].ps_priv = ps;
>                 ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
>                                               non_clock_info,
> @@ -5597,8 +5596,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
>                         k++;
>                 }
>                 power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
> +               rdev->pm.dpm.num_ps = i + 1;
>         }
> -       rdev->pm.dpm.num_ps = state_array->ucNumEntries;
>
>         /* fill in the vce power states */
>         for (i = 0; i < RADEON_MAX_VCE_LEVELS; i++) {
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
