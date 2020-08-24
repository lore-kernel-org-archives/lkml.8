Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A8FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7735C206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aGSEOSla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHXCRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:17:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49130 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHXCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:17:51 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF2C7279;
        Mon, 24 Aug 2020 04:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598235468;
        bh=VS2Ji6BKMMlOSyfmJqEuX9dmkd7/97W4wQM4QpLMh50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGSEOSlarAmS9SsV7QTFOWmejcCuuTIlcLQDaTE6wx/zYQS2rV0NXhaygzDsHetxj
         pQDSk/qp9E91lBNQ9ow/HO9v2iIopYXdzc8Qnb+I0ku9vHrw+nuqm8dnDlg2yst0ck
         e7F74w9KDQWOFTmwNKAkZ3J3xYhsc3A3V3O34s1g=
Date:   Mon, 24 Aug 2020 05:17:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, jsarha@ti.com, nsekhar@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v8 2/3] drm: bridge: Add support for Cadence MHDP DPI/DP
 bridge
Message-ID: <20200824021729.GY6002@pendragon.ideasonboard.com>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <1596713672-8146-3-git-send-email-sjakhade@cadence.com>
 <20200811023622.GC13513@pendragon.ideasonboard.com>
 <a2f2ff9d-0c52-12d9-23c5-bab35ef8f8f6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2f2ff9d-0c52-12d9-23c5-bab35ef8f8f6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Fri, Aug 14, 2020 at 11:22:09AM +0300, Tomi Valkeinen wrote:
> On 11/08/2020 05:36, Laurent Pinchart wrote:
> 
> >> +static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
> >> +{
> >> +	u32 bus_format = MEDIA_BUS_FMT_RGB121212_1X36;
> >> +	struct drm_connector *conn = &mhdp->connector;
> >> +	struct drm_bridge *bridge = &mhdp->bridge;
> >> +	int ret;
> >> +
> >> +	if (!bridge->encoder) {
> >> +		DRM_ERROR("Parent encoder object not found");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	conn->polled = DRM_CONNECTOR_POLL_HPD;
> >> +
> >> +	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
> >> +				 DRM_MODE_CONNECTOR_DisplayPort);
> >> +	if (ret) {
> >> +		DRM_ERROR("Failed to initialize connector with drm\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
> >> +
> >> +	ret = drm_display_info_set_bus_formats(&conn->display_info,
> >> +					       &bus_format, 1);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	conn->display_info.bus_flags = DRM_BUS_FLAG_DE_HIGH;
> > 
> > Aren't these supposed to be retrieved from the display ? Why do we need
> > to override them here ?
> 
> DE_HIGH is meant for the display controller. I think this should be in bridge->timings->input_bus_flags
> 
> >> +static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
> >> +				  struct drm_bridge_state *bridge_state,
> >> +				  struct drm_crtc_state *crtc_state,
> >> +				  struct drm_connector_state *conn_state)
> >> +{
> >> +	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
> >> +	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> >> +	int ret;
> >> +
> >> +	if (!mhdp->plugged)
> >> +		return 0;
> >> +
> >> +	mutex_lock(&mhdp->link_mutex);
> >> +
> >> +	if (!mhdp->link_up) {
> >> +		ret = cdns_mhdp_link_up(mhdp);
> >> +		if (ret < 0)
> >> +			goto err_check;
> >> +	}
> > 
> > atomic_check isn't supposed to access the hardware. Is there a reason
> > this is needed ?
> 
> We have been going back and forth with this. The basic problem is that
> to understand which videomodes can be used, you need to do link
> training to see the bandwidth available.
> 
> I'm not sure if we strictly need to do LT in atomic check, though...
> It would then pass modes that can't be used, but perhaps that's not a
> big issue.
> 
> I think the main point with doing LT in certain places is to filter
> the list of video modes passed to userspace, as we can't pass the
> modes from EDID directly without filtering them based on the link
> bandwidth.

I've discussed this on #dri-devel with Daniel a week or two ago. His
advice was to drop LT from atomic check, relying on DPCD (DisplayPort
Configuration Data) instead. If LT then fails to negotiate a high-enough
bandwidth for the mode when enabling the output, the link-status
property should be set to bad, and userspace should retry. I think
you've seen the discussion, I can provide a log if needed.

-- 
Regards,

Laurent Pinchart
