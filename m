Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A8AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E599222464
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgBDJFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:05:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:38191 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:05:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 01:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="403728065"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2020 01:05:32 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iyu9F-0002I6-Qs; Tue, 04 Feb 2020 11:05:33 +0200
Date:   Tue, 4 Feb 2020 11:05:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200204090533.GM32742@smile.fi.intel.com>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200204021620.GD41358@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204021620.GD41358@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:16:20AM +0900, Sergey Senozhatsky wrote:
> On (20/02/03 15:15), Andy Shevchenko wrote:
> > Static analyzer is not happy:
> > 
> > kernel/printk/printk.c:421:1: warning: symbol 'log_wait' was not declared. Should it be static?
> > 
> > This is due to usage of log_wait in the other module without announcing
> > its declaration to the world. I wasn't able to dug into deep history of
> > reasons why it is so, and thus decide to make less invasive change, i.e.
> > declaring log_wait as external variable to make static analyzer happy.
> 
> [..]
> 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 633f41a11d75..43b5cb88c607 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -418,7 +418,14 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
> >  	} while (0)
> >
> >  #ifdef CONFIG_PRINTK
> > +
> > +#ifdef CONFIG_PROC_FS
> > +extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
> >  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > +#else
> > +static DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > +#endif /* CONFIG_PROC_FS */
> 
> [..]
> 
> Since we are now introducing CONFIG_PROC_FS dependency to printk (and
> proc/kmsg already has CONFIG_PRINTK dependency),

I'm not sure I understood. The above does not introduce any dependencies.

>	then I guess I wouldn't
> mind it if fs/proc/kmsg would just relocate to printk, next to devksmg
> implementation. Just saying.

-- 
With Best Regards,
Andy Shevchenko


