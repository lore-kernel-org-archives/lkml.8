Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBF122B43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHTIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:52:51 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59042 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgHTIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:52:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5A1EEFB03;
        Thu, 20 Aug 2020 10:52:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BdvBbg0DRbpX; Thu, 20 Aug 2020 10:52:47 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BFDC2457CB; Thu, 20 Aug 2020 10:52:46 +0200 (CEST)
Date:   Thu, 20 Aug 2020 10:52:46 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] arm64: defconfig: Enable imx8mq-librem5-devkit
 display stack
Message-ID: <20200820085246.GA7671@bogon.m.sigxcpu.org>
References: <cover.1596025057.git.agx@sigxcpu.org>
 <a98acb7a0ed2ee6af78ba08354740d69b63b8c53.1596025057.git.agx@sigxcpu.org>
 <CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
On Thu, Aug 20, 2020 at 01:11:28AM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> On Wed, Jul 29, 2020 at 9:19 AM Guido Günther <agx@sigxcpu.org> wrote:
> >
> > Enable the panel, NWL DSI host controller and dphy. This
> > also needs the reset controller.
> >
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  arch/arm64/configs/defconfig | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index e0f33826819f..608019f6408d 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -640,10 +640,12 @@ CONFIG_DRM_MSM=m
> >  CONFIG_DRM_TEGRA=m
> >  CONFIG_DRM_PANEL_LVDS=m
> >  CONFIG_DRM_PANEL_SIMPLE=m
> > -CONFIG_DRM_SIMPLE_BRIDGE=m
> > +CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> >  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
> >  CONFIG_DRM_DISPLAY_CONNECTOR=m
> > +CONFIG_DRM_NWL_MIPI_DSI=m
> >  CONFIG_DRM_SII902X=m
> > +CONFIG_DRM_SIMPLE_BRIDGE=m
> 
> One nit: I suppose the CONFIG_DRM_SIMPLE_BRIDGE=m move comes from a
> defconfig re-sync.
> 
> Maybe this re-sync could be part of a separate patch?

I've moved re-sync of the drm related bits to a separate patch in v2. I
didn't do a full resync since this varies between kernel version but i
can do that too - maybe against 5.9-rc1 if that helps.

> Thanks for adding these options to the defconfig so that we could have
> MIPI DSI working by default on i.MX8M:
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 

Thanks!
 -- Guido
