Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307D720671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgENOR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:17:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38067 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726050AbgENOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:17:56 -0400
Received: (qmail 13785 invoked by uid 500); 14 May 2020 10:17:55 -0400
Date:   Thu, 14 May 2020 10:17:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH] USB: dummy-hcd: use configurable endpoint naming scheme
Message-ID: <20200514141755.GA12181@rowland.harvard.edu>
References: <e2638d6e4d38f97b46bee58b2c79a93b29b5718c.1589403150.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2638d6e4d38f97b46bee58b2c79a93b29b5718c.1589403150.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:52:56PM +0200, Andrey Konovalov wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> USB gadget subsystem uses the following naming convention for UDC
> endpoints:
> 
> - "ep-a" names for fully configurable endpoints (address, direction and
>   transfer type can be changed);
> 
> - "ep1in", "ep12out-bulk" names for fixed function endpoints (fixed
>   address, direction and/or transfer type).
> 
> Dummy UDC endpoints are capable of full configuration, but named using
> the second scheme.
> 
> This patch changes the names of generic Dummy UDC endpoints to "ep-aout",
> "ep-bin", etc., to advertise that they have configurable addresses and
> transfer types (except that Dummy UDC doesn't support ISO transfers), but
> fixed direction.
> 
> This is required for Raw Gadget (and perhaps for some other drivers),
> that reasons about whether an endpoint has configurable address based
> on its name.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 6e3e3ebf715f..7402ef0d66d2 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -187,31 +187,31 @@ static const struct {
>  		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
>  
>  	/* and now some generic EPs so we have enough in multi config */
> -	EP_INFO("ep3out",
> +	EP_INFO("ep-aout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep4in",
> +	EP_INFO("ep-bin",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
> -	EP_INFO("ep5out",
> +	EP_INFO("ep-cout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep6out",
> +	EP_INFO("ep-dout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep7in",
> +	EP_INFO("ep-ein",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
> -	EP_INFO("ep8out",
> +	EP_INFO("ep-fout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep9in",
> +	EP_INFO("ep-gin",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
> -	EP_INFO("ep10out",
> +	EP_INFO("ep-hout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep11out",
> +	EP_INFO("ep-iout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep12in",
> +	EP_INFO("ep-jin",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
> -	EP_INFO("ep13out",
> +	EP_INFO("ep-kout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
> -	EP_INFO("ep14in",
> +	EP_INFO("ep-lin",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
> -	EP_INFO("ep15out",
> +	EP_INFO("ep-mout",
>  		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
>  
>  #undef EP_INFO

Acked-by: Alan Stern <stern@rowland.harvard.edu>
