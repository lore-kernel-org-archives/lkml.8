Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A39206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgEVMwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:52:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:60756 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbgEVMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:14 -0400
IronPort-SDR: Ka9sX1pRpxj71nTpCA2i07wCmMwENOMSAYowC05JOeCy6Lv12ZxzRaqm+8Fo/Ru3BRlCphHc90
 49Ez4fV6lR3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:52:13 -0700
IronPort-SDR: mPZJqCPCWWnRl/VU8XjB3NcZOxczurj90S1c4Q5kweewnB64TVcRx4k9x6jnwotSdyglfr6LMy
 pzCkNu+YhvxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="283390068"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 05:52:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc79r-008EUL-3j; Fri, 22 May 2020 15:52:15 +0300
Date:   Fri, 22 May 2020 15:52:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
Cc:     kbuild test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] mux: adgs1408: Add mod_devicetable.h and remove
 of_match_ptr
Message-ID: <20200522125215.GE1634618@smile.fi.intel.com>
References: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:01:22PM +0300, Andy Shevchenko wrote:
> Enables probing via the ACPI PRP0001 route but more is mostly about
> removing examples of this that might get copied into new drivers.
> 
> Also fixes
>   drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
> as has been reported recently.

Maybe Mark or Greg can take this?

I can resend Cc'ing you.

> 
> Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mux/adgs1408.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
> index 89096f10f4c4..12466b06692c 100644
> --- a/drivers/mux/adgs1408.c
> +++ b/drivers/mux/adgs1408.c
> @@ -6,9 +6,9 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mux/driver.h>
> -#include <linux/of_platform.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi.h>
>  
> @@ -59,7 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
>  	s32 idle_state;
>  	int ret;
>  
> -	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
> +	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
>  	if (!chip_id)
>  		chip_id = spi_get_device_id(spi)->driver_data;
>  
> @@ -119,7 +119,7 @@ MODULE_DEVICE_TABLE(of, adgs1408_of_match);
>  static struct spi_driver adgs1408_driver = {
>  	.driver = {
>  		.name = "adgs1408",
> -		.of_match_table = of_match_ptr(adgs1408_of_match),
> +		.of_match_table = adgs1408_of_match,
>  	},
>  	.probe = adgs1408_probe,
>  	.id_table = adgs1408_spi_id,
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


