Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A747CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E0C20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GicjvrjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGHRwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:52:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40832 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGHRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:52:37 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55F08543;
        Wed,  8 Jul 2020 19:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594230754;
        bh=KKzBTl6YKIOlqsHBpama/zrOhg4GPjiqgx1vplbo4pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GicjvrjMGuwUGj7stScs5VUR1thfKARNOkAGLZiB7hXUpmjBFBPpCTTrlZ0zDM3U8
         LvAh28xrblM6T1vN94C3I3gyG6tGvNXItDemR435Da1zbPBhkKvobX2Teu1ZMixztH
         JvBQRBjFoxzl5h8+zILWPnvGq3Q1zVa9fKRNLy3Y=
Date:   Wed, 8 Jul 2020 20:52:28 +0300
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
Message-ID: <20200708175228.GM20298@pendragon.ideasonboard.com>
References: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1587417656-48078-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <20200504184348.GA3095@smtp.xilinx.com>
 <20200524030813.GF6026@pendragon.ideasonboard.com>
 <CY4PR02MB2790B791578160F257049FEAB18D0@CY4PR02MB2790.namprd02.prod.outlook.com>
 <20200607022518.GA7339@pendragon.ideasonboard.com>
 <CY4PR02MB27908C70E9D66DA91868FF35B1820@CY4PR02MB2790.namprd02.prod.outlook.com>
 <20200616214732.GH913@pendragon.ideasonboard.com>
 <CY4PR02MB27908FE1FBB9ADA2F3395E16B1970@CY4PR02MB2790.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR02MB27908FE1FBB9ADA2F3395E16B1970@CY4PR02MB2790.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GVRao,

Thank you for pinging me privately.

On Mon, Jun 22, 2020 at 02:19:22PM +0000, Venkateshwar Rao Gannavarapu wrote:
> On Wednesday, June 17, 2020 3:18 AM, Laurent Pinchart wrote:
> > On Tue, Jun 09, 2020 at 02:48:25AM +0000, Venkateshwar Rao Gannavarapu wrote:
> >> Hi Laurent,
> >>
> >> Thanks for the review.
> >> Please see my comments about D-PHY and bridge driver implementation.
> >>
> >> On Sunday, June 7, 2020 7:55 AM, Laurent Pinchart wrote:
> >>> On Sun, May 31, 2020 at 05:41:50PM +0000, Venkateshwar Rao Gannavarapu wrote:
> >>>> On Sunday, May 24, 2020 8:38 AM, Laurent Pinchart wrote:
> >>>>> On Mon, May 04, 2020 at 11:43:48AM -0700, Hyun Kwon wrote:
> >>>>>> On Mon, 2020-04-20 at 14:20:56 -0700, Venkateshwar Rao Gannavarapu wrote:
> >>>>>>> The Xilinx MIPI DSI Tx Subsystem soft IP is used to display
> >>>>>>> video data from AXI-4 stream interface.
> >>>>>>>
> >>>>>>> It supports upto 4 lanes, optional register interface for the
> >>>>>>> DPHY,
> >>>>>>
> >>>>>> I don't see the register interface for dphy support.
> >>>>>
> >>>>> I think the D-PHY should be supported through a PHY driver, as it
> >>>>> seems to be shared between different subsystems.
> >>>>
> >>>> IP has the provision to read DPHY register for debug purpose only.
> >>>> No programming of DPHY is required in subsystem.
> >>>
> >>> Do you know if this is the same D-PHY as used in the CSI2-RX subsystem ?
> >>
> >> Same D-PHY core has been used in MIPI CSI2 RXSS, but with different configuration.
> >>
> >>>>>>> multiple RGB color formats, command mode and video mode.
> >>>>>>> This is a MIPI-DSI host driver and provides DSI bus for panels.
> >>>>>>> This driver also helps to communicate with its panel using panel
> >>>>>>> framework.
> >>>>>>>
> >>>>>>> Signed-off-by: Venkateshwar Rao Gannavarapu
> >>>>>>> <venkateshwar.rao.gannavarapu@xilinx.com>
> >>>>>>> ---
> >>>>>>>  drivers/gpu/drm/xlnx/Kconfig    |  11 +
> >>>>>>>  drivers/gpu/drm/xlnx/Makefile   |   2 +
> >>>>>>>  drivers/gpu/drm/xlnx/xlnx_dsi.c | 755 ++++++++++++++++++++++++++++++++++++++++
> >>>>>
> >>>>> Daniel Vetter has recently expressed his opiion that bridge
> >>>>> drivers should go to drivers/gpu/drm/bridge/. It would then be
> >>>>> drivers/gpu/drm/bridge/xlnx/. I don't have a strong opinion myself.
> >>
> >> The DSI-TX subsystem IP block is not a bridge driver.
> >> The DSI-TX subsystem IP block itself contains all the drm
> >> encoder/connector functionality and it’s the last node in display pipe line.
> >
> > The DSI-TX subsystem IP block is indeed an encoder from a hardware point of
> > view, but it's not necessarily the last block in the display pipeline. While the
> > output of the IP core goes of the the SoC, tt would be entirely feasible to
> > connect it to a DP to HDMI bridge on the board, such as the ANX7737 ([1]) for
> > instance. This is why we're pushing for all encoder (from a hardware point of
> > view) drivers to be implemented as DRM bridge, in order to make them usable
> > in different display pipelines, without hardcoding the assumption they will be
> > the last encoder in the pipeline.
> 
> Thanks for the details.
> I can understand it as SoC requirement where crtc is fixed, but as a FPGA product
> encoder driver should work with any of crtc driver.  And I still not
> see bridge implementation as hard requirement.
> Could you please explain what problem we face, if implemented as encoder driver.

