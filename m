Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2F920663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWdjRAoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGHJPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgGHJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:15:02 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C2C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:15:02 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id p6so7074620uaq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRjZHkXkzEhGi5hn40XGl/e6qRsBuLGR/qEVHC0USyI=;
        b=kWdjRAoBMkPAyyXi7TjFmQ+d90N4uv7q74fpybzzAATLpMH1LQ5ZZjZptmLJkGPV3+
         T9W2iTQ4XblKDTZM8pOPFoUqFJpat2uLf429wvt28z1lPMBo123+CguPP7H8O6EBkRRB
         d2SB1fITZM5qk8pL0UO91/p3nx9FC12I7sTSwk+GZbF5bYo+iIbvZYANX2mC2p2rs6Cn
         WqY6jGzhIHlea/vA6v3BxbMisLtmkAPIwuY/QKhQEe+NGULedBMlI5nNMJBIOYnuLvKJ
         tGC5xxXH/KxM2OUhp8IXZaSAmpZt74dCV1mSYs8Z2PDZqbTVvcQsMclPhPl65tNtbKs+
         y/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRjZHkXkzEhGi5hn40XGl/e6qRsBuLGR/qEVHC0USyI=;
        b=o6cqYKQW/BgPoVZhFfyTd2IAOiEDgM/yTvEhiMzHU4m3/fjcYenlpXqACe/ZcAMrr6
         eU2HZ+lvkiTezHZHgioS2aqUdCq+i4BQ1OhzQEkyyg/3EIUx4dtl0cLrx1hQZiGgAHDU
         Ecx1FJ953VlD8407AhmChArZnBWQcfgWBdOP5NKP8QzQEofCoPeTUOKeChK89f4polvS
         0yPk+NdTBo/mLrxi7ndwidh5O70jTXJ5Q0/AKqQ0xG11LaVreVk8dgIlqiJeIw5HnXXz
         y8+foTalNpqaO7/0QhSFIwdRB6siuo5L4xoxOtL+4ddkjWYN8stA5OmcLVT1ZdyJ4+qf
         nZUQ==
X-Gm-Message-State: AOAM5339TqMWpX6nF691Pv6SmlMEC7w2vO+/UaHxYyYMzIOPyIQAd9wG
        ij6eQ31LdTQLt53evp8MocBH1TJ40r5PYlL6OOmh7w==
X-Google-Smtp-Source: ABdhPJxLLkk6MK3Csm05jxcjimKiHzWE2ysQXqtuXdKjKHF2mURJuz9XqEp53Da5aTh2O3WgXZAW3cg1bFm+PfC0F4E=
X-Received: by 2002:ab0:15a4:: with SMTP id i33mr6683213uae.85.1594199701485;
 Wed, 08 Jul 2020 02:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200706144713.1123-1-yuzenghui@huawei.com>
In-Reply-To: <20200706144713.1123-1-yuzenghui@huawei.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Wed, 8 Jul 2020 17:14:49 +0800
Message-ID: <CAKoKPbzjJa74b8kayVguLJF_PVzPD4jOfvnUJ-pr3HmytLiGAw@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon/hibmc: Move drm_fbdev_generic_setup() down
 to avoid the splat
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tzimmermann@suse.de,
        Sam Ravnborg <sam@ravnborg.org>, wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,
Thanks for fixing this.
Applied to drm-misc-fixes.

Best,
-Xinliang

On Mon, 6 Jul 2020 at 22:53, Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> The HiSilicon hibmc driver triggers a splat at boot time as below
>
> [   14.137806] ------------[ cut here ]------------
> [   14.142405] hibmc-drm 0000:0a:00.0: Device has not been registered.
> [   14.148661] WARNING: CPU: 0 PID: 496 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x15c/0x1b8
> [   14.158787] [...]
> [   14.278307] Call trace:
> [   14.280742]  drm_fbdev_generic_setup+0x15c/0x1b8
> [   14.285337]  hibmc_pci_probe+0x354/0x418
> [   14.289242]  local_pci_probe+0x44/0x98
> [   14.292974]  work_for_cpu_fn+0x20/0x30
> [   14.296708]  process_one_work+0x1c4/0x4e0
> [   14.300698]  worker_thread+0x2c8/0x528
> [   14.304431]  kthread+0x138/0x140
> [   14.307646]  ret_from_fork+0x10/0x18
> [   14.311205] ---[ end trace a2000ec2d838af4d ]---
>
> This turned out to be due to the fbdev device hasn't been registered when
> drm_fbdev_generic_setup() is invoked. Let's fix the splat by moving it down
> after drm_dev_register() which will follow the "Display driver example"
> documented by commit de99f0600a79 ("drm/drv: DOC: Add driver example
> code").
>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a6fd0c29e5b8..544b9993c99e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -307,8 +307,6 @@ static int hibmc_load(struct drm_device *dev)
>         /* reset all the states of crtc/plane/encoder/connector */
>         drm_mode_config_reset(dev);
>
> -       drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> -
>         return 0;
>
>  err:
> @@ -355,6 +353,9 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>                           ret);
>                 goto err_unload;
>         }
> +
> +       drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> +
>         return 0;
>
>  err_unload:
> --
> 2.19.1
>
