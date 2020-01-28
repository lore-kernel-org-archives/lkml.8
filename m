Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5499C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46EE24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgA1JXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:23:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:38327 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgA1JXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:23:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 01:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="429274093"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2020 01:22:34 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iwN4t-00077h-Td; Tue, 28 Jan 2020 11:22:35 +0200
Date:   Tue, 28 Jan 2020 11:22:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200128092235.GX32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
 <20200128044332.GA115889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128044332.GA115889@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 01:43:32PM +0900, Sergey Senozhatsky wrote:
> On (20/01/27 13:47), Andy Shevchenko wrote:
> [..]
> >  	res = _braille_unregister_console(console);
> > -	if (res)
> > +	if (res < 0)
> >  		return res;
> > +	if (res > 0)
> > +		return 0;
> >  
> > -	res = 1;
> > +	res = -ENODEV;
> >  	console_lock();
> >  	if (console_drivers == console) {
> >  		console_drivers=console->next;
> > @@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
> >  	if (!res && (console->flags & CON_EXTENDED))
> >  		nr_ext_console_drivers--;
> >  
> > +	if (res && !(console->flags & CON_ENABLED))
> > +		res = 0;
> 
> Console is not on the console_drivers list. Why does !ENABLED case
> require extra handling?

It's mirroring (to some extend) the register_console() abort conditions.

> What about the case when console is ENABLED
> but still not registered?

What about when console is ENABLED and we call register_console()?
I think you can tell me what to do in these corner cases (however,
that's not the point of this series).

> I think that if the console is not on the list (was never registered)
> then we can just bail out, without console_sysfs_notify(), etc. IOW,
> 
> 	if (res) {
> 		console->flags &= ~CON_ENABLED; /* just in case */
> 		console_unlock();
> 		return res;
> 	}

Perhaps. But see above. I would rather drop this condition for now
for sake of this series being to the point.

-- 
With Best Regards,
Andy Shevchenko


