Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13880207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGJIbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgGJIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:31:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3998C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:31:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jtoRT-0000yE-Jw; Fri, 10 Jul 2020 10:31:35 +0200
Message-ID: <58ef264448eb3ea75f846513210a5430b75b44c6.camel@pengutronix.de>
Subject: Re: [PATCH 0/4] Add support for GPU load values
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 10 Jul 2020 10:31:33 +0200
In-Reply-To: <20200710074143.306787-1-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Am Freitag, den 10.07.2020, 09:41 +0200 schrieb Christian Gmeiner:
> This patch series add support for loadavg values for GPU
> sub-components. I am adding a SMA algorithm as I was not
> really sure if EWMA would be a good fit for this use case.

1 second is a pretty long window in GPU time. Why do you feel that a
simple moving average is more appropriate than a exponentially
weighted one here? Note that I haven't given this any thought myself
and haven't made up my mind yet, so this is a honest question to
understand the reasoning behind your choice.

Regards,
Lucas

> Christian Gmeiner (4):
>   drm/etnaviv: add simple moving average (SMA)
>   drm/etnaviv: add loadavg accounting
>   drm/etnaviv: show loadavg in debugfs
>   drm/etnaviv: export loadavg via perfmon
> 
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c     | 14 ++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c     | 44 ++++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h     | 29 +++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_sma.h     | 53 +++++++++++++++
>  5 files changed, 218 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h
> 

