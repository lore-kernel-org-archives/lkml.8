Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433DF2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHQLou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:44:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:33588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQLos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:44:48 -0400
IronPort-SDR: F5tImus1N4GBNkLglbn4Ctg0jpjMPxiUOoorL/f6LNyq2DNoR0/i2HMYRMSEPhTsMtRCemkfNo
 8f8eXV9S2lfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134199126"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134199126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 04:44:44 -0700
IronPort-SDR: bHApQlytgHJ6jq4V5bD6qw1c6k+ZY506s+KQj12iysHBxz7oQMzh1q8f6HPp17WTGF6XLOWLww
 Z9NOH4giSXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="326385168"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 04:44:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k7dZB-009IwK-Gv; Mon, 17 Aug 2020 14:44:41 +0300
Date:   Mon, 17 Aug 2020 14:44:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
Message-ID: <20200817114441.GK1891694@smile.fi.intel.com>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:53:03AM -0700, Joe Perches wrote:
> There is a print_vma_addr function used several places
> that requires KERN_CONT use.
> 
> Add a %pv mechanism to avoid the need for KERN_CONT.

I like the idea, but I would accent the selling point to make code
(in the user call sites) nicer.

> An example conversion is arch/x86/kernel/signal.c
> 
> from:
> 	if (show_unhandled_signals && printk_ratelimit()) {
> 		printk("%s"
> 		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx",
> 		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
> 		       me->comm, me->pid, where, frame,
> 		       regs->ip, regs->sp, regs->orig_ax);
> 		print_vma_addr(KERN_CONT " in ", regs->ip);
> 		pr_cont("\n");
> to:
> 		printk("%s"
> 		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx in %pv\n",
> 		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
> 		       me->comm, me->pid, where, frame,
> 		       regs->ip, regs->sp, regs->orig_ax, (void *)regs->ip);

...

> +#else
> +	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);
> +#endif

Can we avoid this spammy message? Really it's quite long and fills valuable
space in kernel buffer. I would rather print the hashed pointer as it's done
for the rest of %pXXX.

-- 
With Best Regards,
Andy Shevchenko


