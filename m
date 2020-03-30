Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83FBC2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C646C20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgC3Nvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:51:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60556 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC3Nvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:51:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 36C842965EC
Message-ID: <4a9d2d6e5cecbe296c14119d27a8793a7dbed7b2.camel@collabora.com>
Subject: Re: [PATCH v5 4/5] drm: imx: Add i.MX 6 MIPI DSI host platform
 driver
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Date:   Mon, 30 Mar 2020 10:51:23 -0300
In-Reply-To: <CAOMZO5CEZSBfhb9xAdf=sDhUnmSeuWSsnUQArz=a1TPzytLAeQ@mail.gmail.com>
References: <20200330113542.181752-1-adrian.ratiu@collabora.com>
         <20200330113542.181752-5-adrian.ratiu@collabora.com>
         <CAOMZO5CEZSBfhb9xAdf=sDhUnmSeuWSsnUQArz=a1TPzytLAeQ@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio, Adrian:

On Mon, 2020-03-30 at 08:49 -0300, Fabio Estevam wrote:
> Hi Adrian,
> 
> On Mon, Mar 30, 2020 at 8:34 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > This adds support for the Synopsis DesignWare MIPI DSI v1.01 host
> > controller which is embedded in i.MX 6 SoCs.
> > 
> > Based on following patches, but updated/extended to work with existing
> > support found in the kernel:
> > 
> > - drm: imx: Support Synopsys DesignWare MIPI DSI host controller
> >   Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > 
> > - ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller
> >   Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> 
> This one looks like a devicetree patch, but this patch does not touch
> devicetree.
> 
> > +       ret = clk_prepare_enable(dsi->pllref_clk);
> > +       if (ret) {
> > +               dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
> > +               return ret;
> > +       }
> > +
> > +       dsi->mux_sel = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,gpr");
> > +       if (IS_ERR(dsi->mux_sel)) {
> > +               ret = PTR_ERR(dsi->mux_sel);
> > +               dev_err(dev, "%s: Failed to get GPR regmap: %d\n",
> > +                       __func__, ret);
> > +               return ret;
> 
> You should disable the dsi->pllref_clk clock prior to returning the error.
> 

Another approach could be moving the clock on and off to
to component_ops.{bind,unbind} (as rockhip driver does).

What exactly is the PLL clock needed for? Would it make sense
to move it some of the PHY power on/off? (Maybe not, but it's worthing
checking).

Also, it seems the other IP blocks have this PLL clock, so maybe
it could be moved to the dw_mipi_dsi core? This could be something
for a follow-up, to avoid creeping this series.

Thanks,
Ezequiel

