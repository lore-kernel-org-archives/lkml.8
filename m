Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB25A20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgA2OZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:25:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:34184 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgA2OZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:25:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 06:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="232457423"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2020 06:25:56 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iwoI2-00034u-7w; Wed, 29 Jan 2020 16:25:58 +0200
Date:   Wed, 29 Jan 2020 16:25:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200129142558.GF32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
 <20200129134141.GA537@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129134141.GA537@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:41:41PM +0900, Sergey Senozhatsky wrote:
> On (20/01/28 11:44), Andy Shevchenko wrote:
> > > If the console was not registered (hence not enabled) is it still required
> > > to call ->exit()? Is there a requirement that ->exit() should handle such
> > > cases?
> > 
> > This is a good point. The ->exit() purpose is to keep balance for whatever
> > happened at ->setup().
> > 
> > But ->setup() is being called either when we have has_preferred == false or
> > when we got no matching we call it for all such consoles, till it returns an
> > error (can you elaborate the logic behind it?).
> 
> ->match() does alias matching and ->setup(). If alias matching failed,
> exact name match takes place. We don't call ->setup() for all consoles,
> but only for those that have exact name match:
> 
> 	if (strcmp(c->name, newcon->name) != 0)
> 		continue;
> 
> As to why we don't stop sooner in that loop - I need to to do some
> archaeology. We need to have CON_CONSDEV at proper place, which is
> IIRC the last matching console.
> 
> Pretty much every time we tried to change the logic we ended up
> reverting the changes.

I understand. Seems the ->setup() has to be idempotent. We can tell the same
for ->exit() in some comment.

Can you describe, btw, struct console in kernel doc format?
It will be very helpful!

> > In both cases we will get the console to have CON_ENABLED flag set.
> 
> And there are sneaky consoles that have CON_ENABLED before we even
> register them.

So, taking into consideration my comment to the previous patch, what would be
suggested guard here?

For a starter something like this?

  if ((console->flags & CON_ENABLED) && console->exit)
	console->exit(console);


-- 
With Best Regards,
Andy Shevchenko


