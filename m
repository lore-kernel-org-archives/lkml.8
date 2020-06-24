Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07166C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D925B2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593001815;
	bh=HlA6luu4r6/yFqJBEksA5pntocBrVJtjQggo8uE7V0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cVmpmM9K7vriT8R/aJjHHnIZGK0y0XF0FQj/zcHTp6qcBSSmzk1b5DiXz0N3Cu2dj
	 4s4KNZJ+ib1I59QNKYAVOHyiXcqcxnYhRbFwjXudIul7pj5pUIsUQP/cpLtDq1uQhT
	 1XiH0lCfBn/0JNaYSFjyFw1kr3Yc6aL+Vfk/TKAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbgFXMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388790AbgFXMaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:30:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2250820707;
        Wed, 24 Jun 2020 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593001811;
        bh=HlA6luu4r6/yFqJBEksA5pntocBrVJtjQggo8uE7V0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLDoURA/Gn5X4R0JA1WB+sDEtFPFY6RMrIYYtzI6+p20500eW6YGrD95nff0+Atb4
         Bf/596jKYcvwaopyzU6z+xyJMHjuS0q2gVnPfPEWbO0QQ7fQ2P7ArAW/Lszfn1uNeY
         TfjK+yTMTXr6Ep9Y6Ml98NDBB/d/eNHz9nnaKy4Q=
Date:   Wed, 24 Jun 2020 14:30:08 +0200
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
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
Message-ID: <20200624123008.GA1773782@kroah.com>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624114127.3016-4-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:41:25PM +0200, Andrzej Hajda wrote:
> Many resource acquisition functions return error value encapsulated in
> pointer instead of integer value. To simplify coding we can use macro
> which will accept both types of error.
> With this patch user can use:
> 	probe_err(dev, ptr, ...)
> instead of:
> 	probe_err(dev, PTR_ERR(ptr), ...)
> Without loosing old functionality:
> 	probe_err(dev, err, ...)
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/core.c    | 25 ++-----------------------
>  include/linux/device.h | 25 ++++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2a96954d5460..df283c62d9c0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3953,28 +3953,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>  
>  #endif
>  
> -/**
> - * probe_err - probe error check and log helper
> - * @dev: the pointer to the struct device
> - * @err: error value to test
> - * @fmt: printf-style format string
> - * @...: arguments as specified in the format string
> - *
> - * This helper implements common pattern present in probe functions for error
> - * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> - * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> - * later by reading devices_deferred debugfs attribute.
> - * It replaces code sequence:
> - * 	if (err != -EPROBE_DEFER)
> - * 		dev_err(dev, ...);
> - * 	return err;
> - * with
> - * 	return probe_err(dev, err, ...);
> - *
> - * Returns @err.
> - *
> - */
> -int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +int __probe_err(const struct device *dev, int err, const char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> @@ -3992,7 +3971,7 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(probe_err);
> +EXPORT_SYMBOL_GPL(__probe_err);
>  
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 40a90d9bf799..22d3c3d4f461 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -965,7 +965,30 @@ void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>  
>  extern __printf(3, 4)
> -int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +int __probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test, can be integer or pointer type
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
> + * later by reading devices_deferred debugfs attribute.
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
> +#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)

Shouldn't that be "unsigned long" instead of "long"?  That's what we put
pointers in last I looked...

thanks,

greg k-h
