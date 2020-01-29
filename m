Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E07C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA03206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwMaTKzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA2Vph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:45:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42449 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgA2Vpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:45:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so475567pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nclDQAc57fGVBDFTZcvntg/YEiVwsYbbmEE1VCKKHLg=;
        b=ZwMaTKzujzRvsoOYh4RoVaxZqJcaDKslwpdjnDms9u/KmNgAXwun1IqcFfAiO+gq1i
         mX9dIMgPRPLi/SsGh4rboYXE+P83RWPLszMjStuactkkeBOxADTViB237qKrw+zH1LqX
         ZwMJmGfgoTt1OXiQeWv1VcSSYlMYwCe9Ds5Un6Bl1gJzcZtXxnSR6twaVUzw9PBYsjKR
         J0Ptii7KP0h/aELgFOoCRE2Q/JOsK/obCwC3hOMvL7yGNDRrJKqSN4V2JaTAENG4/XKM
         jCta6txXwdOK1SaPsone8HpNOVpOj3cEL9sOPK7fXVejm+MnK1sACZmkS7sIDqOAR3O5
         Ec5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nclDQAc57fGVBDFTZcvntg/YEiVwsYbbmEE1VCKKHLg=;
        b=XEbbD+uTD0FALVfBR6nPOU1Py9LQqJBdpNW1+ni49rDLm4/ptVXqey40/XES6z4sBv
         c+v25Rry6/dH5ZM2kGIY6lxuzq714Ad5G8dDP5OdR9LGh9O1GyuSlwfyRrCb+lvlpZlS
         1k2tTcyE3rbMkHbYDS54vHtG4mEjqIVvrHdGCnCnIaYQFOby/TPW63jmMi8JH5f7bFaS
         k+I/lgPmltMYV4WwHNtZDODKjJEa2Ekm5BadVa2RCnhG5iRDvztvZMC0HPYpx6zudZ85
         7rqo2Y7VcOXn5TGxPEDIh6zUVKBTkJbcmvE1keK7TBclAJabHzd9gT8Ylk3hrj8C5w1i
         dOiQ==
X-Gm-Message-State: APjAAAXKosYnf1D5ZwMWRePXbMp9SysF4On/ilLKIwM/3eEfGtcI8EWe
        Sig7tpxZ3+zmaN+gmyNye/eaAlDsVCcAouHhwftxLdER0M4=
X-Google-Smtp-Source: APXvYqzIW92YmXpOGHWgyhnVOCnqTnMqWsQFTenOWcSvmwUlWqxTwRcCT7ZYdui69Mp9XEVYFxK5oXQGEWYB53kahxk=
X-Received: by 2002:a62:38c9:: with SMTP id f192mr1625175pfa.165.1580334334643;
 Wed, 29 Jan 2020 13:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20200129201244.65261-1-john.stultz@linaro.org>
In-Reply-To: <20200129201244.65261-1-john.stultz@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Jan 2020 13:45:23 -0800
Message-ID: <CAKwvOd=EvaSJFcpjh6gSRMrb=D5hwJHNR3wz6uEg3fmqmoGqfg@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: Fix return type of dsi_mgr_connector_mode_valid
 for kCFI
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        freedreno@lists.freedesktop.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:12 PM John Stultz <john.stultz@linaro.org> wrote:
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

John, thanks for fixing this. Our inliner is a point of pride
(inlining indirect function calls; you're welcome). ;)
Indeed, the function pointer member `mode_valid` in `struct
drm_connector_helper_funcs` in
include/drm/drm_modeset_helper_vtables.h returns an `enum
drm_mode_status`.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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

-- 
Thanks,
~Nick Desaulniers
