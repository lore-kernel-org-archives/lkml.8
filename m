Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB850208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsbFOKk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHTSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHTSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:14:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0CC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:14:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so2995974wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CM6owDx/tmtrYOZ28Ao2iCnLC9HCs4xM2EFVOquoNs=;
        b=hsbFOKk4Ojo8tb5Z9o0XzLjGhSjFkb8Ca+4pH8WZu7IiC65gdRhgjsegBsNKrWaBQ1
         8uZ3xpPOaN0KmHAizi5xPWAiXBuY3l4eDnUEwg0iC06FrWTlnbR7u47J7lR0tfna1ENW
         ovE9cZDkHQYIsnLTyZUJ2K3/T3r5/lv0s8tsHaMgZinlWLjos3jZzD0uNg/dhHeGk4Hx
         mUgdD/Di8ckbDTFVp1YYtWC5rqsXAczojlgD5bWr0c7KNWJ6HD/vKxsOVOxz+/fDl71C
         Pq8KtjGij8g+uJ5Qtp9m2BXaQS9uSYWnadE6cghBkgm3kiKQ/cfgYBJ+nsq046Rqknx2
         nViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CM6owDx/tmtrYOZ28Ao2iCnLC9HCs4xM2EFVOquoNs=;
        b=Sz0yKxVxY0ggp0gzyNhcZYxP6H0Dt2xSBRCO7iqJIJAqjGLIP/esG9WnH9Y3NCb1dT
         +q3XhxFp/ZX1zh0DWAsev9HpXx2nRpa2i7EcyblTWOmhZs6QGMzcizS1sfPHe94OJy2O
         uoSADPA5FvJVxecJsJzRwcdQscLMGcArSdfM7E1jtJ3CYXGzIYIAcD9/zUrLligDAi8W
         smRlN1bPWQ3QN0LWWlds6vPaLW0ewNN3Twh7VrYit/h/ix7EteDexxDasjBb1nofKSEw
         lEmhr8NFZOg6mCE9Z+FTWtHFtOsp6KMm9RO38FEpqwHuojzt5fsrDRzyXa1jVkabQM3e
         7MNg==
X-Gm-Message-State: AOAM532V/+mOK9JNry3t9hKkt49PlebYj3nh2vf+XR/l2TEzj6E0teoS
        Bwjx7y/KH92meFx04C7s484/nXgD445/tmlKkaQ=
X-Google-Smtp-Source: ABdhPJxmJr4GSrlkMn4AAOlyfuTX3rqD/eWrX9bwE1mSbI0EH3yQo0Xdtq5w7tqzm8/yzqY0CdZHlJZP+IceFRRwbQM=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr4563077wrs.419.1597947280424;
 Thu, 20 Aug 2020 11:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200820175809.841479-1-alex.dewar90@gmail.com>
In-Reply-To: <20200820175809.841479-1-alex.dewar90@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Aug 2020 14:14:29 -0400
Message-ID: <CADnq5_M5N5TaMBxxOOkuUVyxPwwYn_opSBGFKiCoNmzv+RR70g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Remove unnecessary cast
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
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

On Thu, Aug 20, 2020 at 1:59 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> In init_powerplay_table_information() the value returned from kmalloc()
> is cast unnecessarily. Remove cast.
>
> Issue identified with Coccinelle.
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> index 195d8539fbb4..740e2fc7a034 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> @@ -252,7 +252,7 @@ static int init_powerplay_table_information(
>         phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
>         phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
>
> -       pptable_information->smc_pptable = (PPTable_t *)kmalloc(sizeof(PPTable_t), GFP_KERNEL);
> +       pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
