Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48308C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216992053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgHOV6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:46 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47656 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHOV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:58:41 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B462F20021;
        Sat, 15 Aug 2020 16:53:30 +0200 (CEST)
Date:   Sat, 15 Aug 2020 16:53:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] Add support for Feixin K101-IM2BYL02 panel
Message-ID: <20200815145329.GA1201814@ravnborg.org>
References: <20200719170411.275812-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719170411.275812-1-icenowy@aosc.io>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=8R4CpP16fAPwfkrXZjwA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy

On Mon, Jul 20, 2020 at 01:04:06AM +0800, Icenowy Zheng wrote:
> The controller chip of Feixin K101-IM2BA02 is going to be discontinued,
> so Feixin start to provide K101-IM2BYL02 panel as a replacement, which
> utilizes Ilitek ILI9881C controller.
> 
> Add support for K101-IM2BYL02 panel.
> 
> By the way, is there a way that can try both kind of panels in the same
> kernel/DTB combo? K101-IM2BYL02 has the same pinout with K101-IM2BA02,
> and PineTab schedule to switch to it w/o modifying the mainboard.
> 
> Icenowy Zheng (4):
>   drm/panel: ilitek-ili9881c: prepare for adding support for extra
>     panels
>   dt-bindings: ili9881c: add compatible string for Feixin K101-IM2BYL02
>   drm/panel: ilitek-ili9881c: add support for Feixin K101-IM2BYL02 panel
Thanks, applied the above patches to drm-misc-next.

	Sam

>   [DO NOT MERGE] arm64: allwinner: dts: a64: enable K101-IM2BYL02 panel
>     for PineTab
> 
>  .../display/panel/ilitek,ili9881c.yaml        |   1 +
>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  10 +
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 273 ++++++++++++++++--
>  3 files changed, 265 insertions(+), 19 deletions(-)
> 
> -- 
> 2.27.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
