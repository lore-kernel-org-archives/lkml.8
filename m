Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B712BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3079D207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIJJGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:06:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:17876 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgIJJG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:06:29 -0400
IronPort-SDR: jGewJH0bjtxxheTwJ2NeJA9749X1y2xZnYphQ4MAi81Fey8IfmKg8KcuIFCFrS0gjNZgWXHI6B
 dsM5gESaXoqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158531601"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="158531601"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 02:06:29 -0700
IronPort-SDR: WIrzJC6y5FIl0jF84V5cLkjFwXcy7VIWSi+mxD5gwtYqmrixTipndRhqCyPNoILOuTOXWdOOQ6
 reMeeQ5tk+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="334115483"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 02:06:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kGIXB-00FeKK-FX; Thu, 10 Sep 2020 12:06:25 +0300
Date:   Thu, 10 Sep 2020 12:06:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Bounine <alexandre.bounine@idt.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v1] rapidio: Make it dependent to DMADEVICES
Message-ID: <20200910090625.GL1891694@smile.fi.intel.com>
References: <20190813143906.9865-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813143906.9865-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:39:06PM +0300, Andy Shevchenko wrote:
> DMADEVICES option depends on HAS_DMA, and this dependency is ignored
> when DMADEVICES is being selected.
> 
> Replace 'select' by 'depends on' in Kconfig for RAPIDIO_DMA_ENGINE.

Yeah, I'm wondering why we got this into kernel much later (as
d2b861002450 ("rapidio: Replace 'select' DMAENGINES 'with depends on'") in
linux next and no one commented on this...

> Fixes: e42d98ebe7d7 ("rapidio: add DMA engine support for RIO data transfers")
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/rapidio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index 677d1aff61b7..788e7830771b 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
>  config RAPIDIO_DMA_ENGINE
>  	bool "DMA Engine support for RapidIO"
>  	depends on RAPIDIO
> -	select DMADEVICES
> +	depends on DMADEVICES
>  	select DMA_ENGINE
>  	help
>  	  Say Y here if you want to use DMA Engine frameork for RapidIO data
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


