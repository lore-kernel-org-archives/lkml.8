Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2A7206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHZRUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:20:18 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:56986 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:20:13 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8A7FF80640;
        Wed, 26 Aug 2020 19:20:05 +0200 (CEST)
Date:   Wed, 26 Aug 2020 19:20:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/5] drm/bridge: ps8640: Make sure all needed is
 powered to get the EDID
Message-ID: <20200826172003.GC346855@ravnborg.org>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826081526.674866-1-enric.balletbo@collabora.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=mRsQ17UTts98cKi72SYA:9
        a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

On Wed, Aug 26, 2020 at 10:15:21AM +0200, Enric Balletbo i Serra wrote:
> The first patch was initially part of the series [1] but for some reason
> was not picked when the series were merged, so I included in this series
> because it is needed to make the others to work properly.
> 
> The same happened for the second patch, was part of series [1] but not
> merged.
> 
> The third patch and next are part of the original series and are to rework
> the power handling to get the EDID. Basically, we need to make sure all the
> needed is powered to be able to get the EDID. Before, we saw that getting
> the EDID failed as explained in the third patch.
> 
> [1] https://lkml.org/lkml/2020/6/15/1208
> 
> Changes in v2:
> - Included the patch `drm/bridge_connector: Set default status connected for eDP connectors`
> - Included the patch `drm/bridge: ps8640: Get the EDID from eDP control`
> - Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam Ravnborg)
> 
> Enric Balletbo i Serra (5):
>   drm/bridge_connector: Set default status connected for eDP connectors
>   drm/bridge: ps8640: Get the EDID from eDP control
>   drm/bridge: ps8640: Return an error for incorrect attach flags
>   drm/bridge: ps8640: Print an error if VDO control fails
The first 4 patches are applied to drm-misc-next.

>   drm/bridge: ps8640: Rework power state handling
Let give this a copuple of days on the mailing list to see what we
conclude.

	Sam
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 89 ++++++++++++++++++++++----
>  drivers/gpu/drm/drm_bridge_connector.c |  1 +
>  2 files changed, 79 insertions(+), 11 deletions(-)
> 
> -- 
> 2.28.0
