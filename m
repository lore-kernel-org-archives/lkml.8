Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E400C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2302E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s40JiM4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgG2WAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:00:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48427C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:00:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so4411701wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qI9wSg2asXOQShlsyDaWSUNkhHbRsckiehfdXNqAvjs=;
        b=s40JiM4PNMIQ3UMvDc9YaIViGY5tOJcYGc+8Xwzxz90Bi+5k5TEsMXRH0TIk+FoihL
         SLwtXNJmL2FxIVPXFnmFBxhaBDb78/Ojaavp7t5t5viVYOy6rf6FiAXFB4626ZgqT0+J
         QlxSky5YFXC+fkgVkNDMuNjFTGM7xskQfoBT2mj288QBz5a5aDXPmNkt1iaoAZjxvoXW
         ajrKTzDhDRsVv2KG+oAhZcbupRk54a5wtz4DmOhj6GdgOxJjVJfnDObWcYZecYrkFKdm
         SMBjVzwBmrPq8b4n9LEyNnmAuYkjTjsbNKn92cO4ps6HU1OdDTI0ujJPTNvLi4BqWX1C
         /wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qI9wSg2asXOQShlsyDaWSUNkhHbRsckiehfdXNqAvjs=;
        b=sHCdcaf2tMm8TNUk8ZTmSarlB0s3ITUzCOoGOhIpmdPa7mJffb7DqsuCY0mM5ekvUe
         S6dTgx4ik4/RW1v7yyQPIJMWKVljJclkDeHU2Nw6AKjTLdXLjVWJkkb/i9jvRezTBA7n
         uZYtOU17zLn0Pfn+BrXlZpNBoLff0r3/32WVS2CuIIL+yxzFAEy1w0PhLd9FQ1YRa9V9
         K/10pEdVXONPm6SSh4fVuxvrF32GC6V6cEx/DOOI/DLIPCcZECmXKtw6OZaq1P19eYp6
         KOmKPaBiQ6dt6pg16RWXH7A5xwkCP8wziC7fWeDRmbE/T5mu8DUvEq9wAMzBwpplTEgW
         DQSw==
X-Gm-Message-State: AOAM532pIiZ7c1HpRMhL1S+BqunKMqZ0Ee0mMfNFlKV8kYnOaKvA2Qjb
        d/D59CVGQdJqQoMjpKvsVKurWQ00f5TgC+WV8Kk=
X-Google-Smtp-Source: ABdhPJwEvMI7MQ5NEzBqAR8lfhwJBcIJvQe1V7YS+Wrq1KVyRTHsjdl1/t7122nOVAY8jH3mBHGBexurk/WDw9IkX6E=
X-Received: by 2002:a1c:2:: with SMTP id 2mr10810523wma.79.1596060014118; Wed,
 29 Jul 2020 15:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <1596011641-9136-1-git-send-email-liheng40@huawei.com>
In-Reply-To: <1596011641-9136-1-git-send-email-liheng40@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Jul 2020 18:00:03 -0400
Message-ID: <CADnq5_P7VBe5e1U_e=bfbnhNZg+6matA8urRKUx77bTUPCp+qw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: Remove unneeded cast from memory allocation
To:     Li Heng <liheng40@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Jul 29, 2020 at 9:11 AM Li Heng <liheng40@huawei.com> wrote:
>
> Remove casting the values returned by memory allocation function.
>
> Coccinelle emits WARNING:
>
> ./drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c:893:37-46: WARNING: casting value returned by memory allocation function to (PPTable_t *) is useless.
>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> index 7a7f15d..f56a3cb 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> @@ -890,7 +890,7 @@ static int init_powerplay_table_information(
>                                 power_saving_clock_count);
>         }
>
> -       pptable_information->smc_pptable = (PPTable_t *)kmalloc(sizeof(PPTable_t), GFP_KERNEL);
> +       pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
