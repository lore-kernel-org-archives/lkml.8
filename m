Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9260C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A515C20857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbgDOO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:59:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:18191 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbgDOO65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:58:57 -0400
IronPort-SDR: 3/gF7GTae38S6c8CkXV6wIrkRto8jmU9A1sR9RKxUjhTCH4+BhspqVeYJBWpSk6N3eh/TiKsh9
 jJLYczd082IQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:58:56 -0700
IronPort-SDR: dkZtWpvxmvZ7RSL4z8/dEvJY1cCwOWybYUhtuuikfEQD5huJE0MicKOsO+ktpdYFj5XzOMK4rQ
 Dz7NGPiAPNlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="273642239"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2020 07:58:53 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jOjV9-000oIL-KN; Wed, 15 Apr 2020 17:58:55 +0300
Date:   Wed, 15 Apr 2020 17:58:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/5] memremap: Check for size parameter
Message-ID: <20200415145855.GM185537@smile.fi.intel.com>
References: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
 <20191116162937.GA23951@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116162937.GA23951@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 05:29:37PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 08:00:40PM +0200, Andy Shevchenko wrote:
> > There is no use of memremap() to be called with size = 0.
> > Simple return NULL pointer and allow callers to drop this check.
> 
> Given that this really is an error condition, maybe a WARN_ON_ONCE
> would fit here?

It appears some users are using defensive programming and rely simple on error
code. I dunno if they are really expect to have size == 0 in some (non-fatal)
cases.

-- 
With Best Regards,
Andy Shevchenko


