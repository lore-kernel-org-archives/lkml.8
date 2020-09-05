Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B786C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17E52078E
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DXiRUtx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIEQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIEQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 12:07:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3DC061244;
        Sat,  5 Sep 2020 09:07:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6C3A335;
        Sat,  5 Sep 2020 18:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599322057;
        bh=IB7aiNF5Sb4q/FXtKiMOEHFOQFRZ3n8rv9ArPIC44tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXiRUtx74nhKWsTE0dT3zhkPyvZLLHKqpS8m2WCGl5PGMiYJQEDpp0by3Ai2QEcw/
         ewP2tHRhGjQnr2voRHeinE+hAayuvTUV4JfGTwM618+0kLicpIjgju2gQs4XWNjCxL
         v5QKfyk7CrN4Ats/cfMYBiHh2lhiwm3sd1/a9gIM=
Date:   Sat, 5 Sep 2020 19:07:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 4/5] dt-bindings: display/bridge: nwl-dsi: Document
 fsl,clock-drop-level property
Message-ID: <20200905160714.GA6319@pendragon.ideasonboard.com>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
 <1598613212-1113-5-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598613212-1113-5-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thank you for the patch.

On Fri, Aug 28, 2020 at 02:13:31PM +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> Add documentation for a new property: 'fsl,clock-drop-level'.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index 8b5741b..b415f4e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -143,6 +143,10 @@ properties:
>  
>      additionalProperties: false
>  
> +  clock-drop-level:
> +    description:
> +      Specifies the level at wich the crtc_clock should be dropped
> +

There's no "crtc_clock" defined in the bindings. As DT bindings
shouldn't be tied to a particular driver implementation, could you
document this property without referring to concepts specific to the
driver ? I think the documentation should also be extended, looking at
this patch I have no idea what this does and how to compute the value
that should be set.

>  patternProperties:
>    "^panel@[0-9]+$":
>      type: object

-- 
Regards,

Laurent Pinchart
