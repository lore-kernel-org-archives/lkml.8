Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B100F20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tExXfijl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFOVw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFOVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:52:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EEEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:52:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q25so1099947wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMrmQR08NbuxMuMQ9XTt0aege9jgLzpM8HoXAcM2lr4=;
        b=tExXfijlyDzCgiPKBttpScZpH7EE0HQbvlprkUGn54gjurJarPMV0iKnTgho8tBucC
         nk+dgtb0H3n7ccO1adYneQODQn9PnSRoqgDVhPAffWjhSq3p+PeGnV42A6hU3HcjR7cw
         OCuZuQBKhZTKSRlocN73E1fSqeHc6W5WwGoEtWxsQUTIXGBLzpPOqiHkB9lQUo8kqKMI
         LdykCrm6aFJY7yehqk1cxFzlJ3R1GIRe8uqQi1r+WXlFRc1/F57y8KV90Ga6W+S11i7n
         7Kb5Hcw1py9IfXCwtjD/zPBchiFqChNmuTgbcLd/9kFHBg5CzWhpBMdLfH8UHGVpFLnv
         cEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMrmQR08NbuxMuMQ9XTt0aege9jgLzpM8HoXAcM2lr4=;
        b=FpcJOIZ7hcyXQEow93zr4kKgbUzJSqtZrK3wEaNDCchzWx154GVaP3cKMYiATE4EAE
         pmBmKjSG+LPOQ+M0VRyZv2JP9wEYjJeqqTPPlXRsJh54t+EQZqZAHOzOiMeUgem3IEON
         ihj7QYNrVBKt8566BqcLfINlixIE/thM6gUDPNs6nQFB6RL/BNCWibk++ILLteeUWjJe
         zw2tP3WFfyRdoZ7u5C4Rog77W4TaawLuPoqOEVC16PgZeHduyOhlEHSfv8pwBGvfRA9d
         2ECFdVnQSp+eU+8I66yaRX8GtO05NrJ0jCCDmJIbG7xvcHCmXYE50UkNgJAr/wxb1bXZ
         pfcQ==
X-Gm-Message-State: AOAM533EsQ3Qy/k3F0wI5Ch3OLbLUtnDmj0Cn4E7cYvtFDZaHxms4Y1Y
        AF84BpqLB82CTR3yfXeoaqov5ZBo2N7vTuCa0VY=
X-Google-Smtp-Source: ABdhPJwSxUGklIsrSu/SHjWDyPn/otPVKio1ZbHbv4bC0MTX+tgbgI1YdyYgobjmthIhIY4phxxYn+K1f0UdCUPIRMU=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr1309269wmy.79.1592257945080;
 Mon, 15 Jun 2020 14:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200614015539.123654-1-pakki001@umn.edu>
In-Reply-To: <20200614015539.123654-1-pakki001@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Jun 2020 17:52:14 -0400
Message-ID: <CADnq5_NK7YP-yfN1SWhXk0Kromxs46LbEtFSTfA94cbhvgUEGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix multiple reference count leak
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     wu000273@umn.edu, David Airlie <airlied@linux.ie>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:27 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, decrement the
> reference count before returning the error.

Is this required if pm_runtime_get_sync() fails?

Alex

>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index fe12d9d91d7a..e30834434442 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -879,8 +879,10 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> -               if (r < 0)
> +               if (r < 0) {
> +                       pm_runtime_put_autosuspend(connector->dev->dev);
>                         return connector_status_disconnected;
> +               }
>         }
>
>         if (encoder) {
> @@ -1025,8 +1027,10 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> -               if (r < 0)
> +               if (r < 0) {
> +                       pm_runtime_put_autosuspend(connector->dev->dev);
>                         return connector_status_disconnected;
> +               }
>         }
>
>         encoder = radeon_best_single_encoder(connector);
> @@ -1163,8 +1167,10 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> -               if (r < 0)
> +               if (r < 0) {
> +                       pm_runtime_put_autosuspend(connector->dev->dev);
>                         return connector_status_disconnected;
> +               }
>         }
>
>         encoder = radeon_best_single_encoder(connector);
> @@ -1247,8 +1253,10 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> -               if (r < 0)
> +               if (r < 0) {
> +                       pm_runtime_put_autosuspend(connector->dev->dev);
>                         return connector_status_disconnected;
> +               }
>         }
>
>         if (radeon_connector->detected_hpd_without_ddc) {
> @@ -1657,8 +1665,10 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
>
>         if (!drm_kms_helper_is_poll_worker()) {
>                 r = pm_runtime_get_sync(connector->dev->dev);
> -               if (r < 0)
> +               if (r < 0) {
> +                       pm_runtime_put_autosuspend(connector->dev->dev);
>                         return connector_status_disconnected;
> +               }
>         }
>
>         if (!force && radeon_check_hpd_status_unchanged(connector)) {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
