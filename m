Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC697C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BA420897
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="GkEwuFZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgIDJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:46:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918CC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:46:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so6077988wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVx7hC5Z+ZE9a7SrgsdYEtoRluDNQl4XcnFv96CEECo=;
        b=GkEwuFZ2XgoFCAbgB9JFRh7/4rIuBnkk7B3WowF0Ouo7ZwRGjDRK2ZDlmZJ2RLg/On
         nrfPdZUS/h6zd7gpkrNCNoCHNFDi305JAdVAde3a7doEtdHs0smrUnlcdJG+pKDd/cO7
         z7gpywm58gbc6ZQtGbyM4abXSOAwVd/o12b8eqbMIFpwHGPaugZDkoyz3B5fyVcPllbH
         rhj30xsmlH1C15HVBRhssiDsZvK16TDN6lMszim4cQjNM01buVbRtafq3/3c+yhlPLjS
         mzWOjOvn/OLzZPG+rs7d835O+afcHy1Qx9kDXY5pA1V4bgiKpFHrAZ3z4gH8TtH47vbm
         sVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVx7hC5Z+ZE9a7SrgsdYEtoRluDNQl4XcnFv96CEECo=;
        b=ClzKVsXRoDVFmTPEfrXoLBOoruPpdtbBuCOce+zkxB6OPnHzVoS7D+a1QQwOABhbR6
         bIBXqopRzSpP+Y7DPsMyvBR55yXZMvKVUGKPMXb9xHiZe79HbsFlxo6Z+vyTFue5u6nM
         pfChEveO8RW3HAGfEfTrROrdExGmZ4kWuqEhr/UwrqbGxUpQpp8GOpF1dBNmyGQYMTXy
         IJToicHDMhpnxI5qIBiSSwMN16Ival4uoR3xw7Yf9A3ioVswxSrNE1srap68pV4pj/1k
         h2Fr9uwHAzisoewDG/MDeg6rQND+xa2Mz4l3yUax2Cj23I+clzXkMzljo/MqH9uaZ010
         64FA==
X-Gm-Message-State: AOAM531Frv3LYke2D0/zjP2IDY/J0MpKohqENBmbuNWaLi0WCOLGfr9i
        jeqARkzgp/WLgVbE/2Umc1k5r9SEGMOLjLT1bfXbAQ==
X-Google-Smtp-Source: ABdhPJwptTnuYBF7f+Osku8uKwpWjtboRQN9W4oEJ9YqWxV4nkxW6SWMHqNqVamQSLiM39jayeQ7YaNuePi+ebV3FW8=
X-Received: by 2002:a5d:4949:: with SMTP id r9mr7050780wrs.27.1599212800728;
 Fri, 04 Sep 2020 02:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <d757ddd6549da140f178563e5fd2bf1d129913fd.1599120059.git-series.maxime@cerno.tech>
In-Reply-To: <d757ddd6549da140f178563e5fd2bf1d129913fd.1599120059.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 4 Sep 2020 10:46:26 +0100
Message-ID: <CAPY8ntC_Tobv+4TtgtYhvAst00_zsfxZdZd=torcb57SQ0CMQA@mail.gmail.com>
Subject: Re: [PATCH v5 75/80] drm/vc4: hdmi: Add pixel BVB clock control
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 3 Sep 2020 at 09:03, Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>
> The BCM2711 has another clock that needs to be ramped up depending on the
> pixel rate: the pixel BVB clock. Add the code to adjust that clock when
> changing the mode.
>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> [Maxime: Changed the commit log, used clk_set_min_rate]
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> Link: https://lore.kernel.org/r/20200901040759.29992-3-hoegeun.kwon@samsung.com
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index ab7abb409de2..39508107dafd 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -54,6 +54,7 @@
>  #include "vc4_regs.h"
>
>  #define CEC_CLOCK_FREQ 40000
> +#define VC4_HSM_MID_CLOCK 149985000

I didn't flag it earlier, but this is a bit of a weird name for the
define. I know it wants to be concise, but it made me do a double take
as to what it is for.
I'm currently applying all these patches to our Raspberry Pi tree and
actually CEC needs a fixed HSM on Pi0-3 to avoid recomputing all the
timings. So I have a VC4_HSM_CLOCK define which is the fixed clock
rate for Pi 0-3.
This one is more a threshold for HSM to control BVB, and my brain
starts to hurt over what it should be called.

Unless there are other comments around this patchset (and I hope to
read through the remaining ones today), then I don't consider it a
blocker, but we can probably do better as and when we add the next
threshold for 4k60.
My current understanding is that the clock has to be an integer divide
of 600MHz, and at least the pixel rate / 2, so the only link to HSM is
due to HSM being 101% of pixel rate, but I will try to find
confirmation of that.

>
>  static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  {
> @@ -344,6 +345,7 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
>         HDMI_WRITE(HDMI_VID_CTL,
>                    HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
>
> +       clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
>         clk_disable_unprepare(vc4_hdmi->hsm_clock);
>         clk_disable_unprepare(vc4_hdmi->pixel_clock);
>
> @@ -516,6 +518,27 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder)
>                 return;
>         }
>
> +       /*
> +        * FIXME: When the pixel freq is 594MHz (4k60), this needs to be setup
> +        * at 150MHz.
> +        */

Typo here. For 4k60 we need 300MHz (pixel clock / 2)

Otherwise
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> +       ret = clk_set_min_rate(vc4_hdmi->pixel_bvb_clock,
> +                              (hsm_rate > VC4_HSM_MID_CLOCK ? 150000000 : 75000000));
> +       if (ret) {
> +               DRM_ERROR("Failed to set pixel bvb clock rate: %d\n", ret);
> +               clk_disable_unprepare(vc4_hdmi->hsm_clock);
> +               clk_disable_unprepare(vc4_hdmi->pixel_clock);
> +               return;
> +       }
> +
> +       ret = clk_prepare_enable(vc4_hdmi->pixel_bvb_clock);
> +       if (ret) {
> +               DRM_ERROR("Failed to turn on pixel bvb clock: %d\n", ret);
> +               clk_disable_unprepare(vc4_hdmi->hsm_clock);
> +               clk_disable_unprepare(vc4_hdmi->pixel_clock);
> +               return;
> +       }
> +
>         if (vc4_hdmi->variant->reset)
>                 vc4_hdmi->variant->reset(vc4_hdmi);
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 34138e0dd4a6..59639b405b7f 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -119,6 +119,7 @@ struct vc4_hdmi {
>         struct clk *pixel_clock;
>         struct clk *hsm_clock;
>         struct clk *audio_clock;
> +       struct clk *pixel_bvb_clock;
>
>         struct debugfs_regset32 hdmi_regset;
>         struct debugfs_regset32 hd_regset;
> --
> git-series 0.9.1
