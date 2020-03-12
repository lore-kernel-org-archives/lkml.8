Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE371C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3BA206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCLRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:07:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:22743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgCLRHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:07:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 10:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="444010698"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2020 10:07:42 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCRJA-0093O3-P8; Thu, 12 Mar 2020 19:07:44 +0200
Date:   Thu, 12 Mar 2020 19:07:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] mfd: dln2: Fix sanity checking for endpoints
Message-ID: <20200312170744.GI1922688@smile.fi.intel.com>
References: <20200226145158.13396-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226145158.13396-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:51:58PM +0200, Andy Shevchenko wrote:
> While the commit 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> tries to harden the sanity checks it made at the same time a regression,
> i.e.  mixed in and out endpoints. Obviously it should have been not tested on
> real hardware at that time, but unluckily it didn't happen.
> 
> So, fix above mentioned typo and make device being enumerated again.
> 
> While here, introduce an enumerator for magic values to prevent similar issue
> to happen in the future.

Lee, is this now okay?

> 
> Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: Add enumerator (Lee)
>  drivers/mfd/dln2.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 7841c11411d0..4faa8d2e5d04 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -90,6 +90,11 @@ struct dln2_mod_rx_slots {
>  	spinlock_t lock;
>  };
>  
> +enum dln2_endpoint {
> +	DLN2_EP_OUT	= 0,
> +	DLN2_EP_IN	= 1,
> +};
> +
>  struct dln2_dev {
>  	struct usb_device *usb_dev;
>  	struct usb_interface *interface;
> @@ -733,10 +738,10 @@ static int dln2_probe(struct usb_interface *interface,
>  	    hostif->desc.bNumEndpoints < 2)
>  		return -ENODEV;
>  
> -	epin = &hostif->endpoint[0].desc;
> -	epout = &hostif->endpoint[1].desc;
> +	epout = &hostif->endpoint[DLN2_EP_OUT].desc;
>  	if (!usb_endpoint_is_bulk_out(epout))
>  		return -ENODEV;
> +	epin = &hostif->endpoint[DLN2_EP_IN].desc;
>  	if (!usb_endpoint_is_bulk_in(epin))
>  		return -ENODEV;
>  
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


