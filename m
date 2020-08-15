Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C92C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C56120657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHOWWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:22:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53894 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHOWWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:22:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 609DCFB04;
        Sat, 15 Aug 2020 18:26:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zdXwEJTZCE2k; Sat, 15 Aug 2020 18:25:59 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id AD998457CD; Sat, 15 Aug 2020 18:25:58 +0200 (CEST)
Date:   Sat, 15 Aug 2020 18:25:58 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200815162558.GA2744@bogon.m.sigxcpu.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <0a7539135cc46eec5636ca89f52695f4a1197841.1597412076.git.agx@sigxcpu.org>
 <20200815100230.GA1002374@ravnborg.org>
 <20200815104022.GA5641@bogon.m.sigxcpu.org>
 <20200815104651.GA1005928@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815104651.GA1005928@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, Aug 15, 2020 at 12:46:51PM +0200, Sam Ravnborg wrote:
> On Sat, Aug 15, 2020 at 12:40:22PM +0200, Guido Günther wrote:
> > Hi Sam,
> > On Sat, Aug 15, 2020 at 12:02:30PM +0200, Sam Ravnborg wrote:
> > > Hi Guido.
> > > 
> > > > +static int mantix_probe(struct mipi_dsi_device *dsi)
> > > > +{
> > > > +	struct device *dev = &dsi->dev;
> > > > +	struct mantix *ctx;
> > > > +	int ret;
> > > > +
> > > > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > > +	if (!ctx)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > > > +	if (IS_ERR(ctx->reset_gpio)) {
> > > > +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
> > > > +		return PTR_ERR(ctx->reset_gpio);
> > > > +	}
> > > > +
> > > > +	mipi_dsi_set_drvdata(dsi, ctx);
> > > > +	ctx->dev = dev;
> > > > +
> > > > +	dsi->lanes = 4;
> > > > +	dsi->format = MIPI_DSI_FMT_RGB888;
> > > > +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> > > > +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > > > +
> > > > +	ctx->avdd = devm_regulator_get(dev, "avdd");
> > > > +	if (IS_ERR(ctx->avdd)) {
> > > > +		ret = PTR_ERR(ctx->avdd);
> > > > +		if (ret != -EPROBE_DEFER)
> > > > +			DRM_DEV_ERROR(dev,
> > > > +				      "Failed to request avdd regulator: %d\n",
> > > > +				      ret);
> > > > +		return ret;
> > > > +	}
> > > 
> > > Consider to use the recently added dev_err_probe() here and below.
> > > Note: Not part of drm-misc-next yet - but hopefully after -rc1
> > > when a backmerge is done.
> > 
> > In fact I did decided against it since i was told that missing dev_* and
> > DRM_* logging shouldn't be done. So is that o.k. nowadays?
> s/missing/mixing/
> 
> I often request that logging is consistent - so I recognize the
> argument.
> 
> For panel/* I have not made up my mind what I think is the best
> approach. The DRM_DEV_* and DRM_* logging do not add much value.
> So I have been tempted several times to convert all logging in
> panel/ to dev_* and pr_* (when no struct device * is available).
> That would also avoid that we mix up logging.
> 
> We have drm_* logging - but they require a valid drm_device * which we
> do not have in the the panel drivers. So they are ruled out here.
> 
> Do you have any opinions/comments on this?

I think for panel drivers DRM_* does not give any bonus so moving to
{dev,pr}_* sounds good. I just wonder if other drm parts don't need
`dev_drm_err_probe()` (or similar) anyway. But then maybe dyn_debug
is enough nowadays to not need DRM_DEV_DEBUG_* either?
Cheers,
 -- Guido

> 
> 	Sam
> 
