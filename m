Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7DA2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHaBkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:40:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:6189 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgHaBkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:40:09 -0400
IronPort-SDR: 4+IcsS63f+WZ5uNRz359uSNMgYBpNV64fLkvjQQRZYrhKJQhjDpD3hJTyhNytl0wPCFEX0h63C
 Ynt83oeGiDvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156901088"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="156901088"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:40:08 -0700
IronPort-SDR: vNXjfC+EBV3rEUO6SUoiDmhYRsHa8aKyIwMcpF8hGbXGnj01is6hQ3JUXXGkrDUntcHNWmYnDn
 DbhEtSK7Zq1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="445538157"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2020 18:40:08 -0700
Received: from [10.215.253.33] (vramuthx-MOBL1.gar.corp.intel.com [10.215.253.33])
        by linux.intel.com (Postfix) with ESMTP id A4D315803C5;
        Sun, 30 Aug 2020 18:40:05 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v7 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-2-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <30510a3b-b220-be89-068f-986875df1fd8@linux.intel.com>
Date:   Mon, 31 Aug 2020 09:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200821113747.2912-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/8/2020 7:37 pm, Wan Ahmad Zainie wrote:
> Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c
> to make drivers/phy/intel directory more generic for future use.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>   drivers/phy/intel/Kconfig                              | 10 +++++-----
>   drivers/phy/intel/Makefile                             |  4 ++--
>   .../intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} |  0
>   .../intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c}   |  0
>   4 files changed, 7 insertions(+), 7 deletions(-)
>   rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
>   rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)
> 
> diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
> index 7b47682a4e0e..db8586c3eed8 100644
> --- a/drivers/phy/intel/Kconfig
> +++ b/drivers/phy/intel/Kconfig
> @@ -1,9 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
> -# Phy drivers for Intel Lightning Mountain(LGM) platform
> +# Phy drivers for Intel platforms
>   #
> -config PHY_INTEL_COMBO
> -	bool "Intel ComboPHY driver"
> +config PHY_INTEL_LGM_COMBO
> +	bool "Intel Lightning Mountain ComboPHY driver"
>   	depends on X86 || COMPILE_TEST
>   	depends on OF && HAS_IOMEM
>   	select MFD_SYSCON
> @@ -16,8 +16,8 @@ config PHY_INTEL_COMBO
>   	  chipsets which provides PHYs for various controllers, EMAC,
>   	  SATA and PCIe.
>   
> -config PHY_INTEL_EMMC
> -	tristate "Intel EMMC PHY driver"
> +config PHY_INTEL_LGM_EMMC
> +	tristate "Intel Lightning Mountain EMMC PHY driver"
>   	depends on X86 || COMPILE_TEST
>   	select GENERIC_PHY
>   	help
> diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
> index 233d530dadde..662385d0a366 100644
> --- a/drivers/phy/intel/Makefile
> +++ b/drivers/phy/intel/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
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
Reviewed-by:Ramuthevar Vadivel Murugan 
<vadivel.muruganx.ramuthevar@linux.intel.com>

Regards
Vadivel
> 
