Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F422C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448022078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="I6r7eI3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgG1O5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgG1O5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:57:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:57:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so18057809wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwhNWR8x4sReBUnXjkKAZ+VUi9i5Kb9McNJ2lAFUYVE=;
        b=I6r7eI3O9VehcrKADawlnXf0PAyUWwxAU3XCL5cRdAeuursNuOJMO+HtHbxlxYS1Xv
         AzghH5B+Pp1ChD3vptP4ouSznOVU5WsOSWiY3TRQYDooWtp7UT99tXpv23Gg1Bqa2WX2
         z1pUy07I5jdbs76FEVP0aD/lpF/GMVebXdg4fTZTUO+hCMH+7OuECwRUGyAqGNP4gaJO
         zpWnVoWVrt6knZRcHhO4EW6P7uM7luOEO1Sg660qoKgSbVpSJ4l2iVXZkMP5dsQH5pGn
         99ojDgiGyDTuVsbhLGwQLTFT7o/ZxBfaBw56hnChQALvfqWdAptkdI+H86IJaeo63E+1
         BgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwhNWR8x4sReBUnXjkKAZ+VUi9i5Kb9McNJ2lAFUYVE=;
        b=P/Q4hud3gI2FlOSOqE+Fvksyxj8q0yUhH5Gpc3Bgh+p9C95dR6sVmE5iEnG00Q753n
         si4p4P4JYzvE8wHG3x+HEHu+YxCAdPJmT6xuLuK2lkZV/MKnvcv8Cc6lUYnvJMzWPBWR
         9G918ARsxHQGqavFpShYqfPCtu1sbv9w7blfglB9KGZ4aEiUmYWjuMVMr6VRYfmWHD5c
         P/UAtccOTqAbEDf5ine/xZMwf9Z4FikWeEXhIgjrzQ9LjOGzyqO1bJJoHvBYwrk98IHQ
         Nm/Uh0meKnmBibs3ZQUkiCeGT5Ma2SO/ZcL7t0bUuv7k3A9UUTpjs9C2mVEwt0JtIY8w
         fS8A==
X-Gm-Message-State: AOAM531DpmuIKw2deRzf7XFBPGj7qCYuZQ4ltGDSQ/Atjps2Q7CcFtJ4
        1npCKsl4CeGe7dIrMANwTQIdG70RNc/3fZ64t8NDxA==
X-Google-Smtp-Source: ABdhPJwdvN11Z/Q0YJ6kgQpbGgsMXnn1xBOigXdlYRNApIMYuC35kGIxzsnpR7nvqAx4GRIiJdQxadfOp+Nob0+zceo=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr20006305wrs.273.1595948257404;
 Tue, 28 Jul 2020 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a47487bc8873abe33499e79d3c10d085e341614e.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <a47487bc8873abe33499e79d3c10d085e341614e.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 15:57:22 +0100
Message-ID: <CAPY8ntCkuN-cahLd7Ex4awkcUhFVM43nGX4rZCtjRmy-wCyHGQ@mail.gmail.com>
Subject: Re: [PATCH v4 63/78] drm/vc4: hdmi: Use clk_set_min_rate instead
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
> The HSM clock needs to be running at 101% the pixel clock of the HDMI
> controller, however it's shared between the two HDMI controllers, which
> means that if the resolutions are different between the two HDMI
> controllers, and the lowest resolution is on the second (in enable order)
> controller, the first HDMI controller will end up with a smaller than
> expected clock rate.
>
> Since we don't really need an exact frequency there, we can simply change
> the minimum rate we expect instead.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 9f30fab744f2..d99188c90ff9 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -462,7 +462,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>          * pixel clock, but HSM ends up being the limiting factor.
>          */
>         hsm_rate = max_t(unsigned long, 120000000, (pixel_rate / 100) * 101);
> -       ret = clk_set_rate(vc4_hdmi->hsm_clock, hsm_rate);
> +       ret = clk_set_min_rate(vc4_hdmi->hsm_clock, hsm_rate);
>         if (ret) {
>                 DRM_ERROR("Failed to set HSM clock rate: %d\n", ret);
>                 return;
> --
> git-series 0.9.1
