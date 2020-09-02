Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F292C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE72065E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBLXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:23:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:22206 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBLXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:23:32 -0400
IronPort-SDR: OZs/v5oW+sxnuedzK2ZWYU1Ye74M4OsEe5k7ugN0NoSAx1fJ/R0ilLhnocn+XtxC/Bzmy6Wxik
 HhRlD472xVRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="158360807"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="158360807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 04:23:31 -0700
IronPort-SDR: OqNCIjSk4VpEk9lplIyXWdoWV7hgkGe5Iq51Opx0ujwSKJuJVa80CDtRvjRjmjAzIKCfjyV5JS
 kPXG16VU6E3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="331402380"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2020 04:23:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kDQrN-00Dhr3-5n; Wed, 02 Sep 2020 14:23:25 +0300
Date:   Wed, 2 Sep 2020 14:23:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 03/10] USB: core: message.c: use usb_control_msg_send()
 in a few places
Message-ID: <20200902112325.GL1891694@smile.fi.intel.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902110115.1994491-4-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:01:05PM +0200, Greg Kroah-Hartman wrote:
> There are a few calls to usb_control_msg() that can be converted to use
> usb_control_msg_send() instead, so do that in order to make the error
> checking a bit simpler.

Makes sense. Others will take this as a good example of API in use.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/core/message.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 6aa49b237717..dfd079485c76 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1081,7 +1081,7 @@ int usb_set_isoch_delay(struct usb_device *dev)
>  	if (dev->speed < USB_SPEED_SUPER)
>  		return 0;
>  
> -	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> +	return usb_control_msg_send(dev, 0,
>  			USB_REQ_SET_ISOCH_DELAY,
>  			USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
>  			dev->hub_delay, 0, NULL, 0,
> @@ -1203,13 +1203,13 @@ int usb_clear_halt(struct usb_device *dev, int pipe)
>  	 * (like some ibmcam model 1 units) seem to expect hosts to make
>  	 * this request for iso endpoints, which can't halt!
>  	 */
> -	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> -		USB_REQ_CLEAR_FEATURE, USB_RECIP_ENDPOINT,
> -		USB_ENDPOINT_HALT, endp, NULL, 0,
> -		USB_CTRL_SET_TIMEOUT);
> +	result = usb_control_msg_send(dev, 0,
> +				      USB_REQ_CLEAR_FEATURE, USB_RECIP_ENDPOINT,
> +				      USB_ENDPOINT_HALT, endp, NULL, 0,
> +				      USB_CTRL_SET_TIMEOUT);
>  
>  	/* don't un-halt or force to DATA0 except on success */
> -	if (result < 0)
> +	if (result)
>  		return result;
>  
>  	/* NOTE:  seems like Microsoft and Apple don't bother verifying
> @@ -1558,9 +1558,10 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
>  	if (dev->quirks & USB_QUIRK_NO_SET_INTF)
>  		ret = -EPIPE;
>  	else
> -		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> -				   USB_REQ_SET_INTERFACE, USB_RECIP_INTERFACE,
> -				   alternate, interface, NULL, 0, 5000);
> +		ret = usb_control_msg_send(dev, 0,
> +					   USB_REQ_SET_INTERFACE,
> +					   USB_RECIP_INTERFACE, alternate,
> +					   interface, NULL, 0, 5000);
>  
>  	/* 9.4.10 says devices don't need this and are free to STALL the
>  	 * request if the interface only has one alternate setting.
> @@ -1570,7 +1571,7 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
>  			"manual set_interface for iface %d, alt %d\n",
>  			interface, alternate);
>  		manual = 1;
> -	} else if (ret < 0) {
> +	} else if (ret) {
>  		/* Re-instate the old alt setting */
>  		usb_hcd_alloc_bandwidth(dev, NULL, alt, iface->cur_altsetting);
>  		usb_enable_lpm(dev);
> @@ -1718,11 +1719,10 @@ int usb_reset_configuration(struct usb_device *dev)
>  		mutex_unlock(hcd->bandwidth_mutex);
>  		return retval;
>  	}
> -	retval = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> -			USB_REQ_SET_CONFIGURATION, 0,
> -			config->desc.bConfigurationValue, 0,
> -			NULL, 0, USB_CTRL_SET_TIMEOUT);
> -	if (retval < 0)
> +	retval = usb_control_msg_send(dev, 0, USB_REQ_SET_CONFIGURATION, 0,
> +				      config->desc.bConfigurationValue, 0,
> +				      NULL, 0, USB_CTRL_SET_TIMEOUT);
> +	if (retval)
>  		goto reset_old_alts;
>  	mutex_unlock(hcd->bandwidth_mutex);
>  
> @@ -2103,10 +2103,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  	}
>  	kfree(new_interfaces);
>  
> -	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> -			      USB_REQ_SET_CONFIGURATION, 0, configuration, 0,
> -			      NULL, 0, USB_CTRL_SET_TIMEOUT);
> -	if (ret < 0 && cp) {
> +	ret = usb_control_msg_send(dev, 0, USB_REQ_SET_CONFIGURATION, 0,
> +				   configuration, 0, NULL, 0,
> +				   USB_CTRL_SET_TIMEOUT);
> +	if (ret && cp) {
>  		/*
>  		 * All the old state is gone, so what else can we do?
>  		 * The device is probably useless now anyway.
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


