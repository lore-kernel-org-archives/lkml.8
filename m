Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBCDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B8F206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAURv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:51:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:25439 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAURv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:51:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 09:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250332231"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 09:51:53 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1itxgv-0001Av-UP; Tue, 21 Jan 2020 19:51:53 +0200
Date:   Tue, 21 Jan 2020 19:51:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 34/38] platform/x86: intel_pmc_ipc: Propagate error
 from kstrtoul()
Message-ID: <20200121175153.GB32742@smile.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-35-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-35-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:01:10PM +0300, Mika Westerberg wrote:
> kstrtoul() already returns negative error if the input was not valid so
> return it directly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_ipc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index f912f2a40512..eb4d65768531 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -226,8 +226,9 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
>  	int subcmd;
>  	int ret;
>  
> -	if (kstrtoul(buf, 0, &val))
> -		return -EINVAL;
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
>  
>  	if (val)
>  		subcmd = 1;
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


