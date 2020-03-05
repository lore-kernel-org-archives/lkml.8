Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0003C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57F72073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCENn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:43:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:27196 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCENn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:43:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 05:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="234457765"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 05:43:23 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j9qmb-0076gO-T3; Thu, 05 Mar 2020 15:43:25 +0200
Date:   Thu, 5 Mar 2020 15:43:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCH-V PCI IDs
Message-ID: <20200305134325.GL1224808@smile.fi.intel.com>
References: <20200113125729.8576-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113125729.8576-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:57:29PM +0200, Andy Shevchenko wrote:
> Intel Comet Lake PCH-V has the same LPSS than Intel Kaby Lake.
> Add the new IDs to the list of supported devices.
> 

Lee, anything I need to do with this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index c40a6c7d0cf8..378024a3ba28 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -347,6 +347,16 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
> +	/* CML-V */
> +	{ PCI_VDEVICE(INTEL, 0xa3a7), (kernel_ulong_t)&spt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3a8), (kernel_ulong_t)&spt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3a9), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3aa), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3e0), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3e1), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3e3), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0xa3e6), (kernel_ulong_t)&spt_uart_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


