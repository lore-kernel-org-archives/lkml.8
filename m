Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B23C43457
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A232073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c2blEXv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGTHbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGTHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:31:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:31:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so21218973wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OVJCr1m5cczEE11Y4OrOEI2+d5VysNb+avvmYGzz5EQ=;
        b=c2blEXv0PV3Forf/ih8O0N/mHD2GxHU2L/pCRcwYxPtM45rL0mRfdPLxH55yIKq/hQ
         A9wJ6pwhd6rMsNEnULADCT0fxYXXijggxfgpwa+AOCL8LW2a6O1iVuYlDSBFXV3uqekV
         OdRhqh8OBMAJvnxn57iZOwlGdigLtnkVQMBpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=OVJCr1m5cczEE11Y4OrOEI2+d5VysNb+avvmYGzz5EQ=;
        b=Ye9K7p8tfygWSKE6lmJmd7JVc/lAt77C9pdzBmHlcqosar1SLRpwCUujZQrt3ZyRD0
         e1Rm+Mo+4+SEMWKL+zY5YI1K22QbK5wd5Rf8zzvG4NNEq73GFVtg7O58xeA9dpc911hN
         sx3KNg7kce/erf1XFTXE2yjK0rtiI0oM6fqoT/cv+x/5wZcaVYxQH2MhTTPrd6JcrIsH
         7am0/vVHb+3uy6hc45FvrIb2rTqsak2RGBMiQGRIWNvg/5p8mXWwbSVFo3AQEFPubMaf
         NjBxeJMe21+SXtuVtLnJw6kjvCw3WuFKZUMYz8Z2VdlSIz16RURKcwWLg8XQes37aM3l
         imNw==
X-Gm-Message-State: AOAM533GcdogFLZHoNlEQJCwByWXezRZ44LkruNHT1y4rV6UZqo3BWCs
        7L5eS8o2txUYdOjjnQ5mXa/tzA==
X-Google-Smtp-Source: ABdhPJxN7p0owcN96PIeSqEMA5x15Cm1uEAARNlBA5eLxTQA3ETt1N2u3muHoio5moLJDyia7v05Vw==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr19492056wme.164.1595230274849;
        Mon, 20 Jul 2020 00:31:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h11sm7051935wrb.68.2020.07.20.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:31:14 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:31:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb: Make supported modifiers explicit
Message-ID: <20200720073112.GU3278063@phenom.ffwll.local>
Mail-Followup-To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <26877532e272c12a74c33188e2a72abafc9a2e1c.1584973664.git.agx@sigxcpu.org>
 <d39209a3664179f895a7dfabbd02d27a6adb9895.camel@pengutronix.de>
 <20200718171407.GA72952@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200718171407.GA72952@bogon.m.sigxcpu.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 07:14:07PM +0200, Guido Günther wrote:
> Hi,
> On Mon, Mar 23, 2020 at 04:51:05PM +0100, Lucas Stach wrote:
> > Am Montag, den 23.03.2020, 15:52 +0100 schrieb Guido Günther:
> > > In contrast to other display controllers on imx like DCSS and ipuv3
> > > lcdif/mxsfb does not support detiling e.g. vivante tiled layouts.
> > > Since mesa might assume otherwise make it explicit that only
> > > DRM_FORMAT_MOD_LINEAR is supported.
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > 
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Can i do anything to get this applied?
> Cheers,

Lucas has drm-misc commit rights, I expect him to push.
-Daniel

>  -- Guido
> 
> > 
> > > ---
> > >  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > index 762379530928..fc71e7a7a02e 100644
> > > --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > @@ -73,6 +73,11 @@ static const uint32_t mxsfb_formats[] = {
> > >  	DRM_FORMAT_RGB565
> > >  };
> > >  
> > > +static const uint64_t mxsfb_modifiers[] = {
> > > +	DRM_FORMAT_MOD_LINEAR,
> > > +	DRM_FORMAT_MOD_INVALID
> > > +};
> > > +
> > >  static struct mxsfb_drm_private *
> > >  drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
> > >  {
> > > @@ -334,8 +339,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
> > >  	}
> > >  
> > >  	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
> > > -			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
> > > -			mxsfb->connector);
> > > +			mxsfb_formats, ARRAY_SIZE(mxsfb_formats),
> > > +			mxsfb_modifiers, mxsfb->connector);
> > >  	if (ret < 0) {
> > >  		dev_err(drm->dev, "Cannot setup simple display pipe\n");
> > >  		goto err_vblank;
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
