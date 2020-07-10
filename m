Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5251420772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGJKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:05:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:46072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJKF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:05:59 -0400
IronPort-SDR: 9/i5u3oKHWNNxDEec0H4V6ShRkcY9yGdRMiBcTcNnNNe7j7EWKwuCrzwxCDPI6NzX0xlZhzigo
 undLX7B4xXTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148165949"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="148165949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 03:05:58 -0700
IronPort-SDR: B9FLR4IeGAqPStemj5BUQ5cQEWK4msFG0pOdkuwbIlK9wl+6G9H38Go942Ceq/RfZD3uLp3vBL
 fnBPVzrhnW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="389453118"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2020 03:05:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtpuo-00124w-HJ; Fri, 10 Jul 2020 13:05:58 +0300
Date:   Fri, 10 Jul 2020 13:05:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710100558.GI3703480@smile.fi.intel.com>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708162117.GV4655@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:21:17PM +0100, Mark Brown wrote:
> On Wed, Jul 08, 2020 at 07:12:32PM +0300, Andy Shevchenko wrote:
> > Make regmap firmware node type agnostic by switching it to use fwnode.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is a duplicate of a patch already applied.

Hmm... Can you point out to where is it? I have rebased my branches on top of
Linux Next daily and my patch still valid.

-- 
With Best Regards,
Andy Shevchenko


