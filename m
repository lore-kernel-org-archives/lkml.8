Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FAC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7862467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmMfzbSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA0UPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:15:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgA0UPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:15:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so13112233wro.2;
        Mon, 27 Jan 2020 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agHNCqMi2QnjkHYFDl9fzq4MYwJXHO3unwi3HdF8igA=;
        b=gmMfzbSlLI8I4dMWkE1xcW3fKrfjOA76rLQZmtKlKIY2pVegucYllK/T/qTuxjcCxe
         6WqR2yM8o5KMtlyIexeNoPLR1smpY3NaZiOWiRgTllZh/octMKu/pUouosJcxpBST/06
         TxFGjmZB8w12MmpUzmkunpeoTnl3gl5wU7GU7EqjjyXmj517dOtwWgvooRQ9z2G4V1Mp
         rxmvUbISmX0i+8Ahw5YQHh0fvaZxR/XXRTN8H2KL7IVYvirjnwAFWh6RogWJek3lQXL0
         6b/CUicdyOA7rVxspjR4fNrFYMWBjOk923KJffD/bbmW6LO9I9lKF7VRp6qkM8kf4mVA
         oD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agHNCqMi2QnjkHYFDl9fzq4MYwJXHO3unwi3HdF8igA=;
        b=OvWZnUZ5jGiDcJpGTNkT+0c7IrcdTvcS2TBXcm0pgB0JC/t1FQ+MiN/ABEAXx5qX5o
         FYaWpjDXVir0+//sN73b8iyg2WY9eCx9qQfLz5vY6x0RgwuQx155TB37Q98+MdDF7pO0
         rCT+cRdp9uWNXK7ZhxWuNGTld0ineUYQ9k1Un6ajBkz1xKKybbO/2mMQNyIYwRNKswW6
         w3GxKA9lwS3RzXN+x+z+Cg4NgJAJMAuMH13Ke/ZPoJ1rS0aE+htfcrnbYgWCU4ROOt4q
         Re5CC71QdExDMEViLeOYER7L1ZMKx97pNMvJ9+cSLJYo3qxr2C+zJu6KAR+QYZtxklX6
         C4GQ==
X-Gm-Message-State: APjAAAX2PR7CF4qEXj9WDcQcf4uge5Cv+lywELm/l9gROsCEvlC0hsfB
        Dqao7C5UlCib2f4hTgmy5qD2gsEO4qu1vdHrjbc=
X-Google-Smtp-Source: APXvYqyhY0W5KNwrFS0LgQjqbO91CASwWkBDEMItwLG4El9WqtCluD5nWBgT4qRjEx7Olrk/EeKveMwsWoz5c7yF45o=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr23523903wrt.362.1580156135555;
 Mon, 27 Jan 2020 12:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20200125202613.13448-1-colin.king@canonical.com>
In-Reply-To: <20200125202613.13448-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jan 2020 15:15:20 -0500
Message-ID: <CADnq5_Md7yW+QXhoLVT-HUvjap7YPYe4xp6gRAuBpt-9+EHVzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix spelling mistake "Attemp" -> "Attempt"
To:     Colin King <colin.king@canonical.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
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

On Sat, Jan 25, 2020 at 3:26 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several spelling mistakes in PP_ASSERT_WITH_CODE messages.
> Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c | 12 ++++++------
>  drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> index a3915bfcce81..275dbf65f1a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> @@ -128,20 +128,20 @@ int vega12_enable_smc_features(struct pp_hwmgr *hwmgr,
>         if (enable) {
>                 PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
>                                 return -EINVAL);
>                 PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
>                                 return -EINVAL);
>         } else {
>                 PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
>                                 return -EINVAL);
>                 PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
>                                 return -EINVAL);
>         }
>
> @@ -158,13 +158,13 @@ int vega12_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
>
>         PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
>                         PPSMC_MSG_GetEnabledSmuFeaturesLow) == 0,
> -                       "[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
> +                       "[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
>                         return -EINVAL);
>         smc_features_low = smu9_get_argument(hwmgr);
>
>         PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
>                         PPSMC_MSG_GetEnabledSmuFeaturesHigh) == 0,
> -                       "[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
> +                       "[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
>                         return -EINVAL);
>         smc_features_high = smu9_get_argument(hwmgr);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> index 0db57fb83d30..49e5ef3e3876 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> @@ -316,20 +316,20 @@ int vega20_enable_smc_features(struct pp_hwmgr *hwmgr,
>         if (enable) {
>                 PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low)) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
>                                 return ret);
>                 PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high)) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
>                                 return ret);
>         } else {
>                 PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low)) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
>                                 return ret);
>                 PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high)) == 0,
> -                               "[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
> +                               "[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
>                                 return ret);
>         }
>
> @@ -347,12 +347,12 @@ int vega20_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
>
>         PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
>                         PPSMC_MSG_GetEnabledSmuFeaturesLow)) == 0,
> -                       "[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
> +                       "[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
>                         return ret);
>         smc_features_low = vega20_get_argument(hwmgr);
>         PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
>                         PPSMC_MSG_GetEnabledSmuFeaturesHigh)) == 0,
> -                       "[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
> +                       "[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
>                         return ret);
>         smc_features_high = vega20_get_argument(hwmgr);
>
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
