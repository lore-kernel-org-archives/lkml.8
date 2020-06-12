Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F176CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71CB2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFLNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:22:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:64106 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgFLNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:22:31 -0400
IronPort-SDR: 63gCey8JAfw0Q2D8vxCz9r0elzj68/6cKxaTnVFs8LRZwfyGMCPt/ZpBUwO3iRifNsIlewfx9D
 I2b9Sg/4LhZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 06:22:30 -0700
IronPort-SDR: SX89+EBuBgxAxrixyu2cRCTTkInMh0breXbEkcZpPaEhyA49f6UaS3hr6X/MaTouw6dqetDT+B
 Pv4ZRVio/8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="260827179"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 06:22:29 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jjjdf-00CZGm-Sd; Fri, 12 Jun 2020 16:22:31 +0300
Date:   Fri, 12 Jun 2020 16:22:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com
Subject: Re: [PATCH v4 2/2] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200612132231.GH2428291@smile.fi.intel.com>
References: <20200612035359.14246-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200612035359.14246-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612035359.14246-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 11:53:59AM +0800, Wan Ahmad Zainie wrote:
> Add support for eMMC PHY on Intel Keem Bay SoC.

Pretty much good, my comments below.

...

> +config PHY_KEEMBAY_EMMC
> +	tristate "Intel Keem Bay EMMC PHY Driver"

> +	depends on OF

No compile test?

> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Keem Bay EMMC PHY.

Please, be more verbose here, do I, as a user, need this? What will be the module name?

-- 
With Best Regards,
Andy Shevchenko


