Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE6C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB12206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUkycIGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGKA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:00:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41945 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:00:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so3622983qtr.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yDGBspS/Vs9DNDUoPfT0os2H3JB2qjDoI2tZ7uyD218=;
        b=mUkycIGi4oYACH1QaL1icEImRWZSt902+QXKn3SQBhntJMwPfuyO8L9rM4rlTpZ0by
         0H06Uldy0yy9xPqOePSssOAWiIN8OmvhOHpuoVFrdgpSkQzdKYRr3b6EcuscU98eiSBT
         I3LvuyBBDTn2lFO8Vmtf4Nfy4FuLDNKIQsPcDe9yfppEO3fNkZC9lB7T538nxYapsuNO
         GRWgpXk6Ud47xIaqQOEUGdI/u198RNyfO1g58kfid8+SP5gD6tBP08Chn16/6BXHXmfX
         kQF+YikO9e5LBvxT7UKvKVFIW1j6fDtCCJDaGCrFr2+zVqjsSVxrgix+riTwN7BOqoF1
         pFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yDGBspS/Vs9DNDUoPfT0os2H3JB2qjDoI2tZ7uyD218=;
        b=rrwV6QLez14PWw6FFWU+X9SRYGfilkPx0x5xgNRmWsATvPhrm5dQjoJBrgHJQKUCA/
         vaXycqMH0fJSggfgyxGi/RPwS5c54d6Yb1q8N67yc2O6yoifwSZklKOVjrR+gnrnsbgX
         JVGC1sM2s5lDLiX6sl4al8hKjJ67zFyFcqacQSnJN2FgdiaaY+IM7576iN9ggEu/DmkX
         0Grj7uyzGI65cw2xpFhtFwvbij4PpuhBuWCNgJk2er0JhEMnNpsEGcM/0EDsMFfAE5mb
         fQsOW3gMcdaIzcO1aNzPcZz0BagzeiHMzpaKvnEcIkUkaY1aj9qVCZjTdeBXygFPUuE0
         nJwg==
X-Gm-Message-State: ANhLgQ11LmlN6wjsLihwzK9t1DzxOVnI0u7gcPKpZGsDTnpepfivZh2c
        ZqUEDaPqawriyV6aa8PmR4Fj5yWbpO8sKhVLS8M=
X-Google-Smtp-Source: ADFU+vtczD9jv6SweX81rCr8EDQAcn1DdQ6jOGu9HP7lYy7M0xoTMMY56pvUkFsh8kT6AwsON57IioxbyyVHViNEON4=
X-Received: by 2002:ac8:5484:: with SMTP id h4mr6582813qtq.209.1583575255635;
 Sat, 07 Mar 2020 02:00:55 -0800 (PST)
MIME-Version: 1.0
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
 <1582710377-15489-5-git-send-email-kevin3.tang@gmail.com> <CACvgo53dME1ioYebimSzdOMvjAudtmzpz_-5Q7rNqQnZoBpaqA@mail.gmail.com>
In-Reply-To: <CACvgo53dME1ioYebimSzdOMvjAudtmzpz_-5Q7rNqQnZoBpaqA@mail.gmail.com>
From:   tang pengchuan <kevin3.tang@gmail.com>
Date:   Sat, 7 Mar 2020 18:00:44 +0800
Message-ID: <CAFPSGXaN1SHCK1QqEca3XcYxTV45fdRBzj5KejW6zr3z4dx_aw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,
Maybe here is your missing comments
I =E2=80=99m really sorry, sometimes I forget to use plain text by gmail,
never make the same mistake again.

Emil Velikov <emil.l.velikov@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Kevin,
>
> There's a few small suggestions, although overall the driver looks a lot =
better.
>
> On Thu, 27 Feb 2020 at 08:14, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/dpu/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +ifdef CONFIG_ARM64
> > +KBUILD_CFLAGS +=3D -mstrict-align
>
>
> There are many other drivers that do not use readl/writel for register ac=
cess,
> yet none has this workaround... Even those that they are exclusively ARM6=
4.
>
> Have you tried that it's not a buggy version of GCC? At the very least, I=
'd
> encourage you to add a brief comment about the problem + setup.
>
> ... In general I think one should follow the suggestions from Rob Herring=
.
>
Yocto v2.5
aarch64-linaro-linux-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011

