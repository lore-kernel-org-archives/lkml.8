Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D932070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 11:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGRLFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 07:05:30 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39908 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgGRLFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 07:05:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7F632FB03;
        Sat, 18 Jul 2020 13:05:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zmh5EomUl9RE; Sat, 18 Jul 2020 13:05:26 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B06E842576; Sat, 18 Jul 2020 13:05:25 +0200 (CEST)
Date:   Sat, 18 Jul 2020 13:05:25 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, lukas@mntmn.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] drm/imx: Add initial support for DCSS on iMX8MQ
Message-ID: <20200718110525.GA2827@bogon.m.sigxcpu.org>
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
 <20200717144132.2206-3-laurentiu.palcu@oss.nxp.com>
 <20200717194849.GA2369507@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717194849.GA2369507@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 17, 2020 at 09:48:49PM +0200, Sam Ravnborg wrote:
> Hi Laurentiu.
> 
> On Fri, Jul 17, 2020 at 05:41:27PM +0300, Laurentiu Palcu wrote:
> > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > 
> > This adds initial support for iMX8MQ's Display Controller Subsystem (DCSS).
> > Some of its capabilities include:
> >  * 4K@60fps;
> >  * HDR10;
> >  * one graphics and 2 video pipelines;
> >  * on-the-fly decompression of compressed video and graphics;
> > 
> > The reference manual can be found here:
> > https://www.nxp.com/webapp/Download?colCode=IMX8MDQLQRM
> > 
> > The current patch adds only basic functionality: one primary plane for
> > graphics, linear, tiled and super-tiled buffers support (no graphics
> > decompression yet), no HDR10 and no video planes.
> > 
> > Video planes support and HDR10 will be added in subsequent patches once
> > per-plane de-gamma/CSC/gamma support is in.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> 
> ....
>         return drm_bridge_attach(encoder, bridge, NULL, 0);
> ....
> 
> The above code-snippet tells that the display-driver rely on the bridge
> to create the connector.
> Could this by any chance be updated to the new way where the display
> driver creates the connector - and thus passing DRM_BRIDGE_ATTACH_NO_CONNECTOR
> as the flags argument?
> 
> What bridges would be relevant?
> To check that the reelvant bridges are already ported.

I think that's mostly NWL atm since MHDP isn't mainline yet. Can you
recommend a bridge driver to look at that does this right?
Cheers,
 -- Guido
