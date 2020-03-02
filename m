Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F4DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3D3246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zt/3yA7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCBJSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:18:46 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCBJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:18:46 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0614654A;
        Mon,  2 Mar 2020 10:18:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583140724;
        bh=bWSWnRlEnxgw/Jwkv+DDpLesF0UhMGYrILmgH0Qtapw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt/3yA7PpTzJsecJt56a6UHocBjCjfwDIIKR7c4qy2MfGDvzcZF/wB9G70unntQtS
         /KwBMmScCjYDFPEGhg2ub76ouw7LxQKPHZgdFroo6oYpsj1WcpDhP6iet5OkrVa8cY
         aaWRFDWDjOyXhQkzHqbeWdgP2xatlV4C0knL0oiQ=
Date:   Mon, 2 Mar 2020 11:18:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        a.hajda@samsung.com, jonas@kwiboo.se,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 02/11] drm/bridge: dw-hdmi: add max bpc connector
 property
Message-ID: <20200302091818.GC11960@pendragon.ideasonboard.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-3-narmstrong@baylibre.com>
 <11463907.O9o76ZdvQC@jernej-laptop>
 <09d315b8-22f3-a25a-1aea-9c5d50c634d6@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09d315b8-22f3-a25a-1aea-9c5d50c634d6@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil and Jonas,

(CC'ing Daniel for a framework question)

Thank you for the patch.

On Fri, Feb 21, 2020 at 09:50:18AM +0100, Neil Armstrong wrote:
> On 17/02/2020 07:38, Jernej Škrabec wrote:
> > Dne četrtek, 06. februar 2020 ob 20:18:25 CET je Neil Armstrong napisal(a):
> >> From: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> Add the max_bpc property to the dw-hdmi connector to prepare support
> >> for 10, 12 & 16bit output support.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> >> 9e0927d22db6..051001f77dd4 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -2406,6 +2406,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
> >> *bridge) DRM_MODE_CONNECTOR_HDMIA,
> >>  				    hdmi->ddc);
> >>
> >> +	drm_atomic_helper_connector_reset(connector);
> > 
> > Why is this reset needed?
> 
> I assume it's to allocate a new connector state to attach a the bpc propery.
> 
> But indeed, this helper is never used here, but only as callback to the drm_connector_funcs->reset.
> 
> But, amdgpu calls :
> 	/*
> 	 * Some of the properties below require access to state, like bpc.
> 	 * Allocate some default initial connector state with our reset helper.
> 	 */
> 	if (aconnector->base.funcs->reset)
> 		aconnector->base.funcs->reset(&aconnector->base);
> 
> which is the same.

A comment would be useful:

	/*
	 * drm_connector_attach_max_bpc_property() requires the
	 * connector to have a state.
	 */
	drm_atomic_helper_connector_reset(connector);

	drm_connector_attach_max_bpc_property(connector, 8, 16);

I don't like this much though, it feels like the initial reset performed
by drm_mode_config_reset() should set default values for all state
members that are related to properties. Daniel, what's the rationale
behind the current implementation ?

This is a DRM core issue that shouldn't block this patch though, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >> +
> >> +	drm_connector_attach_max_bpc_property(connector, 8, 16);
> >> +
> >>  	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
> >>  		drm_object_attach_property(&connector->base,
> >>  			connector->dev-
> >> mode_config.hdr_output_metadata_property, 0);

-- 
Regards,

Laurent Pinchart
