Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCAA2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgE0QFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:05:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:37036 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389399AbgE0QFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:05:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 397938030809;
        Wed, 27 May 2020 16:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ATcAqjDKPk9D; Wed, 27 May 2020 19:05:36 +0300 (MSK)
Date:   Wed, 27 May 2020 19:05:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/11] i2c: designware: Add Baytrail sem config DW I2C
 platform dependency
Message-ID: <20200527160536.g5lortlahlaxxctq@mobilestation>
References: <20200527153046.6172-1-Sergey.Semin@baikalelectronics.ru>
 <20200527153046.6172-7-Sergey.Semin@baikalelectronics.ru>
 <20200527155533.GJ1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200527155533.GJ1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:55:33PM +0300, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 06:30:41PM +0300, Serge Semin wrote:
> > Currently Intel Baytrail I2C semaphore is a feature of the DW APB I2C
> > platform driver. It's a bit confusing to see it's config in the menu at
> > some separated place with no reference to the platform code. Let's move the
> > config definition to be below the I2C_DESIGNWARE_PLATFORM config and mark
> > it with "depends on I2C_DESIGNWARE_PLATFORM" statement. By doing so the
> > config menu will display the feature right below the DW I2C platform
> > driver item and will indent it to the right so signifying its belonging.
> 
> Same comment as per previous version.
> 
> >  config I2C_DESIGNWARE_BAYTRAIL
> >  	bool "Intel Baytrail I2C semaphore support"
> >  	depends on ACPI
> > +	depends on I2C_DESIGNWARE_PLATFORM
> >  	depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
> >  		   (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
> 
> i.e. this change is not needed.

See my response to you in the previous version.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
