Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B90207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgIJJeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:32879 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbgIJJeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:34:01 -0400
IronPort-SDR: bR6YK92waCsZSd6Ooij8Utr5tRLTxBE9sDcGD0iPyO8Ue9j2tXVpnJfiooMABL2lX+ExO01Swj
 MW0xATa/SSUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146219723"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="146219723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 02:33:59 -0700
IronPort-SDR: QNL2ND1L1tyhKLpG+ZKs4Uxjdz2jyVmYfTfMOhFiTmMbn76ZfN/EJu0efVynxxtX+NeB2iCJOB
 qmxWV+qox5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="334122407"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 02:33:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kGIxl-00FeZu-IU; Thu, 10 Sep 2020 12:33:53 +0300
Date:   Thu, 10 Sep 2020 12:33:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
Message-ID: <20200910093353.GN1891694@smile.fi.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <20200909103317.GL1891694@smile.fi.intel.com>
 <41cf7b4d-2476-4d0e-0dae-f0200649d7dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41cf7b4d-2476-4d0e-0dae-f0200649d7dd@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:26:04PM +0800, Tanwar, Rahul wrote:
> On 9/9/2020 6:33 pm, Andy Shevchenko wrote:
> > On Wed, Sep 09, 2020 at 02:52:05PM +0800, Rahul Tanwar wrote:

...

> >> +#include <linux/of.h>
> > I don't see anything special about OF here.
> > Perhaps
> > 	mod_devicetable.h
> > 	property.h
> > ?
> 
> of.h is needed because of of_property_read_u8_array(). I will add
> mod_devicetable.h.
> property.h seems not required at all.

if you use device property API then it will be more generic.

...

> >> +static struct regmap_config pvt_regmap_config = {
> >> +	.reg_bits = 32,
> >> +	.reg_stride = 4,
> >> +	.val_bits = 32,
> > How do you use regmap's lock?
> 
> We mutex lock whenever read temperature or voltage values from the registers.
> All non-probe/non-init paths. We do not override regmap's internal lock.

Exactly and my point is why do we have too many locks?

> >> +};

-- 
With Best Regards,
Andy Shevchenko


