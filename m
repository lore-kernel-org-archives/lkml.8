Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8428C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E602082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgA3NjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:39:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:28312 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3NjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:39:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 05:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="428366122"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2020 05:39:16 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ixA2Q-00075x-9E; Thu, 30 Jan 2020 15:39:18 +0200
Date:   Thu, 30 Jan 2020 15:39:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200130133918.GA32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
 <20200129134141.GA537@jagdpanzerIV.localdomain>
 <20200129142558.GF32742@smile.fi.intel.com>
 <20200130132246.qesf6bupt4m3jnue@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130132246.qesf6bupt4m3jnue@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:22:46PM +0100, Petr Mladek wrote:
> On Wed 2020-01-29 16:25:58, Andy Shevchenko wrote:
> > On Wed, Jan 29, 2020 at 10:41:41PM +0900, Sergey Senozhatsky wrote:
> > > On (20/01/28 11:44), Andy Shevchenko wrote:

...

> > > > > If the console was not registered (hence not enabled) is it still required
> > > > > to call ->exit()? Is there a requirement that ->exit() should handle such
> > > > > cases?
> > > > 
> > > > This is a good point. The ->exit() purpose is to keep balance for whatever
> > > > happened at ->setup().
> > > > 
> > > > But ->setup() is being called either when we have has_preferred == false or
> > > > when we got no matching we call it for all such consoles, till it returns an
> > > > error (can you elaborate the logic behind it?).
> > > 
> > > ->match() does alias matching and ->setup(). If alias matching failed,
> > > exact name match takes place. We don't call ->setup() for all consoles,
> > > but only for those that have exact name match:
> > > 
> > > 	if (strcmp(c->name, newcon->name) != 0)
> > > 		continue;
> > > 
> > > As to why we don't stop sooner in that loop - I need to to do some
> > > archaeology. We need to have CON_CONSDEV at proper place, which is
> > > IIRC the last matching console.
> > > 
> > > Pretty much every time we tried to change the logic we ended up
> > > reverting the changes.
> > 
> > I understand. Seems the ->setup() has to be idempotent. We can tell the same
> > for ->exit() in some comment.
> 
> I believe that ->setup() can succeesfully be called only once.
> It is tricky like hell:

Indeed. I think this code is highly starving for comments.

> 1st piece:
> 
> 	if (!has_preferred || bcon || !console_drivers)
> 		has_preferred = preferred_console >= 0;
> 
>   note:
> 
>      + "has_preferred" is updated here only when it was not "true" before.
>      + "has_preferred" is set to "true" here only when "preferred_console"
>        is set in __add_preferred_console()
> 
> 2nd piece:
> 
>   + __add_preferred_console() is called for console defined on
>     the command line. "preferred_console" points to the console
>     defined by the last "console=" parameter.
> 
> 3rd piece:
> 
>   + "has_preferred" is set to "true" later in register_console() when
>     a console with tty binding gets enabled.
> 
> 4th piece:
> 
>   + The code:
> 
> 	/*
> 	 *	See if we want to use this console driver. If we
> 	 *	didn't select a console we take the first one
> 	 *	that registers here.
> 	 */
> 	if (!has_preferred)
> 		... try to enable the given console
> 
>    The comment is a bit unclear. The code is used as a fallback
>    when no console was defined on the command line.
> 
>    Note that "has_preferred" is always true when "preferred_console"
>    was defined via command line, see 2nd piece above.
> 
> 
> By other words:
> 
>   + The fallback code (4th piece) is called only when
>     "preferred_console" was not defined on the command line.
> 
>   + The cycle below matches the given console only when
>     it was defined on the command line.
> 
> 
> As a result, I believe that ->setup() could never be called
> in both paths for the same console. Especially I think that
> fallback code should not be used when the console was defined on
> the command line.
> 
> I am not 100% sure but I am ready to risk this. Anyway, I think
> that many ->setup() callbacks are not ready to be successfully
> called twice.
> 
> (Sigh, I have started to clean up this code two years ago.
> But I have never found time to finish the patchset. It is
> such a huge mess.)

Thanks for the elaboration in such details!

> > Can you describe, btw, struct console in kernel doc format?
> > It will be very helpful!
> > 
> > > > In both cases we will get the console to have CON_ENABLED flag set.
> > > 
> > > And there are sneaky consoles that have CON_ENABLED before we even
> > > register them.
> > 
> > So, taking into consideration my comment to the previous patch, what would be
> > suggested guard here?
> > 
> > For a starter something like this?
> > 
> >   if ((console->flags & CON_ENABLED) && console->exit)
> > 	console->exit(console);
> 
> I would do:
> 
> 	if (!res && console->exit)
> 		console->exit(console);
> 
> I mean. I would call ->exit() only when console->setup() succeeded in
> register_console(). In this case, the console was later added to
> the console_drivers list.

Yes, that is exactly what I meant in previous mails to you.

-- 
With Best Regards,
Andy Shevchenko


