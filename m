Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9746C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BD820870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwzzrgG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgCDJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:32:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgCDJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:32:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id z11so1462299wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM09aI8hT3E7eSpPRMixvbuVdkHccR+97mzsVvQTqFw=;
        b=fwzzrgG0U/O8OvHqSLknOC1y/PyQ5EAazTL3Z+i8L15pFlC/bcTiRIb44KxPXD7w93
         gco1q4LgIgfXkvDy5KFN2I1Tsqe7nSrg0S+0Andr8tSTto08bFpbf6Y3o8a8XtRx+AgL
         S5XAPzjmPTqEhv5UR5WG/H2JFHRUyNOc9/Sdxm6V1VO/caryvLJ9uCBq1B6y5T8wn6Nj
         rp5ZOawQwLFY5yYF6MZXpcdQTQug4MAnXFKcfh/vO4050UwSPYX/6XWISpM4op7C+wVM
         MuMP0lpRuB78BDDZ7lBenC8atVcJqr5N28tcgYr1cD8BDimcu3h846h1+TESnitIrZgO
         fKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM09aI8hT3E7eSpPRMixvbuVdkHccR+97mzsVvQTqFw=;
        b=o0pj8RGNWbpKBnExyCsDLsECx+RWIqge+RkQlmDlo27GYTQRMb7B8u9Lxel2LGOFjH
         tpvyalIWkaQILvWh1Cs/4UUSbsF/s9xdrLbvnzkPM+tb7b0fJBnxPlIXSPA0woG+ck1f
         AnfVq3eURrrCUjAzw7f6niN/yshPEu4F1j9Csm6NUNhU0jJTE6YNrfb2hIJ0Q6dp3I6f
         KiIHpvNiP4rUQF7uor+Fhka7FkMd4zFcH8PEIUF8YysXeEjmAiTah9o5kO22vOyLrUQ8
         QMHL3oh9i56aNs/JZkLoj07AJ6k494pZ4KEiBfcOjSZdAcG5cF+O2MRx2ar5YXd8bmHe
         9Ong==
X-Gm-Message-State: ANhLgQ3fBLKrXfSX/Np0jtZpSGgYB9OZbchTyaM0T9nBvZjyjRhy2bft
        8tRiRA2bevErSs9R15cqhmCdK9T2YEz1n0t/xr2abQ==
X-Google-Smtp-Source: ADFU+vuy7/WdBUoVhMsMrydTfEVCqb2MgwkL1Sw/J9F8ewGCTvi6pifQI9kvwFInIXpkRzR63omdwH8M08Ft1DpAB2s=
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr3266322wrs.306.1583314359012;
 Wed, 04 Mar 2020 01:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20200303163228.52741-1-john.stultz@linaro.org> <CAKoKPbzUKUtpKVAYKMe4vYi70T33aeN74Q6oR8Ngw70CJ3t96Q@mail.gmail.com>
In-Reply-To: <CAKoKPbzUKUtpKVAYKMe4vYi70T33aeN74Q6oR8Ngw70CJ3t96Q@mail.gmail.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Wed, 4 Mar 2020 17:32:24 +0800
Message-ID: <CAKoKPbwmOp6gvwgdAsb9si220iVbbkQpqyvZbOK==es=nyJOBQ@mail.gmail.com>
Subject: Re: [PATCH] drm: kirin: Revert "Fix for hikey620 display offset problem"
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 17:28, Xinliang Liu <xinliang.liu@linaro.org> wrote:
>
> On Wed, 4 Mar 2020 at 00:32, John Stultz <john.stultz@linaro.org> wrote:
> >
> > This reverts commit ff57c6513820efe945b61863cf4a51b79f18b592.
> >
> > With the commit ff57c6513820 ("drm: kirin: Fix for hikey620
> > display offset problem") we added support for handling LDI
> > overflows by resetting the hardware.
> >
> > However, its been observed that when we do hit the LDI overflow
> > condition, the irq seems to be screaming, and we do nothing but
> > stream:
> >   [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
> > over and over to the screen
> >
> > I've tried a few appraoches to avoid this, but none has yet
> > been successful and the cure here is worse then the original
> > disease, so revert this for now.
>
> Sorry to hear that. Then it seems such underflow errors can't be
> recovered via reset.
> Anyway, for this patch
> Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>

Sorry , should be:
 Acked-by: Xinliang Liu <xinliang.liu@linaro.org>

>
> And applied to drm-misc .
>
> -xinliang
>
> >
> > Cc: Xinliang Liu <xinliang.liu@linaro.org>
> > Cc: Rongrong Zou <zourongrong@gmail.com>
> > Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> > Cc: Chen Feng <puck.chen@hisilicon.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > Fixes: ff57c6513820 ("drm: kirin: Fix for hikey620 display offset problem")
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |  1 -
> >  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 20 -------------------
> >  2 files changed, 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> > index 0da860200410..e2ac09894a6d 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> > @@ -83,7 +83,6 @@
> >  #define VSIZE_OFST                     20
> >  #define LDI_INT_EN                     0x741C
> >  #define FRAME_END_INT_EN_OFST          1
> > -#define UNDERFLOW_INT_EN_OFST          2
> >  #define LDI_CTRL                       0x7420
> >  #define BPP_OFST                       3
> >  #define DATA_GATE_EN                   BIT(2)
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > index 73cd28a6ea07..86000127d4ee 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > @@ -46,7 +46,6 @@ struct ade_hw_ctx {
> >         struct clk *media_noc_clk;
> >         struct clk *ade_pix_clk;
> >         struct reset_control *reset;
> > -       struct work_struct display_reset_wq;
> >         bool power_on;
> >         int irq;
> >
> > @@ -136,7 +135,6 @@ static void ade_init(struct ade_hw_ctx *ctx)
> >          */
> >         ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
> >                         FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
> > -       ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
> >  }
> >
> >  static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
> > @@ -304,17 +302,6 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
> >                         MASK(1), 0);
> >  }
> >
> > -static void drm_underflow_wq(struct work_struct *work)
> > -{
> > -       struct ade_hw_ctx *ctx = container_of(work, struct ade_hw_ctx,
> > -                                             display_reset_wq);
> > -       struct drm_device *drm_dev = ctx->crtc->dev;
> > -       struct drm_atomic_state *state;
> > -
> > -       state = drm_atomic_helper_suspend(drm_dev);
> > -       drm_atomic_helper_resume(drm_dev, state);
> > -}
> > -
> >  static irqreturn_t ade_irq_handler(int irq, void *data)
> >  {
> >         struct ade_hw_ctx *ctx = data;
> > @@ -331,12 +318,6 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
> >                                 MASK(1), 1);
> >                 drm_crtc_handle_vblank(crtc);
> >         }
> > -       if (status & BIT(UNDERFLOW_INT_EN_OFST)) {
> > -               ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
> > -                               MASK(1), 1);
> > -               DRM_ERROR("LDI underflow!");
> > -               schedule_work(&ctx->display_reset_wq);
> > -       }
> >
> >         return IRQ_HANDLED;
> >  }
> > @@ -919,7 +900,6 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
> >         if (ret)
> >                 return ERR_PTR(-EIO);
> >
> > -       INIT_WORK(&ctx->display_reset_wq, drm_underflow_wq);
> >         ctx->crtc = crtc;
> >
> >         return ctx;
> > --
> > 2.17.1
> >
