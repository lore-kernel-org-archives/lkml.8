Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E82207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgH0MOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:14:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:50721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgH0LxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:53:02 -0400
IronPort-SDR: I0k0YF4ek32zFIlpUDfYcS1PI5oanqAcsMRtNwlcyoaebXeCK3lj3y6M1LBqodXZljAAkSFWmu
 2p0mpK8qTmYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="155722115"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="155722115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 04:52:55 -0700
IronPort-SDR: ug1usJ7p4y6iccl57ts+nkKCZh7yjIkFPh9ovPzETDP2GF8TG0jU+MUQGWl0ERFmRg57TT4ahi
 1pMOhqCPQtsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="329571977"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2020 04:52:53 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kBGSZ-00BoKb-EV; Thu, 27 Aug 2020 14:52:51 +0300
Date:   Thu, 27 Aug 2020 14:52:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 0/5] irqdomain: clean up, add
 irq_domain_create_legacy()
Message-ID: <20200827115251.GE1891694@smile.fi.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
 <20200726091202.GJ3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726091202.GJ3703480@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:12:02PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 08, 2020 at 07:21:30PM +0300, Andy Shevchenko wrote:
> > In order to make users OF independent provide irq_domain_create_legacy() API.
> > Last patch is an example of such user. First three patches are little cleanups.
> > 
> > Since regmap patch is dependent to what is now in regmap tree, I suggest to
> > create an immutable branch in IRQ domain tree and Mark can pull it and apply
> > the last one.
> 
> Marc, are you okay with the IRQ domain patches?

Marc, should I resend this? All dependencies are now resolved.

> > Andy Shevchenko (5):
> >   irqdomain: Remove unused of_device_id forward declaration
> >   irqdomain: Add forward declaration of fwnode_handle
> >   irqdomain: Replace open coded of_node_to_fwnode()
> >   irqdomain: Introduce irq_domain_create_legacy() API
> >   regmap: irq: Convert to use fwnode directly
> > 
> >  Documentation/core-api/irq/irq-domain.rst |  6 ++++++
> >  drivers/base/regmap/regmap-irq.c          | 11 +++++------
> >  include/linux/irqdomain.h                 |  8 +++++++-
> >  kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
> >  4 files changed, 33 insertions(+), 11 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


