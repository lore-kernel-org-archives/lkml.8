Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA95C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8EE20774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GQiAUrd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371282AbgDOUdY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:33:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38086 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371264AbgDOUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:33:12 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4BCC8DD3;
        Wed, 15 Apr 2020 22:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586982789;
        bh=ZWrQLQiITcnJHS7w+LOALjXfWMs5iz+rT8aFRxucxtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQiAUrd7WJjvq8jNIeeljZaHhBNFa/QhJS4yGJW5WND2eu3EUuqC3ud3FcqdxopQf
         XSO0UCi7+yJP0gda51b3GJ5gC4HhTREnnvjaC0aBVqfHLALAzWwxAUjKVIJuL19Bua
         VngkH6/jze8rIhCrN/ha0VSue9EADOCMji40G+to=
Date:   Wed, 15 Apr 2020 23:32:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch, narmstrong@baylibre.com,
        robh+dt@kernel.org, spanda@codeaurora.org, jonas@kwiboo.se,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        jeffrey.l.hugo@gmail.com, jernej.skrabec@siol.net,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: drm/bridge: ti-sn65dsi86: Add hpd-gpios
 to the bindings
Message-ID: <20200415203256.GP4758@pendragon.ideasonboard.com>
References: <20200415084758.1.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
 <20200415084758.2.Ic98f6622c60a1aa547ed85781f2c3b9d3e56b734@changeid>
 <158698038289.105027.2860892334897893887@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158698038289.105027.2860892334897893887@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:53:02PM -0700, Stephen Boyd wrote:
> Quoting Douglas Anderson (2020-04-15 08:48:40)
> > Allow people to specify to use a GPIO for hot-plug-detect.  Add an
> > example.
> > 
> > NOTE: The current patch adding support for hpd-gpios to the Linux
> > driver for hpd-gpios only adds enough support to the driver so that
> > the bridge can use one of its own GPIOs.  The bindings, however, are
> > written generically.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> >  .../bindings/display/bridge/ti,sn65dsi86.yaml          | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > index 8cacc6db33a9..554bfd003000 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > @@ -60,6 +60,10 @@ properties:
> >      const: 1
> >      description: See ../../pwm/pwm.yaml for description of the cell formats.
> >  
> > +  hpd-gpios:
> > +    maxItems: 1
> > +    description: If present use the given GPIO for hot-plug-detect.
> 
> Shouldn't this go in the panel node? And the panel driver should get the
> gpio and poll it after powering up the panel? Presumably that's why we
> have the no-hpd property in the simple panel binding vs. putting it here
> in the bridge.

Same question really, I think this belongs to the panel (or connector)
node indeed.

-- 
Regards,

Laurent Pinchart
