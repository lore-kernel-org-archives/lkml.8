Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F66C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97F0208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Un6dIIgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgFPVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:47:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36142 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFPVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:47:57 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75ABEF9;
        Tue, 16 Jun 2020 23:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592344075;
        bh=7zS+t+AfxuVeGBr5sbILnhIldXeY6ocnNF8IQEghTYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Un6dIIgiw/jT8P/Kb1KkDWEaDh6FY7x6vUVLMflCxQJ+bzBR/DrVZKXFANKDmo7Jo
         sorX9pLMiQrNScw/1Md/zog+jIrsxSMmz6bXZ78Gg4cEHMMtUOgnRwYgMb8NIPTD/G
         trljgxNPrmeozMb3sYl/NSCdVBKLZH3dX8zmcCIA=
Date:   Wed, 17 Jun 2020 00:47:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Venkateshwar Rao Gannavarapu <VGANNAVA@xilinx.com>
Cc:     Hyun Kwon <hyunk@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandip Kothari <sandipk@xilinx.com>,
        Vishal Sagar <vsagar@xilinx.com>
Subject: Re: [RFC PATCH 2/2] drm: xlnx: driver for Xilinx DSI TX Subsystem
Message-ID: <20200616214732.GH913@pendragon.ideasonboard.com>
References: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1587417656-48078-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <20200504184348.GA3095@smtp.xilinx.com>
 <20200524030813.GF6026@pendragon.ideasonboard.com>
 <CY4PR02MB2790B791578160F257049FEAB18D0@CY4PR02MB2790.namprd02.prod.outlook.com>
 <20200607022518.GA7339@pendragon.ideasonboard.com>
 <CY4PR02MB27908C70E9D66DA91868FF35B1820@CY4PR02MB2790.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR02MB27908C70E9D66DA91868FF35B1820@CY4PR02MB2790.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GVRao,

Sorry for the delayed reply.

On Tue, Jun 09, 2020 at 02:48:25AM +0000, Venkateshwar Rao Gannavarapu wrote:
> Hi Laurent,
> 
> Thanks for the review. 
> Please see my comments about D-PHY and bridge driver implementation.
> 
> On Sunday, June 7, 2020 7:55 AM, Laurent Pinchart wrote:
> > On Sun, May 31, 2020 at 05:41:50PM +0000, Venkateshwar Rao Gannavarapu wrote:
> >> On Sunday, May 24, 2020 8:38 AM, Laurent Pinchart wrote:
> >>> On Mon, May 04, 2020 at 11:43:48AM -0700, Hyun Kwon wrote:
> >>>> On Mon, 2020-04-20 at 14:20:56 -0700, Venkateshwar Rao Gannavarapu wrote:
> >>>>> The Xilinx MIPI DSI Tx Subsystem soft IP is used to display video
> >>>>> data from AXI-4 stream interface.
> >>>>>
> >>>>> It supports upto 4 lanes, optional register interface for the
> >>>>> DPHY,
> >>>>
> >>>> I don't see the register interface for dphy support.
> >>>
> >>> I think the D-PHY should be supported through a PHY driver, as it
> >>> seems to be shared between different subsystems.
> >>
> >> IP has the provision to read DPHY register for debug purpose only.
> >> No programming of DPHY is required in subsystem.
> >
> > Do you know if this is the same D-PHY as used in the CSI2-RX subsystem ?
>  
> Same D-PHY core has been used in MIPI CSI2 RXSS, but with different configuration.
>
> >>>>> multiple RGB color formats, command mode and video mode.
> >>>>> This is a MIPI-DSI host driver and provides DSI bus for panels.
> >>>>> This driver also helps to communicate with its panel using panel
> >>>>> framework.
> >>>>>
> >>>>> Signed-off-by: Venkateshwar Rao Gannavarapu
> >>>>> <venkateshwar.rao.gannavarapu@xilinx.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/xlnx/Kconfig    |  11 +
> >>>>>  drivers/gpu/drm/xlnx/Makefile   |   2 +
> >>>>>  drivers/gpu/drm/xlnx/xlnx_dsi.c | 755 ++++++++++++++++++++++++++++++++++++++++
> >>>
> >>> Daniel Vetter has recently expressed his opiion that bridge drivers
> >>> should go to drivers/gpu/drm/bridge/. It would then be
> >>> drivers/gpu/drm/bridge/xlnx/. I don't have a strong opinion myself.
> 
> The DSI-TX subsystem IP block is not a bridge driver.
> The DSI-TX subsystem IP block itself contains all the drm encoder/connector
> functionality and it’s the last node in display pipe line.

The DSI-TX subsystem IP block is indeed an encoder from a hardware point
of view, but it's not necessarily the last block in the display
pipeline. While the output of the IP core goes of the the SoC, tt would
be entirely feasible to connect it to a DP to HDMI bridge on the board,
such as the ANX7737 ([1]) for instance. This is why we're pushing for
all encoder (from a hardware point of view) drivers to be implemented as
DRM bridge, in order to make them usable in different display pipelines,
without hardcoding the assumption they will be the last encoder in the
pipeline.

> I didn't see any hard
> requirement to implement it into bridge driver and I see many DSI drivers are
> implemented as encoder drivers.
> Xilinx PL DRM encoder drivers are implemented in modular approach so that
> they can work with any CRTC driver which handles the DMA calls.
> So, at this stage we want to upstream as encoder driver only.
>
> >>>>>  3 files changed, 768 insertions(+)  create mode 100644
> >>>>> drivers/gpu/drm/xlnx/xlnx_dsi.c

[1] https://www.analogix.com/en/products/convertersbridges/anx7737

-- 
Regards,

Laurent Pinchart
