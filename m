Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8DEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396820787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we5VT1tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbgDCCAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 22:00:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33666 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389507AbgDCCAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 22:00:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so6725499wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXBmPI1aMBP86rFq67gcQrBQ0rMBGLe0pgjXqjE6OXg=;
        b=we5VT1tIaUauueTImm6VHNLLfFfkERkS+qqB5I25fA1/vaM4+IgSg5UQaU5G1vGJBQ
         ZlsjJbcJ47yqWyqfDwAh16Ut3J/+m1JDN1spRFmk2bdi8/58Y7GcgseoMV81RiQ5zN1P
         ncJVoY5weEO3ypUFN8zZY3/NmO2qfEOctfRxSWTBPntCQG17sDsHfCvEDcreLYUVK0EN
         osYpYl+eIIbJ1zoUiSDtEsc5b9F9MzsNMetN+j0HtSrpgmPSgsCtAvvwovDWgrt0xf0r
         u3ylqWoVNVVNEIsAFAB13uHetGhVjlKZ3Aox3ZZX4ZQiPPPAv8FajG1SfTHVYegjbwQT
         5OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXBmPI1aMBP86rFq67gcQrBQ0rMBGLe0pgjXqjE6OXg=;
        b=Y06qoZ1tLxVCwWL3GZq9i0L/YAu9CKh3c3eWK+o4WdAZuh6lNRr+noMqb/jG4gUjwU
         a2gDQe0ZZ0lazHAj2iHvPLQGFe1t0N/SymoBS9rGPoNdmBlmxMTQpD4VQl4bGsafLPgL
         I+4MEpCNONrbjaoFgJKxAQhtTb3MDuMdnbR51ncVDVCj73h/ZX3LAdwzVohrZCD8RYCH
         YbxxTMg7TD0Pn93K9eLYNsBQ/dvrm6sUjH0Ngz5Pao7Gb/fUL9/AKSm7bWObCOevtvVd
         w2epFVXWK+IqKCf6G7vmjmVP1FEYqS6/hQQJBE42eM6Hj0u+yqAwlKnJV+U27sjp2UCr
         8l2g==
X-Gm-Message-State: AGi0Pub3ogd4trlzeGmuAnVdDfOPY+tyiWIWTFobPHP6DlM5D2MtQd7O
        1Eo5aGgD2o8Fqe/md1UqD+yAUDtD7wbhldMMjFfNAA==
X-Google-Smtp-Source: APiQypJpeSSwOq64/N7vOjBoWjJ/56BFT+hlHKLS0f3nog579CzDJTnDcAtebBwG/3cPxDxAd++E7WmJ/MKvp8wSlgA=
X-Received: by 2002:adf:a4c9:: with SMTP id h9mr49479wrb.426.1585879229770;
 Thu, 02 Apr 2020 19:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com> <1583466184-7060-4-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1583466184-7060-4-git-send-email-tiantao6@hisilicon.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Fri, 3 Apr 2020 10:00:18 +0800
Message-ID: <CAKoKPbxF05D4vhKNkCsVCRHsfEAVmdFf8akVzSAHNEfXnwpFwA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/hisilicon: Enforce 128-byte stride alignment to
 fix the hardware limitation
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Fri, 6 Mar 2020 at 11:44, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> because the hardware limitation,The initial color depth must set to 32bpp
> and must set the FB Offset of the display hardware to 128Byte alignment,
> which is used to solve the display problem at 800x600 and 1440x900
> resolution under 16bpp.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Signed-off-by: Gong junjie <gongjunjie2@huawei.com>

Thanks for the patch.
Acked-by: Xinliang Liu <xinliang.liu@linaro.org>
Applied to drm-misc.

-Xinliang

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 9 +++++----
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 4 ++--
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     | 2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 55b46a7..cc70e83 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -94,6 +94,10 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
>                 return -EINVAL;
>         }
>
> +       if (state->fb->pitches[0] % 128 != 0) {
> +               DRM_DEBUG_ATOMIC("wrong stride with 128-byte aligned\n");
> +               return -EINVAL;
> +       }
>         return 0;
>  }
>
> @@ -119,11 +123,8 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>         writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>
>         reg = state->fb->width * (state->fb->format->cpp[0]);
> -       /* now line_pad is 16 */
> -       reg = PADDING(16, reg);
>
> -       line_l = state->fb->width * state->fb->format->cpp[0];
> -       line_l = PADDING(16, line_l);
> +       line_l = state->fb->pitches[0];
>         writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
>                HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
>                priv->mmio + HIBMC_CRT_FB_WIDTH);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 222356a..79a180a 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -94,7 +94,7 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>         priv->dev->mode_config.max_height = 1200;
>
>         priv->dev->mode_config.fb_base = priv->fb_base;
> -       priv->dev->mode_config.preferred_depth = 24;
> +       priv->dev->mode_config.preferred_depth = 32;
>         priv->dev->mode_config.prefer_shadow = 1;
>
>         priv->dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
> @@ -307,7 +307,7 @@ static int hibmc_load(struct drm_device *dev)
>         /* reset all the states of crtc/plane/encoder/connector */
>         drm_mode_config_reset(dev);
>
> -       ret = drm_fbdev_generic_setup(dev, 16);
> +       ret = drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
>         if (ret) {
>                 DRM_ERROR("failed to initialize fbdev: %d\n", ret);
>                 goto err;
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> index 99397ac..322bd54 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> @@ -50,7 +50,7 @@ void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
>  int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>                       struct drm_mode_create_dumb *args)
>  {
> -       return drm_gem_vram_fill_create_dumb(file, dev, 0, 16, args);
> +       return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
>  }
>
>  const struct drm_mode_config_funcs hibmc_mode_funcs = {
> --
> 2.7.4
>
