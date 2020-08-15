Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB86E206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgHOWAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgHOVvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325DC02B8F4;
        Sat, 15 Aug 2020 06:05:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 39E75299A26
Message-ID: <b318069fe873e456f18d07d11f5d165667c9b04a.camel@collabora.com>
Subject: Re: [PATCH v9 00/11] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philippe CORNU <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick FERTRE <yannick.fertre@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
Date:   Sat, 15 Aug 2020 10:05:00 -0300
In-Reply-To: <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
         <c6f10db1-7f56-a156-36a1-125e764c8c1a@baylibre.com>
         <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, 2020-07-01 at 09:35 +0300, Adrian Ratiu wrote:
> Hi Neil,
> 
> On Mon, 29 Jun 2020, Neil Armstrong <narmstrong@baylibre.com> 
> wrote:
> > Hi Adrian, 
> > 
> > On 09/06/2020 19:49, Adrian Ratiu wrote: 
> > > [Re-submitting to cc dri-devel, sorry about the noise]  Hello 
> > > all,  v9 cleanly applies on top of latest next-20200609 tree. 
> > > v9 does not depend on other patches as the last binding doc has 
> > > been merged.   All feedback up to this point has been 
> > > addressed. Specific details in individual patch changelogs. 
> > > The biggest changes are the deprecation of the Synopsys DW 
> > > bridge bind() API in favor of of_drm_find_bridge() and .attach 
> > > callbacks, the addition of a TODO entry which outlines future 
> > > planned bridge driver refactorings and a reordering of some 
> > > i.MX 6 patches to appease checkpatch.   The idea behind the 
> > > TODO is to get this regmap and i.MX 6 driver merged and then do 
> > > the rest of refactorings in-tree because it's easier and the 
> > > refactorings themselves are out-of-scope of this series which 
> > > is adding i.MX 6 support and is quite big already, so please, 
> > > if there are more refactoring ideas, let's add them to the TODO 
> > > doc. :) I intend to tackle those after this series is merged to 
> > > avoid two complex inter-dependent simultaneous series. 
> > 
> > This has been around here for a long time and you seem to have 
> > addressed all the reviews. 
> > 
> > >  As always more testing is welcome especially on Rockchip and 
> > > STM SoCs. 
> > 
> > It has been tested on STM, but I'd like a feedback on RK 
> > platform before applying the bridge parts. 
> > 
> > Can the imx & stm patches be applied separately ? 
> > 
> 
> Yes the IMX and STM patches can be applied separately, they just 
> both depend on the common regmap patches.
> 

It's been a month so I think it's a good idea to go forward
applying IMX and STM patches (probably with the usual
rebase dance).

As for Rockchip...

> The binding API removal change which directly touches RK can also 
> be applied separately, but unfortunately I do not have access to a 
> RK board with a DSI display to test it (or the bridge regmap logic 
> on RK btw...), I just "eye-balled" the RK code based on the public 
> docs and it LGTM.
> 

... I'll be getting some DSI hardware to help with the pending
Rockchip issues, so we can tackle Rockchip as well. I'm quite sure
we'll loop Heiko as well if needed :-)

Cheers,
Ezequiel

> > Neil
> > 
> > > Big thank you to everyone who has contributed to this up to now,
> > > Adrian
> > > 
> > > Adrian Ratiu (11):
> > >   drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
> > >   drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
> > >   drm: bridge: dw_mipi_dsi: add dsi v1.01 support
> > >   drm: bridge: dw_mipi_dsi: remove bind/unbind API
> > >   dt-bindings: display: add i.MX6 MIPI DSI host controller doc
> > >   ARM: dts: imx6qdl: add missing mipi dsi properties
> > >   drm: imx: Add i.MX 6 MIPI DSI host platform driver
> > >   drm: stm: dw-mipi-dsi: let the bridge handle the HW version check
> > >   drm: bridge: dw-mipi-dsi: split low power cfg register into fields
> > >   drm: bridge: dw-mipi-dsi: fix bad register field offsets
> > >   Documentation: gpu: todo: Add dw-mipi-dsi consolidation plan
> > > 
> > >  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 112 +++
> > >  Documentation/gpu/todo.rst                    |  25 +
> > >  arch/arm/boot/dts/imx6qdl.dtsi                |   8 +
> > >  drivers/gpu/drm/bridge/synopsys/Kconfig       |   1 +
> > >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 713 ++++++++++++------
> > >  drivers/gpu/drm/imx/Kconfig                   |   8 +
> > >  drivers/gpu/drm/imx/Makefile                  |   1 +
> > >  drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
> > >  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   7 +-
> > >  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  16 +-
> > >  10 files changed, 1059 insertions(+), 231 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> > >  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
> > > 

