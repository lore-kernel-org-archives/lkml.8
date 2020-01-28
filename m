Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB669C35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB8D24686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA1KDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:03:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:16797 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1KDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:03:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 01:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="217569900"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2020 01:52:36 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iwNXx-0007OL-MW; Tue, 28 Jan 2020 11:52:37 +0200
Date:   Tue, 28 Jan 2020 11:52:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200128095237.GZ32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
 <20200128044332.GA115889@google.com>
 <20200128092235.GX32742@smile.fi.intel.com>
 <20200128093726.GE115889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128093726.GE115889@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:37:26PM +0900, Sergey Senozhatsky wrote:
> On (20/01/28 11:22), Andy Shevchenko wrote:
> > On Tue, Jan 28, 2020 at 01:43:32PM +0900, Sergey Senozhatsky wrote:
> > > On (20/01/27 13:47), Andy Shevchenko wrote:
> > > [..]
> > > >  	res = _braille_unregister_console(console);
> > > > -	if (res)
> > > > +	if (res < 0)
> > > >  		return res;
> > > > +	if (res > 0)
> > > > +		return 0;
> > > >  
> > > > -	res = 1;
> > > > +	res = -ENODEV;
> > > >  	console_lock();
> > > >  	if (console_drivers == console) {
> > > >  		console_drivers=console->next;
> > > > @@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
> > > >  	if (!res && (console->flags & CON_EXTENDED))
> > > >  		nr_ext_console_drivers--;
> > > >  
> > > > +	if (res && !(console->flags & CON_ENABLED))
> > > > +		res = 0;
> > > 
> > > Console is not on the console_drivers list. Why does !ENABLED case
> > > require extra handling?
> > 
> > It's mirroring (to some extend) the register_console() abort conditions.
> 
> Could you please explain?
> 
> I see the "newcon->flags & CON_ENABLED" error out path. I'm guessing,
> that the expectation is that this is how we filter out consoles which
> were not matched (there is that "newcon->flags |= CON_ENABLED" several
> lines earlier.) So this looks like the assumption is that consoles don't
> have CON_ENABLED bit set prior to register_console(), as far as I understand.

I put it to cover the case when register_console() fails (since it has no
return code caller is not able to say this anyhow) somebody may call
unregister_console() on it unconditionally (and I guess many do like this).
In such case we shouldn't return an error code.

> Well, look at these
> ...
> drivers/net/netconsole.c:       .flags  = CON_ENABLED,
> drivers/tty/ehv_bytechan.c:     .flags  = CON_PRINTBUFFER | CON_ENABLED,
> drivers/tty/serial/mux.c:	.flags = CON_ENABLED | CON_PRINTBUFFER,
> ...

The code there (I meant register_console() and unregister_console() and
their usage) is quite twisted and probably abused, so, I have definitely
miss something.

-- 
With Best Regards,
Andy Shevchenko


