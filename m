Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80119C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3932084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBDNlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:39784 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgBDNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 05:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="431525408"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2020 05:41:45 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iyySZ-0005Ac-1E; Tue, 04 Feb 2020 15:41:47 +0200
Date:   Tue, 4 Feb 2020 15:41:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] kernel.h: Split out mathematical helpers
Message-ID: <20200204134147.GC10400@smile.fi.intel.com>
References: <20190910105105.7714-1-andriy.shevchenko@linux.intel.com>
 <20191002171337.7cf1f48fde153382d7245fc5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002171337.7cf1f48fde153382d7245fc5@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:13:37PM -0700, Andrew Morton wrote:
> On Tue, 10 Sep 2019 13:51:05 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out mathematical
> > helpers.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  fs/nfs/callback_proc.c        |   1 +
> >  include/linux/bitops.h        |   3 +-
> >  include/linux/dcache.h        |   1 +
> >  include/linux/iommu-helper.h  |   1 +
> >  include/linux/kernel.h        | 143 --------------------------------
> >  include/linux/math.h          | 149 ++++++++++++++++++++++++++++++++++
> >  include/linux/rcu_node_tree.h |   2 +
> 
> I'm not really understanding how this works, apart from "dumb luck".

Looks like it right now.

> Random example: mm/percpu.c needs roundup(), so how does it include the
> new math.h?
> 
> ....... ./arch/x86/include/asm/uprobes.h
> ........ ./include/linux/notifier.h
> ......... ./include/linux/mutex.h
> ......... ./include/linux/srcu.h
> .......... ./include/linux/workqueue.h
> ........... ./include/linux/timer.h
> ............ ./include/linux/ktime.h
> ............. ./include/linux/time.h
> .............. ./include/linux/time32.h
> ............... ./include/linux/timex.h
> ................ ./include/uapi/linux/timex.h
> ................. ./include/linux/time.h
> ................ ./include/uapi/linux/param.h
> ................. ./arch/x86/include/generated/uapi/asm/param.h
> .................. ./include/asm-generic/param.h
> ................... ./include/uapi/asm-generic/param.h
> ................ ./arch/x86/include/asm/timex.h
> ................. ./arch/x86/include/asm/tsc.h
> ............. ./include/linux/jiffies.h
> .............. ./arch/x86/include/generated/uapi/asm/param.h
> .............. ./include/generated/timeconst.h
> ............. ./include/linux/timekeeping.h
> ............. ./include/linux/timekeeping32.h
> ............ ./include/linux/debugobjects.h
> .......... ./include/linux/rcu_segcblist.h
> .......... ./include/linux/srcutree.h
> ........... ./include/linux/rcu_node_tree.h
> ............ ./include/linux/math.h
> 
> oh, like that.

Long way to clean up this...

> It seems rather unreliable.  Perhaps a "#include <linux/math.h>" was
> intended in kernel.h?

Yeah, this needs to be done for time being in hope that it will be clearer in
the future. I'll do this in v2.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


