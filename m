Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42513C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5CA20658
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgHOWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:33:42 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50554 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgHOWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:33:41 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CA97720022;
        Sat, 15 Aug 2020 12:46:52 +0200 (CEST)
Date:   Sat, 15 Aug 2020 12:46:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
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
Message-ID: <20200815104651.GA1005928@ravnborg.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <0a7539135cc46eec5636ca89f52695f4a1197841.1597412076.git.agx@sigxcpu.org>
 <20200815100230.GA1002374@ravnborg.org>
 <20200815104022.GA5641@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815104022.GA5641@bogon.m.sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=T4MLU0igAHpipydq7w0A:9 a=wPNLvfGTeEIA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 12:40:22PM +0200, Guido Günther wrote:
> Hi Sam,
> On Sat, Aug 15, 2020 at 12:02:30PM +0200, Sam Ravnborg wrote:
> > Hi Guido.
> > 
> > > +static int mantix_probe(struct mipi_dsi_device *dsi)
> > > +{
> > > +	struct device *dev = &dsi->dev;
> > > +	struct mantix *ctx;
> > > +	int ret;
> > > +
> > > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > +	if (!ctx)
> > > +		return -ENOMEM;
> > > +
> > > +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > > +	if (IS_ERR(ctx->reset_gpio)) {
> > > +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
> > > +		return PTR_ERR(ctx->reset_gpio);
> > > +	}
> > > +
> > > +	mipi_dsi_set_drvdata(dsi, ctx);
> > > +	ctx->dev = dev;
> > > +
> > > +	dsi->lanes = 4;
> > > +	dsi->format = MIPI_DSI_FMT_RGB888;
> > > +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> > > +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > > +
> > > +	ctx->avdd = devm_regulator_get(dev, "avdd");
> > > +	if (IS_ERR(ctx->avdd)) {
> > > +		ret = PTR_ERR(ctx->avdd);
> > > +		if (ret != -EPROBE_DEFER)
> > > +			DRM_DEV_ERROR(dev,
> > > +				      "Failed to request avdd regulator: %d\n",
> > > +				      ret);
> > > +		return ret;
> > > +	}
> > 
> > Consider to use the recently added dev_err_probe() here and below.
> > Note: Not part of drm-misc-next yet - but hopefully after -rc1
> > when a backmerge is done.
> 
> In fact I did decided against it since i was told that missing dev_* and
> DRM_* logging shouldn't be done. So is that o.k. nowadays?
s/missing/mixing/

I often request that logging is consistent - so I recognize the
argument.

For panel/* I have not made up my mind what I think is the best
approach. The DRM_DEV_* and DRM_* logging do not add much value.
So I have been tempted several times to convert all logging in
panel/ to dev_* and pr_* (when no struct device * is available).
That would also avoid that we mix up logging.

We have drm_* logging - but they require a valid drm_device * which we
do not have in the the panel drivers. So they are ruled out here.

Do you have any opinions/comments on this?

	Sam
