Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF58C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE032070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fEjcnq4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG2OJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:09:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48819C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:09:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so2849506wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5t5DpkkM9FfZvKuPlhDVpBPxywRpdtxeaztDcBlDx4Y=;
        b=fEjcnq4vJQquAdBwoOz/l89X9cOzX01g1ijj/xRZfBFMpu62QB2kZxFalmndleCpMV
         sbUgwYVYL8w78hxFH2mGTCXNBkhrbUWNgHMtxWN2VddpZD+Osy4SrfSWqYWr8bkDhCt1
         uFRTD1I0aoky8JhSEK6Lf0jiISaaoWuInL7qKUdTvGCczzFjUujs6SEItOYKA0lTSrWe
         ZdYMX5KlQJ068pjIozZXX8FNlyNO1sM+OJ9YtYgp0b7LC01awjuwiXJG+kgZcV04J1uG
         XcYyF1BEqEoDtn8MuPs2bon7aRIT3c2vJqWBGTrxWm0Bu4tJcBxRYQQy6PwA7ACUJ2sd
         vTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5t5DpkkM9FfZvKuPlhDVpBPxywRpdtxeaztDcBlDx4Y=;
        b=t7gn7aNu1J8EnOo3HcL02m808RjLZjo6krOs8OlJdA5CobMgHvnqgIdpY3CtW3y2TK
         2ts52accb7c5PzUfj6vZWJZ5iXmZmIqti4ptDTcQHIPD6852CnjKwcM95oYFp/ri/s1+
         CquMftQekXZDXjXN3oOQPKgAnLZDDcT6TQy1xE+gHmaHHFY11c3PM3iQ6OLOIQyXGitu
         g0HiWbDjAgfMlZ9lItyD8E69+m3aXu56I9S6FJaHkeN3bLvc7dI2WJw6hlgzd/XDuKlM
         lTpTNY3I3e24HKw++5mbcfubGzjP/gmDpIrCbchEKE1lv6c5hmMVexZM/jTogusl1N9e
         RNmA==
X-Gm-Message-State: AOAM530+hEGDN2TEDmmc/kpxughlQSfTuG2qB/qQ6XjeXTXrOmLwPPpy
        HBLoort4jzYTqLtDHp8BwKygojx4I+iD3oSu3dABHw==
X-Google-Smtp-Source: ABdhPJwML2HLeKzyxrFF+2eyXRCw+6uwISHpNJJ9ngzcYnDb3HpcH9lWvSA2mgwpe3fjqqayKr8IeuRxi7/Mg0IgVuI=
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr1521918wmg.183.1596031776995;
 Wed, 29 Jul 2020 07:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 29 Jul 2020 15:09:21 +0100
Message-ID: <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
Subject: Re: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the
 PixelValve output
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
> In order to avoid pixels getting stuck in the (unflushable) FIFO between
> the HVS and the PV, we need to add some delay after disabling the PV output
> and before disabling the HDMI controller. 20ms seems to be good enough so
> let's use that.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index d0b326e1df0a..7b178d67187f 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>         ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
>
> +       mdelay(20);

mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can we
not msleep instead?

  Dave

> +
>         if (vc4_encoder->post_crtc_disable)
>                 vc4_encoder->post_crtc_disable(encoder);
>
> --
> git-series 0.9.1
