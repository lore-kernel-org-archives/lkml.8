Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE982074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgE2EXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:23:52 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47144 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgE2EXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:23:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 75CD8FB03;
        Fri, 29 May 2020 06:23:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cWWfHe7cer4i; Fri, 29 May 2020 06:23:46 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A09C644AF9; Fri, 29 May 2020 06:23:45 +0200 (CEST)
Date:   Fri, 29 May 2020 06:23:45 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/6] dt-bindings: display/bridge/nwl-dsi: Drop mux
 handling
Message-ID: <20200529042345.GA2876@bogon.m.sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <9884c56219e9bdbeec179c27ea2b734dbb5f1289.1589548223.git.agx@sigxcpu.org>
 <20200528195914.GB568887@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528195914.GB568887@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On Thu, May 28, 2020 at 01:59:14PM -0600, Rob Herring wrote:
> On Fri, May 15, 2020 at 03:12:12PM +0200, Guido Günther wrote:
> > No need to encode the SoC specifics in the bridge driver. For the
> > imx8mq we can use the mux-input-bridge.
> 
> You can't just change bindings like this. You'd still have to support 
> the "old" way. But IMO, this way is the right way.

My understanding is that binding stability only applies to released
kernels and this binding never was in released kernel yet. Does it still
apply in this case?
Cheers,
 -- Guido

> 
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../devicetree/bindings/display/bridge/nwl-dsi.yaml         | 6 ------
> >  1 file changed, 6 deletions(-)
> 
