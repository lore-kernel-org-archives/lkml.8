Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD7C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="ykgD7mMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgEEMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEEMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:53:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F94C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:53:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so1658927edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2i9n3QivG/CM9qoO26QmpcQc9zHZUpC7ZjISkDMfja0=;
        b=ykgD7mMk1AO9ntaCABmSTtKquiOrVLNE0/xcuFQU4P5zhRiyD6W7b/k8DZnHM2KXWh
         pbc7VfEK3ns0WkVUDq5iLwDESL54lrLrKSxgKfYKkV/5Av7bHpg7jNzxYvQburMvDNDT
         k7sqmmJrr5SZHDbNPFvAV7lUwKABcok2dnj/ibYe65YMqCDgSb3kIcprp2ll1SeRes/a
         kAuxWMGsN0bj8fXm3lHPdSudWSfZMH2z4yVV+jFRzlfj5u7n1IpH1WNCld7zIXLpJSg8
         1ntFtVL/XZac5e/nKyil9+TYK6/jqQl1ErbOwPoIqavFH/VEw/DG7RJn5UIUXWERKx9O
         jZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2i9n3QivG/CM9qoO26QmpcQc9zHZUpC7ZjISkDMfja0=;
        b=uK1Z5YGOFr5+P5H8rUtb99MjWUkeU/6S03YOPbrNMw2ziNNn6ggP/26jEcFcrFJxLq
         zOgx2ZcJ6Vhs4K3RgLCUlPg6As7p2KJKqOHEDTuFaKQDY6NLNH8ZHELbO3+2DahUeXRv
         Af95G8Juu7/LIpEXpK5zVpDjqlHJbbzKiMdg+v8KWplzXlEu7LYTeyT91pOQeCTl1Nk/
         l8fAVJhgyj1PUDZD7gWD6VVF1oOz3S4undaQfSSJndcUr4Mh1CihSFovkiSMAKFTZl6y
         nA9ey3V/MZHZEmwdw0mfwCBZDnS4Ddha2BDPHqm9nBKT0P9DmhK7kL42zvuwKf+JbGyK
         0/JA==
X-Gm-Message-State: AGi0PuYMdFevIAkhlg2+yfs9KPzJ55X61Oa5rJR0jNG2SGcj/wf7q69X
        Tw2FwMjpzhReeod+IVCKfwPRmdH1OsJdHA0X4JndTg==
X-Google-Smtp-Source: APiQypLBXkk48AohPhXWRPT5DKky4xjbtLLoeoS/saHbLkVqipzVHqvlv/6HNYaIesJ9AbYqAkqUx2y1bKu1VaD2sxU=
X-Received: by 2002:a05:6402:391:: with SMTP id o17mr2458965edv.71.1588683199198;
 Tue, 05 May 2020 05:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200422040410.6251-1-samuel@sholland.org> <20200422040410.6251-2-samuel@sholland.org>
In-Reply-To: <20200422040410.6251-2-samuel@sholland.org>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 5 May 2020 09:53:08 -0300
Message-ID: <CAAEAJfBdRVZwvEZNU_Hu4eutOO5HJzLLU2HJ2OcP=L+pBZfiTg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 2/2] media: cedrus: Implement runtime PM
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 01:00, Samuel Holland <samuel@sholland.org> wrote:
>
> This allows the VE clocks and PLL_VE to be disabled most of the time.
> A runtime PM reference is held while streaming.
>
> Originally-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>

