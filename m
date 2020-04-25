Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10745C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB53220714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDYRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:23:45 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:45892 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDYRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:23:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id AFB6C804B9;
        Sat, 25 Apr 2020 19:23:40 +0200 (CEST)
Date:   Sat, 25 Apr 2020 19:23:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        drinkcat@chromium.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        hsinyi@chromium.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] Convert mtk-dsi to drm_bridge API and get EDID
 for ps8640 bridge
Message-ID: <20200425172334.GA30970@ravnborg.org>
References: <20200417150614.2631786-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417150614.2631786-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=D19gQVrFAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=C1xfsh8iGGs-51XnUgAA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
        a=W4TVW4IDbPiebHqcZpNg:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:06:07PM +0200, Enric Balletbo i Serra wrote:
> The PS8640 dsi-to-eDP bridge driver is using the panel bridge API,
> however, not all the components in the chain have been ported to the
> drm_bridge API. Actually, when a panel is attached the default panel's mode
> is used, but in some cases we can't get display up if mode getting from
> eDP control EDID is not chosen.
> 
> This series address that problem, first implements the .get_edid()
> callback in the PS8640 driver (which is not used until the conversion is
> done) and then, converts the Mediatek DSI driver to use the drm_bridge
> API.
> 
> As far as I know, we're the only users of the mediatek dsi driver in
> mainline, so should be safe to switch to the new chain of drm_bridge API
> unconditionally.
> 
> The patches has been tested on a Acer Chromebook R13 (Elm) running a
> Chrome OS userspace and checking that the valid EDID mode reported by
> the bridge is selected.
> 
> [1] https://lore.kernel.org/lkml/20200210063523.133333-1-hsinyi@chromium.org/
> 
> Changes in v3:
> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
> - Add the bridge.type. (Laurent Pinchart)
> - Use next_bridge field to store the panel bridge. (Laurent Pinchart)
> - Add the bridge.type field. (Laurent Pinchart)
> - This patch requires https://lkml.org/lkml/2020/4/16/2080 to work
>   properly.
This patch is now applied to drm-misc-next.
IMO this patchset could go in now.


> - Move the bridge.type line to the patch that adds drm_bridge support. (Laurent Pinchart)
> 
> Changes in v2:
> - Do not set connector_type for panel here. (Sam Ravnborg)
> 
> Enric Balletbo i Serra (7):
>   drm/bridge: ps8640: Get the EDID from eDP control
>   drm/bridge_connector: Set default status connected for eDP connectors
>   drm/mediatek: mtk_dsi: Rename bridge to next_bridge
>   drm/mediatek: mtk_dsi: Convert to bridge driver
>   drm/mediatek: mtk_dsi: Use simple encoder
>   drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
>   drm/mediatek: mtk_dsi: Create connector for bridges
All patches:
Acked-by: Sam Ravnborg <sam@ravnborg.org>


> 
>  drivers/gpu/drm/bridge/parade-ps8640.c |  12 ++
>  drivers/gpu/drm/drm_bridge_connector.c |   1 +
>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 276 ++++++++-----------------
>  3 files changed, 96 insertions(+), 193 deletions(-)
> 
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
