Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9DDC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B120A2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGQTs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:48:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47402 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGQTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:48:55 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6268180501;
        Fri, 17 Jul 2020 21:48:51 +0200 (CEST)
Date:   Fri, 17 Jul 2020 21:48:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, agx@sigxcpu.org,
        lukas@mntmn.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] drm/imx: Add initial support for DCSS on iMX8MQ
Message-ID: <20200717194849.GA2369507@ravnborg.org>
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
 <20200717144132.2206-3-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717144132.2206-3-laurentiu.palcu@oss.nxp.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8 a=zm2rouQ-rTcRMPztwuMA:9
        a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu.

On Fri, Jul 17, 2020 at 05:41:27PM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> This adds initial support for iMX8MQ's Display Controller Subsystem (DCSS).
> Some of its capabilities include:
>  * 4K@60fps;
>  * HDR10;
>  * one graphics and 2 video pipelines;
>  * on-the-fly decompression of compressed video and graphics;
> 
> The reference manual can be found here:
> https://www.nxp.com/webapp/Download?colCode=IMX8MDQLQRM
> 
> The current patch adds only basic functionality: one primary plane for
> graphics, linear, tiled and super-tiled buffers support (no graphics
> decompression yet), no HDR10 and no video planes.
> 
> Video planes support and HDR10 will be added in subsequent patches once
> per-plane de-gamma/CSC/gamma support is in.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---

....
        return drm_bridge_attach(encoder, bridge, NULL, 0);
....

The above code-snippet tells that the display-driver rely on the bridge
to create the connector.
Could this by any chance be updated to the new way where the display
driver creates the connector - and thus passing DRM_BRIDGE_ATTACH_NO_CONNECTOR
as the flags argument?

What bridges would be relevant?
To check that the reelvant bridges are already ported.

	Sam
