Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7920C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8109214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBFLcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:32:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:53596 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgBFLcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:32:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 03:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="232017090"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 03:32:49 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1izfOs-0007k3-NS; Thu, 06 Feb 2020 13:32:50 +0200
Date:   Thu, 6 Feb 2020 13:32:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] kernel.h: Split out min()/max() et al helpers
Message-ID: <20200206113250.GV10400@smile.fi.intel.com>
References: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
 <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 12:23:53AM +0100, Rasmus Villemoes wrote:
> On 04/02/2020 18.04, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out min()/max()
> > et al helpers.
> > 
> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> This is definitely long overdue, so thanks for taking this on. I think
> minmax.h is fine as a header on its own, but for the other one, I think
> you should go even further - and perhaps all these should go in a
> include/math/ dir (include/linux/ has ~1200 files), so we'd have
> math/minmax.h, math/round.h, math/ilog2.h, math/gcd.h etc., each
> containing just enough #includes to be self-contained (so if there's a
> declaration of something taking a u32, there's no way around having it
> include types.h (or wherever that's defined).

While I like the idea, I think we may do it in a next iteration.

-- 
With Best Regards,
Andy Shevchenko


