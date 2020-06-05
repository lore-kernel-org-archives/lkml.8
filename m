Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E64CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8063F2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFENQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:16:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:43102 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgFENQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:16:22 -0400
IronPort-SDR: oAZREbqUfVAPE8RddbmZG000S7/GLaZJhpr8pI483GE7xwvz3r6wPIHipsvBG9C283tPdXB1tE
 WQYvX2qY90Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 06:16:21 -0700
IronPort-SDR: FRvclmCYfHfRvfURQUywqf1K+AYbwemI/DPq0Q7e3yniMyQNLNFqSkZ6y86e5lhOS/0AGSuzct
 x8Y3gsiTG95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471909899"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2020 06:16:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jhCCs-00B2Cj-Ou; Fri, 05 Jun 2020 16:16:22 +0300
Date:   Fri, 5 Jun 2020 16:16:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gene Chen <gene.chen.richtek@gmail.com>
Subject: Re: [PATCH] mfd: mfd-core: Don't overwrite the dma_mask of the child
 device
Message-ID: <20200605131622.GL2428291@smile.fi.intel.com>
References: <20200604213037.17254-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604213037.17254-1-michael@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:30:37PM +0200, Michael Walle wrote:
> Commit cdfee5623290 ("driver core: initialize a default DMA mask for
> platform device") initialize the DMA of a platform device. But if the
> parent doesn't have a dma_mask set, for example if it's an I2C device,
> the dma_mask of the child platform device will be set to zero again.
> Which leads to many "DMA mask not set" warnings, if the MFD cell has the
> of_compatible property set.
> 
> [    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
> [    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
> [    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set
> 
> Thus don't overwrite the dma_mask of the children. Instead set the
> dma_mask of the platform device.

> ---
> Former discussion was here:
> https://lore.kernel.org/lkml/20200423174543.17161-3-michael@walle.cc/
> 
> Because my MFD driver now uses of_platform_populate() it doesn't trigger
> this anymore. But it may be useful for others, e.g. if I'm not mistaken it
> should apply to the mt6360 sub devices.

Yeah, I'm not sure it's right thing to do, but let maintainers and more
experienced in topic developers to speak up.

-- 
With Best Regards,
Andy Shevchenko


