Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A549C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3453920658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgHQI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:28:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:39733 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgHQI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:27:57 -0400
IronPort-SDR: RN8TCLZ4ToFewbdc5uR8rSJDDpSpRGtqJioEMZ3KeDyjFr7wkitumdkFwk951HySM06e4AM1wA
 VQLbD2kRwVJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142485498"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="142485498"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:27:56 -0700
IronPort-SDR: jlweMGgmnmuDxpK/28ZfkxICm7W9Bw5hE6caHFphHEnPY/rg2JZVeaGTdGOayRAdwkC49Kz3uR
 weoZ+heuQTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="496935225"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2020 01:27:54 -0700
Date:   Mon, 17 Aug 2020 16:24:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200817082410.GB19661@yilunxu-OptiPlex-7050>
References: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brown & jones:

I tried to refacor the regmap code and add comments in this patchset. I
made big changes to the rx flow and remove some tricky parts in it.

Would it be more understandable than last version? I'm expecting your
comments on it when you have time, thanks in advance.

Yilun

On Wed, Aug 05, 2020 at 04:00:54PM +0800, Xu Yilun wrote:
> This patchset adds the regmap-spi-avmm to support the Intel SPI Slave to
> AVMM Bus Bridge (spi-avmm) IP block. It also implements the usercase - the
> driver of Intel Max10 BMC chip which integrates this IP block.
> 
> Patch #1 implements the regmap-spi-avmm.
> Patch #2 implements the mfd driver of Intel Max10 BMC chip.
> 
> Main changes from v1:
> - Split out the regmap-spi-avmm module out of intel-m10-bmc module.
> 
> Main changes from v2:
> - Refactor the code of regmap-spi-avmm.
>    - Rewrites the rx flow and simplifies the implementation, collapse some
>      function calls.
>    - Add bounds checking every time we fill trans_buf & phy_buf.
>    - Try to configure spi mode on regmap init
>    - delete regmap_bus.reg_write/reg_read callbacks.
>    - Squash the bug fixing patch.
> - Add the sub devices in mfd_cell for Max10 bmc driver.
> - Improve comments and some minor fixes.
> 
> Xu Yilun (2):
>   regmap: add Intel SPI Slave to AVMM Bus Bridge support
>   mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
> 
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
>  drivers/base/regmap/Kconfig                        |   6 +-
>  drivers/base/regmap/Makefile                       |   1 +
>  drivers/base/regmap/regmap-spi-avmm.c              | 735 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  13 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/intel-m10-bmc.c                        | 169 +++++
>  include/linux/mfd/intel-m10-bmc.h                  |  57 ++
>  include/linux/regmap.h                             |  36 +
>  9 files changed, 1033 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 drivers/base/regmap/regmap-spi-avmm.c
>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> 
> -- 
> 2.7.4
