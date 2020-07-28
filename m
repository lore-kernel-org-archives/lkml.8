Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D609C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDDD2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Y+eu+sJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgG1J5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgG1J5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:57:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:57:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so10633503wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ks8UK+swNcNUZbdDaIUKC9qqYkJwhk2Hx4F+3k63Chc=;
        b=Y+eu+sJpGrYgH0mNN9toTGBx4G+NLxhEKfQIa4YPWE9Fd/atwdD+iJJikuHVaIHjL4
         3vk2oxVwl5RQUpNKIRuE/87Or4aYXeoQr8IyGX80HVFFd61KmjtdknAn43o5pWlwZHp1
         4e/00mRCtYK2D8ZLZENbnUNNVXC408M+T5qZ0ShDKqRiV6Z4vwMKE6GaRLWHVj1T2aue
         /7jar28q9F8VESrnHUMk/cuuwb9K4PLomAM485ObbD3TawJfauU/SYofr9qP13cfQa3d
         pyTWRIEE8iAeg4NkK1/JVH9L0GtaQhmjU9fz53HaO4u9q53Rl+zmbEE2MfxKUvxQN7zN
         RGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ks8UK+swNcNUZbdDaIUKC9qqYkJwhk2Hx4F+3k63Chc=;
        b=oN6zsdRMmz1dEbk0XXozA/XSjKdoaUGHPzrfzHpueYTPfBe+UK3h3lH/pUUJ7OWqRn
         mVsoIY7CXirTl57pp9WcZzm7ptCDXmqGEyTcLMXleo4HeQARhHrmI8ipHzHC9G0VluzP
         WSCE28X3CLbZqbFihm+k3eWABD9ehxuVOrQhtCDc1GReAmOZw4bruQ+RrMtXxNbkMmdl
         UoO4mFcZR1/cjKoSYXPGWsOcy6cBvRdYTnzihTqI0RUUhmM9MvacJm5N5+TaPLoPPNT3
         NqahxqjGEq8HTnziIOw259THvpwijXC9usfGM1KfohrCgS21jSZMEwBIf0YB1y/Vepuc
         fcjg==
X-Gm-Message-State: AOAM530mFlBCY5uHWbmc+GHq3Vevtvn5TheePGYjDjphjbgZ11t7tBm6
        NWcspxpgNYERcJS+FHI7mMhCB+Jvj283iCarWWJyhw==
X-Google-Smtp-Source: ABdhPJxwfcIK2fQs0g2jKCS8hE3C6ccmau1/i/vXjqKRFYo645xAz7b+rg+SQXC96rwUdrq9N1R3enHanZ7N1/hbo00=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr754429wmd.82.1595930272348;
 Tue, 28 Jul 2020 02:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <3d00592745e9559b754e84ffc74b4a727b82e8ab.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <3d00592745e9559b754e84ffc74b4a727b82e8ab.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 10:57:36 +0100
Message-ID: <CAPY8ntDbEYD8swL7Tg=YnZWgHOxxdRFUMth-Ha-sGB-gNnc=+A@mail.gmail.com>
Subject: Re: [PATCH v4 12/78] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
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

On Wed, 8 Jul 2020 at 18:42, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The VIDEN bit in the pixelvalve currently being used to enable or disable
> the pixelvalve seems to not be enough in some situations, which whill end
> up with the pixelvalve stalling.
>
> In such a case, even re-enabling VIDEN doesn't bring it back and we need to
> clear the FIFO. This can only be done if the pixelvalve is disabled though.
>
> In order to overcome this, we can configure the pixelvalve during
> mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
> there, and in atomic_disable disable the pixelvalve again.

Very minor nitpick: the configure is in vc4_crtc_config_pv, but that
is called from mode_set_no_fb. The comment is correct from a DRM
overview perspective, but not from the actual code. Describing the DRM
call is probably the better approach, but it looks odd when compared
to the code.

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index cdeaa0cd981f..fe2e5675aed4 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -332,9 +332,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>                    PV_CONTROL_TRIGGER_UNDERFLOW |
>                    PV_CONTROL_WAIT_HSTART |
>                    VC4_SET_FIELD(vc4_encoder->clock_select,
> -                                PV_CONTROL_CLK_SELECT) |
> -                  PV_CONTROL_FIFO_CLR |
> -                  PV_CONTROL_EN);
> +                                PV_CONTROL_CLK_SELECT));
>  }
>
>  static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
> @@ -386,6 +384,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>         ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
>
> +       CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
> +
>         vc4_hvs_atomic_disable(crtc, old_state);
>
>         /*
> @@ -410,6 +410,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         require_hvs_enabled(dev);
>
> +       /* Reset the PV fifo. */
> +       CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) |
> +                  PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
> +
>         /* Enable vblank irq handling before crtc is started otherwise
>          * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
>          */
> --
> git-series 0.9.1
