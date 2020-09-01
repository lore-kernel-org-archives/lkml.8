Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2142DC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAC6206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIAIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:10:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:62349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgIAIKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:10:45 -0400
IronPort-SDR: KbETmduCJU25KeHQOkCP5B6z5sueyhbu6jaNGvEgWoJfI5sqtpj+OlGQmVMNh9xh8Cj2zLuX23
 anWDw68o9RkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="218679195"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="218679195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 01:10:44 -0700
IronPort-SDR: dovm96Q6dXJ+SFXqtKOvg2fPhMEdFiCL95D039Vxn1+8RSZLF2FfnTXohAqzaMgD32DD4pZ8nv
 tBnVd9tV64fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="330988244"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2020 01:10:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kD1NI-00DFCj-4D; Tue, 01 Sep 2020 11:10:40 +0300
Date:   Tue, 1 Sep 2020 11:10:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v8 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Message-ID: <20200901081040.GN1891694@smile.fi.intel.com>
References: <20200901044201.20978-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200901044201.20978-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901044201.20978-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:41:59PM +0800, Wan Ahmad Zainie wrote:
> Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c
> to make drivers/phy/intel directory more generic for future use.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

> Reviewed-by: Ramuthevar Vadivel Murugan
> <vadivel.muruganx.ramuthevar@linux.intel.com>

This shall be one line.

> ---
>  drivers/phy/intel/Kconfig                              | 10 +++++-----
>  drivers/phy/intel/Makefile                             |  4 ++--
>  .../intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} |  0
>  .../intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c}   |  0
>  4 files changed, 7 insertions(+), 7 deletions(-)
>  rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
>  rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)
> 
> diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
> index 7b47682a4e0e..db8586c3eed8 100644
> --- a/drivers/phy/intel/Kconfig
> +++ b/drivers/phy/intel/Kconfig
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
> -# Phy drivers for Intel Lightning Mountain(LGM) platform
> +# Phy drivers for Intel platforms
>  #
> -config PHY_INTEL_COMBO
> -	bool "Intel ComboPHY driver"
> +config PHY_INTEL_LGM_COMBO
> +	bool "Intel Lightning Mountain ComboPHY driver"
>  	depends on X86 || COMPILE_TEST
>  	depends on OF && HAS_IOMEM
>  	select MFD_SYSCON
> @@ -16,8 +16,8 @@ config PHY_INTEL_COMBO
>  	  chipsets which provides PHYs for various controllers, EMAC,
>  	  SATA and PCIe.
>  
> -config PHY_INTEL_EMMC
> -	tristate "Intel EMMC PHY driver"
> +config PHY_INTEL_LGM_EMMC
> +	tristate "Intel Lightning Mountain EMMC PHY driver"
>  	depends on X86 || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
> diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
> index 233d530dadde..662385d0a366 100644
> --- a/drivers/phy/intel/Makefile
> +++ b/drivers/phy/intel/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
> -obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
> +obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+= phy-intel-lgm-combo.o
> +obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+= phy-intel-lgm-emmc.o
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
> similarity index 100%
> rename from drivers/phy/intel/phy-intel-combo.c
> rename to drivers/phy/intel/phy-intel-lgm-combo.c
> diff --git a/drivers/phy/intel/phy-intel-emmc.c b/drivers/phy/intel/phy-intel-lgm-emmc.c
> similarity index 100%
> rename from drivers/phy/intel/phy-intel-emmc.c
> rename to drivers/phy/intel/phy-intel-lgm-emmc.c
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


