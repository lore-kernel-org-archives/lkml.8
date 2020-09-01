Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D1CC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C252206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIAIUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:20:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:12016 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgIAIUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:20:51 -0400
IronPort-SDR: fgM2m8JuMfIE8GH5CiNTqkpGbNzABFSMBvIXV36VCi/YVDPfJZABROtj1OVbUlZmEcBC/3qJyk
 oL/VdcBPneoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154639809"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="154639809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 01:20:50 -0700
IronPort-SDR: LVggzNWPXu1Bf7uu+OK1VELuWrpP2vKoT6TOptxUNRJKxtgmoyJSZ+p+3Fwq52tv2pLhTtR3mt
 jII/QHBB9ZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="330990492"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2020 01:20:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kD1X4-00DFKA-Ku; Tue, 01 Sep 2020 11:20:46 +0300
Date:   Tue, 1 Sep 2020 11:20:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
Cc:     wsa@kernel.org, jdelvare@suse.de, jarkko.nikula@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: algo-pca: Reapply i2c bus settings after reset
Message-ID: <20200901082046.GO1891694@smile.fi.intel.com>
References: <20200901005713.27453-1-evan.nimmo@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901005713.27453-1-evan.nimmo@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:57:13PM +1200, Evan Nimmo wrote:

Thanks for the patch, my nit-picks, comments below.

> If something goes wrong (such as the SCL being stuck low) then we need
> to reset the pca chip. The issue with this is that on reset we lose all

pca -> PCA (here and where it applicable below).

> config settings and the chip ends up in a disabled state which results
> in a lock up/high cpu usage. We need to re-apply any configuration that
> had previously been set and re-enable the chip.

...

> +		/* We need to apply any configuration settings that
> +		 * were calculated in the pca_init function. The reset
> +		 * results in these changes being set back to defaults.
> +		 */

	/*
	 * Multi-line comments usually go
	 * like this.
	 */

...

> +		clock = pca_clock(pca_data);
> +
> +		/* Store settings as these will be needed when the pca chip is reset */
> +		pca_data->bus_settings.clock_freq = clock;
> +
>  		pca_reset(pca_data);
>  

> -		clock = pca_clock(pca_data);
>  		printk(KERN_INFO "%s: Clock frequency is %dkHz\n",
>  		     adap->name, freqs[clock]);

Seems this message is attached to above call. Can we move it as well?

...

> +/**
> + * struct i2c_bus_settings - The configured i2c bus settings
> + * @mode: Configured i2c bus mode (PCA9665)
> + * @tlow: Configured SCL LOW period (PCA9665)
> + * @thi: Configured SCL HIGH period (PCA9665)
> + * @clock_freq: The configured clock frequency (PCA9564)
> + */
> +struct i2c_bus_settings {
> +	int mode;
> +	int tlow;
> +	int thi;
> +	int clock_freq;
> +};

This is a good candidate to have it in generic header for sake of the
unification. Possible users:

struct tegra_i2c_hw_feature
struct cci_data::struct hw_params


-- 
With Best Regards,
Andy Shevchenko


