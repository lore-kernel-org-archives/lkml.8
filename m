Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA231C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OdcjBFGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbgFXN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:29:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58476 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389616AbgFXN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:29:29 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A757B2A8;
        Wed, 24 Jun 2020 15:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593005366;
        bh=d5m/4U8ouUWtGQMkuBOm9oR1g2TjV7IE81nI+UkOV54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdcjBFGk6kcibBpH8I829r8eulNBJSZsWGArYnDXSYwMFnv9fNB6lSsDnDAKRWHW+
         Hz+SKV/+/Z9it4Qk6z/osneeClL9qB2swaEWwu2KCWP3MaNwP29REcV91H1j5oXgiH
         l5RgIlVD9KYKXsGOcWeyOIXhjfoyJOsadY/zYSmQ=
Date:   Wed, 24 Jun 2020 16:29:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
Message-ID: <20200624132901.GB5980@pendragon.ideasonboard.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com>
 <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:37:52PM +0100, Robin Murphy wrote:
> On 2020-06-24 12:41, Andrzej Hajda wrote:
> > Many resource acquisition functions return error value encapsulated in
> > pointer instead of integer value. To simplify coding we can use macro
> > which will accept both types of error.
> > With this patch user can use:
> > 	probe_err(dev, ptr, ...)
> > instead of:
> > 	probe_err(dev, PTR_ERR(ptr), ...)
> > Without loosing old functionality:
> > 	probe_err(dev, err, ...)
> 
> Personally I'm not convinced that simplification has much value, and I'd 
> say it *does* have a significant downside. This:
> 
> 	if (IS_ERR(x))
> 		do_something_with(PTR_ERR(x));
> 
> is a familiar and expected pattern when reading/reviewing code, and at a 
> glance is almost certainly doing the right thing. If I see this, on the 
> other hand:
> 
> 	if (IS_ERR(x))
> 		do_something_with(x);
> 
> my immediate instinct is to be suspicious, and now I've got to go off 
> and double-check that if do_something_with() really expects a pointer 
> it's also robust against PTR_ERR values. Off-hand I can't think of any 
> APIs that work that way in the areas with which I'm familiar, so it 
> would be a pretty unusual and non-obvious thing.

I second this. Furthermore, the hidden cast to long means that we'll
leak pointer values if one happens to pass a real pointer to this
function.

> Furthermore, an error helper that explicitly claims to accept "pointer 
> type" values seems like it could easily lead to misunderstandings like this:
> 
> 	int init_my_buffer(struct my_device *d)
> 	{
> 		d->buffer = kzalloc(d->buffer_size, GFP_KERNEL);
> 		return probe_err(d->dev, d->buffer, "failed to init buffer\n");
> 	}
> 
> and allowing that to compile without any hint of an error seems a 
> little... unfair.
> 
> Robin.
> 
> > Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> > ---
> >   drivers/base/core.c    | 25 ++-----------------------
> >   include/linux/device.h | 25 ++++++++++++++++++++++++-
> >   2 files changed, 26 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 2a96954d5460..df283c62d9c0 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3953,28 +3953,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
> >   
> >   #endif
> >   
> > -/**
> > - * probe_err - probe error check and log helper
> > - * @dev: the pointer to the struct device
> > - * @err: error value to test
> > - * @fmt: printf-style format string
> > - * @...: arguments as specified in the format string
> > - *
> > - * This helper implements common pattern present in probe functions for error
> > - * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> > - * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> > - * later by reading devices_deferred debugfs attribute.
> > - * It replaces code sequence:
> > - * 	if (err != -EPROBE_DEFER)
> > - * 		dev_err(dev, ...);
> > - * 	return err;
> > - * with
> > - * 	return probe_err(dev, err, ...);
> > - *
> > - * Returns @err.
> > - *
> > - */
> > -int probe_err(const struct device *dev, int err, const char *fmt, ...)
> > +int __probe_err(const struct device *dev, int err, const char *fmt, ...)
> >   {
> >   	struct va_format vaf;
> >   	va_list args;
> > @@ -3992,7 +3971,7 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
> >   
> >   	return err;
> >   }
> > -EXPORT_SYMBOL_GPL(probe_err);
> > +EXPORT_SYMBOL_GPL(__probe_err);
> >   
> >   static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> >   {
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 40a90d9bf799..22d3c3d4f461 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -965,7 +965,30 @@ void device_links_supplier_sync_state_pause(void);
> >   void device_links_supplier_sync_state_resume(void);
> >   
> >   extern __printf(3, 4)
> > -int probe_err(const struct device *dev, int err, const char *fmt, ...);
> > +int __probe_err(const struct device *dev, int err, const char *fmt, ...);
> > +
> > +/**
> > + * probe_err - probe error check and log helper
> > + * @dev: the pointer to the struct device
> > + * @err: error value to test, can be integer or pointer type
> > + * @fmt: printf-style format string
> > + * @...: arguments as specified in the format string
> > + *
> > + * This helper implements common pattern present in probe functions for error
> > + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> > + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> > + * later by reading devices_deferred debugfs attribute.
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
> > +#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)
> >   
> >   /* Create alias, so I can be autoloaded. */
> >   #define MODULE_ALIAS_CHARDEV(major,minor) \
> > 

-- 
Regards,

Laurent Pinchart
