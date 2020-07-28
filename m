Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3750A20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="k7c86DFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgG1Kae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgG1Kad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:30:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA65C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:30:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so16799653wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5ceSz5kBwvnkS9EauvIKWx1J5tvf5TXDk4n7UdnC5w=;
        b=k7c86DFkAMXUKdkCigOqF6z+tJn4AYl2YFAMqdxQpX14GIluEQj8pekgNwItnSKj2N
         /QAd8CsRWLuuqXATjhgH9+qrbs1gpFld3vO5ncwaNXqlFGY49rCbnwRhIlYipEtCt67u
         sBhVQtty+k7AOvdFftIO1Lty4nZqVGdGhSWByRfV7G0j5SPsdYngxeSdPrMmt8tCr9/Q
         49BL0ffavtQhjtvmfcng4fEU9t5tKjBbAYzqmUvnG9GBahvgtOoD0/r+JvtSbOul80JO
         qnmn4M3ZvTEwgzc9M1yl3PAyy6eynXLRW8We14LFJpaxWRvuK/pm3soZMPyo3178Uz0n
         tXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5ceSz5kBwvnkS9EauvIKWx1J5tvf5TXDk4n7UdnC5w=;
        b=c90TduWsICp7BKhJIOkrhj+XWA556rSQ4fZPCxj/Yiu448T4/Xxs+VRKOVbVPWO5GE
         bx+ApjjBE9mdqMAV3mWXCjcAhEsVTjcW8Otm42Nt86WDwEqrKRyax1IE88Mgy3k1zAnr
         HiV3o27LVuEBvxHIUIHErjMGTjBnhjFTY/+IvZg3J3Ot83tjXEx2D6bugBEB9kEy7fQb
         NdROuT4zKZgPKHx30Ax27/PN/BB/RU2d29jy1/I1yzZbfDsprluC49ef9QnOHfdfRls4
         eoxkNREBwCqJuCetk63b+hHSVf5KtyTPqpkMBnFJ3uUu4Dfcxch6KEyLgcuhKrPe8+IS
         pLzg==
X-Gm-Message-State: AOAM533EzdKw6CDND80Bss7iVLTgjDY37TXybXyZdv/JWG+YGKGAAxEC
        aTSpv++i+inYge+gPlHDSuZokraFFUkCuo4jP7dHng==
X-Google-Smtp-Source: ABdhPJwKbedCANNtAuPmzJgxQeCetxm7R61+Z3yE5qNo7ncV2Mv/As0sHRgJ0X8luyfpiII4Snt3cMFdXnKRnxMJjXE=
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3367332wme.158.1595932231996;
 Tue, 28 Jul 2020 03:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <bb369aede3a6d0463805faabeb5f598a369b54bf.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <bb369aede3a6d0463805faabeb5f598a369b54bf.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:30:16 +0100
Message-ID: <CAPY8ntBSux3gAU1+LV_wA5pLwaovNy1cwZY7KZkb8Er8-MnNPA@mail.gmail.com>
Subject: Re: [PATCH v4 21/78] drm/vc4: crtc: Move PV dump to config_pv
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Now that we only configure the PixelValve in vc4_crtc_config_pv, it doesn't
> really make much sense to dump its register content in its caller.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index c2ab907611e3..181d3fd57bc7 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -290,6 +290,14 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>                        vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
>         u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
>         u8 ppc = pv_data->pixels_per_clock;
> +       bool debug_dump_regs = false;
> +
> +       if (debug_dump_regs) {
> +               struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
> +               dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
> +                        drm_crtc_index(crtc));
> +               drm_print_regset32(&p, &vc4_crtc->regset);
> +       }
>
>         vc4_crtc_pixelvalve_reset(crtc);
>
> @@ -359,30 +367,20 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>                    PV_CONTROL_WAIT_HSTART |
>                    VC4_SET_FIELD(vc4_encoder->clock_select,
>                                  PV_CONTROL_CLK_SELECT));
> -}
> -
> -static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
> -{
> -       struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> -       bool debug_dump_regs = false;
>
>         if (debug_dump_regs) {
>                 struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
> -               dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
> +               dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
>                          drm_crtc_index(crtc));
>                 drm_print_regset32(&p, &vc4_crtc->regset);
>         }
> +}
>
> +static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
> +{
>         vc4_crtc_config_pv(crtc);
>
>         vc4_hvs_mode_set_nofb(crtc);
> -
> -       if (debug_dump_regs) {
> -               struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
> -               dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
> -                        drm_crtc_index(crtc));
> -               drm_print_regset32(&p, &vc4_crtc->regset);
> -       }
>  }
>
>  static void require_hvs_enabled(struct drm_device *dev)
> --
> git-series 0.9.1
