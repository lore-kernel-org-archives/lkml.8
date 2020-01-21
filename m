Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19523C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2EF2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAUSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:00:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:10991 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAUSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 10:00:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="374663571"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2020 10:00:15 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1itxp1-0001Ib-2w; Tue, 21 Jan 2020 20:00:15 +0200
Date:   Tue, 21 Jan 2020 20:00:15 +0200
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
Subject: Re: [PATCH v4 36/38] platform/x86: intel_telemetry: Add
 telemetry_get_pltdata()
Message-ID: <20200121180015.GC32742@smile.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-37-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-37-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:01:12PM +0300, Mika Westerberg wrote:
> Add new function that allows telemetry modules to get pointer to the
> platform specific configuration. This is needed to allow the telemetry
> debugfs module to fetch PMC IPC instance in the subsequent patch.

One comment below.
After addressing,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_telemetry.h      |  1 +
>  drivers/platform/x86/intel_telemetry_core.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel_telemetry.h b/arch/x86/include/asm/intel_telemetry.h
> index e19deb776003..1335565c43b5 100644
> --- a/arch/x86/include/asm/intel_telemetry.h
> +++ b/arch/x86/include/asm/intel_telemetry.h
> @@ -99,6 +99,7 @@ int telemetry_set_pltdata(const struct telemetry_core_ops *ops,
>  int telemetry_clear_pltdata(void);
>  
>  int telemetry_pltconfig_valid(void);
> +struct telemetry_plt_config *telemetry_get_pltdata(void);
>  
>  int telemetry_get_evtname(enum telemetry_unit telem_unit,
>  			  const char **name, int len);
> diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
> index d4040bb222b4..e11b79d1b3a7 100644
> --- a/drivers/platform/x86/intel_telemetry_core.c
> +++ b/drivers/platform/x86/intel_telemetry_core.c
> @@ -369,6 +369,18 @@ int telemetry_pltconfig_valid(void)
>  }
>  EXPORT_SYMBOL_GPL(telemetry_pltconfig_valid);
>  
> +/**
> + * telemetry_get_pltdata() - Return telemetry platform config
> + *
> + * May be used by other telemetry modules to get platform specific
> + * configuration.
> + */
> +struct telemetry_plt_config *telemetry_get_pltdata(void)
> +{
> +	return telm_core_conf.plt_config;
> +}
> +EXPORT_SYMBOL_GPL(telemetry_get_pltdata);

Effectively this may replace telemetry_pltconfig_valid().

> +
>  static inline int telemetry_get_pssevtname(enum telemetry_unit telem_unit,
>  					   const char **name, int len)
>  {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


