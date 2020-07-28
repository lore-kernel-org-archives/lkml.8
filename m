Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB320775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Jtgwn639"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgG1KcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgG1KcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:32:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:32:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so17671617wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klH9XyrVq3uSlEXE3zAfesJXPnrCV0J6mB3bxXXeLHI=;
        b=Jtgwn639L7rCcHeF8Su+nhnl0wfh/jljZ8QPs8S+BQVQGFRp/n90hrkBTzk5eteqae
         /5M61JjXkFkxNAWZS9PKf55QSCBl2rlavEN7xHeSOywsXapHDLfbNofwV2LXh+rNQHLl
         WE4mtf9rrjnf/sJYX3KOujasNbmo1wIK90X8LnGiHr8J9Whd0N8ZFWi+WNC90s88OIED
         11L33ZyZrNWsys+OeK6GF5TRHAd3ZVrgX6kGbzTrV4TpjMqOOCUpuIkywspjHeBxYjro
         lXpXwom60ETpdTSGfc80jbou+ftATvrdrHdatj4egO4RV4bGAwL/6Zds604o41XmneDv
         K1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klH9XyrVq3uSlEXE3zAfesJXPnrCV0J6mB3bxXXeLHI=;
        b=Ck/TYO+t3DxSjhWegDifF3STyNAqQ0drrC0TDWGAjF6yQL94nxoqLrDJdyIBBhX5Pm
         9hbEPVtsw6TMZ8xIp9NgmYWPu7iAHifKn4YXDAH4t9HkiT7YTql6bKeQfyGTQQNZym+U
         MxPshZq8AjF1uUwl/92W204hrYI1Ivoq3w5NtUEEezctgUX8kVoDu6tyHsE/FWVPyB41
         I5/QcTJhyHkmQaJM4bRULJLRW8Xw9RK9ZGYH5Go1hRr+y09MMb8Y1+urhMdAnSf2NPWz
         oeWDMBVqSbOj6GtYi0Q3y4uSqFgeM+WfCjBz3YWAGvTo/mSKSbOg7wGroIMMOS2Ptr/c
         +ddQ==
X-Gm-Message-State: AOAM533ptYGZmddiJ1GbsPlepyJBL2L5Vwb3QVcDrUnuTdQ130OSKY+D
        n1N9RThigVCHgcmmAZhI1uzt7sdK6Q+sq4t4i7V+1w==
X-Google-Smtp-Source: ABdhPJz8Mn129klT2Z8C5717SOIojFV7FscbpxEGGVx1FGUmDzUkvja4xu2G7NB9uooMLEC7pKyMk/eDXyTyxpqWxew=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr3176329wmh.96.1595932324875;
 Tue, 28 Jul 2020 03:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <840cb5324364e431b15d4105c85cebf8d12257f0.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <840cb5324364e431b15d4105c85cebf8d12257f0.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:31:49 +0100
