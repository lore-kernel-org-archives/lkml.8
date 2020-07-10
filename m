Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6018E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGJLqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:46:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:19721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgGJLqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:46:23 -0400
IronPort-SDR: FSIaHJk/SSQs14a67gHdGc5VCA1suTwuA0jmcYv3QNz0t5xgSXLoU1dlBcIgjayGlTO9mkXkl2
 1J+mebwCxMHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149652834"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="149652834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 04:46:23 -0700
IronPort-SDR: 3kkvFIOEyUAJ/q83noeOkqKBJYC2Nk8LtP/UQ/ZtIRuC3T+zYZv9xMeRI7hETnswjFAJaeOqMQ
 69/iJ2uH4m6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="358814673"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2020 04:46:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtrTy-0012uw-Uv; Fri, 10 Jul 2020 14:46:22 +0300
Date:   Fri, 10 Jul 2020 14:46:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710114622.GJ3703480@smile.fi.intel.com>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710110132.GA5653@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:01:32PM +0100, Mark Brown wrote:
> On Fri, Jul 10, 2020 at 01:05:58PM +0300, Andy Shevchenko wrote:
> 
> > Hmm... Can you point out to where is it? I have rebased my branches on top of
> > Linux Next daily and my patch still valid.
> 
> It's in the regmap tree, -next only gets built once per day so you might
> not see something in there for two days.

You mean it's being synchronised with git.kernel.org, but not yet contains that
patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).

-- 
With Best Regards,
Andy Shevchenko


