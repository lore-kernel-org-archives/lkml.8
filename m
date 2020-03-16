Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A0020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgCPO5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:57:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:45629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgCPO5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:57:11 -0400
IronPort-SDR: ipCyzaCmqAz02j3yyM2ZZHTyHDMjVN0vJdQM++gaeYpN88Y4Xj3nh9Vy+uTSChBqfsOiBCTlm9
 6l8nPxZuS++A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 07:57:11 -0700
IronPort-SDR: jlqNv9QCzBihFxCV578HUzN4uzrW32o3cZ6DFhRaarLtJnTE+O6LmjeB3NdA0biye4AsyAntqJ
 RQsX7kr6QAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="247479311"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2020 07:57:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jDrB1-00A5mM-SB; Mon, 16 Mar 2020 16:57:11 +0200
Date:   Mon, 16 Mar 2020 16:57:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Elkhart Lake LPSS I2C input
 clock
Message-ID: <20200316145711.GO1922688@smile.fi.intel.com>
References: <20200316143224.234432-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316143224.234432-1-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:32:24PM +0200, Jarkko Nikula wrote:
> Intel Elkhart Lake LPSS I2C has 100 MHz input clock instead of 133 MHz
> that was our preliminary information. This will result slower I2C bus
> clock when driver calculates its timing parameters in case ACPI tables
> don't provide them.
> 
> Slower I2C bus clock is allowed but let's fix this to match with
> reality.
> 
> While at it, keep the same default I2C device properties as Intel
> Broxton since it is not known do they need any update.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> For normal development cycle.
> ---
>  drivers/mfd/intel-lpss-pci.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index c40a6c7d0cf8..e48f00448551 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -139,6 +139,11 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
>  	.properties = spt_i2c_properties,
>  };
>  
> +static const struct intel_lpss_platform_info ehl_i2c_info = {
> +	.clk_rate = 100000000,
> +	.properties = bxt_i2c_properties,
> +};
> +
>  static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	/* CML-LP */
>  	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
> @@ -231,15 +236,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x4b2a), (kernel_ulong_t)&bxt_info },
>  	{ PCI_VDEVICE(INTEL, 0x4b2b), (kernel_ulong_t)&bxt_info },
>  	{ PCI_VDEVICE(INTEL, 0x4b37), (kernel_ulong_t)&bxt_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b44), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b45), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b4b), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b4c), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b44), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b45), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b4b), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b4c), (kernel_ulong_t)&ehl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x4b4d), (kernel_ulong_t)&bxt_uart_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b78), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&bxt_i2c_info },
> -	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b78), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&ehl_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&ehl_i2c_info },
>  	/* JSL */
>  	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


