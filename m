Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAA0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CCE204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f4LKtUcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMKpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:45:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37616 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:45:39 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2FE6B551;
        Thu, 13 Aug 2020 12:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597315536;
        bh=uW9VG8L7uohIKIDyQFErTa9Bom9c0JitTWJGHjrtMBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4LKtUcfI19KJrA+6t0w9g7GZzxoDtN+AoYGLifVjEnd6+QVHofMU65o12GsHvWr4
         pWNFBQQDoN5XWn9tkEDgWaT5RRU8cn6inf9/O3VY49f6lSYx1p0kLGwBsquqGT9VNk
         BPgfZc4ZtUL/JGzGN0l0y0S9M/5yz1nCC6BJDQq8=
Date:   Thu, 13 Aug 2020 13:45:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     crj <algea.cao@rock-chips.com>, jernej.skrabec@siol.net,
        laurent.pinchart+renesas@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, kuankuan.y@gmail.com, narmstrong@baylibre.com,
        hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        tzimmermann@suse.de, jbrunet@baylibre.com,
        linux-rockchip@lists.infradead.org, darekm@google.com,
        sam@ravnborg.org, linux-arm-kernel@lists.infradead.org,
        cychiang@chromium.org
Subject: Re: [PATCH 4/6] drm/rockchip: dw_hdmi: Add vendor hdmi properties
Message-ID: <20200813104522.GA6057@pendragon.ideasonboard.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
 <20200812083543.4231-1-algea.cao@rock-chips.com>
 <20200812093315.GE6057@pendragon.ideasonboard.com>
 <52cca26d-b2b3-22b2-f371-a8086f2e6336@rock-chips.com>
 <20200812133017.GJ6057@pendragon.ideasonboard.com>
 <20200813104228.096179e7@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813104228.096179e7@eldfell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:42:28AM +0300, Pekka Paalanen wrote:
> On Wed, 12 Aug 2020 16:30:17 +0300 Laurent Pinchart wrote:
> > On Wed, Aug 12, 2020 at 07:08:10PM +0800, crj wrote:
> > > 在 2020/8/12 17:33, Laurent Pinchart 写道:  
> > > > On Wed, Aug 12, 2020 at 04:35:43PM +0800, Algea Cao wrote:  
> > > >> Introduce struct dw_hdmi_property_ops in plat_data to support
> > > >> vendor hdmi property.
> > > >>
> > > >> Implement hdmi vendor properties color_depth_property and
> > > >> hdmi_output_property to config hdmi output color depth and
> > > >> color format.
> > > >>
> > > >> The property "hdmi_output_format", the possible value
> > > >> could be:
> > > >>           - RGB
> > > >>           - YCBCR 444
> > > >>           - YCBCR 422
> > > >>           - YCBCR 420
> > > >>
> > > >> Default value of the property is set to 0 = RGB, so no changes if you
> > > >> don't set the property.
> > > >>
> > > >> The property "hdmi_output_depth" possible value could be
> > > >>           - Automatic
> > > >>             This indicates prefer highest color depth, it is
> > > >>             30bit on rockcip platform.
> > > >>           - 24bit
> > > >>           - 30bit
> > > >> The default value of property is 24bit.
> > > >>
> > > >> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> > > >> ---
> > > >>
> > > >>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 174 ++++++++++++++++++++
> > > >>   include/drm/bridge/dw_hdmi.h                |  22 +++
> > > >>   2 files changed, 196 insertions(+)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > >> index 23de359a1dec..8f22d9a566db 100644
> > > >> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > >> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > > >> @@ -52,6 +52,27 @@
> > > >>   
> > > >>   #define HIWORD_UPDATE(val, mask)	(val | (mask) << 16)
> > > >>   
> > > >> +/* HDMI output pixel format */
> > > >> +enum drm_hdmi_output_type {
> > > >> +	DRM_HDMI_OUTPUT_DEFAULT_RGB, /* default RGB */
> > > >> +	DRM_HDMI_OUTPUT_YCBCR444, /* YCBCR 444 */
> > > >> +	DRM_HDMI_OUTPUT_YCBCR422, /* YCBCR 422 */
> > > >> +	DRM_HDMI_OUTPUT_YCBCR420, /* YCBCR 420 */
> > > >> +	DRM_HDMI_OUTPUT_YCBCR_HQ, /* Highest subsampled YUV */
> > > >> +	DRM_HDMI_OUTPUT_YCBCR_LQ, /* Lowest subsampled YUV */
> > > >> +	DRM_HDMI_OUTPUT_INVALID, /* Guess what ? */
> > > >> +};  
> > > >
> > > > Vendor-specific properties shouldn't use names starting with drm_ or
> > > > DRM_, that's for the DRM core. But this doesn't seem specific to
> > > > Rockchip at all, it should be a standard property. Additionally, new
> > > > properties need to come with a userspace implementation showing their
> > > > usage, in X.org, Weston, the Android DRM/KMS HW composer, or another
> > > > relevant upstream project (a test tool is usually not enough).  
> > > 
> > > We use these properties only in Android HW composer, But we can't upstream
> > > 
> > > our HW composer code right now.  Can we use this properties as private 
> > > property
> > > 
> > > and do not upstream HW composer for the time being?  
> > 
> > It's not my decision, it's a policy of the DRM subsystem to require an
> > open implementation in userspace to validate all API additions.
> 
> Also read
> https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements
> very carefully: it calls for a FOSS userspace project's proper upstream
> to have reviewed and accepted the patches to use the new UAPI, but
> those patches must NOT be MERGED at that time yet.

Correct. Many userspace projects wouldn't merge a patch before the
kernel API is merged, so that would create a chicken and egg problem :-)

-- 
Regards,

Laurent Pinchart
