Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276EC2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2A206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mdyk4hId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgCaQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:00:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37240 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgCaQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:00:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id o3so13801291vsd.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GMoukOL0KHHE8wEvMLxzDD6OsKNGd37py8qqC7r4eI=;
        b=Mdyk4hIdWk9iaKwb4+KZqwkLAVAFtwZV/5MocNo0ZUVnr90atdWYJplVeGt1osWlMJ
         tsGG0jSCSuDfx6UCog8dLugU+8D/yjeNzKb4ikMbN1zz2tOBe/7yHSe5i4d0VKOn18dH
         u6KGIqmobDm7Jdik275lPhk3ZHks5e56i9mV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GMoukOL0KHHE8wEvMLxzDD6OsKNGd37py8qqC7r4eI=;
        b=TTSXuIm9ELOimzHH7kAFiq2zh/uzkCGB6Qq+kLQLYm9PBtX24AuGSfKgX9P7YYy9KG
         M5eFA0cndHccXQAlYxJVhBHokgQ+5DVEKubVRobzsHsJKpQL6nZmAv3TlguHW9iCV7iv
         Y3vqnZ5Sh8dD7JwpbNTgjClZRACsAraTakkTuJMZaUaW0dXk5JklNezPVJngGSqBaV/8
         ko4hOhb88AfQQXChDCSs2siFD+zrCRb3u26ve5HS006gWztF/bB+wTX8dpVIk1bkxGdi
         1T4ZlgUlNh95SzS/m80gb/4FrZHGcXLkhCGX8ELcHm4Nh/JEu04NolDv3h64PdCpm18z
         qLSQ==
X-Gm-Message-State: AGi0PuY8xW9K5OWiO9WGsod80h9ubv5Ml1A8aNOHjnd6ejczjr9yY+m1
        uSUjdjkaNGu0sTkgZR7G/Pi3IOyGWV8=
X-Google-Smtp-Source: APiQypJluOmGTnohHw8idtaCDxfkYBGczNxce5xoYsATDm56uRkF5W1Cjta1J9jSRCgChsgbV7DA6w==
X-Received: by 2002:a67:f846:: with SMTP id b6mr11331838vsp.130.1585670419314;
        Tue, 31 Mar 2020 09:00:19 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 123sm7000646vsz.33.2020.03.31.09.00.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 09:00:18 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id r47so7846497uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:00:18 -0700 (PDT)
X-Received: by 2002:ab0:7406:: with SMTP id r6mr3595683uap.22.1585670417847;
 Tue, 31 Mar 2020 09:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <1585663107-12406-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1585663107-12406-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 31 Mar 2020 09:00:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Up4y6GUkJc8NNJBdC28L+6LvUs7pCUg4pyMCgHMGEkug@mail.gmail.com>
Message-ID: <CAD=FV=Up4y6GUkJc8NNJBdC28L+6LvUs7pCUg4pyMCgHMGEkug@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: ensure device suspend happens during PM sleep
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 31, 2020 at 6:58 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> "The PM core always increments the runtime usage counter
> before calling the ->suspend() callback and decrements it
> after calling the ->resume() callback"
>
> DPU and DSI are managed as runtime devices. When
> suspend is triggered, PM core adds a refcount on all the
> devices and calls device suspend, since usage count is
> already incremented, runtime suspend was not getting called
> and it kept the clocks on which resulted in target not
> entering into XO shutdown.
>
> Add changes to force suspend on runtime devices during pm sleep.
>
> Changes in v1:
>  - Remove unnecessary checks in the function
>     _dpu_kms_disable_dpu (Rob Clark).
>
> Changes in v2:
>  - Avoid using suspend_late to reset the usagecount
>    as suspend_late might not be called during suspend
>    call failures (Doug).
>
> Changes in v3:
>  - Use force suspend instead of managing device usage_count
>    via runtime put and get API's to trigger callbacks (Doug).
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 ++
>  drivers/gpu/drm/msm/dsi/dsi.c           | 2 ++
>  drivers/gpu/drm/msm/msm_drv.c           | 4 ++++
>  3 files changed, 8 insertions(+)

This looks much saner to me.  Thanks!  I assume it still works fine
for you?  I'm still no expert on how all the pieces of DRM drivers
work together, but at least there's not a bunch of strange fiddling
with pm_runtime state and hopefully it will avoid weird corner
cases...


> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index ce19f1d..b886d9d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1123,6 +1123,8 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
>
>  static const struct dev_pm_ops dpu_pm_ops = {
>         SET_RUNTIME_PM_OPS(dpu_runtime_suspend, dpu_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>  };
>
>  static const struct of_device_id dpu_dt_match[] = {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 55ea4bc2..62704885 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -161,6 +161,8 @@ static int dsi_dev_remove(struct platform_device *pdev)
>
>  static const struct dev_pm_ops dsi_pm_ops = {
>         SET_RUNTIME_PM_OPS(msm_dsi_runtime_suspend, msm_dsi_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>  };
>
>  static struct platform_driver dsi_driver = {
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 7d985f8..2b8c99c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1051,6 +1051,8 @@ static int msm_pm_suspend(struct device *dev)
>                 return ret;
>         }
>
> +       pm_runtime_force_suspend(dev);

nit: check return value of pm_runtime_force_suspend()?


> +
>         return 0;
>  }
>
> @@ -1063,6 +1065,8 @@ static int msm_pm_resume(struct device *dev)
>         if (WARN_ON(!priv->pm_state))
>                 return -ENOENT;
>
> +       pm_runtime_force_resume(dev);

nit: check return value of pm_runtime_force_resume()?


-Doug
