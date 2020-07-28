Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F6C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1EE2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="BFhBYAbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgG1LZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgG1LZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:25:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01073C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:25:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so17942142wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01W6bDMMr/9SeqGNAca6mqzfZvjZHQBkuzzpt+5sERc=;
        b=BFhBYAblS2kS48Qsdd8d02m5F9TXV37ymz7H00YDmaAEGVoVo8qIPLYY0UjfGymCAb
         IGC4u6E+FaDCX2UG1DFEWdezGB4HLfkskioBHmDLE0eNEL9crb2QqmOSuOAkCnQQRqqj
         rJbPYAe/5RDLRTNq/EyxF8NR5rhQv3f3X1T8We2ulAi3EDXCV6DjRkwdtY/DxscKFgWh
         QVkAvZa76E2nMsHqw5QtylHxdrFpK8dI2qJn5KpJfiFMpPcnPsHEHPXkqmJplEPLRIGg
         dU2cZrm6iJW+EATyj4dd9/yfNa+j3YQvJEBtF9dpcbVvSKQiooJqMkk8brUC5PaB7iCK
         rx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01W6bDMMr/9SeqGNAca6mqzfZvjZHQBkuzzpt+5sERc=;
        b=UEXa95IkbS8sMnQ/xtPfvE6gI2BA7PBzSeYifkkZ5glLXzX6cdgloplk2lu+8a9w3E
         GlYRJTuZmRdgQ8FBcMX7iS/KQP7Fd96ZEbfN8er68QulbPJ5JHX9vzQO7jDg9oiT9DTG
         yth5Lhp5643S2CwzHQs+KcUhpZI6/IdpChSIjvFET7FaSTsyXgy721QgfIGVBZtagCYS
         WyObapognCLuuR3nzh39w4y4mwC0qyvs72YpjIg1O2j5zI6yqjR4n0QxIGu6z8EFiN7q
         u0yLgPweEApyPo3901YBKPAf7Ymhl9Ly6y8yL9Zv+dhlIV8+xOOmF6oZUeAYhDJ0tUBI
         nbUg==
X-Gm-Message-State: AOAM531CXoygLUJBGUKgP/u8aCVrNZ1BjMG+zwK7osBg5MzAkJThMHCE
        QTBf/HxY6A258LrHQASi2ESx13dZn3JW7CaJlEEi2w==
X-Google-Smtp-Source: ABdhPJyW96+nJG/qGUJ5CLd6oUoQmnituQIg/MeTxa60UlVUr5zPOJnzE9jCKFnkSxX5KeQi//ytGNtBOAOj/9zBu2U=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr17563956wrv.42.1595935522766;
 Tue, 28 Jul 2020 04:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <5fadf9256d130d447e3c66a0c86ceeba05c47fa4.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <5fadf9256d130d447e3c66a0c86ceeba05c47fa4.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 12:25:07 +0100
Message-ID: <CAPY8ntA-Ywzk6usF0cgTLZ_YtAP3FD1RM9duJTu1A7+sP=DUjw@mail.gmail.com>
Subject: Re: [PATCH v4 28/78] drm/vc4: encoder: Add finer-grained encoder callbacks
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
> In the BCM2711, the setup of the HVS, pixelvalve and HDMI controller
> requires very precise ordering and timing that the regular atomic callbacks
> don't provide. Let's add new callbacks on top of the regular ones to be
> able to split the configuration as needed.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 19 +++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.h  |  7 +++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index b7b0e19e2fe1..d0b326e1df0a 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -389,6 +389,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
> +       struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         int ret;
>
>         require_hvs_enabled(dev);
> @@ -401,10 +403,16 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>         ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
>
> +       if (vc4_encoder->post_crtc_disable)
> +               vc4_encoder->post_crtc_disable(encoder);
> +
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
>
>         vc4_hvs_atomic_disable(crtc, old_state);
>
> +       if (vc4_encoder->post_crtc_powerdown)
> +               vc4_encoder->post_crtc_powerdown(encoder);
> +
>         /*
>          * Make sure we issue a vblank event after disabling the CRTC if
>          * someone was waiting it.
> @@ -424,6 +432,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>  {
>         struct drm_device *dev = crtc->dev;
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +       struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
> +       struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>
>         require_hvs_enabled(dev);
>
> @@ -434,15 +444,24 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         vc4_hvs_atomic_enable(crtc, old_state);
>
> +       if (vc4_encoder->pre_crtc_configure)
> +               vc4_encoder->pre_crtc_configure(encoder);
> +
>         vc4_crtc_config_pv(crtc);
>
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
>
> +       if (vc4_encoder->pre_crtc_enable)
> +               vc4_encoder->pre_crtc_enable(encoder);
> +
>         /* When feeding the transposer block the pixelvalve is unneeded and
>          * should not be enabled.
>          */
>         CRTC_WRITE(PV_V_CONTROL,
>                    CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
> +
> +       if (vc4_encoder->post_crtc_enable)
> +               vc4_encoder->post_crtc_enable(encoder);
>  }
>
>  static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index dfcc684f5d28..251fcc35530c 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -439,6 +439,13 @@ struct vc4_encoder {
>         struct drm_encoder base;
>         enum vc4_encoder_type type;
>         u32 clock_select;
> +
> +       void (*pre_crtc_configure)(struct drm_encoder *encoder);
> +       void (*pre_crtc_enable)(struct drm_encoder *encoder);
> +       void (*post_crtc_enable)(struct drm_encoder *encoder);
> +
> +       void (*post_crtc_disable)(struct drm_encoder *encoder);
> +       void (*post_crtc_powerdown)(struct drm_encoder *encoder);
>  };
>
>  static inline struct vc4_encoder *
> --
> git-series 0.9.1
