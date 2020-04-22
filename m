Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A2C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877582076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDVPoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:44:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:32121 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgDVPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:44:01 -0400
IronPort-SDR: EkJZ5xH3CsMZl2nxn0B62GL0E6bODK3BPqvEiXgJ0/W4T8wZfnrV7fiVaHw2HDeIZKS17phkdn
 yh1ragYfSqPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 08:44:01 -0700
IronPort-SDR: uacoHrS/75vy0fPWVfYZWr90WFuxiU1gdrPpxIteIEZyoAgjFdEtLcjloN+lDtgm0kwddB598v
 0XaXqF7klQ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,303,1583222400"; 
   d="scan'208";a="334662350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2020 08:43:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jRHXe-002TBj-6x; Wed, 22 Apr 2020 18:44:02 +0300
Date:   Wed, 22 Apr 2020 18:44:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 4/7] kernel.h: Split out min()/max() et al helpers
Message-ID: <20200422154402.GK185537@smile.fi.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
 <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
 <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:52:32AM -0700, Joe Perches wrote:
> On Wed, 2020-04-22 at 15:51 +0300, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out min()/max()
> > et al helpers.
> 
> While adding organization into kernel.h by splitting
> out various bits into separate files is a fine idea,
> I believe removing the generic #include <linux/kernel.h>
> from various files and substituting the sub-includes
> is not a good idea.

Are you sure?

> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> Yeah, that's the difficult bit and it could make
> using precompiled headers very cumbersome.
> 
> I'd rather make #include <linux/kernel.h>" _more_
> common or even used as the mandatory first #include
> for all kernel .c files.

Huh?

Perhaps we may just cat include/linux/* > include/linux/kernel.h?

> That would also ensure that common kernel facilities
> are not duplicated or have naming conflicts with other
> files.

-- 
With Best Regards,
Andy Shevchenko