Originally-by is not documented, perhaps just go with Signed-off-by,
as Jernej suggested.

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> v2: moved PM reference to cedrus_{start,stop}_streaming, based on an
>     earlier patch by Jernej Skrabec. Removes the need for autosuspend.
>     I tested this with running 2x v4l2-request-test in parallel.
>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |   7 ++
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 106 ++++++++++++------
>  .../staging/media/sunxi/cedrus/cedrus_hw.h    |   3 +
>  .../staging/media/sunxi/cedrus/cedrus_video.c |  33 ++++--
>  4 files changed, 104 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 05a85517ff60..bc27f9430eeb 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pm.h>
>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
> @@ -551,12 +552,18 @@ static const struct of_device_id cedrus_dt_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, cedrus_dt_match);
>
> +static const struct dev_pm_ops cedrus_dev_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(cedrus_hw_suspend,
> +                          cedrus_hw_resume, NULL)
> +};
> +
>  static struct platform_driver cedrus_driver =3D {
>         .probe          =3D cedrus_probe,
>         .remove         =3D cedrus_remove,
>         .driver         =3D {
>                 .name           =3D CEDRUS_NAME,
>                 .of_match_table =3D of_match_ptr(cedrus_dt_match),
> +               .pm             =3D &cedrus_dev_pm_ops,
>         },
>  };
>  module_platform_driver(cedrus_driver);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index daf5f244f93b..1744e6fcc999 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/soc/sunxi/sunxi_sram.h>
> @@ -140,6 +141,64 @@ static irqreturn_t cedrus_irq(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> +int cedrus_hw_suspend(struct device *device)
> +{
> +       struct cedrus_dev *dev =3D dev_get_drvdata(device);
> +
> +       reset_control_assert(dev->rstc);
> +
> +       clk_disable_unprepare(dev->ram_clk);
> +       clk_disable_unprepare(dev->mod_clk);
> +       clk_disable_unprepare(dev->ahb_clk);
> +

You can use clk_bulk API here.

> +       return 0;
> +}
> +
> +int cedrus_hw_resume(struct device *device)
> +{
> +       struct cedrus_dev *dev =3D dev_get_drvdata(device);
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(dev->ahb_clk);
> +       if (ret) {
> +               dev_err(dev->dev, "Failed to enable AHB clock\n");
> +
> +               return ret;
> +       }
> +
> +       ret =3D clk_prepare_enable(dev->mod_clk);
> +       if (ret) {
> +               dev_err(dev->dev, "Failed to enable MOD clock\n");
> +
> +               goto err_ahb_clk;
> +       }
> +
> +       ret =3D clk_prepare_enable(dev->ram_clk);
> +       if (ret) {
> +               dev_err(dev->dev, "Failed to enable RAM clock\n");
> +
> +               goto err_mod_clk;
> +       }
> +
> +       ret =3D reset_control_reset(dev->rstc);
> +       if (ret) {
> +               dev_err(dev->dev, "Failed to apply reset\n");
> +
> +               goto err_ram_clk;
> +       }
> +
> +       return 0;
> +
> +err_ram_clk:
> +       clk_disable_unprepare(dev->ram_clk);
> +err_mod_clk:
> +       clk_disable_unprepare(dev->mod_clk);
> +err_ahb_clk:
> +       clk_disable_unprepare(dev->ahb_clk);
> +
> +       return ret;
> +}
> +
>  int cedrus_hw_probe(struct cedrus_dev *dev)
>  {
>         const struct cedrus_variant *variant;
> @@ -236,42 +295,17 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>                 goto err_sram;
>         }
>
> -       ret =3D clk_prepare_enable(dev->ahb_clk);
> -       if (ret) {
> -               dev_err(dev->dev, "Failed to enable AHB clock\n");
> -
> -               goto err_sram;
> -       }
> -
> -       ret =3D clk_prepare_enable(dev->mod_clk);
> -       if (ret) {
> -               dev_err(dev->dev, "Failed to enable MOD clock\n");
> -
> -               goto err_ahb_clk;
> -       }
> -
> -       ret =3D clk_prepare_enable(dev->ram_clk);
> -       if (ret) {
> -               dev_err(dev->dev, "Failed to enable RAM clock\n");
> -
> -               goto err_mod_clk;
> -       }
> -
> -       ret =3D reset_control_reset(dev->rstc);
> -       if (ret) {
> -               dev_err(dev->dev, "Failed to apply reset\n");
> -
> -               goto err_ram_clk;
> +       pm_runtime_enable(dev->dev);
> +       if (!pm_runtime_enabled(dev->dev)) {
> +               ret =3D cedrus_hw_resume(dev->dev);
> +               if (ret)
> +                       goto err_pm;
>         }
>
>         return 0;
>
> -err_ram_clk:
> -       clk_disable_unprepare(dev->ram_clk);
> -err_mod_clk:
> -       clk_disable_unprepare(dev->mod_clk);
> -err_ahb_clk:
> -       clk_disable_unprepare(dev->ahb_clk);
> +err_pm:
> +       pm_runtime_disable(dev->dev);
>  err_sram:
>         sunxi_sram_release(dev->dev);
>  err_mem:
> @@ -282,11 +316,9 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>
>  void cedrus_hw_remove(struct cedrus_dev *dev)
>  {
> -       reset_control_assert(dev->rstc);
> -
> -       clk_disable_unprepare(dev->ram_clk);
> -       clk_disable_unprepare(dev->mod_clk);
> -       clk_disable_unprepare(dev->ahb_clk);
> +       pm_runtime_disable(dev->dev);
> +       if (!pm_runtime_status_suspended(dev->dev))
> +               cedrus_hw_suspend(dev->dev);
>
>         sunxi_sram_release(dev->dev);
>
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.h
> index 604ff932fbf5..45f641f0bfa2 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> @@ -22,6 +22,9 @@ void cedrus_engine_disable(struct cedrus_dev *dev);
>  void cedrus_dst_format_set(struct cedrus_dev *dev,
>                            struct v4l2_pix_format *fmt);
>
> +int cedrus_hw_suspend(struct device *device);
> +int cedrus_hw_resume(struct device *device);
> +
>  int cedrus_hw_probe(struct cedrus_dev *dev);
>  void cedrus_hw_remove(struct cedrus_dev *dev);
>
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
> index ed3f511f066f..16d82309e7b6 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -13,6 +13,8 @@
>   * Marek Szyprowski, <m.szyprowski@samsung.com>
>   */
>
> +#include <linux/pm_runtime.h>
> +
>  #include <media/videobuf2-dma-contig.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
> @@ -450,12 +452,24 @@ static int cedrus_start_streaming(struct vb2_queue =
*vq, unsigned int count)
>                 return -EINVAL;
>         }
>
> -       if (V4L2_TYPE_IS_OUTPUT(vq->type) &&
> -           dev->dec_ops[ctx->current_codec]->start)
> -               ret =3D dev->dec_ops[ctx->current_codec]->start(ctx);
> +       if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
> +               ret =3D pm_runtime_get_sync(dev->dev);

It's entirely up to you, but you could do get_sync/put
between .device_run, as everything should happen
in the context of v4l2_m2m_ops.device_run.
(In that case, I believe you'd want to enable autosuspend.)

Not sure there's much to gain from an power consumption
pov, though.

With the Originally-by changed:

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks,
Ezequiel
