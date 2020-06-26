Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BC120768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgFZHHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:07:23 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53370 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgFZHHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:07:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 21BFCFB03;
        Fri, 26 Jun 2020 09:07:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zv7aaNIuXRxh; Fri, 26 Jun 2020 09:07:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 335B640939; Fri, 26 Jun 2020 09:07:18 +0200 (CEST)
Date:   Fri, 26 Jun 2020 09:07:18 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Message-ID: <20200626070718.GA5854@bogon.m.sigxcpu.org>
References: <cover.1582645780.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1582645780.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Feb 25, 2020 at 04:53:33PM +0100, Guido Günther wrote:
> This allows us to shut down the mipi power domain on the SOC.  The
> alternative would be to drop the dphy from the mipi power domain in the
> SOCs device tree and only have the DSI host controller visible there
> (and rely on the phy layer's built in runtime pm handling) but this
> makes the power domain dependency less explicit.
> 
> Currently the pm domain can't be shut off when blanking the panel:

Anything I can do to get this applied?
Cheers,
 -- Guido

> 
> pm_genpd_summary
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> mipi                            on
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> while with this we can shut down the power domain on panel blank:
> 
> mipi                            off-0
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> This is similar to what drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> does.
> 
> Patch is against next-20200217
> 
> Guido Günther (1):
>   phy: fsl-imx8-mipi-dphy: Hook into runtime pm
> 
>  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
