Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B03C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0625521556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCELLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:11:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:14331 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCELLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:11:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="441345234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2020 03:11:17 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j9oPQ-0074pd-6r; Thu, 05 Mar 2020 13:11:20 +0200
Date:   Thu, 5 Mar 2020 13:11:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, Randy Dunlap <rdunlap@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove CONFIG_ prefix from
 MFD_CROS_EC section
Message-ID: <20200305111120.GG1224808@smile.fi.intel.com>
References: <20200305102838.108967-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305102838.108967-1-enric.balletbo@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:28:38AM +0100, Enric Balletbo i Serra wrote:
> Remove the CONFIG_ prefix from the select statement for MFD_CROS_EC.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 2fa2b980e3fe1 ("mfd / platform: cros_ec: Rename config to a better name")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/platform/chrome/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 15fc8b8a2db8..5ae6c49f553d 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -7,7 +7,7 @@ config MFD_CROS_EC
>  	tristate "Platform support for Chrome hardware (transitional)"
>  	select CHROME_PLATFORMS
>  	select CROS_EC
> -	select CONFIG_MFD_CROS_EC_DEV
> +	select MFD_CROS_EC_DEV
>  	depends on X86 || ARM || ARM64 || COMPILE_TEST
>  	help
>  	  This is a transitional Kconfig option and will be removed after
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


