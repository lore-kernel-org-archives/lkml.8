Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDEC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47FE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgA0JoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:44:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:63991 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbgA0JoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:44:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 01:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="251895501"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2020 01:44:03 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iw0w8-0001tp-LF; Mon, 27 Jan 2020 11:44:04 +0200
Date:   Mon, 27 Jan 2020 11:44:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] console: Don't perform test for CON_BRL flag twice
Message-ID: <20200127094404.GT32742@smile.fi.intel.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
 <20200127024114.GC100275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127024114.GC100275@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:41:14AM +0900, Sergey Senozhatsky wrote:
> On (20/01/24 17:57), Andy Shevchenko wrote:
> [..]
> > +++ b/drivers/accessibility/braille/braille_console.c
> > @@ -369,10 +369,10 @@ int braille_register_console(struct console *console, int index,
> >  
> >  int braille_unregister_console(struct console *console)
> >  {
> > -	if (braille_co != console)
> > -		return -EINVAL;
> >  	if (!(console->flags & CON_BRL))
> >  		return 0;
> > +	if (braille_co != console)
> > +		return -EINVAL;
> >  	unregister_keyboard_notifier(&keyboard_notifier_block);
> >  	unregister_vt_notifier(&vt_notifier_block);
> >  	braille_co = NULL;
> > diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> > index 17a9591e54ff..2ec42173890f 100644
> > --- a/kernel/printk/braille.c
> > +++ b/kernel/printk/braille.c
> > @@ -51,8 +51,5 @@ _braille_register_console(struct console *console, struct console_cmdline *c)
> >  int
> >  _braille_unregister_console(struct console *console)
> >  {
> > -	if (console->flags & CON_BRL)
> > -		return braille_unregister_console(console);
> > -
> > -	return 0;
> > +	return braille_unregister_console(console);
> >  }
> 
> Hmm, I don't know. This moves sort of important code from common upper
> layer down to particular driver implementation. Should there be another
> driver/super-braille.c it must test CON_BRL flag as well.
> Because printk invokes _braille_unregister_console() unconditionally,
> and _braille_unregister_console() unconditionally calls into the driver.
> 
> I guess we can remove CON_BRL from braille_unregister_console() instead,
> because printk tests it.

Let me do that way, thanks!

-- 
With Best Regards,
Andy Shevchenko


