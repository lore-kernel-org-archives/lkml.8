Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDDF20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOInRZUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:35:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37785 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgBXRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:35:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so9463237otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tEYu+54m1fl9TzRp5L/NXdZJVqyRdysGPfNpn510WU=;
        b=QOInRZULa9P/XYIryyVGyh5tELPyplPJ4ALDmU4YnvwVadkdLReQrzRjRvCvc4k3W3
         YP58TckkfgDtUFglY9VDOPkJLvYfzRyyEvsK6k1+6wTBX4XoTYyrChIC4va0B3anEg/9
         L2tdHbzOzE9buuYOXTYkgoPXReUlAJjLeJyOZKwgP+bkfDeOvTENdpF8VfPF2DCPmrcY
         fTrHEfy8UobVGp0eiLzb8VBVdm1Zw/stYgAKoX17e5Q1yCEONBZowvV+a/qnvF+T0HMw
         SV4chSJUVBvn1RgzHkboBj7fkk7A8HxdLpNw+276k7yOnFCC1A1F55qVHCUto+MIPdcY
         iGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tEYu+54m1fl9TzRp5L/NXdZJVqyRdysGPfNpn510WU=;
        b=d8zWiG6DjY805tsZ+qc1a/8OHpLBPf9KDkPvdP1A4A8b0IW8Kwu20QwqNe4rdEGKs2
         i2oqhw2KrbxlHlveBkMpARlNWFcvK9edI78DblIHlDNYT/sCGW7oFkO501Syasnpq6kS
         /71o1RdNU5hu35Rf2CWG6/Wpd+siQTYZ1Nk5qeC4ZtPB6lAKOy51Bo1ZjRAqm6Mq9Fp+
         fa/a1EakOLgSZw5B8nf3VKKq//8Np0thjotXLe6PZOwaULHNhjyDnikHqft8t3pVvZQA
         4I2UP0vhosVHyftw0tkS7GIKMi5h89NyONBLo4GlmCsgI0g2p7acy+ZRTwPaz2afRK71
         SXwQ==
X-Gm-Message-State: APjAAAWZ9+c4+y/ehS1m31fqaOTWZY80ZUPv5zfonx49p5JpEgT4WMd5
        5cZkApaSDm652ZOVMoVpTZ3DTvfaXbfkT5dVTQ95X7Qq
X-Google-Smtp-Source: APXvYqyZY2lCUVDQkuQUlgp9LffhyVyhSpreH4yEeOBpi1ayBCUwfqBWiCnDg/lmksvE5WDW/QjJ1ZSHUakDp9X2KMY=
X-Received: by 2002:a9d:6289:: with SMTP id x9mr41621051otk.8.1582565745450;
 Mon, 24 Feb 2020 09:35:45 -0800 (PST)
MIME-Version: 1.0
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com> <1582271336-3708-5-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1582271336-3708-5-git-send-email-kevin3.tang@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 24 Feb 2020 17:35:26 +0000
Message-ID: <CACvgo535TKq1goSsYiDQVU+6eQBMG+P9iUeaKS_caV=nrUYPMA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 11:15, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> Adds DPU(Display Processor Unit) support for the Unisoc's display subsystem.
> It's support multi planes, scaler, rotation, PQ(Picture Quality) and more.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  drivers/gpu/drm/sprd/Makefile       |   6 +-
>  drivers/gpu/drm/sprd/disp_lib.c     |  59 +++
>  drivers/gpu/drm/sprd/disp_lib.h     |  21 +
>  drivers/gpu/drm/sprd/dpu/Makefile   |   7 +
>  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 787 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.c     | 678 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h     | 130 ++++++
>  drivers/gpu/drm/sprd/sprd_drm.c     |   1 +
>  drivers/gpu/drm/sprd/sprd_drm.h     |   2 +
>  9 files changed, 1690 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sprd/disp_lib.c
>  create mode 100644 drivers/gpu/drm/sprd/disp_lib.h
>  create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
>
> diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makefile
> index 63b8751..c94c8ac 100644
> --- a/drivers/gpu/drm/sprd/Makefile
> +++ b/drivers/gpu/drm/sprd/Makefile
> @@ -4,4 +4,8 @@ ccflags-y += -Iinclude/drm
>
>  subdir-ccflags-y += -I$(src)
>
> -obj-y := sprd_drm.o
> +obj-y := sprd_drm.o \
> +       sprd_dpu.o
> +
> +obj-y += disp_lib.o
> +obj-y += dpu/
> diff --git a/drivers/gpu/drm/sprd/disp_lib.c b/drivers/gpu/drm/sprd/disp_lib.c
> new file mode 100644
> index 0000000..c887822
> +++ b/drivers/gpu/drm/sprd/disp_lib.c
> +++ b/drivers/gpu/drm/sprd/disp_lib.h

