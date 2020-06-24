Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA39B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t0QNK4Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbgFXNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:24:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58380 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgFXNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:24:12 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9F6A2A8;
        Wed, 24 Jun 2020 15:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593005050;
        bh=9FvYZAeIEFhM+JzFaVDBCgpx8ST/p2ndCMOZJSUhqVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0QNK4Y0HvQGnv/OPruCmqjPCrEapbS9oYQvfpmeNJKLmUnRSr7nbq+HKuDFtb4rc
         vGnPLdD994z4HiGZAlXcmpMPpRdy1p8MlrhPL3H8tptS8AbK2v/6nR8otECzwezL50
         4kp1MaPvbgyIso516Pa7RAssnvKI6w1y5+Mjs9z0=
Date:   Wed, 24 Jun 2020 16:23:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
Message-ID: <20200624132344.GA5980@pendragon.ideasonboard.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com>
 <20200624123140.GB1773782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624123140.GB1773782@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:31:40PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2020 at 01:41:23PM +0200, Andrzej Hajda wrote:
> > During probe every time driver gets resource it should usually check for error
> > printk some message if it is not -EPROBE_DEFER and return the error. This
> > pattern is simple but requires adding few lines after any resource acquisition
> > code, as a result it is often omited or implemented only partially.
> > probe_err helps to replace such code sequences with simple call, so code:
> > 	if (err != -EPROBE_DEFER)
> > 		dev_err(dev, ...);
> > 	return err;
> > becomes:
> > 	return probe_err(dev, err, ...);
> > 
> > Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/device.h |  3 +++
> >  2 files changed, 42 insertions(+)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67d39a90b45c..ee9da66bff1b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3953,6 +3953,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
> >  
> >  #endif
> >  
> > +/**
> > + * probe_err - probe error check and log helper
> > + * @dev: the pointer to the struct device
> > + * @err: error value to test
> > + * @fmt: printf-style format string
> > + * @...: arguments as specified in the format string
> > + *
> > + * This helper implements common pattern present in probe functions for error
> > + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> > + * It replaces code sequence:
> > + * 	if (err != -EPROBE_DEFER)
> > + * 		dev_err(dev, ...);
> > + * 	return err;
> > + * with
> > + * 	return probe_err(dev, err, ...);
> > + *
> > + * Returns @err.
> > + *
> > + */
> > +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +
> > +	if (err == -EPROBE_DEFER)
> > +		return err;
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +
> > +	dev_err(dev, "error %d: %pV", err, &vaf);
> > +
> > +	va_end(args);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(probe_err);
> 
> Please be specific in global symbols, how about "driver_probe_error()"?

Or dev_err_probe() to match the existing dev_* functions ?

> And merge the other patch into this one, as Raphael said, otherwise this
> just looks odd to add something and then fix it up later.

-- 
Regards,

Laurent Pinchart
