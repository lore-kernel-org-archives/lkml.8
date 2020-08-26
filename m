Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A60E20825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgHZPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:55:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:18824 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgHZPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:55:10 -0400
IronPort-SDR: zgFv1I5c4/t1Q8NdD/Ix5F+zSFXgO9th07AHnI7ZPgD7OVEr+rV/ffbB0PQaLXYFK1gYkFlzpT
 NMiIoHkdgg9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="143985066"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="143985066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:55:10 -0700
IronPort-SDR: fvLsOD2XMoMTI8CwlzG9v6oMPe4Fs+jHmWvidaxwI72ZZBN5XcXQpqYJHNWk7bGswAONcg0riO
 RX+QyS6HboJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="329271341"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 08:55:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAxlT-00BbMf-25; Wed, 26 Aug 2020 18:55:07 +0300
Date:   Wed, 26 Aug 2020 18:55:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
Message-ID: <20200826155507.GV1891694@smile.fi.intel.com>
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:

...

> > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> 
> Generally, the __must_check should go before the return type
> and the extern isn't necessary and is also generally not used
> in device.h, so I'd prefer:
> 
> __printf(3, 4)
> __must_check int dev_err_probe(...);

I grepped the current code... I don't see support of your preference.
Maybe I missed something? (I'm talking about include/*)

-- 
With Best Regards,
Andy Shevchenko


