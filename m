Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2959DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0627D2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="TtGG4LDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgGHQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbgGHQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:54:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA5C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:54:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so49750975wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOVkqwckQQd55xs9l2xekP/piuHMiACO9inQRc/624Y=;
        b=TtGG4LDilrrh105PxPZxfegeCFu329cU+BDYujVlSNPA/eV+N5rQLeSu4f9VNLv4EY
         jJXnMpeYSsY9v5ysdriB/Hdv7bPmV6ebu0WLsdR5QtuofFwIKWHA25JdHRc8aJmzbtST
         dkPMA8o+wOk1I1iqtY8N8XkkS8AY9V/RXRrRmMpZhOHeETr6llzVlatZu8t4uIRUziB/
         pZCHiO5QP8ZfoMsI13oKDv2l5Sao7jE9NVeqdVzNS8i7Sp+FU7KFZsf/qKt9IB8E1irm
         0YehjaJ5rDST1wEhuW7LtWdNQ/+HKsI9krgqqI7O7wAyVZ2Wm6XV9+9fRTczuXASdmoi
         Q0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOVkqwckQQd55xs9l2xekP/piuHMiACO9inQRc/624Y=;
        b=AbzpUCrNa8839lByWpY/VvJaGJVr/YOSf1i/5xOCO8CNhTdDqpT7ZW6YnQ7VG6aRY2
         nhhp/w4fp247pz0aRG9g+0rgyOv/BwFa+35BiTX1G+QBf3RpWp2n/7XpurSbg1ha5WOf
         f4GG9mQW3wmmV524qUMG/7h0viP/vnnu4oewI089cc4cu5HzUVmuwT/kmzp38AmSFTrF
         klLdoazqWkGpinypeLQSZmRkbKtIjt8L8+ElBcuHIFQ9NYSEjb6squWk11eDyTh+1ni/
         9ceNrpgBpJwFlaH37kCmj0Viadk9WwCVwPeTnTImQ1zbgZ4DLxjNc1F1Go2OlsxovFzb
         1eLQ==
X-Gm-Message-State: AOAM5326vxPOe8uGITHriWh438Q2Qjlo1wWeoHzR/KCM9AktNpEQ8ItM
        1s8cLON1V8KtjqyBOj06IYMGXdSY74sOWiah8FSFUg==
X-Google-Smtp-Source: ABdhPJyVCpbbKtoLOEzP8YwwHDnBfwPBOs+phqlZhXQ4uNw+YwtkN1XbsB4wVgHaAUiql5DgdP9vGzDTZQsegl1cvIg=
X-Received: by 2002:adf:9062:: with SMTP id h89mr55137959wrh.285.1594227249993;
 Wed, 08 Jul 2020 09:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <1594137527-15201-1-git-send-email-martin.fuzzey@flowbird.group> <a55b91f01a2e795fe2dd38d860e63a63c8c8871c.camel@pengutronix.de>
In-Reply-To: <a55b91f01a2e795fe2dd38d860e63a63c8c8871c.camel@pengutronix.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 8 Jul 2020 18:53:59 +0200
Message-ID: <CANh8QzwEgVG5AvJ4s7ydfPMDKpK5pb0TSaz9i9dgZ+1ZMJw3vQ@mail.gmail.com>
Subject: Re: [PATCH] drm: imx: Fix occasional screen corruption on modeset.
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

thanks for the quick reply.

On Wed, 8 Jul 2020 at 10:31, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Could this be just a panel getting confused because the pixel clock is
> disabled, or is there really an issue with the IPU? Have you tried just
> keeping clk_di_pixel enabled in ipu_di_disable(), but continuing
> to disable DI and DC?
>

I've  tried that now but still observed the corruption.

> > The exact reason isn't understood but it seems timing related.
> >

Also just adding a msleep(2) or a mdelay(20) at the end of
ipu_crtc_atomic_disable() makes the problem go away too.
Obviously I'm not suggesting doing that, just that it may help
understand what is going on.

>
> Just removing ipu_di_disable() leaks a clk_prepare_enable refcount on
> the di->clk_di_pixel clock.
>
> Also this is followed by an ipu_dc_disable(), which should remove the DC
> module's clock if this is the only display. So the DC should be disabled
> anyway.
>

True.

How about doing just ipu_crtc_disable_planes() and
drm_crtc_vblank_off() in the active (modeset) case.
and in ipu_crtc_atomic_enable() only doing the stuff  (which doesn't
touch the planes) if old_state->active == false ?

That will fix the clock refcount problem and seems generally better as
tearing down everything just to do a modeset
seems a bit heavy handed.

I've tested that and it works too but it's probably better to discuss
this some more before sending a new patch.

Regards,

Martin
