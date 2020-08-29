Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A3C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EB820757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5HQXDx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgH2RKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgH2RKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:10:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12995C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:10:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c8so1310822lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WhNcYUtCTYL+KMnDgz2Db29532EpJkEYPIGnk6o9Yws=;
        b=h5HQXDx1r6rWjJd0qwKJnQrg69Kls1Nnjj97jVEBcwvwkM0PcaVwg7kLjNfxqULG2f
         LSAltidcFEDbzp/0vR0O1A3UEM5kbHn+k4yU9SAdaBEvZH5fF4mcxCFvZWIlpUCqRQok
         0vqqcm70DAKR35XP9ad85AXwbo/jFi9ElHyDJPheZ0y0cJAwNMv7pCDK9PGout1COnh8
         o96qmLDLFE1fkc5MoeyWcjJN9WLJDw546RruVdvl0tF7fGeV3m363bkchfbjLazzW1uj
         QdJQFvaj+AEzFBRih7O+ThY67fWVNOgMFXKEbk5e8f4S7VR753ftbsxewbPccPN73s5R
         Hl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WhNcYUtCTYL+KMnDgz2Db29532EpJkEYPIGnk6o9Yws=;
        b=qMN+50sC7KpuTakpKYwI2O3XLEnayrhWgup5FT5hkeYda+2JFLEaM+oLmASox2cs4L
         4AZbKdsvXp6QEXt8r7WEjD/cb1wNRUShgvhmsiazHFYL0ReZF+xJPwK/Eo/HElNKwZC9
         7bQrrO/uDaZ9wCxLmgJ7MkPqZpQG44YqGmEz3eusaLcmG5V5Cp28LqiwqdazIKDpzkSV
         ktKPIM+V3QNSOaTbgSETppW0Vk/Agp2we3zlSOxbjRt4RwwGJtBJBibftmvLW2esdqy4
         tdNj54EKCznL5Ggqmg60RJMvV4hvyhAVftLhEV63Qla3yMvp3KbihErOn9lKN/6DCIXy
         mJeA==
X-Gm-Message-State: AOAM531uqYeBHWZIxJ4EiBWD4nqJfJEZ+ZfpXfPC3U9hYdryXJaY1gD6
        HYhbsb2qRoLokm66DESntmBtv13lbIvkL4/BDtqlXexA/NY=
X-Google-Smtp-Source: ABdhPJxqtZXaLHmY78/6y3M1QQbqTTbqaOx9f7vetJfDr3gluI0PQvp6fcqoNmfI8ysrJvMvYHhsyXsJjpDOcgBmvPU=
X-Received: by 2002:ac2:43c5:: with SMTP id u5mr1993746lfl.0.1598721031453;
 Sat, 29 Aug 2020 10:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-5-git-send-email-kevin3.tang@gmail.com> <CAKMK7uE=86hRWdowXWVrE5184-gS2TYPArC1XcqTXwRQxHRMHg@mail.gmail.com>
In-Reply-To: <CAKMK7uE=86hRWdowXWVrE5184-gS2TYPArC1XcqTXwRQxHRMHg@mail.gmail.com>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Sun, 30 Aug 2020 01:10:20 +0800
Message-ID: <CAFPSGXbOKTVqxHG1aOVminurnd7EvNUXt8Azo0dsSXEPmxJowQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Kevin Tang <kevin3.tang@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> =E4=BA=8E2020=E5=B9=B47=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 28, 2020 at 12:08 PM Kevin Tang <kevin3.tang@gmail.com> wrote=
:
> >
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > Adds DPU(Display Processor Unit) support for the Unisoc's display subsy=
stem.
> > It's support multi planes, scaler, rotation, PQ(Picture Quality) and mo=
re.
> >
> > RFC v6:
> >   - Access registers via readl/writel
> >   - Checking for unsupported KMS properties (format, rotation, blend_mo=
de, etc) on plane_check ops
> >   - Remove always true checks for dpu core ops
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
>
> Quickly scrolled through this, and the entire thing very much leaves a
> midlayer heavy aftertaste. Do we really need stuff like struct dpu_layer
> and struct dpu_core_ops? They only seem to complicate the code base, and
> seem to have no real reason. The indirection with first computing registe=
r
> values into a sprd_plane/crtc structure, and then writing it into hardwar=
e
> is also a bit much - I recommend to only do that if you have to compute
> values in _check to validate them, so that the computation doesn't have t=
o
> be repeated in the commit phase functions.
Hi daniel,
Maybe some DPU's IP verison, there will be some differences in the
DPU on each Soc. Not only control registers, there will be some differences
in control logic and functions
If access H/W registers all put into crtc or plane driver, how did
others deal with it? Add Soc's macro?
When there are too many H/W IPs, split into different files(dpu_core_ops)
according to different IP, I think the code project will be more
convenient to keeping.

For multiple H/W IP, the popular design method is?