Message-ID: <CAPY8ntCSEH58GDzT4=N_eExpJCfsdaEpNFZ0aq=xessBhFfiZg@mail.gmail.com>
Subject: Re: [PATCH v4 22/78] drm/vc4: crtc: Move HVS init and close to a function
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
> In order to make further refactoring easier, let's move the HVS channel
> setup / teardown to their own function.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 104 +++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 50f9a9674a7e..78bb1c0b0b76 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -196,6 +196,62 @@ static void vc4_hvs_update_gamma_lut(struct drm_crtc *crtc)
>         vc4_hvs_lut_load(crtc);
>  }
>
> +static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
> +                               struct drm_display_mode *mode, bool oneshot)
> +{
> +       struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(crtc->state);
> +       unsigned int chan = vc4_crtc_state->assigned_channel;
> +       u32 dispctrl;
> +
> +       /* Turn on the scaler, which will wait for vstart to start
> +        * compositing.
> +        * When feeding the transposer, we should operate in oneshot
> +        * mode.
> +        */
> +       dispctrl = SCALER_DISPCTRLX_ENABLE;
> +
> +       if (!vc4->hvs->hvs5)
> +               dispctrl |= VC4_SET_FIELD(mode->hdisplay,
> +                                         SCALER_DISPCTRLX_WIDTH) |
> +                           VC4_SET_FIELD(mode->vdisplay,
> +                                         SCALER_DISPCTRLX_HEIGHT) |
> +                           (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
> +       else
> +               dispctrl |= VC4_SET_FIELD(mode->hdisplay,
> +                                         SCALER5_DISPCTRLX_WIDTH) |
> +                           VC4_SET_FIELD(mode->vdisplay,
> +                                         SCALER5_DISPCTRLX_HEIGHT) |
> +                           (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
> +
> +       HVS_WRITE(SCALER_DISPCTRLX(chan), dispctrl);
> +
> +       return 0;
> +}
> +
> +static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
> +{
> +       struct vc4_dev *vc4 = to_vc4_dev(dev);
> +
> +       if (HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_ENABLE)
> +               return;
> +
> +       HVS_WRITE(SCALER_DISPCTRLX(chan),
> +                 HVS_READ(SCALER_DISPCTRLX(chan)) | SCALER_DISPCTRLX_RESET);
> +       HVS_WRITE(SCALER_DISPCTRLX(chan),
> +                 HVS_READ(SCALER_DISPCTRLX(chan)) & ~SCALER_DISPCTRLX_ENABLE);
> +
> +       /* Once we leave, the scaler should be disabled and its fifo empty. */
> +       WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
> +
> +       WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
> +                                  SCALER_DISPSTATX_MODE) !=
> +                    SCALER_DISPSTATX_MODE_DISABLED);
> +
> +       WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
> +                     (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
> +                    SCALER_DISPSTATX_EMPTY);
> +}
> +
>  int vc4_hvs_atomic_check(struct drm_crtc *crtc,
>                          struct drm_crtc_state *state)
>  {
> @@ -268,63 +324,19 @@ void vc4_hvs_atomic_enable(struct drm_crtc *crtc,
>         struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
>         struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>         bool oneshot = vc4_state->feed_txp;
> -       u32 dispctrl;
>
>         vc4_hvs_update_dlist(crtc);
> -
> -       /* Turn on the scaler, which will wait for vstart to start
> -        * compositing.
> -        * When feeding the transposer, we should operate in oneshot
> -        * mode.
> -        */
> -       dispctrl = SCALER_DISPCTRLX_ENABLE;
> -
> -       if (!vc4->hvs->hvs5)
> -               dispctrl |= VC4_SET_FIELD(mode->hdisplay,
> -                                         SCALER_DISPCTRLX_WIDTH) |
> -                           VC4_SET_FIELD(mode->vdisplay,
> -                                         SCALER_DISPCTRLX_HEIGHT) |
> -                           (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
> -       else
> -               dispctrl |= VC4_SET_FIELD(mode->hdisplay,
> -                                         SCALER5_DISPCTRLX_WIDTH) |
> -                           VC4_SET_FIELD(mode->vdisplay,
> -                                         SCALER5_DISPCTRLX_HEIGHT) |
> -                           (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
> -
> -       HVS_WRITE(SCALER_DISPCTRLX(vc4_state->assigned_channel), dispctrl);
> +       vc4_hvs_init_channel(vc4, crtc, mode, oneshot);
>  }
>
>  void vc4_hvs_atomic_disable(struct drm_crtc *crtc,
>                             struct drm_crtc_state *old_state)
>  {
>         struct drm_device *dev = crtc->dev;
> -       struct vc4_dev *vc4 = to_vc4_dev(dev);
>         struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(old_state);
>         unsigned int chan = vc4_state->assigned_channel;
>
> -       if (HVS_READ(SCALER_DISPCTRLX(chan)) &
> -           SCALER_DISPCTRLX_ENABLE) {
> -               HVS_WRITE(SCALER_DISPCTRLX(chan),
> -                         SCALER_DISPCTRLX_RESET);
> -
> -               /* While the docs say that reset is self-clearing, it
> -                * seems it doesn't actually.
> -                */
> -               HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
> -       }
> -
> -       /* Once we leave, the scaler should be disabled and its fifo empty. */
> -
> -       WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
> -
> -       WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
> -                                  SCALER_DISPSTATX_MODE) !=
> -                    SCALER_DISPSTATX_MODE_DISABLED);
> -
> -       WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
> -                     (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
> -                    SCALER_DISPSTATX_EMPTY);
> +       vc4_hvs_stop_channel(dev, chan);
>  }
>
>  void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
> --
> git-series 0.9.1
