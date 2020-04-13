Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2333DC2BB55
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0D320678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7Mar2Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgDMBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgDMBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 21:39:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB129C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 18:39:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so770759wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyN/h3gL1049cpXdFDaYnbMCFESReQmxEl5EsV/QxIE=;
        b=Y7Mar2Y92zLTJMkiLnBFdWA9rU3I5813JGr8i83ybHOb4pP4+PNGPokjnSgfEz5+/R
         8MYnyp1ecfae0+5tamHFcQGnTCpFsdezVxDuM960nkfph2/lvEzASa3DRjIqMz3nLYGL
         7TIppEfABo7f5zHm72kV4gTc+G+HxCNjikMKAI5JTNPKk5CJgFl6YPXrquwnts4cP4Iz
         PMzvPU6Ys1AJPKuMrgMv9bnvYJCvXK5hiP6ZDoGBuaDhEznwe47IQkcPGH2ddDQBGjSf
         /YfXgcTJe73wOdYVBXUZDqpj77riDNgoT8RgB+6fB6wl1EjgeMz1oqF+PTya2BMyaKVr
         sVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyN/h3gL1049cpXdFDaYnbMCFESReQmxEl5EsV/QxIE=;
        b=bF55oD6TeYrp3UtjVHoF0/RyMlkrtvM9m/zuxPKOX81zPSgY9I+E7T+Wwsn/o69Axp
         F2ig4qplnOR27bNZfpx1HuWhxoITK8YZHasyzGf88DlpVhdlfE3M/XZErQ00W8JOBTn6
         +f8FO29VtT+LxzXIQbDas9Kr7Uwm6YeAEOJ0R0w73MathhekHTGMWZWNISCAKvw6B0XI
         eTDPYRPEx2ukwJzTQxPoxtQsXZH6X+sLoK7HjvPNXo39+7aTIaHwGl0n7W6EaXom4yw9
         VfiQXP8SkB+1ejwT8ikuUzoHzRooK1WCZinOcW/KxiszFl+rE3GUbfGctgHl+4gjzhkr
         lIHA==
X-Gm-Message-State: AGi0PuYlbrbhZ7gOKG2kSkWHrOHzOEw6BoSSCNQBOEaMcRhGWNOGvDu4
        RLJv2k9nMpZ/5Co7W04S6feGOA+5Zc2UgZibwXujSA==
X-Google-Smtp-Source: APiQypJGmt365lwnDZunq5BXifhgZnKlqlq44CQy7pdjPF0L6QT7kprUreBXQsd9BlOpcEgNXG8x1dTxwAnCXi37pUQ=
X-Received: by 2002:a1c:7212:: with SMTP id n18mr17213521wmc.53.1586741997265;
 Sun, 12 Apr 2020 18:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200409004306.18541-1-john.stultz@linaro.org>
In-Reply-To: <20200409004306.18541-1-john.stultz@linaro.org>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Mon, 13 Apr 2020 09:39:45 +0800
Message-ID: <CAKoKPbzCiEJRoFWMMNx+O261G6=-6Dc90qbPhNQ=M-y67LXOMg@mail.gmail.com>
Subject: Re: [PATCH] drm: kirin: Revert change to add register connect helper functions
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 at 08:43, John Stultz <john.stultz@linaro.org> wrote:
>
> Daniel noted[1] that commit d606dc9a6323 ("drm: kirin: Add
> register connect helper functions in drm init") was unnecessary
> and incorrect, as drm_dev_register does register connectors for
> us.
>
> Thus, this patch reverts the change as suggested by Daniel.
>
> [1]: https://lore.kernel.org/lkml/CAKMK7uHr5U-pPsxdQ4MpfK5v8iLjphDFug_3VTiUAf06nhS=yQ@mail.gmail.com/
>
> Cc: Xu YiPing <xuyiping@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Thanks John for the fix.
Acked-by: Xinliang Liu <xinliang.liu@linaro.org>
Applied to drm-misc.

-Xinliang

> ---
>  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 -
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 -------------------
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 -
>  3 files changed, 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 86000127d4ee..c339e632522a 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -940,7 +940,6 @@ static struct drm_driver ade_driver = {
>  };
>
>  struct kirin_drm_data ade_driver_data = {
> -       .register_connects = false,
>         .num_planes = ADE_CH_NUM,
>         .prim_plane = ADE_CH1,
>         .channel_formats = channel_formats,
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index d3145ae877d7..4349da3e2379 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -219,40 +219,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
>         return 0;
>  }
>
> -static int kirin_drm_connectors_register(struct drm_device *dev)
> -{
> -       struct drm_connector *connector;
> -       struct drm_connector *failed_connector;
> -       struct drm_connector_list_iter conn_iter;
> -       int ret;
> -
> -       mutex_lock(&dev->mode_config.mutex);
> -       drm_connector_list_iter_begin(dev, &conn_iter);
> -       drm_for_each_connector_iter(connector, &conn_iter) {
> -               ret = drm_connector_register(connector);
> -               if (ret) {
> -                       failed_connector = connector;
> -                       goto err;
> -               }
> -       }
> -       drm_connector_list_iter_end(&conn_iter);
> -       mutex_unlock(&dev->mode_config.mutex);
> -
> -       return 0;
> -
> -err:
> -       drm_connector_list_iter_begin(dev, &conn_iter);
> -       drm_for_each_connector_iter(connector, &conn_iter) {
> -               if (failed_connector == connector)
> -                       break;
> -               drm_connector_unregister(connector);
> -       }
> -       drm_connector_list_iter_end(&conn_iter);
> -       mutex_unlock(&dev->mode_config.mutex);
> -
> -       return ret;
> -}
> -
>  static int kirin_drm_bind(struct device *dev)
>  {
>         struct kirin_drm_data *driver_data;
> @@ -279,17 +245,8 @@ static int kirin_drm_bind(struct device *dev)
>
>         drm_fbdev_generic_setup(drm_dev, 32);
>
> -       /* connectors should be registered after drm device register */
> -       if (driver_data->register_connects) {
> -               ret = kirin_drm_connectors_register(drm_dev);
> -               if (ret)
> -                       goto err_drm_dev_unregister;
> -       }
> -
>         return 0;
>
> -err_drm_dev_unregister:
> -       drm_dev_unregister(drm_dev);
>  err_kms_cleanup:
>         kirin_drm_kms_cleanup(drm_dev);
>  err_drm_dev_put:
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> index 4d5c05a24065..dee8ec2f7f2e 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> @@ -37,7 +37,6 @@ struct kirin_drm_data {
>         u32 channel_formats_cnt;
>         int config_max_width;
>         int config_max_height;
> -       bool register_connects;
>         u32 num_planes;
>         u32 prim_plane;
>
> --
> 2.17.1
>
