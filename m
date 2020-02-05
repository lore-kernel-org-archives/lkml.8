Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A65C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941762082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgBELRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:17:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:2567 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBELRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:17:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 03:17:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="254733294"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2020 03:17:20 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1izIgL-0001Mk-Rp; Wed, 05 Feb 2020 13:17:21 +0200
Date:   Wed, 5 Feb 2020 13:17:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] kernel.h: Split out min()/max() et al helpers
Message-ID: <20200205111721.GI10400@smile.fi.intel.com>
References: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
 <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
 <ee9b52c291fe7f090d6516397db978eaaae6c657.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9b52c291fe7f090d6516397db978eaaae6c657.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 05:17:36PM -0800, Joe Perches wrote:
> On Wed, 2020-02-05 at 00:23 +0100, Rasmus Villemoes wrote:
> > On 04/02/2020 18.04, Andy Shevchenko wrote:
> > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > Here is the attempt to start cleaning it up by splitting out min()/max()
> > > et al helpers.
> > > 
> > > At the same time convert users in header and lib folder to use new header.
> > > Though for time being include new header back to kernel.h to avoid twisted
> > > indirected includes for existing users.
> > 
> > This is definitely long overdue, so thanks for taking this on. I think
> > minmax.h is fine as a header on its own, but for the other one, I think
> > you should go even further - and perhaps all these should go in a
> > include/math/ dir (include/linux/ has ~1200 files), so we'd have
> > math/minmax.h, math/round.h, math/ilog2.h, math/gcd.h etc., each
> > containing just enough #includes to be self-contained (so if there's a
> > declaration of something taking a u32, there's no way around having it
> > include types.h (or wherever that's defined).
> 
> I think that's not at all desirable.

device.h has been recently split to a 4 files (by Linus [old] request).
Any comments on that?

> kernel.h as a monolithic include block is pretty useful.
> 
> Separating out the various bits into separate files is
> OK, but kernel.h should #include them all.

That's fine but should not make people think this is a good idea to include
only one header to their modules.

> One day a precompiled header of just kernel.h would be
> useful to reduce overall compilation time.

All years no change.

> Converting
> all the other source files that use a small part of the
> existing kernel.h into multiple includes would not allow
> precompiled headers to work efficiently.


-- 
With Best Regards,
Andy Shevchenko


