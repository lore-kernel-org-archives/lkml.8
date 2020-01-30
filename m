Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1032C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B951206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA3NPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:15:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:37750 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3NPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:15:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 05:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="232923285"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2020 05:14:26 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ix9eN-0006n1-MV; Thu, 30 Jan 2020 15:14:27 +0200
Date:   Thu, 30 Jan 2020 15:14:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200130131427.GZ32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
 <20200129134141.GA537@jagdpanzerIV.localdomain>
 <20200129142558.GF32742@smile.fi.intel.com>
 <20200129151243.GA488@jagdpanzerIV.localdomain>
 <20200129165053.GA392@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129165053.GA392@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:50:53AM +0900, Sergey Senozhatsky wrote:
> On (20/01/30 00:12), Sergey Senozhatsky wrote:
> > On (20/01/29 16:25), Andy Shevchenko wrote:
> > > I understand. Seems the ->setup() has to be idempotent. We can tell the same
> > > for ->exit() in some comment.
> > > 
> > > Can you describe, btw, struct console in kernel doc format?
> > > It will be very helpful!
> > 
> > We probably need some documentation.
> > 
> > > > > In both cases we will get the console to have CON_ENABLED flag set.
> > > > 
> > > > And there are sneaky consoles that have CON_ENABLED before we even
> > > > register them.
> > > 
> > > So, taking into consideration my comment to the previous patch, what would be
> > > suggested guard here?
> > > 
> > > For a starter something like this?
> > > 
> > >   if ((console->flags & CON_ENABLED) && console->exit)
> > > 	console->exit(console);
> > 
> > This will work if we also add something like this
> 
> No, wait... This will not work, console can be suspended, yet
> still registered. I think the only criteria is "the console is
> on the list".

Okay, I guess we need to drop CON_ENABLE bits from this patch and
rely on the res value instead.

-- 
With Best Regards,
Andy Shevchenko


