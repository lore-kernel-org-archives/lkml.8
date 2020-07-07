Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE00C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DE920738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="zVxRNPDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGGQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:48:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:48:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so47267548eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgVTJRvD9bwxe5h5OvimEh3WdUQa6jrydlK+z8ViyTs=;
        b=zVxRNPDq7ABzlflkDXevx/FhRX3DMHNv1OPOprmzo5mnbqWnTdiXr3GZ9aWg1o3S99
         kfIbw7eX93DpOe60uBJ1MCq69J4i2kwjsfBHFiQSBpFsRGqoP+Xw8vUEiubYxSvh9eKd
         rEEvMukKP+CiCbPiwrg0eVAIXy72RK2BZF7IzlOHb6akoBOrVrqBd5R97Iyn4yOI1Jzm
         qtGuOV8VdVYNsp3CYFNGqby+BbC4t7/DVn4OiKv3nXhRZBqmDU0D/c8gD/aWojzgoKMy
         Cp99EZZjV60Ui9aeL7L8GegBgX5P36pggwvzayFn3QiBf8do4mMHVD29Sxm2ZcwkmTI5
         GJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgVTJRvD9bwxe5h5OvimEh3WdUQa6jrydlK+z8ViyTs=;
        b=G3u4Gl6iYGKZJsznRZy5G+UJ18oQ2lAfJVqq5Bh7pQhm32fa48S6eMkDu5rsIsPFkS
         StfO/ULzlJbCyBLK94eGqcxVEjC+grN6TibxjiXrvy7pveMtGcndEcCdvFjHH54rFrHv
         KgVooZqWAkdgkJsH029YCXTs1O2kCEuvRU9peS8BGOI8/l8Cya5iw9OhNH/iApBGhgV0
         csPACOWXFE//HAqTw86ySsDUpYjrN0nd0z0yQj7CB8JLi/XiwhwWmvThwgR4kUdTcMZK
         e8OgIcH59h4ru3yjBuIurhvZsayqGAq5l8LT6spulEm9xRnSzGsIDwMKRnPAMdGoNnNJ
         /STQ==
X-Gm-Message-State: AOAM531OQN5osMHj1WFZTEM5vagRiAPnTD7ZzPB8VYDrh2Q74Ne823GG
        EBbDPp72mADtBXIfJTpcPqC+PZIE/Q1A9/EIo71XiQ==
X-Google-Smtp-Source: ABdhPJwN4AiRPoJPptQHSEO5cXd/B0knty7XexXAcHi41D+rEc2uWRwzjRdqzHuHAga/dgYkl+FQ3tSx4nDRlmqpLQA=
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr37299161ejd.404.1594140536621;
 Tue, 07 Jul 2020 09:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101912.571531-1-maxime@cerno.tech>
In-Reply-To: <20200707101912.571531-1-maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Tue, 7 Jul 2020 09:48:45 -0700
Message-ID: <CADaigPVu1PEANANuS03fO=kSxFuhmqsz=Y5WmwiAeXmMOotrHA@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: dsi: Only register our component once a DSI
 device is attached
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 3:26 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> If the DSI driver is the last to probe, component_add will try to run all
> the bind callbacks straight away and return the error code.
>
> However, since we depend on a power domain, we're pretty much guaranteed to
> be in that case on the BCM2711, and are just lucky on the previous SoCs
> since the v3d also depends on that power domain and is further in the probe
> order.
>
> In that case, the DSI host will not stick around in the system: the DSI
> bind callback will be executed, will not find any DSI device attached and
> will return EPROBE_DEFER, and we will then remove the DSI host and ask to
> be probed later on.
>
> But since that host doesn't stick around, DSI devices like the RaspberryPi
> touchscreen whose probe is not linked to the DSI host (unlike the usual DSI
> devices that will be probed through the call to mipi_dsi_host_register)
> cannot attach to the DSI host, and we thus end up in a situation where the
> DSI host cannot probe because the panel hasn't probed yet, and the panel
> cannot probe because the DSI host hasn't yet.
>
> In order to break this cycle, let's wait until there's a DSI device that
> attaches to the DSI host to register the component and allow to progress
> further.
>
> Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

I feel like I've written this patch before, but I've thankfully
forgotten most of my battle with DSI probing.  As long as this still
lets vc4 probe in the absence of a DSI panel in the DT as well, then
this is enthusiastically acked.
