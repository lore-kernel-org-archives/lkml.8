Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8180C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B002070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="hP8vsKKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgG1PD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgG1PDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:03:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E61C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:03:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so15066742wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtL8cvtGkTaSwrDEo6k42OsH604F6vO5Vz2A8YHvbY0=;
        b=hP8vsKKec9YLR2W8CGgLTYGKA8sdZ4RxnBJQkHDsbPl2+gFpJ7h5Xi2unxRqQ8shA3
         owPmJ/S3v/1TLjQ3qN/DTf27uH3u1CAWl0907z2yfwETuyMlYYNcv2eDKOySGn66zwyQ
         mX+E2fYeqgs89ToGesm8NC4ntvo9YrhrI5cXmSR3fBL2zq/ez2tay/ByKBEc7Ri74dZc
         5KDyExhpUPDPdVxhaukoFQ+r0GaDRTi98myBRjPgdsEYeuWZMYKKiYp+Uwpc1EuM5HCD
         XCMQaOWzub3ePwPr9UA4oBzmZCYovmxd/dIXwRzV+pIptUk/dqv2ubJ8drc4OiA1kN7P
         Wj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtL8cvtGkTaSwrDEo6k42OsH604F6vO5Vz2A8YHvbY0=;
        b=cs1UBt5BIUC+htQrDXZLC879+amzV24QETnIqT2AGNUkM0oeMEbAzu+4dVsiKzM+aa
         NCi7SVhqRopyW+TeFjbw+UoH2gxG2rigROnDOWD+ajZvE0bB5srksDsBCKlCjCh3Q2jg
         cxLnlbGWMsbYM8Jp1nGBoo44vgOSMPrqOfy6tLMXyOaXI9tjoTitOawmuCOfN65J+h60
         /Gp7PKRaNc1ZMXyujCUX8AQsq65n/rGr/lD4WG7cgcQHtSnYNQBjqaur6g8FY8OV7Ob9
         gbjSUTT5hrs1SpAgh5J/GOFWNzi0dkaCRgyr7CBethn4xa6wtg6rG+z7qPyKQHFenn5T
         /JrA==
X-Gm-Message-State: AOAM530nJ6NNK5znoDduDZqCzfsfD73Gw3OHpaCuPE+YaEz9LM52nYkv
        b/MicpRcDD5gFpUBsU/cRFr+KON+9Py9Hn9fHCPeHNSouME=
X-Google-Smtp-Source: ABdhPJwb5RGbkaoI7/zf6RLk+H9Fb3Ean0zD1XK8jF76zOj3GM3Mzq0w6Hd+U4moU85Uefhrh/0o0bNmat6Ci3VhPrk=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr7990761wrs.27.1595948604162;
 Tue, 28 Jul 2020 08:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <12499869afccd632b222eec328a6352111472986.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <12499869afccd632b222eec328a6352111472986.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:03:04 +0100
Message-ID: <CAPY8ntCypUxUzGw0LBDsG8oPZBf5RbF-ia=McBF0gYp9mAtwxQ@mail.gmail.com>
Subject: Re: [PATCH v4 70/78] drm/vc4: hdmi: Always recenter the HDMI FIFO
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

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to avoid a pixel getting stuck in an unflushable FIFO, we need to
> recenter the FIFO every time we're doing a modeset and not only if we're
> connected to an HDMI monitor.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 46 +++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 4058985940e6..00592c1ada73 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -425,6 +425,30 @@ static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
>                    (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
>  }
>
> +static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
> +{
> +       u32 drift;
> +       int ret;
> +
> +       drift = HDMI_READ(HDMI_FIFO_CTL);
> +       drift &= VC4_HDMI_FIFO_VALID_WRITE_MASK;
> +
> +       HDMI_WRITE(HDMI_FIFO_CTL,
> +                  drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
> +       HDMI_WRITE(HDMI_FIFO_CTL,
> +                  drift | VC4_HDMI_FIFO_CTL_RECENTER);
> +       usleep_range(1000, 1100);
> +       HDMI_WRITE(HDMI_FIFO_CTL,
> +                  drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
> +       HDMI_WRITE(HDMI_FIFO_CTL,
> +                  drift | VC4_HDMI_FIFO_CTL_RECENTER);
> +
> +       ret = wait_for(HDMI_READ(HDMI_FIFO_CTL) &
> +                      VC4_HDMI_FIFO_CTL_RECENTER_DONE, 1);
> +       WARN_ONCE(ret, "Timeout waiting for "
> +                 "VC4_HDMI_FIFO_CTL_RECENTER_DONE");
> +}
> +
>  static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>  {
>         struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> @@ -543,8 +567,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         }
>
>         if (vc4_encoder->hdmi_monitor) {
> -               u32 drift;
> -
>                 WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
>                           VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
>                 HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
> @@ -555,25 +577,9 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                            VC4_HDMI_RAM_PACKET_ENABLE);
>
>                 vc4_hdmi_set_infoframes(encoder);
> -
> -               drift = HDMI_READ(HDMI_FIFO_CTL);
> -               drift &= VC4_HDMI_FIFO_VALID_WRITE_MASK;
> -
> -               HDMI_WRITE(HDMI_FIFO_CTL,
> -                          drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
> -               HDMI_WRITE(HDMI_FIFO_CTL,
> -                          drift | VC4_HDMI_FIFO_CTL_RECENTER);
> -               usleep_range(1000, 1100);
> -               HDMI_WRITE(HDMI_FIFO_CTL,
> -                          drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
> -               HDMI_WRITE(HDMI_FIFO_CTL,
> -                          drift | VC4_HDMI_FIFO_CTL_RECENTER);
> -
> -               ret = wait_for(HDMI_READ(HDMI_FIFO_CTL) &
> -                              VC4_HDMI_FIFO_CTL_RECENTER_DONE, 1);
> -               WARN_ONCE(ret, "Timeout waiting for "
> -                         "VC4_HDMI_FIFO_CTL_RECENTER_DONE");
>         }
> +
> +       vc4_hdmi_recenter_fifo(vc4_hdmi);
>  }
>
>  static enum drm_mode_status
> --
> git-series 0.9.1
