Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31499C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C0A22B3F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="a51eZGbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgG1Kht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgG1Kht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:37:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F40C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:37:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so17777292wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZjzAoiWn1HSh0Y0nkJfSNiw0UIfvD0fsceTUq2RuYk=;
        b=a51eZGbm6AIsMwVK6quzrGdo4namqdd/119nT+FhzgTCI1cP2ZXE9xyzrK/Dibox96
         YDt4CzGvuA8BFkl6016hNTW65d2MdXct9rnADduF3Tm7F1000TWXFtnBDgvhHzvpINcC
         x/2/TT7wO4hqryvt80wM3Bz/a0BF49Te3UREiFw+98qdgckjXAUNXeR7LAyM563LdL8H
         t0fRLSOS82X2PRwXm7F3OXswaZIJyyg6VWwUX43rrEsTpA/0A0ZAoAFxwU9Wify7tz9R
         rGgFpoLWs5DorYH8Q4HiE3O/45ZMgSWEIEr6RgJq78b9FKZQ6Z1QbbH6ZEhxt6tbGNLF
         56vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZjzAoiWn1HSh0Y0nkJfSNiw0UIfvD0fsceTUq2RuYk=;
        b=RkzPvYZYvDsk4wQP5hVGkQTVXWtlH5U8Rygh8FN2IZc7p8PJR0HPR88p7c3nJI0qSX
         WLVUUs5ICkdUEcpExytdf0RTPs2O2mQWKFJxhpdK5sXpW/1PiwPn6jmSn7RHhopTrzjU
         T14ryIJjUK7eOXybYlEXhweIp/3/Wr1QdAoPw0OvU9S5LmH4HRq0jt0ThHVR+u4hzgdH
         sG9BAUPRrxQWE6SH5rvgZc/DJ6QpTHJJW9r9xjmRE/S3UTwcpPNSUbEvMcUnWAa37ueT
         JWmTXAUSJshZjsr4UOPS/2GbTU+lTzynVNikPb66AM6hnZeh3RFGaKk0OW7AqDX2yaFS
         AkLA==
X-Gm-Message-State: AOAM530heZirCgrC9UsZHd3/pjjRX3HaUaWCLHhSaLAsClA36k3/IOR5
        ud9sy+QOrnR5ackc6tUPfJoOKrXhOAZUvkFGLvX+fg==
X-Google-Smtp-Source: ABdhPJxWibovrmlX+nW4KlLfNQN5y+/n0cpGK4fLmq/5GvkNGv0NvEq0f6EQqnQZa3H/YJqJNCOOQ0IuE/d+gBI6tto=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr19075246wrs.273.1595932667516;
 Tue, 28 Jul 2020 03:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <1fa32b771828098365162a24654c7bbab805500e.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <1fa32b771828098365162a24654c7bbab805500e.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:37:31 +0100
Message-ID: <CAPY8ntCtj+yMNmnqT+q0AH6sYSLXWa7E=vZoSPGt1Bda1iHEpw@mail.gmail.com>
Subject: Re: [PATCH v4 24/78] drm/vc4: hvs: Make sure our channel is reset
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
> In order to clear our intermediate FIFOs that might end up with a stale
> pixel, let's make sure our FIFO channel is reset everytime our channel is
> setup.

Minor nit pick: s/everytime/every time

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index c7de77afbf0a..64b9d72471ef 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -205,6 +205,10 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
>         u32 dispbkgndx;
>         u32 dispctrl;
>
> +       HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
> +       HVS_WRITE(SCALER_DISPCTRLX(chan), SCALER_DISPCTRLX_RESET);
> +       HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
> +
>         /* Turn on the scaler, which will wait for vstart to start
>          * compositing.
>          * When feeding the transposer, we should operate in oneshot
> --
> git-series 0.9.1