First of all, there's no "encoder driver" in DRM/KMS. We have a "DRM
encoder slave" infrastructure that has been deprecated for a long time
in favour of DRM bridge, but apart from that, there's no "encoder
driver".

When the DRM/KMS API was designed, it modelled display devices using
four main objects:

- Planes, that represented a memory input to the compositor
- CRTCs, that represented the scan out hardware
- Encoders, that represented a device encoding the output of the
  composer to the display bus format (LVDS, HDMI, DisplayPort, ...)
- Connectors, that represented the physical connector

Drivers initially implemented all these objects internally, without much
code sharing for encoders (for instance the same I2C encoder chip would
have support code inside the i915 driver and inside the nouveau driver).

Those four objects exist in the kernel and are exposed to userspace. As
we can't break the API, this is set in stone. The model was later
extended with additional objects that are not exposed to userspace:

- Panels allow sharing code related to display panels, and are
  implemented as panel drivers, registering a drm_panel structure with
  the DRM core.

- Slave encoders allow sharing code related to encoders, mostly for I2C
  chips. This has quickly been deprecated.

- Bridges also allow sharing code related to encoders, initially for
  I2C/SPI encoder chips outside of the SoC.

The bridge infrastructure was initially designed to be an add-on to the
encoder, allowing the framework to share code for external encoders. For
instance, and SoC that contains an parallel RGB (output of the CRTC) to
LVDS encoder, and an on-board I2C LVDS to HDMI encoder, would handle the
former in the display controller driver, and the latter as a DRM bridge.

We later figured out that some systems had more than one additional chip
attached to the output of the in-SoC encoder. The DRM bridge
infrastructure received support for bridge chaining, where multiple
bridges can be attached one after the other at the output of an encoder.
At that point it became possible to model the in-SoC encoder IP cores as
a DRM bridge, and that has been done mostly for IP cores that are used
in different SoCs (such as the Synopsys DWC-HDMI for instance).
Supporting internal encoders that are specific to a particular display
controller through the DRM bridge infrastructure was possible too, but
nobody bothered migrating existing code.

