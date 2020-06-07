Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7364C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 02:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B13B2074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 02:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tNNhCUdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgFGCZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 22:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgFGCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 22:25:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB45C08C5C3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 19:25:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B59822C9;
        Sun,  7 Jun 2020 04:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591496737;
        bh=W0aS8y06jhHnoY2ZgzF67OR9OL7k63AD2O3cS5yHeWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNNhCUdEvEYf77HFGlsC9eyIiL3KdZoi9KsrO/tg0WM2Hhwsewt/58bgOBE8SOzCy
         g/HcRpX2611sIeCcqgRSaZ3Z7apRBTRhih0q4NAZ5zLBFDGkyjry4acAU9E0AvjaOf
         bpyRs3DR3tj6nfI5vtMMwhHq9qqlycmFxVEqWAKU=
Date:   Sun, 7 Jun 2020 05:25:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Venkateshwar Rao Gannavarapu <VGANNAVA@xilinx.com>
Cc:     Hyun Kwon <hyunk@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandip Kothari <sandipk@xilinx.com>
Subject: Re: [RFC PATCH 2/2] drm: xlnx: driver for Xilinx DSI TX Subsystem
Message-ID: <20200607022518.GA7339@pendragon.ideasonboard.com>
References: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1587417656-48078-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <20200504184348.GA3095@smtp.xilinx.com>
 <20200524030813.GF6026@pendragon.ideasonboard.com>
 <CY4PR02MB2790B791578160F257049FEAB18D0@CY4PR02MB2790.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR02MB2790B791578160F257049FEAB18D0@CY4PR02MB2790.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GVRao,

On Sun, May 31, 2020 at 05:41:50PM +0000, Venkateshwar Rao Gannavarapu wrote:
> On Sunday, May 24, 2020 8:38 AM, Laurent Pinchart wrote:
> > On Mon, May 04, 2020 at 11:43:48AM -0700, Hyun Kwon wrote:
> >> On Mon, 2020-04-20 at 14:20:56 -0700, Venkateshwar Rao Gannavarapu wrote:
> >>> The Xilinx MIPI DSI Tx Subsystem soft IP is used to display video
> >>> data from AXI-4 stream interface.
> >>>
> >>> It supports upto 4 lanes, optional register interface for the DPHY,
> >>
> >> I don't see the register interface for dphy support.
> >
> > I think the D-PHY should be supported through a PHY driver, as it seems to be
> > shared between different subsystems.
>
> IP has the provision to read DPHY register for debug purpose only.
> No programming of DPHY is required in subsystem.

Do you know if this is the same D-PHY as used in the CSI2-RX subsystem ?

> >>> multiple RGB color formats, command mode and video mode.
> >>> This is a MIPI-DSI host driver and provides DSI bus for panels.
> >>> This driver also helps to communicate with its panel using panel
> >>> framework.
> >>>
> >>> Signed-off-by: Venkateshwar Rao Gannavarapu <venkateshwar.rao.gannavarapu@xilinx.com>
> >>> ---
> >>>  drivers/gpu/drm/xlnx/Kconfig    |  11 +
> >>>  drivers/gpu/drm/xlnx/Makefile   |   2 +
> >>>  drivers/gpu/drm/xlnx/xlnx_dsi.c | 755 ++++++++++++++++++++++++++++++++++++++++
> >
> > Daniel Vetter has recently expressed his opiion that bridge drivers should go to
> > drivers/gpu/drm/bridge/. It would then be drivers/gpu/drm/bridge/xlnx/. I don't
> > have a strong opinion myself.
> >
> >>>  3 files changed, 768 insertions(+)
> >>>  create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c

[snip]

-- 
Regards,

Laurent Pinchart