>
> Also, the layer and pending_flips stuff in sprd_dpu don't work with
> atomic, that races. You have to put all that stuff into state objects, or
> if it's some data shared with interrupt handlers (doesn't seem to be the
> case here), it needs its own locking, and any data you need in the
> interrupt handler must be copied over.
the layer and pending_flips, we put into atomic_flush, We do have some
features related to interrupt handlers, but it has not been submitted yet.
So pending_flips lock have not been added.
>
> Also no devm_kzalloc for anything containined a drm_* structure, that's
> the wrong lifetime.
>
> So yeah high level review is that I think this driver would benefit a lot
> from a pile of demidlayer.
>
> Cheers, Daniel
>
> > ---
> >  drivers/gpu/drm/sprd/Makefile       |   5 +-
> >  drivers/gpu/drm/sprd/dpu/Makefile   |   3 +
> >  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 503 ++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sprd/sprd_dpu.c     | 646 ++++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/sprd/sprd_dpu.h     | 187 +++++++++++
> >  drivers/gpu/drm/sprd/sprd_drm.c     |   1 +
> >  drivers/gpu/drm/sprd/sprd_drm.h     |   2 +
> >  7 files changed, 1346 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
> >  create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
> >  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
> >  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
> >
> > diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makef=
ile
> > index 86d95d9..88ab32a 100644
> > --- a/drivers/gpu/drm/sprd/Makefile
> > +++ b/drivers/gpu/drm/sprd/Makefile
> > @@ -2,4 +2,7 @@
> >
> >  subdir-ccflags-y +=3D -I$(srctree)/$(src)
> >
> > -obj-y :=3D sprd_drm.o
> > +obj-y :=3D sprd_drm.o \
> > +       sprd_dpu.o
> > +
> > +obj-y +=3D dpu/
> > diff --git a/drivers/gpu/drm/sprd/dpu/Makefile b/drivers/gpu/drm/sprd/d=
pu/Makefile
> > new file mode 100644
> > index 0000000..40278b6
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/dpu/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-y +=3D dpu_r2p0.o
> > diff --git a/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c b/drivers/gpu/drm/sprd=
/dpu/dpu_r2p0.c
> > new file mode 100644
> > index 0000000..4b9521d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
> > @@ -0,0 +1,503 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Unisoc Inc.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/wait.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include "sprd_dpu.h"
> > +
> > +/* DPU registers size, 4 Bytes(32 Bits) */
> > +#define DPU_REG_SIZE   0x04
> > +
> > +/* Layer registers offset */
> > +#define DPU_LAY_REG_OFFSET     0x0C
> > +
> > +#define DPU_LAY_REG(reg, index) \
> > +       (reg + index * DPU_LAY_REG_OFFSET * DPU_REG_SIZE)
> > +
> > +#define DPU_REG_RD(reg) readl_relaxed(reg)
> > +
> > +#define DPU_REG_WR(reg, mask) writel_relaxed(mask, reg)
> > +
> > +#define DPU_REG_SET(reg, mask) \
> > +       writel_relaxed(readl_relaxed(reg) | mask, reg)
> > +
> > +#define DPU_REG_CLR(reg, mask) \
> > +       writel_relaxed(readl_relaxed(reg) & ~mask, reg)
> > +
> > +/* Global control registers */
> > +#define REG_DPU_CTRL   0x04
> > +#define REG_DPU_CFG0   0x08
> > +#define REG_DPU_CFG1   0x0C
> > +#define REG_DPU_CFG2   0x10
> > +#define REG_PANEL_SIZE 0x20
> > +#define REG_BLEND_SIZE 0x24
> > +#define REG_BG_COLOR   0x2C
> > +
> > +/* Layer0 control registers */
> > +#define REG_LAY_BASE_ADDR0     0x30
> > +#define REG_LAY_BASE_ADDR1     0x34
> > +#define REG_LAY_BASE_ADDR2     0x38
> > +#define REG_LAY_CTRL           0x40
> > +#define REG_LAY_SIZE           0x44
> > +#define REG_LAY_PITCH          0x48
> > +#define REG_LAY_POS            0x4C
> > +#define REG_LAY_ALPHA          0x50
> > +#define REG_LAY_PALLETE                0x58
> > +#define REG_LAY_CROP_START     0x5C
> > +
> > +/* Interrupt control registers */
> > +#define REG_DPU_INT_EN         0x1E0
> > +#define REG_DPU_INT_CLR                0x1E4
> > +#define REG_DPU_INT_STS                0x1E8
> > +
> > +/* DPI control registers */
> > +#define REG_DPI_CTRL           0x1F0
> > +#define REG_DPI_H_TIMING       0x1F4
> > +#define REG_DPI_V_TIMING       0x1F8
> > +
> > +/* MMU control registers */
> > +#define REG_MMU_EN                     0x800
> > +#define REG_MMU_VPN_RANGE              0x80C
> > +#define REG_MMU_VAOR_ADDR_RD           0x818
> > +#define REG_MMU_VAOR_ADDR_WR           0x81C
> > +#define REG_MMU_INV_ADDR_RD            0x820
> > +#define REG_MMU_INV_ADDR_WR            0x824
> > +#define REG_MMU_PPN1                   0x83C
> > +#define REG_MMU_RANGE1                 0x840
> > +#define REG_MMU_PPN2                   0x844
> > +#define REG_MMU_RANGE2                 0x848
> > +
> > +/* Global control bits */
> > +#define BIT_DPU_RUN                    BIT(0)
> > +#define BIT_DPU_STOP                   BIT(1)
> > +#define BIT_DPU_REG_UPDATE             BIT(2)
> > +#define BIT_DPU_IF_EDPI                        BIT(0)
> > +#define BIT_DPU_COEF_NARROW_RANGE              BIT(4)
> > +#define BIT_DPU_Y2R_COEF_ITU709_STANDARD       BIT(5)
> > +
> > +/* Layer control bits */
> > +#define BIT_DPU_LAY_EN                         BIT(0)
> > +
> > +/* Interrupt control & status bits */
> > +#define BIT_DPU_INT_DONE               BIT(0)
> > +#define BIT_DPU_INT_TE                 BIT(1)
> > +#define BIT_DPU_INT_ERR                        BIT(2)
> > +#define BIT_DPU_INT_UPDATE_DONE                BIT(4)
> > +#define BIT_DPU_INT_VSYNC              BIT(5)
> > +#define BIT_DPU_INT_FBC_PLD_ERR                BIT(8)
> > +#define BIT_DPU_INT_FBC_HDR_ERR                BIT(9)
> > +#define BIT_DPU_INT_MMU_VAOR_RD                BIT(16)
> > +#define BIT_DPU_INT_MMU_VAOR_WR                BIT(17)
> > +#define BIT_DPU_INT_MMU_INV_RD         BIT(18)
> > +#define BIT_DPU_INT_MMU_INV_WR         BIT(19)
> > +
> > +/* DPI control bits */
> > +#define BIT_DPU_EDPI_TE_EN             BIT(8)
> > +#define BIT_DPU_EDPI_FROM_EXTERNAL_PAD BIT(10)
> > +#define BIT_DPU_DPI_HALT_EN            BIT(16)
> > +
> > +
> > +static u32 check_mmu_isr(struct dpu_context *ctx, u32 reg_val)
> > +{
> > +       u32 mmu_mask =3D BIT_DPU_INT_MMU_VAOR_RD |
> > +                       BIT_DPU_INT_MMU_VAOR_WR |
> > +                       BIT_DPU_INT_MMU_INV_RD |
> > +                       BIT_DPU_INT_MMU_INV_WR;
> > +       u32 val =3D reg_val & mmu_mask;
> > +       int i;
> > +
> > +       if (val) {
> > +               DRM_ERROR("--- iommu interrupt err: 0x%04x ---\n", val)=
;
> > +
> > +               if (val & BIT_DPU_INT_MMU_INV_RD)
> > +                       DRM_ERROR("iommu invalid read error, addr: 0x%0=
8x\n",
> > +                               DPU_REG_RD(ctx->base + REG_MMU_INV_ADDR=
_RD));
> > +               if (val & BIT_DPU_INT_MMU_INV_WR)
> > +                       DRM_ERROR("iommu invalid write error, addr: 0x%=
08x\n",
> > +                               DPU_REG_RD(ctx->base + REG_MMU_INV_ADDR=
_WR));
> > +               if (val & BIT_DPU_INT_MMU_VAOR_RD)
> > +                       DRM_ERROR("iommu va out of range read error, ad=
dr: 0x%08x\n",
> > +                               DPU_REG_RD(ctx->base + REG_MMU_VAOR_ADD=
R_RD));
> > +               if (val & BIT_DPU_INT_MMU_VAOR_WR)
> > +                       DRM_ERROR("iommu va out of range write error, a=
ddr: 0x%08x\n",
> > +                               DPU_REG_RD(ctx->base + REG_MMU_VAOR_ADD=
R_WR));
> > +
> > +               for (i =3D 0; i < 8; i++) {
> > +                       reg_val =3D DPU_REG_RD(ctx->base + DPU_LAY_REG(=
REG_LAY_CTRL, i));
> > +                       if (reg_val & 0x1)
> > +                               DRM_INFO("layer%d: 0x%08x 0x%08x 0x%08x=
 ctrl: 0x%08x\n", i,
> > +                                       DPU_REG_RD(ctx->base + DPU_LAY_=
REG(REG_LAY_BASE_ADDR0, i)),
> > +                                       DPU_REG_RD(ctx->base + DPU_LAY_=
REG(REG_LAY_BASE_ADDR1, i)),
> > +                                       DPU_REG_RD(ctx->base + DPU_LAY_=
REG(REG_LAY_BASE_ADDR2, i)),
> > +                                       DPU_REG_RD(ctx->base + DPU_LAY_=
REG(REG_LAY_CTRL, i)));
> > +               }
> > +       }
> > +
> > +       return val;
> > +}
> > +
> > +static void dpu_clean_all(struct dpu_context *ctx)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < 8; i++)
> > +               DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_CTRL, i), 0x=
00);
> > +}
> > +
> > +static u32 dpu_isr(struct dpu_context *ctx)
> > +{
> > +       u32 reg_val, int_mask =3D 0;
> > +
> > +       reg_val =3D DPU_REG_RD(ctx->base + REG_DPU_INT_STS);
> > +
> > +       /* disable err interrupt */
> > +       if (reg_val & BIT_DPU_INT_ERR)
> > +               int_mask |=3D BIT_DPU_INT_ERR;
> > +
> > +       /* dpu update done isr */
> > +       if (reg_val & BIT_DPU_INT_UPDATE_DONE) {
> > +               ctx->evt_update =3D true;
> > +               wake_up_interruptible_all(&ctx->wait_queue);
> > +       }
> > +
> > +       /* dpu stop done isr */
> > +       if (reg_val & BIT_DPU_INT_DONE) {
> > +               ctx->evt_stop =3D true;
> > +               wake_up_interruptible_all(&ctx->wait_queue);
> > +       }
> > +
> > +       /* dpu ifbc payload error isr */
> > +       if (reg_val & BIT_DPU_INT_FBC_PLD_ERR) {
> > +               int_mask |=3D BIT_DPU_INT_FBC_PLD_ERR;
> > +               DRM_ERROR("dpu ifbc payload error\n");
> > +       }
> > +
> > +       /* dpu ifbc header error isr */
> > +       if (reg_val & BIT_DPU_INT_FBC_HDR_ERR) {
> > +               int_mask |=3D BIT_DPU_INT_FBC_HDR_ERR;
> > +               DRM_ERROR("dpu ifbc header error\n");
> > +       }
> > +
> > +       int_mask |=3D check_mmu_isr(ctx, reg_val);
> > +
> > +       DPU_REG_WR(ctx->base + REG_DPU_INT_CLR, reg_val);
> > +       DPU_REG_CLR(ctx->base + REG_DPU_INT_EN, int_mask);
> > +
> > +       return reg_val;
> > +}
> > +
> > +static int dpu_wait_stop_done(struct dpu_context *ctx)
> > +{
> > +       int rc;
> > +
> > +       if (ctx->stopped)
> > +               return 0;
> > +
> > +       rc =3D wait_event_interruptible_timeout(ctx->wait_queue, ctx->e=
vt_stop,
> > +                                              msecs_to_jiffies(500));
> > +       ctx->evt_stop =3D false;
> > +
> > +       ctx->stopped =3D true;
> > +
> > +       if (!rc) {
> > +               DRM_ERROR("dpu wait for stop done time out!\n");
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int dpu_wait_update_done(struct dpu_context *ctx)
> > +{
> > +       int rc;
> > +
> > +       ctx->evt_update =3D false;
> > +
> > +       rc =3D wait_event_interruptible_timeout(ctx->wait_queue, ctx->e=
vt_update,
> > +                                              msecs_to_jiffies(500));
> > +
> > +       if (!rc) {
> > +               DRM_ERROR("dpu wait for reg update done time out!\n");
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void dpu_stop(struct dpu_context *ctx)
> > +{
> > +       if (ctx->if_type =3D=3D SPRD_DPU_IF_DPI)
> > +               DPU_REG_SET(ctx->base + REG_DPU_CTRL, BIT_DPU_STOP);
> > +
> > +       dpu_wait_stop_done(ctx);
> > +}
> > +
> > +static void dpu_run(struct dpu_context *ctx)
> > +{
> > +       DPU_REG_SET(ctx->base + REG_DPU_CTRL, BIT_DPU_RUN);
> > +
> > +       ctx->stopped =3D false;
> > +}
> > +
> > +static void dpu_init(struct dpu_context *ctx)
> > +{
> > +       u32 reg_val, size;
> > +
> > +       DPU_REG_WR(ctx->base + REG_BG_COLOR, 0x00);
> > +
> > +       size =3D (ctx->vm.vactive << 16) | ctx->vm.hactive;
> > +
> > +       DPU_REG_WR(ctx->base + REG_PANEL_SIZE, size);
> > +       DPU_REG_WR(ctx->base + REG_BLEND_SIZE, size);
> > +
> > +       reg_val =3D BIT_DPU_COEF_NARROW_RANGE | BIT_DPU_Y2R_COEF_ITU709=
_STANDARD;
> > +       DPU_REG_WR(ctx->base + REG_DPU_CFG0, reg_val);
> > +       DPU_REG_WR(ctx->base + REG_DPU_CFG1, 0x004466da);
> > +       DPU_REG_WR(ctx->base + REG_DPU_CFG2, 0x00);
> > +
> > +       if (ctx->stopped)
> > +               dpu_clean_all(ctx);
> > +
> > +       DPU_REG_WR(ctx->base + REG_MMU_EN, 0x00);
> > +       DPU_REG_WR(ctx->base + REG_MMU_PPN1, 0x00);
> > +       DPU_REG_WR(ctx->base + REG_MMU_RANGE1, 0xffff);
> > +       DPU_REG_WR(ctx->base + REG_MMU_PPN2, 0x00);
> > +       DPU_REG_WR(ctx->base + REG_MMU_RANGE2, 0xffff);
> > +       DPU_REG_WR(ctx->base + REG_MMU_VPN_RANGE, 0x1ffff);
> > +
> > +       DPU_REG_WR(ctx->base + REG_DPU_INT_CLR, 0xffff);
> > +}
> > +
> > +static void dpu_fini(struct dpu_context *ctx)
> > +{
> > +       DPU_REG_WR(ctx->base + REG_DPU_INT_EN, 0x00);
> > +       DPU_REG_WR(ctx->base + REG_DPU_INT_CLR, 0xff);
> > +}
> > +
> > +static void dpu_layer(struct dpu_context *ctx,
> > +                   struct dpu_layer *hwlayer)
> > +{
> > +       const struct drm_format_info *info;
> > +       u32 size, offset, ctrl, pitch;
> > +       int i;
> > +
> > +       offset =3D (hwlayer->dst_x & 0xffff) | ((hwlayer->dst_y) << 16)=
;
> > +
> > +       if (hwlayer->src_w && hwlayer->src_h)
> > +               size =3D (hwlayer->src_w & 0xffff) | ((hwlayer->src_h) =
<< 16);
> > +       else
> > +               size =3D (hwlayer->dst_w & 0xffff) | ((hwlayer->dst_h) =
<< 16);
> > +
> > +       for (i =3D 0; i < hwlayer->planes; i++)
> > +               DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_BASE_ADDR0,
> > +                               hwlayer->index), hwlayer->addr[i]);
> > +
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_POS,
> > +                       hwlayer->index), offset);
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_SIZE,
> > +                       hwlayer->index), size);
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_CROP_START,
> > +                       hwlayer->index), hwlayer->src_y << 16 | hwlayer=
->src_x);
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_ALPHA,
> > +                       hwlayer->index), hwlayer->alpha);
> > +
> > +       info =3D drm_format_info(hwlayer->format);
> > +       if (hwlayer->planes =3D=3D 3) {
> > +               /* UV pitch is 1/2 of Y pitch*/
> > +               pitch =3D (hwlayer->pitch[0] / info->cpp[0]) |
> > +                               (hwlayer->pitch[0] / info->cpp[0] << 15=
);
> > +               DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_PITCH,
> > +                               hwlayer->index), pitch);
> > +       } else {
> > +               pitch =3D hwlayer->pitch[0] / info->cpp[0];
> > +               DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_PITCH,
> > +                               hwlayer->index), pitch);
> > +       }
> > +
> > +       ctrl =3D hwlayer->format |
> > +               hwlayer->blending |
> > +               (hwlayer->rotation & 0x7) << 20;
> > +
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_CTRL,
> > +                       hwlayer->index), ctrl);
> > +       DPU_REG_WR(ctx->base + DPU_LAY_REG(REG_LAY_CTRL,
> > +                       hwlayer->index), BIT_DPU_LAY_EN);
> > +
> > +       DRM_DEBUG("dst_x =3D %d, dst_y =3D %d, dst_w =3D %d, dst_h =3D =
%d\n",
> > +                               hwlayer->dst_x, hwlayer->dst_y,
> > +                               hwlayer->dst_w, hwlayer->dst_h);
> > +       DRM_DEBUG("start_x =3D %d, start_y =3D %d, start_w =3D %d, star=
t_h =3D %d\n",
> > +                               hwlayer->src_x, hwlayer->src_y,
> > +                               hwlayer->src_w, hwlayer->src_h);
> > +}
> > +
> > +static void dpu_flip(struct dpu_context *ctx,
> > +                    struct dpu_layer layers[], u8 count)
> > +{
> > +       int i;
> > +       u32 reg_val;
> > +
> > +       /*
> > +        * Make sure the dpu is in stop status. DPU_R2P0 has no shadow
> > +        * registers in EDPI mode. So the config registers can only be
> > +        * updated in the rising edge of DPU_RUN bit.
> > +        */
> > +       if (ctx->if_type =3D=3D SPRD_DPU_IF_EDPI)
> > +               dpu_wait_stop_done(ctx);
> > +
> > +       /* reset the bgcolor to black */
> > +       DPU_REG_WR(ctx->base + REG_BG_COLOR, 0x00);
> > +
> > +       /* disable all the layers */
> > +       dpu_clean_all(ctx);
> > +
> > +       /* start configure dpu layers */
> > +       for (i =3D 0; i < count; i++)
> > +               dpu_layer(ctx, &layers[i]);
> > +
> > +       /* update trigger and wait */
> > +       if (ctx->if_type =3D=3D SPRD_DPU_IF_DPI) {
> > +               if (!ctx->stopped) {
> > +                       DPU_REG_SET(ctx->base + REG_DPU_CTRL, BIT_DPU_R=
EG_UPDATE);
> > +                       dpu_wait_update_done(ctx);
> > +               }
> > +
> > +               DPU_REG_SET(ctx->base + REG_DPU_INT_EN, BIT_DPU_INT_ERR=
);
> > +       } else if (ctx->if_type =3D=3D SPRD_DPU_IF_EDPI) {
> > +               DPU_REG_SET(ctx->base + REG_DPU_CTRL, BIT_DPU_RUN);
> > +
> > +               ctx->stopped =3D false;
> > +       }
> > +
> > +       /*
> > +        * If the following interrupt was disabled in isr,
> > +        * re-enable it.
> > +        */
> > +       reg_val =3D BIT_DPU_INT_FBC_PLD_ERR |
> > +                 BIT_DPU_INT_FBC_HDR_ERR |
> > +                 BIT_DPU_INT_MMU_VAOR_RD |
> > +                 BIT_DPU_INT_MMU_VAOR_WR |
> > +                 BIT_DPU_INT_MMU_INV_RD |
> > +                 BIT_DPU_INT_MMU_INV_WR;
> > +       DPU_REG_SET(ctx->base + REG_DPU_INT_EN, reg_val);
> > +
> > +}
> > +
> > +static void dpu_dpi_init(struct dpu_context *ctx)
> > +{
> > +       u32 int_mask =3D 0;
> > +       u32 reg_val;
> > +
> > +       if (ctx->if_type =3D=3D SPRD_DPU_IF_DPI) {
> > +               /* use dpi as interface */
> > +               DPU_REG_CLR(ctx->base + REG_DPU_CFG0, BIT_DPU_IF_EDPI);
> > +
> > +               /* disable Halt function for SPRD DSI */
> > +               DPU_REG_CLR(ctx->base + REG_DPI_CTRL, BIT_DPU_DPI_HALT_=
EN);
> > +
> > +               /* select te from external pad */
> > +               DPU_REG_SET(ctx->base + REG_DPI_CTRL, BIT_DPU_EDPI_FROM=
_EXTERNAL_PAD);
> > +
> > +               /* set dpi timing */
> > +               reg_val =3D ctx->vm.hsync_len << 0 |
> > +                         ctx->vm.hback_porch << 8 |
> > +                         ctx->vm.hfront_porch << 20;
> > +               DPU_REG_WR(ctx->base + REG_DPI_H_TIMING, reg_val);
> > +
> > +               reg_val =3D ctx->vm.vsync_len << 0 |
> > +                         ctx->vm.vback_porch << 8 |
> > +                         ctx->vm.vfront_porch << 20;
> > +               DPU_REG_WR(ctx->base + REG_DPI_V_TIMING, reg_val);
> > +
> > +               if (ctx->vm.vsync_len + ctx->vm.vback_porch < 32)
> > +                       DRM_WARN("Warning: (vsync + vbp) < 32, "
> > +                               "underflow risk!\n");
> > +
> > +               /* enable dpu update done INT */
> > +               int_mask |=3D BIT_DPU_INT_UPDATE_DONE;
> > +               /* enable dpu DONE  INT */
> > +               int_mask |=3D BIT_DPU_INT_DONE;
> > +               /* enable dpu dpi vsync */
> > +               int_mask |=3D BIT_DPU_INT_VSYNC;
> > +               /* enable dpu TE INT */
> > +               int_mask |=3D BIT_DPU_INT_TE;
> > +               /* enable underflow err INT */
> > +               int_mask |=3D BIT_DPU_INT_ERR;
> > +       } else if (ctx->if_type =3D=3D SPRD_DPU_IF_EDPI) {
> > +               /* use edpi as interface */
> > +               DPU_REG_SET(ctx->base + REG_DPU_CFG0, BIT_DPU_IF_EDPI);
> > +
> > +               /* use external te */
> > +               DPU_REG_SET(ctx->base + REG_DPI_CTRL, BIT_DPU_EDPI_FROM=
_EXTERNAL_PAD);
> > +
> > +               /* enable te */
> > +               DPU_REG_SET(ctx->base + REG_DPI_CTRL, BIT_DPU_EDPI_TE_E=
N);
> > +
> > +               /* enable stop DONE INT */
> > +               int_mask |=3D BIT_DPU_INT_DONE;
> > +               /* enable TE INT */
> > +               int_mask |=3D BIT_DPU_INT_TE;
> > +       }
> > +
> > +       /* enable ifbc payload error INT */
> > +       int_mask |=3D BIT_DPU_INT_FBC_PLD_ERR;
> > +       /* enable ifbc header error INT */
> > +       int_mask |=3D BIT_DPU_INT_FBC_HDR_ERR;
> > +       /* enable iommu va out of range read error INT */
> > +       int_mask |=3D BIT_DPU_INT_MMU_VAOR_RD;
> > +       /* enable iommu va out of range write error INT */
> > +       int_mask |=3D BIT_DPU_INT_MMU_VAOR_WR;
> > +       /* enable iommu invalid read error INT */
> > +       int_mask |=3D BIT_DPU_INT_MMU_INV_RD;
> > +       /* enable iommu invalid write error INT */
> > +       int_mask |=3D BIT_DPU_INT_MMU_INV_WR;
> > +
> > +       DPU_REG_WR(ctx->base + REG_DPU_INT_EN, int_mask);
> > +}
> > +
> > +static void enable_vsync(struct dpu_context *ctx)
> > +{
> > +       DPU_REG_SET(ctx->base + REG_DPU_INT_EN, BIT_DPU_INT_VSYNC);
> > +}
> > +
> > +static void disable_vsync(struct dpu_context *ctx)
> > +{
> > +       DPU_REG_CLR(ctx->base + REG_DPU_INT_EN, BIT_DPU_INT_VSYNC);
> > +}
> > +
> > +static const u32 primary_fmts[] =3D {
> > +       DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> > +       DRM_FORMAT_ARGB8888, DRM_FORMAT_ABGR8888,
> > +       DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888,
> > +       DRM_FORMAT_RGBX8888, DRM_FORMAT_RGB565,
> > +       DRM_FORMAT_BGR565, DRM_FORMAT_NV12,
> > +       DRM_FORMAT_NV21, DRM_FORMAT_NV16,
> > +       DRM_FORMAT_NV61, DRM_FORMAT_YUV420,
> > +       DRM_FORMAT_YVU420,
> > +};
> > +
> > +static void dpu_capability(struct dpu_context *ctx,
> > +                       struct dpu_capability *cap)
> > +{
> > +       cap->max_layers =3D 6;
> > +       cap->fmts_ptr =3D primary_fmts;
> > +       cap->fmts_cnt =3D ARRAY_SIZE(primary_fmts);
> > +}
> > +
> > +const struct dpu_core_ops dpu_r2p0_core_ops =3D {
> > +       .init =3D dpu_init,
> > +       .fini =3D dpu_fini,
> > +       .run =3D dpu_run,
> > +       .stop =3D dpu_stop,
> > +       .isr =3D dpu_isr,
> > +       .ifconfig =3D dpu_dpi_init,
> > +       .capability =3D dpu_capability,
> > +       .flip =3D dpu_flip,
> > +       .enable_vsync =3D enable_vsync,
> > +       .disable_vsync =3D disable_vsync,
> > +};
> > diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/spr=
d_dpu.c
> > new file mode 100644
> > index 0000000..5ec8e7c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> > @@ -0,0 +1,646 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Unisoc Inc.
> > + */
> > +
> > +#include <linux/component.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_plane_helper.h>
> > +
> > +#include "sprd_drm.h"
> > +#include "sprd_dpu.h"
> > +
> > +struct sprd_plane {
> > +       struct drm_plane plane;
> > +       u32 index;
> > +       u32 addr[4];
> > +       u32 pitch[4];
> > +       u32 format;
> > +       u32 rotation;
> > +       u32 blend_mode;
> > +};
> > +
> > +static void sprd_dpu_init(struct sprd_dpu *dpu);
> > +static void sprd_dpu_fini(struct sprd_dpu *dpu);
> > +
> > +static inline struct sprd_plane *to_sprd_plane(struct drm_plane *plane=
)
> > +{
> > +       return container_of(plane, struct sprd_plane, plane);
> > +}
> > +
> > +static int sprd_plane_format_convert(u32 fourcc, u32 *format)
> > +{
> > +       switch (fourcc) {
> > +       case DRM_FORMAT_BGRA8888:
> > +               /* BGRA8888 -> ARGB8888 */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B3B2B1B0;
> > +               *format |=3D BIT_DPU_LAY_FORMAT_ARGB8888;
> > +               break;
> > +       case DRM_FORMAT_RGBX8888:
> > +       case DRM_FORMAT_RGBA8888:
> > +               /* RGBA8888 -> ABGR8888 */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B3B2B1B0;
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_ABGR8888:
> > +               /* RB switch */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_ARGB8888:
> > +               *format |=3D BIT_DPU_LAY_FORMAT_ARGB8888;
> > +               break;
> > +       case DRM_FORMAT_XBGR8888:
> > +               /* RB switch */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_XRGB8888:
> > +               *format |=3D BIT_DPU_LAY_FORMAT_ARGB8888;
> > +               break;
> > +       case DRM_FORMAT_BGR565:
> > +               /* RB switch */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_RGB565:
> > +               *format |=3D BIT_DPU_LAY_FORMAT_RGB565;
> > +               break;
> > +       case DRM_FORMAT_NV12:
> > +               /* 2-Lane: Yuv420 */
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV420_2PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_NO_SWITCH;
> > +               break;
> > +       case DRM_FORMAT_NV21:
> > +               /* 2-Lane: Yuv420 */
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV420_2PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               break;
> > +       case DRM_FORMAT_NV16:
> > +               /* 2-Lane: Yuv422 */
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV422_2PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B3B2B1B0;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               break;
> > +       case DRM_FORMAT_NV61:
> > +               /* 2-Lane: Yuv422 */
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV422_2PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_NO_SWITCH;
> > +               break;
> > +       case DRM_FORMAT_YUV420:
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV420_3PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_NO_SWITCH;
> > +               break;
> > +       case DRM_FORMAT_YVU420:
> > +               *format |=3D BIT_DPU_LAY_FORMAT_YUV420_3PLANE;
> > +               /* Y endian */
> > +               *format |=3D BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3;
> > +               /* UV endian */
> > +               *format |=3D BIT_DPU_LAY_RB_OR_UV_SWITCH;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_plane_rotation_convert(u32 angle, u32 *rotation)
> > +{
> > +       switch (angle) {
> > +       case DRM_MODE_ROTATE_0:
> > +               *rotation =3D DPU_LAYER_ROTATION_0;
> > +               break;
> > +       case DRM_MODE_ROTATE_90:
> > +               *rotation =3D DPU_LAYER_ROTATION_90;
> > +               break;
> > +       case DRM_MODE_ROTATE_180:
> > +               *rotation =3D DPU_LAYER_ROTATION_180;
> > +               break;
> > +       case DRM_MODE_ROTATE_270:
> > +               *rotation =3D DPU_LAYER_ROTATION_270;
> > +               break;
> > +       case DRM_MODE_REFLECT_Y:
> > +               *rotation =3D DPU_LAYER_ROTATION_180_M;
> > +               break;
> > +       case (DRM_MODE_REFLECT_Y | DRM_MODE_ROTATE_90):
> > +               *rotation =3D DPU_LAYER_ROTATION_90_M;
> > +               break;
> > +       case DRM_MODE_REFLECT_X:
> > +               *rotation =3D DPU_LAYER_ROTATION_0_M;
> > +               break;
> > +       case (DRM_MODE_REFLECT_X | DRM_MODE_ROTATE_90):
> > +               *rotation =3D DPU_LAYER_ROTATION_270_M;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_plane_atomic_check(struct drm_plane *plane,
> > +                                 struct drm_plane_state *state)
> > +{
> > +       struct sprd_plane *p =3D to_sprd_plane(plane);
> > +       struct drm_framebuffer *fb =3D state->fb;
> > +       struct drm_gem_cma_object *cma_obj;
> > +       int i, ret;
> > +       u32 addr;
> > +
> > +       if (!state->fb || !state->crtc)
> > +               return 0;
> > +
> > +       ret =3D sprd_plane_format_convert(fb->format->format,
> > +                                       &p->format);
> > +       if (ret < 0) {
> > +               DRM_ERROR("Invalid plane format\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D sprd_plane_rotation_convert(state->rotation,
> > +                                       &p->rotation);
> > +       if (ret < 0) {
> > +               DRM_ERROR("Invalid plane rotation\n");
> > +               return ret;
> > +       }
> > +
> > +       switch (state->pixel_blend_mode) {
> > +       case DRM_MODE_BLEND_COVERAGE:
> > +               /* alpha mode select - combo alpha */
> > +               p->blend_mode |=3D BIT_DPU_LAY_COMBO_ALPHA;
> > +               /* Normal mode */
> > +               p->blend_mode |=3D BIT_DPU_LAY_MODE_BLEND_NORMAL;
> > +               break;
> > +       case DRM_MODE_BLEND_PREMULTI:
> > +               /* alpha mode select - combo alpha */
> > +               p->blend_mode |=3D BIT_DPU_LAY_COMBO_ALPHA;
> > +               /* Pre-mult mode */
> > +               p->blend_mode |=3D BIT_DPU_LAY_MODE_BLEND_PREMULT;
> > +               break;
> > +       case DRM_MODE_BLEND_PIXEL_NONE:
> > +       default:
> > +               /* don't do blending, maybe RGBX */
> > +               /* alpha mode select - layer alpha */
> > +               p->blend_mode |=3D BIT_DPU_LAY_LAYER_ALPHA;
> > +               break;
> > +       }
> > +
> > +       for (i =3D 0; i < fb->format->num_planes; i++) {
> > +               cma_obj =3D drm_fb_cma_get_gem_obj(fb, i);
> > +               addr =3D cma_obj->paddr + fb->offsets[i];
> > +               if (addr % 16) {
> > +                       DRM_ERROR("layer addr[%d] is not 16 bytes align=
, it's 0x%08x\n",
> > +                               i, addr);
> > +                       return -EFAULT;
> > +               }
> > +
> > +               p->addr[i] =3D addr;
> > +               p->pitch[i] =3D fb->pitches[i];
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_plane_atomic_update(struct drm_plane *plane,
> > +                                   struct drm_plane_state *old_state)
> > +{
> > +       struct drm_plane_state *state =3D plane->state;
> > +       struct drm_framebuffer *fb =3D plane->state->fb;
> > +       struct sprd_plane *p =3D to_sprd_plane(plane);
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(plane->state->crtc);
> > +       struct dpu_layer *layer =3D &dpu->layers[p->index];
> > +       int i;
> > +
> > +       if (!state->crtc || !state->fb)
> > +               return;
> > +
> > +       layer->index =3D p->index;
> > +       layer->src_x =3D state->src_x >> 16;
> > +       layer->src_y =3D state->src_y >> 16;
> > +       layer->src_w =3D state->src_w >> 16;
> > +       layer->src_h =3D state->src_h >> 16;
> > +       layer->dst_x =3D state->crtc_x;
> > +       layer->dst_y =3D state->crtc_y;
> > +       layer->dst_w =3D state->crtc_w;
> > +       layer->dst_h =3D state->crtc_h;
> > +       layer->alpha =3D state->alpha;
> > +       layer->format =3D p->format;
> > +       layer->blending =3D p->blend_mode;
> > +       layer->rotation =3D p->rotation;
> > +       layer->planes =3D fb->format->num_planes;
> > +
> > +       for (i =3D 0; i < layer->planes; i++) {
> > +               layer->addr[i] =3D p->addr[i];
> > +               layer->pitch[i] =3D p->pitch[i];
> > +       }
> > +
> > +       dpu->pending_planes++;
> > +}
> > +
> > +static void sprd_plane_create_properties(struct sprd_plane *p, int ind=
ex)
> > +{
> > +       unsigned int supported_modes =3D BIT(DRM_MODE_BLEND_PIXEL_NONE)=
 |
> > +                                      BIT(DRM_MODE_BLEND_PREMULTI) |
> > +                                      BIT(DRM_MODE_BLEND_COVERAGE);
> > +
> > +       /* create rotation property */
> > +       drm_plane_create_rotation_property(&p->plane,
> > +                                          DRM_MODE_ROTATE_0,
> > +                                          DRM_MODE_ROTATE_MASK |
> > +                                          DRM_MODE_REFLECT_MASK);
> > +
> > +       /* create alpha property */
> > +       drm_plane_create_alpha_property(&p->plane);
> > +
> > +       /* create blend mode property */
> > +       drm_plane_create_blend_mode_property(&p->plane, supported_modes=
);
> > +
> > +       /* create zpos property */
> > +       drm_plane_create_zpos_immutable_property(&p->plane, index);
> > +}
> > +
> > +static const struct drm_plane_helper_funcs sprd_plane_helper_funcs =3D=
 {
> > +       .atomic_check =3D sprd_plane_atomic_check,
> > +       .atomic_update =3D sprd_plane_atomic_update,
> > +};
> > +
> > +static const struct drm_plane_funcs sprd_plane_funcs =3D {
> > +       .update_plane =3D drm_atomic_helper_update_plane,
> > +       .disable_plane  =3D drm_atomic_helper_disable_plane,
> > +       .destroy =3D drm_plane_cleanup,
> > +       .reset =3D drm_atomic_helper_plane_reset,
> > +       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_s=
tate,
> > +       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state=
,
> > +};
> > +
> > +static struct drm_plane *sprd_plane_init(struct drm_device *drm,
> > +                                       struct sprd_dpu *dpu)
> > +{
> > +       struct drm_plane *primary =3D NULL;
> > +       struct sprd_plane *p =3D NULL;
> > +       struct dpu_capability cap =3D {};
> > +       int ret, i;
> > +
> > +       dpu->core->capability(&dpu->ctx, &cap);
> > +
> > +       dpu->layers =3D devm_kcalloc(drm->dev, cap.max_layers,
> > +                                 sizeof(struct dpu_layer), GFP_KERNEL)=
;
> > +       if (!dpu->layers)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       for (i =3D 0; i < cap.max_layers; i++) {
> > +
> > +               p =3D devm_kzalloc(drm->dev, sizeof(*p), GFP_KERNEL);
> > +               if (!p)
> > +                       return ERR_PTR(-ENOMEM);
> > +
> > +               ret =3D drm_universal_plane_init(drm, &p->plane, 1,
> > +                                              &sprd_plane_funcs, cap.f=
mts_ptr,
> > +                                              cap.fmts_cnt, NULL,
> > +                                              DRM_PLANE_TYPE_PRIMARY, =
NULL);
> > +               if (ret) {
> > +                       DRM_ERROR("fail to init primary plane\n");
> > +                       return ERR_PTR(ret);
> > +               }
> > +
> > +               drm_plane_helper_add(&p->plane, &sprd_plane_helper_func=
s);
> > +
> > +               sprd_plane_create_properties(p, i);
> > +
> > +               p->index =3D i;
> > +               if (i =3D=3D 0)
> > +                       primary =3D &p->plane;
> > +       }
> > +
> > +       return primary;
> > +}
> > +
> > +static enum drm_mode_status sprd_crtc_mode_valid(struct drm_crtc *crtc=
,
> > +                                       const struct drm_display_mode *=
mode)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       DRM_DEBUG("%s() mode: "DRM_MODE_FMT"\n", __func__, DRM_MODE_ARG=
(mode));
> > +
> > +       if (mode->type & DRM_MODE_TYPE_PREFERRED) {
> > +               drm_display_mode_to_videomode(mode, &dpu->ctx.vm);
> > +
> > +               if ((mode->hdisplay =3D=3D mode->htotal) ||
> > +                   (mode->vdisplay =3D=3D mode->vtotal))
> > +                       dpu->ctx.if_type =3D SPRD_DPU_IF_EDPI;
> > +               else
> > +                       dpu->ctx.if_type =3D SPRD_DPU_IF_DPI;
> > +       }
> > +
> > +       return MODE_OK;
> > +}
> > +
> > +static void sprd_crtc_atomic_enable(struct drm_crtc *crtc,
> > +                                  struct drm_crtc_state *old_state)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       sprd_dpu_init(dpu);
> > +
> > +       enable_irq(dpu->ctx.irq);
> > +}
> > +
> > +static void sprd_crtc_atomic_disable(struct drm_crtc *crtc,
> > +                                   struct drm_crtc_state *old_state)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +       struct drm_device *drm =3D dpu->crtc.dev;
> > +
> > +       disable_irq(dpu->ctx.irq);
> > +
> > +       sprd_dpu_fini(dpu);
> > +
> > +       spin_lock_irq(&drm->event_lock);
> > +       if (crtc->state->event) {
> > +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +               crtc->state->event =3D NULL;
> > +       }
> > +       spin_unlock_irq(&drm->event_lock);
> > +}
> > +
> > +static int sprd_crtc_atomic_check(struct drm_crtc *crtc,
> > +                                struct drm_crtc_state *state)
> > +{
> > +       DRM_DEBUG("%s()\n", __func__);
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_crtc_atomic_begin(struct drm_crtc *crtc,
> > +                                 struct drm_crtc_state *old_state)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       memset(dpu->layers, 0, sizeof(*dpu->layers) * dpu->pending_plan=
es);
> > +
> > +       dpu->pending_planes =3D 0;
> > +}
> > +
> > +static void sprd_crtc_atomic_flush(struct drm_crtc *crtc,
> > +                                 struct drm_crtc_state *old_state)
> > +
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +       struct drm_device *drm =3D dpu->crtc.dev;
> > +
> > +       if (dpu->pending_planes)
> > +               dpu->core->flip(&dpu->ctx, dpu->layers, dpu->pending_pl=
anes);
> > +
> > +       spin_lock_irq(&drm->event_lock);
> > +       if (crtc->state->event) {
> > +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +               crtc->state->event =3D NULL;
> > +       }
> > +       spin_unlock_irq(&drm->event_lock);
> > +}
> > +
> > +static int sprd_crtc_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       dpu->core->enable_vsync(&dpu->ctx);
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_crtc_disable_vblank(struct drm_crtc *crtc)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       dpu->core->disable_vsync(&dpu->ctx);
> > +}
> > +
> > +static const struct drm_crtc_helper_funcs sprd_crtc_helper_funcs =3D {
> > +       .mode_valid     =3D sprd_crtc_mode_valid,
> > +       .atomic_check   =3D sprd_crtc_atomic_check,
> > +       .atomic_begin   =3D sprd_crtc_atomic_begin,
> > +       .atomic_flush   =3D sprd_crtc_atomic_flush,
> > +       .atomic_enable  =3D sprd_crtc_atomic_enable,
> > +       .atomic_disable =3D sprd_crtc_atomic_disable,
> > +};
> > +
> > +static const struct drm_crtc_funcs sprd_crtc_funcs =3D {
> > +       .destroy        =3D drm_crtc_cleanup,
> > +       .set_config     =3D drm_atomic_helper_set_config,
> > +       .page_flip      =3D drm_atomic_helper_page_flip,
> > +       .reset          =3D drm_atomic_helper_crtc_reset,
> > +       .atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_st=
ate,
> > +       .atomic_destroy_state   =3D drm_atomic_helper_crtc_destroy_stat=
e,
> > +       .enable_vblank  =3D sprd_crtc_enable_vblank,
> > +       .disable_vblank =3D sprd_crtc_disable_vblank,
> > +};
> > +
> > +static int sprd_crtc_init(struct drm_device *drm, struct drm_crtc *crt=
c,
> > +                        struct drm_plane *primary)
> > +{
> > +       struct device_node *port;
> > +       int ret;
> > +
> > +       /*
> > +        * set crtc port so that drm_of_find_possible_crtcs call works
> > +        */
> > +       port =3D of_parse_phandle(drm->dev->of_node, "ports", 0);
> > +       if (!port) {
> > +               DRM_ERROR("find 'ports' phandle of %s failed\n",
> > +                         drm->dev->of_node->full_name);
> > +               return -EINVAL;
> > +       }
> > +       of_node_put(port);
> > +       crtc->port =3D port;
> > +
> > +       ret =3D drm_crtc_init_with_planes(drm, crtc, primary, NULL,
> > +                                       &sprd_crtc_funcs, NULL);
> > +       if (ret) {
> > +               DRM_ERROR("failed to init crtc.\n");
> > +               return ret;
> > +       }
> > +
> > +       drm_mode_crtc_set_gamma_size(crtc, 256);
> > +
> > +       drm_crtc_helper_add(crtc, &sprd_crtc_helper_funcs);
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_dpu_init(struct sprd_dpu *dpu)
> > +{
> > +       struct dpu_context *ctx =3D &dpu->ctx;
> > +
> > +       dpu->core->init(ctx);
> > +       dpu->core->ifconfig(ctx);
> > +}
> > +
> > +static void sprd_dpu_fini(struct sprd_dpu *dpu)
> > +{
> > +       struct dpu_context *ctx =3D &dpu->ctx;
> > +
> > +       dpu->core->fini(ctx);
> > +}
> > +
> > +static irqreturn_t sprd_dpu_isr(int irq, void *data)
> > +{
> > +       struct sprd_dpu *dpu =3D data;
> > +       struct dpu_context *ctx =3D &dpu->ctx;
> > +       u32 int_mask =3D 0;
> > +
> > +       int_mask =3D dpu->core->isr(ctx);
> > +
> > +       if (int_mask & BIT_DPU_INT_ERR)
> > +               DRM_WARN("Warning: dpu underflow!\n");
> > +
> > +       if (int_mask & BIT_DPU_INT_VSYNC)
> > +               drm_crtc_handle_vblank(&dpu->crtc);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int sprd_dpu_bind(struct device *dev, struct device *master, vo=
id *data)
> > +{
> > +       struct drm_device *drm =3D data;
> > +       struct sprd_dpu *dpu =3D dev_get_drvdata(dev);
> > +       struct drm_plane *plane;
> > +       int ret;
> > +
> > +       plane =3D sprd_plane_init(drm, dpu);
> > +       if (IS_ERR_OR_NULL(plane)) {
> > +               ret =3D PTR_ERR(plane);
> > +               return ret;
> > +       }
> > +
> > +       ret =3D sprd_crtc_init(drm, &dpu->crtc, plane);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_dpu_unbind(struct device *dev, struct device *master,
> > +       void *data)
> > +{
> > +       struct sprd_dpu *dpu =3D dev_get_drvdata(dev);
> > +
> > +       drm_crtc_cleanup(&dpu->crtc);
> > +}
> > +
> > +static const struct component_ops dpu_component_ops =3D {
> > +       .bind =3D sprd_dpu_bind,
> > +       .unbind =3D sprd_dpu_unbind,
> > +};
> > +
> > +static int sprd_dpu_context_init(struct sprd_dpu *dpu,
> > +                               struct device *dev)
> > +{
> > +       struct platform_device *pdev =3D to_platform_device(dev);
> > +       struct dpu_context *ctx =3D &dpu->ctx;
> > +       struct resource *res;
> > +       int ret;
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       ctx->base =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> > +       if (!ctx->base) {
> > +               DRM_ERROR("failed to map dpu registers\n");
> > +               return -EFAULT;
> > +       }
> > +
> > +       ctx->irq =3D platform_get_irq(pdev, 0);
> > +       if (ctx->irq < 0) {
> > +               DRM_ERROR("failed to get dpu irq\n");
> > +               return ctx->irq;
> > +       }
> > +
> > +       irq_set_status_flags(ctx->irq, IRQ_NOAUTOEN);
> > +       ret =3D devm_request_irq(dev, ctx->irq, sprd_dpu_isr,
> > +                                       0, "DPU", dpu);
> > +       if (ret) {
> > +               DRM_ERROR("failed to register dpu irq handler\n");
> > +               return ret;
> > +       }
> > +
> > +       init_waitqueue_head(&ctx->wait_queue);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct sprd_dpu_ops sharkl3_dpu =3D {
> > +       .core =3D &dpu_r2p0_core_ops,
> > +};
> > +
> > +static const struct of_device_id dpu_match_table[] =3D {
> > +       { .compatible =3D "sprd,sharkl3-dpu",
> > +         .data =3D &sharkl3_dpu },
> > +       { /* sentinel */ },
> > +};
> > +
> > +static int sprd_dpu_probe(struct platform_device *pdev)
> > +{
> > +       const struct sprd_dpu_ops *pdata;
> > +       struct sprd_dpu *dpu;
> > +       int ret;
> > +
> > +       dpu =3D devm_kzalloc(&pdev->dev, sizeof(*dpu), GFP_KERNEL);
> > +       if (!dpu)
> > +               return -ENOMEM;
> > +
> > +       pdata =3D of_device_get_match_data(&pdev->dev);
> > +       if (pdata) {
> > +               dpu->core =3D pdata->core;
> > +       } else {
> > +               DRM_ERROR("No matching driver data found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D sprd_dpu_context_init(dpu, &pdev->dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       platform_set_drvdata(pdev, dpu);
> > +
> > +       return component_add(&pdev->dev, &dpu_component_ops);
> > +}
> > +
> > +static int sprd_dpu_remove(struct platform_device *pdev)
> > +{
> > +       component_del(&pdev->dev, &dpu_component_ops);
> > +       return 0;
> > +}
> > +
> > +struct platform_driver sprd_dpu_driver =3D {
> > +       .probe =3D sprd_dpu_probe,
> > +       .remove =3D sprd_dpu_remove,
> > +       .driver =3D {
> > +               .name =3D "sprd-dpu-drv",
> > +               .of_match_table =3D dpu_match_table,
> > +       },
> > +};
> > +
> > +MODULE_AUTHOR("Leon He <leon.he@unisoc.com>");
> > +MODULE_AUTHOR("Kevin Tang <kevin.tang@unisoc.com>");
> > +MODULE_DESCRIPTION("Unisoc Display Controller Driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/gpu/drm/sprd/sprd_dpu.h b/drivers/gpu/drm/sprd/spr=
d_dpu.h
> > new file mode 100644
> > index 0000000..7d3c5e4
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_dpu.h
> > @@ -0,0 +1,187 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020 Unisoc Inc.
> > + */
> > +
> > +#ifndef __SPRD_DPU_H__
> > +#define __SPRD_DPU_H__
> > +
> > +#include <linux/bug.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +#include <video/videomode.h>
> > +
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_fourcc.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_vblank.h>
> > +#include <uapi/drm/drm_mode.h>
> > +
> > +#define BIT_DPU_INT_DONE_              BIT(0)
> > +#define BIT_DPU_INT_TE                 BIT(1)
> > +#define BIT_DPU_INT_ERR                        BIT(2)
> > +#define BIT_DPU_INT_EDPI_TE            BIT(3)
> > +#define BIT_DPU_INT_UPDATE_DONE                BIT(4)
> > +#define BIT_DPU_INT_VSYNC              BIT(5)
> > +#define BIT_DPU_INT_WB_DONE            BIT(6)
> > +#define BIT_DPU_INT_WB_ERR             BIT(7)
> > +
> > +#define BIT_DPU_LAY_LAYER_ALPHA                        (0x01 << 2)
> > +#define BIT_DPU_LAY_COMBO_ALPHA                        (0x02 << 2)
> > +#define BIT_DPU_LAY_FORMAT_YUV422_2PLANE               (0x00 << 4)
> > +#define BIT_DPU_LAY_FORMAT_YUV420_2PLANE               (0x01 << 4)
> > +#define BIT_DPU_LAY_FORMAT_YUV420_3PLANE               (0x02 << 4)
> > +#define BIT_DPU_LAY_FORMAT_ARGB8888                    (0x03 << 4)
> > +#define BIT_DPU_LAY_FORMAT_RGB565                      (0x04 << 4)
> > +#define BIT_DPU_LAY_DATA_ENDIAN_B0B1B2B3               (0x00 << 8)
> > +#define BIT_DPU_LAY_DATA_ENDIAN_B3B2B1B0               (0x01 << 8)
> > +#define BIT_DPU_LAY_NO_SWITCH                  (0x00 << 10)
> > +#define BIT_DPU_LAY_RB_OR_UV_SWITCH            (0x01 << 10)
> > +#define BIT_DPU_LAY_MODE_BLEND_NORMAL          (0x00 << 16)
> > +#define BIT_DPU_LAY_MODE_BLEND_PREMULT         (0x01 << 16)
> > +
> > +enum {
> > +       SPRD_DPU_IF_DBI =3D 0,
> > +       SPRD_DPU_IF_DPI,
> > +       SPRD_DPU_IF_EDPI,
> > +       SPRD_DPU_IF_LIMIT
> > +};
> > +
> > +enum {
> > +       DPU_LAYER_ROTATION_0,
> > +       DPU_LAYER_ROTATION_90,
> > +       DPU_LAYER_ROTATION_180,
> > +       DPU_LAYER_ROTATION_270,
> > +       DPU_LAYER_ROTATION_0_M,
> > +       DPU_LAYER_ROTATION_90_M,
> > +       DPU_LAYER_ROTATION_180_M,
> > +       DPU_LAYER_ROTATION_270_M,
> > +};
> > +
> > +struct dpu_layer {
> > +       u8 index;
> > +       u8 planes;
> > +       u32 addr[4];
> > +       u32 pitch[4];
> > +       s16 src_x;
> > +       s16 src_y;
> > +       s16 src_w;
> > +       s16 src_h;
> > +       s16 dst_x;
> > +       s16 dst_y;
> > +       u16 dst_w;
> > +       u16 dst_h;
> > +       u32 format;
> > +       u32 alpha;
> > +       u32 blending;
> > +       u32 rotation;
> > +};
> > +
> > +/**
> > + * Sprd DPU capability structure
> > + *
> > + * @max_layers: maximum number of layers available
> > + * @fmts_ptr: A pointer to array of supported pixel formats
> > + * @fmts_cnt: the number of format on @fmts_ptr
> > + */
> > +struct dpu_capability {
> > +       u32 max_layers;
> > +       const u32 *fmts_ptr;
> > +       u32 fmts_cnt;
> > +};
> > +
> > +/**
> > + * Sprd DPU core callback ops
> > + *
> > + * This structure decribes the display controller common
> > + * callback ops
> > + *
> > + * @init: initial DPU core
> > + * @fini: cleanup DPU core
> > + * @run: enable DPU output
> > + * @stop: disable DPU output
> > + * @enable_vsync: enable vblank interrupt
> > + * @disable_vsync: disable vblank interrupt
> > + * @isr: function pointer to the isr
> > + * @ifconfig: initial DPI interface
> > + * @flip: commit CRTC planes to DPU
> > + * @capability: callback for DPU capabilities
> > + */
> > +struct dpu_context;
> > +struct dpu_core_ops {
> > +       void (*init)(struct dpu_context *ctx);
> > +       void (*fini)(struct dpu_context *ctx);
> > +       void (*run)(struct dpu_context *ctx);
> > +       void (*stop)(struct dpu_context *ctx);
> > +       void (*enable_vsync)(struct dpu_context *ctx);
> > +       void (*disable_vsync)(struct dpu_context *ctx);
> > +       u32 (*isr)(struct dpu_context *ctx);
> > +       void (*ifconfig)(struct dpu_context *ctx);
> > +       void (*flip)(struct dpu_context *ctx,
> > +                    struct dpu_layer layers[], u8 count);
> > +       void (*capability)(struct dpu_context *ctx,
> > +                       struct dpu_capability *cap);
> > +};
> > +
> > +/**
> > + * Sprd DPU context structure
> > + *
> > + * @base: DPU controller base address
> > + * @irq: IRQ number to install the handler for
> > + * @if_type: The type of DPI interface, default is DPI mode.
> > + * @vm: videomode structure to use for DPU and DPI initialization
> > + * @stopped: indicates whether DPU are stopped
> > + * @wait_queue: wait queue, used to wait for DPU shadow register updat=
e done and
> > + * DPU stop register done interrupt signal.
> > + * @evt_update: wait queue condition for DPU shadow register
> > + * @evt_stop: wait queue condition for DPU stop register
> > + */
> > +struct dpu_context {
> > +       void __iomem *base;
> > +       int irq;
> > +       u8 if_type;
> > +       struct videomode vm;
> > +       bool stopped;
> > +       wait_queue_head_t wait_queue;
> > +       bool evt_update;
> > +       bool evt_stop;
> > +};
> > +
> > +/**
> > + * Sprd DPU device structure
> > + *
> > + * @crtc: DRM crtc
> > + * @ctx: A pointer to the DPU's implementation specific context
> > + * @core: pointer to callbacks for DPU core functionality
> > + * @layers: active DPU layers ready to commit
> > + * @pending_planes: the number of layers on @layers
> > + */
> > +struct sprd_dpu {
> > +       struct drm_crtc crtc;
> > +       struct dpu_context ctx;
> > +       const struct dpu_core_ops *core;
> > +       struct dpu_layer *layers;
> > +       u8 pending_planes;
> > +};
> > +
> > +/**
> > + * Sprd DPU H/W callback ops match table structure
> > + * The structure used for matching a specific device callback ops
> > + *
> > + * @core: pointer to callbacks for DPU core functionality
> > + */
> > +struct sprd_dpu_ops {
> > +       const struct dpu_core_ops *core;
> > +};
> > +
> > +static inline struct sprd_dpu *crtc_to_dpu(struct drm_crtc *crtc)
> > +{
> > +       return crtc ? container_of(crtc, struct sprd_dpu, crtc) : NULL;
> > +}
> > +
> > +extern const struct dpu_core_ops dpu_r2p0_core_ops;
> > +
> > +#endif
> > diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/spr=
d_drm.c
> > index 4706185..200020f 100644
> > --- a/drivers/gpu/drm/sprd/sprd_drm.c
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.c
> > @@ -200,6 +200,7 @@ static struct platform_driver sprd_drm_driver =3D {
> >
> >  static struct platform_driver *sprd_drm_drivers[]  =3D {
> >         &sprd_drm_driver,
> > +       &sprd_dpu_driver,
> >  };
> >
> >  static int __init sprd_drm_init(void)
> > diff --git a/drivers/gpu/drm/sprd/sprd_drm.h b/drivers/gpu/drm/sprd/spr=
d_drm.h
> > index edf0881..3c32f3a 100644
> > --- a/drivers/gpu/drm/sprd/sprd_drm.h
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.h
> > @@ -13,4 +13,6 @@ struct sprd_drm {
> >         struct drm_device *drm;
> >  };
> >
> > +extern struct platform_driver sprd_dpu_driver;
> > +
> >  #endif /* _SPRD_DRM_H_ */
> > --
> > 2.7.4
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