Crash Stack:
/sprd/drv/dispc/dpu_r2p0.c:729
1796256 ffffff8008486650:       f803c043        stur    x3, [x2,#60]
=3D>Unhandled fault: alignment fault (0x96000061) at 0xffffff80098b883c

729         reg->mmu_min_ppn1 =3D 0;
730         reg->mmu_ppn_range1 =3D 0xffff;
731         reg->mmu_min_ppn2 =3D 0;
732         reg->mmu_ppn_range2 =3D 0xffff;

The above C code operation are continuous. The compiler may think that
the access can be completed by directly using two 64-bit assignment
operations, so it is optimized to 64-bit operation.

Assembly code=EF=BC=9A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
/sprd/drv/dispc/dpu_r2p0.c:729
1796244 ffffff8008486638:       91200022        add     x2, x1, #0x800
/sprd/drv/dispc/dpu_r2p0.c:728
1796246 ffffff800848663c:       b908003f        str     wzr, [x1,#2048]
/sprd/drv/dispc/dpu_r2p0.c:729
1796248 ffffff8008486640:       d2dfffe3        mov     x3,
#0xffff00000000
/sprd/drv/dispc/dpu_r2p0.c:733
1796250 ffffff8008486644:       12bfffc4        mov     w4, #0x1ffff
/sprd/drv/dispc/dpu_r2p0.c:735
1796252 ffffff8008486648:       529fffe5        mov     w5, #0xffff
/sprd/drv/dispc/dpu_r2p0.c:741
1796254 ffffff800848664c:       52800000        mov     w0, #0x0
/sprd/drv/dispc/dpu_r2p0.c:729
1796256 ffffff8008486650:       f803c043        stur    x3, [x2,#60]
=3D>Unhandled fault: alignment fault (0x96000061) at 0xffffff80098b883c
/sprd/drv/dispc/dpu_r2p0.c:730
1796258 ffffff8008486654:       f8044043        stur    x3, [x2,#68]
/sprd/drv/dispc/dpu_r2p0.c:735
1796260 ffffff8008486658:       b901e425        str     w5, [x1,#484]
/sprd/drv/dispc/dpu_r2p0.c:733
1796262 ffffff800848665c:       b9080c24        str     w4, [x1,#2060]
1796263 ffffff8008486660:       f9400274        ldr     x20, [x19]
>
>
> > +static void dpu_dump(struct dpu_context *ctx)
> > +{
> > +       u32 *reg =3D (u32 *)ctx->base;
> > +       int i;
> > +
> > +       pr_info("      0          4          8          C\n");
> > +       for (i =3D 0; i < 256; i +=3D 4) {
> > +               pr_info("%04x: 0x%08x 0x%08x 0x%08x 0x%08x\n",
> > +                       i * 4, reg[i], reg[i + 1], reg[i + 2], reg[i + =
3]);
>
> Using some of the helpers from drm_print.h would be better than pr_*.
> This applies for the rest of the patch.
>
>
> > +static void dpu_clean_all(struct dpu_context *ctx)
> > +{
> > +       int i;
> > +       struct dpu_reg *reg =3D (struct dpu_reg *)ctx->base;
> > +
> > +       for (i =3D 0; i < 8; i++)
>
> This "< 8" seem pretty magical. How about "< ARRAY_SIZE(reg->layers)"
> Same logic applies through the rest of the patch.
>
>
> > +static int dpu_wait_stop_done(struct dpu_context *ctx)
> > +{
> > +       int rc;
> > +
> > +       if (ctx->stopped)
> > +               return 0;
> > +
> The stopped handling does look suspicious. Admittedly I did not look too =
closely
> at the dpu_flip code, which seems to require it.
>
> Let's add a small comment in the struct dpu_context::stopped declaration,=
 why it
> is needed, if it truely is.
>
> > +       rc =3D wait_event_interruptible_timeout(ctx->wait_queue, ctx->e=
vt_stop,
> > +                                              msecs_to_jiffies(500));
> > +       ctx->evt_stop =3D false;
> > +
> > +       ctx->stopped =3D true;
> > +
> > +       if (!rc) {
> > +               pr_err("dpu wait for stop done time out!\n");
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
>
> > +static void dpu_stop(struct dpu_context *ctx)
> > +{
> > +       struct dpu_reg *reg =3D (struct dpu_reg *)ctx->base;
> > +
> > +       if (ctx->stopped)
> > +               return;
> > +
> > +       if (ctx->if_type =3D=3D SPRD_DISPC_IF_DPI)
> > +               reg->dpu_ctrl |=3D BIT(1);
> > +
> > +       dpu_wait_stop_done(ctx);
> > +
> > +       pr_info("dpu stop\n");
>
> This and the dpu_run pr_info() messages can be removed.
>
>
> > +}
> > +
> > +static void dpu_run(struct dpu_context *ctx)
> > +{
> > +       struct dpu_reg *reg =3D (struct dpu_reg *)ctx->base;
> > +
> > +       if (!ctx->stopped)
> > +               return;
> > +
> > +       reg->dpu_ctrl |=3D BIT(0);
> > +
> > +       ctx->stopped =3D false;
> > +
> > +       pr_info("dpu run\n");
> > +}
> > +
> > +static int dpu_init(struct dpu_context *ctx)
> > +{
> > +       struct dpu_reg *reg =3D (struct dpu_reg *)ctx->base;
> > +       u32 size;
> > +
> > +       reg->bg_color =3D 0;
> > +
> > +       size =3D (ctx->vm.vactive << 16) | ctx->vm.hactive;
> > +       reg->panel_size =3D size;
> > +       reg->blend_size =3D size;
> > +
> > +       reg->dpu_cfg0 =3D BIT(4) | BIT(5);
> > +
> > +       reg->dpu_cfg1 =3D 0x004466da;
> > +       reg->dpu_cfg2 =3D 0;
> > +
> > +       if (ctx->stopped)
> > +               dpu_clean_all(ctx);
> > +
> > +       reg->mmu_en =3D 0;
> > +       reg->mmu_min_ppn1 =3D 0;
> > +       reg->mmu_ppn_range1 =3D 0xffff;
> > +       reg->mmu_min_ppn2 =3D 0;
> > +       reg->mmu_ppn_range2 =3D 0xffff;
> > +       reg->mmu_vpn_range =3D 0x1ffff;
> > +
> > +       reg->dpu_int_clr =3D 0xffff;
> > +
> > +       init_waitqueue_head(&ctx->wait_queue);
> > +
> > +       return 0;
>
> Function always returns 0. Let's make it static void dpu_init()
>
>
>
> > +static u32 to_dpu_rotation(u32 angle)
> > +{
> > +       u32 rot =3D DPU_LAYER_ROTATION_0;
> > +
> > +       switch (angle) {
> > +       case 0:
> > +       case DRM_MODE_ROTATE_0:
> > +               rot =3D DPU_LAYER_ROTATION_0;
> > +               break;
> > +       case DRM_MODE_ROTATE_90:
> > +               rot =3D DPU_LAYER_ROTATION_90;
> > +               break;
> > +       case DRM_MODE_ROTATE_180:
> > +               rot =3D DPU_LAYER_ROTATION_180;
> > +               break;
> > +       case DRM_MODE_ROTATE_270:
> > +               rot =3D DPU_LAYER_ROTATION_270;
> > +               break;
> > +       case DRM_MODE_REFLECT_Y:
> > +               rot =3D DPU_LAYER_ROTATION_180_M;
> > +               break;
> > +       case (DRM_MODE_REFLECT_Y | DRM_MODE_ROTATE_90):
> > +               rot =3D DPU_LAYER_ROTATION_90_M;
> > +               break;
> > +       case DRM_MODE_REFLECT_X:
> > +               rot =3D DPU_LAYER_ROTATION_0_M;
> > +               break;
> > +       case (DRM_MODE_REFLECT_X | DRM_MODE_ROTATE_90):
> > +               rot =3D DPU_LAYER_ROTATION_270_M;
> > +               break;
> > +       default:
> > +               pr_err("rotation convert unsupport angle (drm)=3D 0x%x\=
n", angle);
> > +               break;
>
> Have you seen a case where the 0 or default case are reached? AFAICT they=
 will
> never trigger. So one might as well use:
>     switch (angle) {
>     case DRM_MODE_FOO:
>         return DPU_LAYER_ROTATION_FOO;
>     ...
>     case DRM_MODE_BAR:
>         return DPU_LAYER_ROTATION_BAR;
>     }
>
>
> > +       }
> > +
> > +       return rot;
> > +}
> > +
> > +static u32 dpu_img_ctrl(u32 format, u32 blending, u32 rotation)
> > +{
> > +       int reg_val =3D 0;
> > +
> > +       /* layer enable */
> > +       reg_val |=3D BIT(0);
> > +
> > +       switch (format) {
> > +       case DRM_FORMAT_BGRA8888:
> > +               /* BGRA8888 -> ARGB8888 */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 8;
> > +               reg_val |=3D (DPU_LAYER_FORMAT_ARGB8888 << 4);
> > +               break;
> > +       case DRM_FORMAT_RGBX8888:
> > +       case DRM_FORMAT_RGBA8888:
> > +               /* RGBA8888 -> ABGR8888 */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 8;
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_ABGR8888:
> > +               /* rb switch */
> > +               reg_val |=3D BIT(10);
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_ARGB8888:
> > +               reg_val |=3D (DPU_LAYER_FORMAT_ARGB8888 << 4);
> > +               break;
> > +       case DRM_FORMAT_XBGR8888:
> > +               /* rb switch */
> > +               reg_val |=3D BIT(10);
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_XRGB8888:
> > +               reg_val |=3D (DPU_LAYER_FORMAT_ARGB8888 << 4);
> > +               break;
> > +       case DRM_FORMAT_BGR565:
> > +               /* rb switch */
> > +               reg_val |=3D BIT(10);
> > +               /* FALLTHRU */
> > +       case DRM_FORMAT_RGB565:
> > +               reg_val |=3D (DPU_LAYER_FORMAT_RGB565 << 4);
> > +               break;
> > +       case DRM_FORMAT_NV12:
> > +               /* 2-Lane: Yuv420 */
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV420_2PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 10;
> > +               break;
> > +       case DRM_FORMAT_NV21:
> > +               /* 2-Lane: Yuv420 */
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV420_2PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 10;
> > +               break;
> > +       case DRM_FORMAT_NV16:
> > +               /* 2-Lane: Yuv422 */
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV422_2PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 10;
> > +               break;
> > +       case DRM_FORMAT_NV61:
> > +               /* 2-Lane: Yuv422 */
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV422_2PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 10;
> > +               break;
> > +       case DRM_FORMAT_YUV420:
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV420_3PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 10;
> > +               break;
> > +       case DRM_FORMAT_YVU420:
> > +               reg_val |=3D DPU_LAYER_FORMAT_YUV420_3PLANE << 4;
> > +               /* Y endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B0B1B2B3 << 8;
> > +               /* UV endian */
> > +               reg_val |=3D SPRD_IMG_DATA_ENDIAN_B3B2B1B0 << 10;
> > +               break;
> > +       default:
> > +               pr_err("error: invalid format %c%c%c%c\n", format,
> > +                                               format >> 8,
> > +                                               format >> 16,
> > +                                               format >> 24);
> > +               break;
> The default case here should be unreachable. Either it is or the upper la=
yer (or
> earlier code) should ensure that.
>
> > +       }
> > +
> > +       switch (blending) {
> > +       case DRM_MODE_BLEND_PIXEL_NONE:
> > +               /* don't do blending, maybe RGBX */
> > +               /* alpha mode select - layer alpha */
> > +               reg_val |=3D BIT(2);
> > +               break;
> > +       case DRM_MODE_BLEND_COVERAGE:
> > +               /* alpha mode select - combo alpha */
> > +               reg_val |=3D BIT(3);
> > +               /*Normal mode*/
> > +               reg_val &=3D (~BIT(16));
> > +               break;
> > +       case DRM_MODE_BLEND_PREMULTI:
> > +               /* alpha mode select - combo alpha */
> > +               reg_val |=3D BIT(3);
> > +               /*Pre-mult mode*/
> > +               reg_val |=3D BIT(16);
> > +               break;
> > +       default:
> > +               /* alpha mode select - layer alpha */
> > +               reg_val |=3D BIT(2);
> > +               break;
> Ditto
>
> > +       }
> > +
> > +       rotation =3D to_dpu_rotation(rotation);
> > +       reg_val |=3D (rotation & 0x7) << 20;
> > +
> > +       return reg_val;
> > +}
> > +
>
> > +static void dpu_layer(struct dpu_context *ctx,
> > +                   struct sprd_dpu_layer *hwlayer)
> > +{
> > +       struct dpu_reg *reg =3D (struct dpu_reg *)ctx->base;
> > +       const struct drm_format_info *info;
> > +       struct layer_reg *layer;
> > +       u32 addr, size, offset;
> > +       int i;
> > +
> > +       layer =3D &reg->layers[hwlayer->index];
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
> > +       for (i =3D 0; i < hwlayer->planes; i++) {
> > +               addr =3D hwlayer->addr[i];
> > +
> > +               if (addr % 16)
> > +                       pr_err("layer addr[%d] is not 16 bytes align, i=
t's 0x%08x\n",
> > +                               i, addr);
> > +               layer->addr[i] =3D addr;
> > +       }
> > +
> > +       layer->pos =3D offset;
> > +       layer->size =3D size;
> > +       layer->crop_start =3D (hwlayer->src_y << 16) | hwlayer->src_x;
> > +       layer->alpha =3D hwlayer->alpha;
> > +
> > +       info =3D drm_format_info(hwlayer->format);
> > +       if (info->cpp[0] =3D=3D 0) {
>
> Ditto
>
> > +               pr_err("layer[%d] bytes per pixel is invalid\n", hwlaye=
r->index);
> > +               return;
> > +       }
> > +
>
>
>
>
> > +static int dpu_capability(struct dpu_context *ctx,
> > +                       struct dpu_capability *cap)
> > +{
> > +       if (!cap)
> > +               return -EINVAL;
> > +
> Ensure the caller always passes cap !=3D NULL and drop the function retur=
n type?
>
> > +       cap->max_layers =3D 6;
> > +       cap->fmts_ptr =3D primary_fmts;
> > +       cap->fmts_cnt =3D ARRAY_SIZE(primary_fmts);
> > +
> > +       return 0;
> > +}
>
>
> > +static int sprd_plane_atomic_check(struct drm_plane *plane,
> > +                                 struct drm_plane_state *state)
> > +{
> > +       DRM_DEBUG("%s()\n", __func__);
> > +
>
> Would be nice to hear from the atomic experts, how a no-op atomic_check g=
oes
> with the overall atomic semantics.
>
>
> > +       return 0;
> > +}
> > +
>
>
> > +static void sprd_plane_atomic_disable(struct drm_plane *plane,
> > +                                    struct drm_plane_state *old_state)
> > +{
> > +       struct sprd_plane *p =3D to_sprd_plane(plane);
> > +
> > +       /*
> > +        * NOTE:
> > +        * The dpu->core->flip() will disable all the planes each time.
> > +        * So there is no need to impliment the atomic_disable() functi=
on.
> > +        * But this function can not be removed, because it will change
> > +        * to call atomic_update() callback instead. Which will cause
> > +        * kernel panic in sprd_plane_atomic_update().
> > +        *
> > +        * We do nothing here but just print a debug log.
> > +        */
> > +       DRM_DEBUG("%s() layer_id =3D %u\n", __func__, p->index);
>
> Similar to the check - would be nice to see a confirmation, that this isn=
't
> abusing atomics in some way.
>
>
> > +}
> > +
> > +static int sprd_plane_create_properties(struct sprd_plane *p, int inde=
x)
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
> > +
> Either check if creating the properties fail (and propagate the error) or=
 drop
> the function return type. As-is it's in the middle making it fairly misle=
ading.
>
> > +       return 0;
> > +}
> > +
>
>
> > +static struct drm_plane *sprd_plane_init(struct drm_device *drm,
> > +                                       struct sprd_dpu *dpu)
> > +{
> > +       struct drm_plane *primary =3D NULL;
> > +       struct sprd_plane *p =3D NULL;
> > +       struct dpu_capability cap =3D {};
> > +       int err, i;
> > +
> > +       if (dpu->core && dpu->core->capability)
> As mentioned before - this always evaluates to true, so drop the check.
> Same applies for the other dpu->core->foo checks.
>
> Still not a huge fan of the abstraction layer, but I guess you're hesitan=
t on
> removing it.
Here is the complete implementation of our "sprd_dpu_init":
    if (dpu->glb && dpu->glb->power)
        dpu->glb->power(ctx, true);
    if (dpu->glb && dpu->glb->enable)
        dpu->glb->enable(ctx);

    if (ctx->is_stopped && dpu->glb && dpu->glb->reset)
        dpu->glb->reset(ctx);

    if (dpu->clk && dpu->clk->init)
        dpu->clk->init(ctx);
    if (dpu->clk && dpu->clk->enable)
        dpu->clk->enable(ctx);

    if (dpu->core && dpu->core->init)
        dpu->core->init(ctx);
    if (dpu->core && dpu->core->ifconfig)
        dpu->core->ifconfig(ctx);

=E2=80=9Cdpu->core", "dpu->clk", "dpu->glb" checking maybe is not needed, i
will remove it.
But, Eg: "dpu->glb->power" not always need for all h/w
So in order to keep the same coding style, could i do like this:
    if (dpu->glb->power)
        dpu->glb->power(ctx, true);
    if (dpu->glb->enable)
        dpu->glb->enable(ctx);
......

But here, "dpu->core->capability", your are right, this always evaluates to=
 true
So i will remove the error checking about always being true...
>
> > +               dpu->core->capability(&dpu->ctx, &cap);
> > +
> > +       dpu->layers =3D devm_kcalloc(drm->dev, cap.max_layers,
> > +                                 sizeof(struct sprd_dpu_layer), GFP_KE=
RNEL);
> > +       if (!dpu->layers)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       for (i =3D 0; i < cap.max_layers; i++) {
> > +
> > +               p =3D devm_kzalloc(drm->dev, sizeof(*p), GFP_KERNEL);
> > +               if (!p)
> > +                       return ERR_PTR(-ENOMEM);
> > +
> > +               err =3D drm_universal_plane_init(drm, &p->plane, 1,
> > +                                              &sprd_plane_funcs, cap.f=
mts_ptr,
> > +                                              cap.fmts_cnt, NULL,
> > +                                              DRM_PLANE_TYPE_PRIMARY, =
NULL);
> > +               if (err) {
> > +                       DRM_ERROR("fail to init primary plane\n");
> > +                       return ERR_PTR(err);
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
> > +       if (p)
> > +               DRM_INFO("dpu plane init ok\n");
>
> This and nearly all the other DRM_INFO() messages look like a debug/devel=
opment
> left over. Please remove them - the driver does not need to print when fu=
nctions
> are successfull.
>
>
> > +
> > +       return primary;
> > +}
> > +
> > +static void sprd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       if ((dpu->mode->hdisplay =3D=3D dpu->mode->htotal) ||
> > +           (dpu->mode->vdisplay =3D=3D dpu->mode->vtotal))
> > +               dpu->ctx.if_type =3D SPRD_DISPC_IF_EDPI;
> > +       else
> > +               dpu->ctx.if_type =3D SPRD_DISPC_IF_DPI;
> > +}
> > +
> > +static enum drm_mode_status sprd_crtc_mode_valid(struct drm_crtc *crtc=
,
> > +                                       const struct drm_display_mode *=
mode)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       DRM_INFO("%s() mode: "DRM_MODE_FMT"\n", __func__, DRM_MODE_ARG(=
mode));
> > +
>
> If needed, let's move this to core and make it a debug message. As-is it =
will
> cause spam for no reason.
>
>
> > +       if (mode->type & DRM_MODE_TYPE_DEFAULT)
> > +               dpu->mode =3D (struct drm_display_mode *)mode;
> > +
> > +       if (mode->type & DRM_MODE_TYPE_PREFERRED) {
> > +               dpu->mode =3D (struct drm_display_mode *)mode;
>
> Casting away the constness is a bad idea.
>
> Instead, let's move the if_type decision here, thus we can remove the
> nsprd_crtc_mode_set_nofb function? This way we can also remove sprd_dpu::=
mode.
>
>
> > +               drm_display_mode_to_videomode(dpu->mode, &dpu->ctx.vm);
>
> Similarly, one could derive the vm based attributes here and remove dpu->=
ctx.vm.
>
>
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
> > +       DRM_INFO("%s()\n", __func__);
> > +
> More sprurious info messages - debug leftover?
>
>
>
> > +static int sprd_crtc_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +
> > +       DRM_DEBUG("%s()\n", __func__);
> > +
> Personally, I don't see the appeal in these debug messages. While a few d=
isplay
> controllers have the odd piece, they are an exception in DRM.
>
>
>
> > +static int sprd_crtc_create_properties(struct drm_crtc *crtc)
> > +{
> > +       struct sprd_dpu *dpu =3D crtc_to_dpu(crtc);
> > +       struct drm_device *drm =3D dpu->crtc.dev;
> > +       struct drm_property *prop;
> > +       struct drm_property_blob *blob;
> > +       size_t blob_size;
> > +
> > +       blob_size =3D strlen(dpu->ctx.version) + 1;
> > +
> > +       blob =3D drm_property_create_blob(dpu->crtc.dev, blob_size,
> > +                       dpu->ctx.version);
> > +       if (IS_ERR(blob)) {
> > +               DRM_ERROR("drm_property_create_blob dpu version failed\=
n");
> > +               return PTR_ERR(blob);
> > +       }
> > +
> > +       /* create dpu version property */
> > +       prop =3D drm_property_create(drm,
> > +               DRM_MODE_PROP_IMMUTABLE | DRM_MODE_PROP_BLOB,
> > +               "dpu version", 0);
>
> Note: Custom properties should be separate patches. This includes documen=
tation
> why they are needed and references to open-source userspace.
>
>
> HTH
> Emil
