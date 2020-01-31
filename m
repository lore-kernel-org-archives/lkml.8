Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7233C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FA20663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYSfoyHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAaSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:08:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51836 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:08:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so8981063wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYOKSEFF1BtF9aJwHzx6v8WXqAWKyMBvX++xdlfE4d8=;
        b=iYSfoyHTsGlXKZ4IO0n64y0Xqn7f8PjxKdcCYPDJWYitw/g6eGxDn3V5rE/Xe8Ktla
         vYUmCX3I5mkCkzLmizMb67m/NdRR8sV/C9hZTZ0vHD/UfetrAh0lC3OGmXy2jUwobG9B
         Lw5eMdV0NCU7UAYlEhmwrE47UkhqC/PBGJkUSmJHsyJNkunH4eja/PlkCQccI8kaxO5q
         8HC+SngAl3zd2bWqaGlKv2k2h3/nFk7FO93xsxEdBhkDOth6tBP0ohNkeYK24ENkXBav
         8XTCNb/UW9j/06AdAD1hFtSfBACG9prcTAk/s3SkTNbNKV0fqlHKWLLJIL+JtGVL1wzH
         Dpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYOKSEFF1BtF9aJwHzx6v8WXqAWKyMBvX++xdlfE4d8=;
        b=sw9R8Y0CRtVUmiT4ETyK38gCZtAyhH04yKA1oM5IEcG7vT3Csuoi8g0RWvzpgc/+XT
         Yr1+pEzAlt1r9q+R3YhldW1SmjwH7ctavoixXagOO4OrTehnEArkFQfo5AD7Wzm+7RmU
         Dv09nyTmNt29K7l00tpmeAoaD1WN3o3Clr31Lvk+Cwhu/PjEjvxYOYwb37+gsd8rKyvs
         xUCi/fE1KR/P0UiVOw2gR0BwPOeuL1TPIR+ro0SK0qqSRG6mrLDdvkUDCPH4FY35H34+
         DfxmT6m0cZ8XUbNm55CkwTeTR4TwaItJ4lkgKAIFoeaZm+o/hne09T2SFHmAimjCuvCN
         ru3A==
X-Gm-Message-State: APjAAAVpYHasHQWi3Ii9ca9t7Z111jo3PyyP7eiaqwFoKKKzFDtEQThT
        WnehgGkljo5UhwDPeh2KctIKwcNBLdSqx12gAUHgPw==
X-Google-Smtp-Source: APXvYqyhZyRGCBxAeZg+IW09HBdaPjaVlM6D9DWfNiUlhVSeaPJsVbBU1kH/80Y6uYbH7F/mIN7daAvKakWdC3THYQg=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr13239142wml.88.1580494113721;
 Fri, 31 Jan 2020 10:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20200129201244.65261-1-john.stultz@linaro.org>
In-Reply-To: <20200129201244.65261-1-john.stultz@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 31 Jan 2020 23:37:57 +0530
Message-ID: <CAMi1Hd3bWmhSSrbYoM59LP5NuxJt2JWwiXBacOyNxpnx-73w_Q@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: Fix return type of dsi_mgr_connector_mode_valid
 for kCFI
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        freedreno@lists.freedesktop.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 at 01:42, John Stultz <john.stultz@linaro.org> wrote:
>
> I was hitting kCFI crashes when building with clang, and after
> some digging finally narrowed it down to the
> dsi_mgr_connector_mode_valid() function being implemented as
> returning an int, instead of an enum drm_mode_status.
>
> This patch fixes it, and appeases the opaque word of the kCFI
> gods (seriously, clang inlining everything makes the kCFI
> backtraces only really rough estimates of where things went
> wrong).
>
> Thanks as always to Sami for his help narrowing this down.
>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: freedreno@lists.freedesktop.org
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Cc: stable@vger.kernel.org # v4.4+

> ---
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 271aa7bbca925..355a60b4a536f 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -336,7 +336,7 @@ static int dsi_mgr_connector_get_modes(struct drm_connector *connector)
>         return num;
>  }
>
> -static int dsi_mgr_connector_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status dsi_mgr_connector_mode_valid(struct drm_connector *connector,
>                                 struct drm_display_mode *mode)
>  {
>         int id = dsi_mgr_connector_get_id(connector);
> --
> 2.17.1
>