Much more recently, we realized there was one more missing features in
the DRM bridge infrastructure. Bridges always made assumptions as
whether they would be in the middle of the chain or at the end of it,
and created a DRM connector in the latter case. This became problematic
when the same bridge got used in the middle of the chain and at the end
of it in different systems. We have thus started to migrate the DRM
bridge framework to be more flexible, and allow delegating connector
operations to different bridges, based on the features they implement,
and not based on their position in the chain. In this model, which we
are actively transitioning to, the DRM connector is created by the
display controller drivers, not the bridge drivers, and the connector
operations are implemented in a way that calls the appropriate bridge
operations (see [2] for more information).

Implementing support for an in-SoC encoder that is part of a display
controller as a DRM bridge is not mandatory, even if I recommend doing
so. In the case at hand, the DSI TX is an IP core (or rather a set of IP
cores, but from the outside it's one coherent unit) that can be used in
different designs. It's not tied to a particular display controller, but
can be used with different IP cores that would all fulfil the role of a
CRTC. It thus needs to be supported by code that can be shared between
different DRM drivers, instantiating the DSI TX device from DT. This is
exactly what the DRM bridge framework provides, a way to abstract a
component in the display pipeline, register it with the DRM core, and
using it in different DRM drivers.

If I were to stop here, implementing support for the DSI TX using a
Xilinx-specific component registration mechanism would duplicate what
DRM bridge provides, but apart from code duplication, there wouldn't be
large drawbacks. However, the position of the DSI TX in the display
pipeline isn't fixed. It is a fact that it terminates the part of the
display pipeline that is internal to the SoC, as it interfaces directly
with the pins of the SoC through the D-PHY. That's the only guarantee on
the IP core position though: it can be followed by other encoders (for
instance an on-board DSI to HDMI or DSI to DP encoder) instead of being
connected directly to a DSI panel, but can also be preceded by other
IP cores (I'm in particular thinking about a scaler, other options are
possible as we're dealing with an FPGA here). For these reasons,
modelling the DSI TX as a bridge would not only avoid duplication of
code, but would also provide the ability to support a wider variety of
use cases and pipelines, if all the components are implemented as DRM
bridges.

There's one caveat though. DRM bridges may be chained, but only in a
linear fashion, starting at the CRTC output and going to the display.
More complex topologies are not possible today with higher fan-in or
fan-out. This is a feature that we theoretically need to support, and I
don't know when it will become an important enough issue that we'll have
to implement it. That day, there will be two options, extending the DRM
bridge infrastructure to support more complex topologies, or using a
Xilinx-specific framework. The latter would really be reimplementing a
more complex DRM bridge tailored to Xilinx-specific architectures, which
I'd like to avoid, but we may not be able to implement this in DRM
bridge if the Xilinx-specific constraints can't be abstracted in a
generic way. In that case, we wouldn't be able to use DRM bridge, but we
would need a much more complex framework than what this patch
implements. I don't think it makes sense to go there today already
without having an actual use case and a customer need.

I hope this explains more clearly why DRM bridge is the preferred option
today.

[2] https://lore.kernel.org/dri-devel/20200417180819.GE5861@pendragon.ideasonboard.com/

> >> I didn't see any hard
> >> requirement to implement it into bridge driver and I see many DSI
> >> drivers are implemented as encoder drivers.
> >> Xilinx PL DRM encoder drivers are implemented in modular approach so
> >> that they can work with any CRTC driver which handles the DMA calls.
> >> So, at this stage we want to upstream as encoder driver only.
> >>
> >>>>>>>  3 files changed, 768 insertions(+)  create mode 100644
> >>>>>>> drivers/gpu/drm/xlnx/xlnx_dsi.c
> >
> > [1] https://www.analogix.com/en/products/convertersbridges/anx7737

-- 
Regards,

Laurent Pinchart