These are completely unused. Drop them for now as well as their Makefile hunk.


> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/dpu/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ifdef CONFIG_ARM64
> +KBUILD_CFLAGS += -mstrict-align
> +endif
> +
There is only a single case of this in the whole kernel. This is a strong
indication that there is something wrong, perhaps. Why do we need this?


> +obj-y += dpu_r2p0.o
> diff --git a/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c b/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
> new file mode 100644
> index 0000000..b96e2e2
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
> @@ -0,0 +1,787 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Unisoc Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +#include "sprd_dpu.h"
> +
> +#define DISPC_INT_FBC_PLD_ERR_MASK     BIT(8)
> +#define DISPC_INT_FBC_HDR_ERR_MASK     BIT(9)
> +
> +#define DISPC_INT_MMU_INV_WR_MASK      BIT(19)
> +#define DISPC_INT_MMU_INV_RD_MASK      BIT(18)
> +#define DISPC_INT_MMU_VAOR_WR_MASK     BIT(17)
> +#define DISPC_INT_MMU_VAOR_RD_MASK     BIT(16)
> +
> +struct layer_reg {
> +       u32 addr[4];
> +       u32 ctrl;
> +       u32 size;
> +       u32 pitch;
> +       u32 pos;
> +       u32 alpha;
> +       u32 ck;
> +       u32 pallete;
> +       u32 crop_start;
> +};
> +
> +struct wb_region_reg {
> +       u32 pos;
> +       u32 size;
> +};
> +
> +struct dpu_reg {
...

There are actual HW registers and we get the base via ioremap_nocache().
Please add a small comment.


> +static DECLARE_WAIT_QUEUE_HEAD(wait_queue);
> +static bool panel_ready = true;
> +static bool evt_update;
> +static bool evt_stop;
> +
Using static variables tend to be an example of badly designed code.


...

> +static void dpu_uninit(struct dpu_context *ctx)

Normally people use init - for initialization and fini for "uninitialization"


> +enum {
> +       DPU_LAYER_FORMAT_YUV422_2PLANE,
> +       DPU_LAYER_FORMAT_YUV420_2PLANE,
> +       DPU_LAYER_FORMAT_YUV420_3PLANE,
> +       DPU_LAYER_FORMAT_ARGB8888,
> +       DPU_LAYER_FORMAT_RGB565,
> +       DPU_LAYER_FORMAT_XFBC_ARGB8888 = 8,
> +       DPU_LAYER_FORMAT_XFBC_RGB565,
> +       DPU_LAYER_FORMAT_MAX_TYPES,
> +};
> +
> +enum {
> +       DPU_LAYER_ROTATION_0,
> +       DPU_LAYER_ROTATION_90,
> +       DPU_LAYER_ROTATION_180,
> +       DPU_LAYER_ROTATION_270,
> +       DPU_LAYER_ROTATION_0_M,
> +       DPU_LAYER_ROTATION_90_M,
> +       DPU_LAYER_ROTATION_180_M,
> +       DPU_LAYER_ROTATION_270_M,
> +};
> +


Starting with one format and rotation is good. Others can be added as follow-up.
Especially since FBC is something that is just becoming fashionable.

> +static void dpu_dpi_init(struct dpu_context *ctx)
> +{

...

> +       } else if (ctx->if_type == SPRD_DISPC_IF_EDPI) {
> +               /* use edpi as interface */
> +               reg->dpu_cfg0 |= BIT(0);
> +
> +               /* use external te */
> +               reg->dpi_ctrl |= BIT(10);
> +
> +               /* enable te */
> +               reg->dpi_ctrl |= BIT(8);

Try to avoid using BIT() randomly. A well chosen name, removes the need for a
comment. Perhaps it's just me but the "enable foo" comments do not help much.

...


> +struct dpu_core_ops sharkl3_dpu_core_ops = {
In general ops should be const.

> +       .version = dpu_get_version,
> +       .init = dpu_init,
> +       .uninit = dpu_uninit,
> +       .run = dpu_run,
> +       .stop = dpu_stop,
> +       .isr = dpu_isr,
> +       .ifconfig = dpu_dpi_init,
> +       .capability = dpu_capability,
> +       .flip = dpu_flip,
> +       .bg_color = dpu_bgcolor,
> +       .enable_vsync = enable_vsync,
> +       .disable_vsync = disable_vsync,

... then again, we have only a single set of dpu_core_ops. So the whole
abstraction layer seems unnessesary.




> +};
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> new file mode 100644
> index 0000000..331f236
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c



> +static int sprd_plane_atomic_check(struct drm_plane *plane,
> +                                 struct drm_plane_state *state)
> +{
> +       DRM_DEBUG("%s()\n", __func__);
> +
This does not feel right. Here the driver must ensure that the state given will
always work.

Is the hardware so versatile that any permutation (given by userspace)
will work?

Same goes for the other atomic_check functions that are no-op.


> +static void sprd_plane_atomic_disable(struct drm_plane *plane,
> +                                    struct drm_plane_state *old_state)
> +{
> +       struct sprd_plane *p = to_sprd_plane(plane);
> +
> +       /*
> +        * NOTE:
> +        * The dpu->core->flip() will disable all the planes each time.
> +        * So there is no need to impliment the atomic_disable() function.
> +        * But this function can not be removed, because it will change
> +        * to call atomic_update() callback instead. Which will cause
> +        * kernel panic in sprd_plane_atomic_update().
> +        *
Why do we disable all the planes on flip? This is the first time I see such
driver decision.


> +static void sprd_crtc_atomic_enable(struct drm_crtc *crtc,
> +                                  struct drm_crtc_state *old_state)
> +{
> +       struct sprd_dpu *dpu = crtc_to_dpu(crtc);
> +       static bool is_enabled = true;
> +
More static variables - please remove.



> +static int sprd_dpu_init(struct sprd_dpu *dpu)
> +{
> +       struct dpu_context *ctx = &dpu->ctx;
> +
> +       down(&ctx->refresh_lock);
> +
Why do we need the semaphore? From a quick look all the other drivers are
semaphore/lock free in their atomic codepath.

One notable exception is the event_lock.



> +       if (dpu->ctx.is_inited) {
> +               up(&ctx->refresh_lock);
> +               return 0;
> +       }
> +
How can did this trigger? IMHO we either have a serious bug or the check is dead
code.

> +       if (dpu->core && dpu->core->init)

Using if dpu->core && dpu->core->FOO is a recurring pattern, yet they are always
set. Unless needed we can kill the abstraction layer all together can call FOO
directly.

> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.h

> +struct dpu_context {
> +       unsigned long base;
> +       const char *version;
> +       int irq;
> +       u8 if_type;
> +       bool is_inited;
> +       bool is_stopped;
Nit: more natural names for these are "initialized" and "stopped"


> +       struct videomode vm;
> +       struct semaphore refresh_lock;
I've mentioned it earlier - not 100% sure that the semaphore is needed. If it is
please add a comment just above it.



> +int sprd_dpu_run(struct sprd_dpu *dpu);
> +int sprd_dpu_stop(struct sprd_dpu *dpu);
> +
These two functions seem to be unused in this patch. Let's drop them for now.


Thanks
Emil
