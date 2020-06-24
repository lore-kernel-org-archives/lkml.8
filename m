Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84C320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593001904;
	bh=HHFW9P/Qkn3LOU79EtMz+P3iLwblu/8OTGW8v5iyu7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUwYhu79OxOUNVPMKRBY6HlMIKMPoBfIBxI+4YSkQVpbvDAU7JmBbAHwnWejMaOJV
	 wCmIInYMyWbHaOA4ax8DHM8+jvixFHZphE7pEZPaigZdhD983ewlIAGxUuHnq0ANGf
	 A5C9aFHH5Mezac4JpCoV292Zzefrcv7zY7VlWUZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbgFXMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbgFXMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:31:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58AAD20B1F;
        Wed, 24 Jun 2020 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593001902;
        bh=HHFW9P/Qkn3LOU79EtMz+P3iLwblu/8OTGW8v5iyu7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjlpDlMYSWuBlcaaODRklRvE0ggw9FShRdjGviDu9yK/vCFr1fQpKjofevQJSnoUQ
         lS49EyX4L8oFtt0OVluh+L2oE+6gRim2gCbF/4NhnRvPw0iuPeK947ikIrRjtgCtRN
         XaBRLKr/qIHfA77EhvA/7fzLkhMMgAIzKkWuR65k=
Date:   Wed, 24 Jun 2020 14:31:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
Message-ID: <20200624123140.GB1773782@kroah.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624114127.3016-2-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:41:23PM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..ee9da66bff1b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3953,6 +3953,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>  
>  #endif
>  
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + * 	if (err != -EPROBE_DEFER)
> + * 		dev_err(dev, ...);
> + * 	return err;
> + * with
> + * 	return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	if (err == -EPROBE_DEFER)
> +		return err;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	dev_err(dev, "error %d: %pV", err, &vaf);
> +
> +	va_end(args);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);

Please be specific in global symbols, how about "driver_probe_error()"?

And merge the other patch into this one, as Raphael said, otherwise this
just looks odd to add something and then fix it up later.

thanks,

greg k-h
