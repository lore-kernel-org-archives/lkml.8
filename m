Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E84C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 23:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C091E20733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 23:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC2X3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 19:29:48 -0400
Received: from mailoutvs3.siol.net ([185.57.226.194]:44343 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbgC2X3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 19:29:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A502E521FBD;
        Mon, 30 Mar 2020 01:29:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZWF0-JOzCeTW; Mon, 30 Mar 2020 01:29:44 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4DA5D521FD4;
        Mon, 30 Mar 2020 01:29:44 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 934CE521FBD;
        Mon, 30 Mar 2020 01:29:42 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] drm/bridge: anx6345: set correct BPC for display_info of connector
Date:   Mon, 30 Mar 2020 01:29:42 +0200
Message-ID: <11490050.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20200329222253.2941405-1-anarsoul@gmail.com>
References: <20200329222253.2941405-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 30. marec 2020 ob 00:22:53 CEST je Vasily Khoruzhick 
napisal(a):
> Some drivers (e.g. sun4i-drm) need this info to decide whether they
> need to enable dithering. Currently driver reports what panel supports
> and if panel supports 8 we don't get dithering enabled.
> 
> Hardcode BPC to 6 for now since that's the only BPC
> that driver supports.

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

> 
> Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c index
> d7cb10c599a3..ea5de9395662 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -494,6 +494,9 @@ static int anx6345_get_modes(struct drm_connector
> *connector)
> 
>  	num_modes += drm_add_edid_modes(connector, anx6345->edid);
> 
> +	/* Driver currently supports only 6bpc */
> +	connector->display_info.bpc = 6;
> +
>  unlock:
>  	if (power_off)
>  		anx6345_poweroff(anx6345);




