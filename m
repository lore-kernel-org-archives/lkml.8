Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90444C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5B4206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGZJMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:12:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:51178 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:12:04 -0400
IronPort-SDR: vkeHC7hGzL2wbnpqIPVOi2lqvrSdgmV9XQHWAAYUF4RgVTwRY2P4SXaSOkAZTfp3Q6egFoBdKc
 THF7fxac5pNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="152147463"
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="152147463"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 02:12:04 -0700
IronPort-SDR: Eh+bPL5MT3i7V3MlgHbDG6OEXhs4iHxyX9psKdhO2/OpDwC7I3oGWPWIwUY0oHlajUFwKxaFqj
 fqAFM37sc5MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="285368577"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2020 02:12:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jzchO-0045pL-BC; Sun, 26 Jul 2020 12:12:02 +0300
Date:   Sun, 26 Jul 2020 12:12:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 0/5] irqdomain: clean up, add
 irq_domain_create_legacy()
Message-ID: <20200726091202.GJ3703480@smile.fi.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 07:21:30PM +0300, Andy Shevchenko wrote:
> In order to make users OF independent provide irq_domain_create_legacy() API.
> Last patch is an example of such user. First three patches are little cleanups.
> 
> Since regmap patch is dependent to what is now in regmap tree, I suggest to
> create an immutable branch in IRQ domain tree and Mark can pull it and apply
> the last one.

Marc, are you okay with the IRQ domain patches?

> Andy Shevchenko (5):
>   irqdomain: Remove unused of_device_id forward declaration
>   irqdomain: Add forward declaration of fwnode_handle
>   irqdomain: Replace open coded of_node_to_fwnode()
>   irqdomain: Introduce irq_domain_create_legacy() API
>   regmap: irq: Convert to use fwnode directly
> 
>  Documentation/core-api/irq/irq-domain.rst |  6 ++++++
>  drivers/base/regmap/regmap-irq.c          | 11 +++++------
>  include/linux/irqdomain.h                 |  8 +++++++-
>  kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
>  4 files changed, 33 insertions(+), 11 deletions(-)
> 
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


