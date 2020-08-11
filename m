Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3161C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7766A2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AvcnLevq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgHKCnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:43:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49214 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgHKCnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:43:23 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6460858;
        Tue, 11 Aug 2020 04:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597113801;
        bh=WW5T77cfFpWObOoCK4Jd1gjvAgx5wXNgpO1aG1KQAGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvcnLevqsm+75glXW8u0IeEaT4/SPDcX+tRt01nszuRleIHWVqP/1zGNKhPdeBtwQ
         Rl4lNNNYSdi+4OxLFhJ3rzoHDVNBTshZjfwVsj+lNybDvr8CE2mUlW5SH1e3s9zW72
         f/j9m4qvpu4MYOpl+jw/rDfGzRp/8Ev4jngdT+BE=
Date:   Tue, 11 Aug 2020 05:43:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>, daniel@ffwll.ch
Cc:     Yuti Amonkar <yamonkar@cadence.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, maxime@cerno.tech, airlied@linux.ie,
        mark.rutland@arm.com, a.hajda@samsung.com, narmstrong@baylibre.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, praneeth@ti.com,
        jsarha@ti.com, mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v6 2/3] drm: bridge: Add support for Cadence MHDP DPI/DP
 bridge
Message-ID: <20200811024308.GE13513@pendragon.ideasonboard.com>
References: <1582712579-28504-1-git-send-email-yamonkar@cadence.com>
 <1582712579-28504-3-git-send-email-yamonkar@cadence.com>
 <20200311222053.GE4863@pendragon.ideasonboard.com>
 <ef6a6e31-425f-c402-83ab-886221b4a0c3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6a6e31-425f-c402-83ab-886221b4a0c3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi, Daniel,

On Thu, Mar 12, 2020 at 09:13:06AM +0200, Tomi Valkeinen wrote:
> On 12/03/2020 00:20, Laurent Pinchart wrote:
> >> +	ret = load_firmware(mhdp);
> >> +	if (ret)
> >> +		goto phy_exit;
> >> +
> >> +	drm_bridge_add(&mhdp->bridge);
>
> > What if someone starts using the bridge before the firmware is
> > operational ? It seems that you should delay bridge registration until
> > the firmware is loaded. It may make it possible to remove
> > bridge_attached and solve the problem you mention in mhdp_fw_cb().
> 
> Handling the fw has been a bit of a pain... This is what we came up with to support all the 
> combinations (built-in/module, fw-userspace-helper/direct load, single-output/multiple-outputs).
> 
> The idea is that when the driver is loaded and probed (with or without fw), the DP is "ready". If we 
> don't have fw yet, everything looks fine, but the connector stays in disconnected state. When we get 
> the fw, connector will get connected (only if there's a cable connected, of course).
> 
> If we register the bridge only when we have fw, two things can happen:
> 
> - If we get the fw only rather late (in case userspace fw helper), a userspace app (e.g. weston) 
> could already have been started, and failed due to there being no DRM card.
> 
> - If we have two displays from the same display controller, say, DP and HDMI, the HDMI will only be 
> available when the DP is available. If the DP fw, for some reason, cannot be loaded, we never get HDMI.

These seem to me to be deficiencies in the graphics stack. We don't have
to solve them now, but I'm curious to know if anyone would have ideas on
how this should ideally be addressed. Daniel, what do you think ?

-- 
Regards,

Laurent Pinchart
