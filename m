Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41146C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B802071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgCaOeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:34:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:64552 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgCaOeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:34:00 -0400
IronPort-SDR: B9PYXwznGP3Hj+nnOhmMo+nJ/DlhzNVOcnZzOLUdO08DBzrOZYOFPDeQWXlbZ8UL/QoAueLe40
 vXdgVmi7KeaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 07:33:55 -0700
IronPort-SDR: PoVz2pXBjVTUT9DlfTQYcfPUohGMn5hhvWqYZhmscH6zT9y0UxtuZRV7CvcbhfJsLoPX88lsrR
 8TDSbWmn+l9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="450183284"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2020 07:33:53 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jJHxj-00EWXQ-VY; Tue, 31 Mar 2020 17:33:55 +0300
Date:   Tue, 31 Mar 2020 17:33:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
Message-ID: <20200331143355.GP1922688@smile.fi.intel.com>
References: <20200327170132.17275-1-grant.likely@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327170132.17275-1-grant.likely@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:01:32PM +0000, Grant Likely wrote:
> Add a bit of documentation on what it means when a driver .probe() hook
> returns the -EPROBE_DEFER error code, including the limitation that
> -EPROBE_DEFER should be returned as early as possible, before the driver
> starts to register child devices.
> 
> Also: minor markup fixes in the same file

Greg, can we at least for time being have this documented, means applied?

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../driver-api/driver-model/driver.rst        | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
> index baa6a85c8287..63057d9bc8a6 100644
> --- a/Documentation/driver-api/driver-model/driver.rst
> +++ b/Documentation/driver-api/driver-model/driver.rst
> @@ -4,7 +4,6 @@ Device Drivers
>  
>  See the kerneldoc for the struct device_driver.
>  
> -
>  Allocation
>  ~~~~~~~~~~
>  
> @@ -167,9 +166,26 @@ the driver to that device.
>  
>  A driver's probe() may return a negative errno value to indicate that
>  the driver did not bind to this device, in which case it should have
> -released all resources it allocated::
> +released all resources it allocated.
> +
> +Optionally, probe() may return -EPROBE_DEFER if the driver depends on
> +resources that are not yet available (e.g., supplied by a driver that
> +hasn't initialized yet).  The driver core will put the device onto the
> +deferred probe list and will try to call it again later. If a driver
> +must defer, it should return -EPROBE_DEFER as early as possible to
> +reduce the amount of time spent on setup work that will need to be
> +unwound and reexecuted at a later time.
> +
> +.. warning::
> +      -EPROBE_DEFER must not be returned if probe() has already created
> +      child devices, even if those child devices are removed again
> +      in a cleanup path. If -EPROBE_DEFER is returned after a child
> +      device has been registered, it may result in an infinite loop of
> +      .probe() calls to the same driver.
> +
> +::
>  
> -	void (*sync_state)(struct device *dev);
> +	void	(*sync_state)	(struct device *dev);
>  
>  sync_state is called only once for a device. It's called when all the consumer
>  devices of the device have successfully probed. The list of consumers of the
> @@ -212,6 +228,8 @@ over management of devices from the bootloader, the usage of sync_state() is
>  not restricted to that. Use it whenever it makes sense to take an action after
>  all the consumers of a device have probed.
>  
> +::
> +
>  	int 	(*remove)	(struct device *dev);
>  
>  remove is called to unbind a driver from a device. This may be
> @@ -224,11 +242,15 @@ not. It should free any resources allocated specifically for the
>  device; i.e. anything in the device's driver_data field.
>  
>  If the device is still present, it should quiesce the device and place
> -it into a supported low-power state::
> +it into a supported low-power state.
> +
> +::
>  
>  	int	(*suspend)	(struct device *dev, pm_message_t state);
>  
> -suspend is called to put the device in a low power state::
> +suspend is called to put the device in a low power state.
> +
> +::
>  
>  	int	(*resume)	(struct device *dev);
>  
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


