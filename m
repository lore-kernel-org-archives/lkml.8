Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68C420786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKUAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:00:10 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43558 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:00:09 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1E6D4804FC;
        Tue, 11 Aug 2020 22:00:05 +0200 (CEST)
Date:   Tue, 11 Aug 2020 22:00:04 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>
Cc:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, sandipk@xilinx.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org, vgannava@xilinx.com
Subject: Re: [RFC PATCH V2 0/2] Add Xilinx DSI TX driver
Message-ID: <20200811200004.GA528241@ravnborg.org>
References: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=SWFKjwIlav1saKlI7LoA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkateshwar

On Tue, Aug 11, 2020 at 06:16:15AM +0530, Venkateshwar Rao Gannavarapu wrote:
> Xilinx DSI-TX subsytem consists of DSI controller core, AXI crossbar
> and D-PHY as sub blocks. DSI TX subsystem driver supports multiple lanes
> upto 4, RGB color formats, video mode and command modes.
> 
> DSI-TX driver is implemented as an encoder driver, as it going to be
> the final node in display pipeline. Xilinx doesn't support any converter
> logic to make this as bridge driver. Xilinx doesn't have such
> use cases where end node can't be an encoder like DSI-TX. And Xilinx
> encoder drivers represents a subsystem where individual blocks can't be
> used with external components / encoders.
> 
> Venkateshwar Rao Gannavarapu (2):
>   dt-bindings: display: xlnx: dsi: This add a DT binding for Xilinx DSI
>     TX     subsystem.
>   drm: xlnx: dsi: driver for Xilinx DSI TX subsystem

Can you please elaborate a little what was changed since v1.
Preferably in some dense list form where you also list who provided the
feedback, preferably in the individual patches.

This is a great help trying to trigger the memory of past reviewers.
Please also include feedback that was not addressed. For example Laurent
said that this is a bridge drive and thus belongs in bridge/ alas that
was not done for so please list a reason.

	Sam

> 
>  .../devicetree/bindings/display/xlnx/xlnx,dsi.yaml | 147 +++++
>  drivers/gpu/drm/xlnx/Kconfig                       |  11 +
>  drivers/gpu/drm/xlnx/Makefile                      |   2 +
>  drivers/gpu/drm/xlnx/xlnx_dsi.c                    | 701 +++++++++++++++++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.yaml
>  create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c
> 
> --
> 1.8.3.1
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
