Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC80C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA7206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCMIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:50:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:25284 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgCMIuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:50:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 01:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="232355751"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2020 01:50:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCg1W-009Dnb-Cb; Fri, 13 Mar 2020 10:50:30 +0200
Date:   Fri, 13 Mar 2020 10:50:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        grant.likely@arm.com, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/3] driver core: Break infinite loop when deferred
 probe can't be satisfied
Message-ID: <20200313085030.GO1922688@smile.fi.intel.com>
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
 <ad68e006-8a9f-7183-6313-77a5fc3f18f2@ti.com>
 <20200312105402.GU1922688@smile.fi.intel.com>
 <3b0586f4-0af4-3a17-7a4b-e73910f66bff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0586f4-0af4-3a17-7a4b-e73910f66bff@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 09:35:55AM +0200, Peter Ujfalusi wrote:
> On 12/03/2020 12.54, Andy Shevchenko wrote:
> > On Wed, Mar 11, 2020 at 10:32:32AM +0200, Peter Ujfalusi wrote:
> >> On 09/03/2020 16.11, Andy Shevchenko wrote:

...

> >> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Thank you, Peter!
> > 
> > Yes, under "successful probe" we understand the one that has stayed probed
> > after the deferred trigger cycle. That's why a decrement counter is essential
> > to make this scheme work.
> > 
> > Ideally I would like to get Grant's comment on / test of this...
> 
> I fixed up Grant's email address to get his attention you are seeking for...

Ah, thank you!

How can I forget that he moved to ARM while ago? Grant, I may re-send series
with your address corrected if it feels better to you.

-- 
With Best Regards,
Andy Shevchenko


