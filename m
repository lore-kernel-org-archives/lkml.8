Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884BE2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA3NNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:13:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:5950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3NNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:13:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 05:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="430017974"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2020 05:13:28 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ix9dS-0006mR-1Q; Thu, 30 Jan 2020 15:13:30 +0200
Date:   Thu, 30 Jan 2020 15:13:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200130131330.GY32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
 <20200130090428.f5lrkxclnmuegqxw@pathway.suse.cz>
 <20200130095807.GQ32742@smile.fi.intel.com>
 <20200130122226.u4qsa53a3cbwdcpt@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130122226.u4qsa53a3cbwdcpt@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:22:26PM +0100, Petr Mladek wrote:
> On Thu 2020-01-30 11:58:07, Andy Shevchenko wrote:
> > On Thu, Jan 30, 2020 at 10:04:29AM +0100, Petr Mladek wrote:

...

> > Okay, I understand that for time being it's matter of how eloquent
> > the commit message will be. (And maybe some comments in the code?)
> > Is it correct?
> 
> Good question.
> 
> Please, remove the last hunk if Sergey is not against it.
> I think that the success/error should not depend on the state
> of CON_ENABLED flag.

If I understood his last message correctly, he is exactly in favour of not
using it (and thus changing conditional for ->exit() callback to rely only
on res value).

> The other two changes might stay in the same patch. We just need
> to make the commit message easier to understand. I would write
> something like:

Thanks! Will do this way.

> <begin>
> There are only two callers that use the returned code from
> unregister_console():
> 
>   + unregister_early_console() in arch/m68k/kernel/early_printk.c
>   + kgdb_unregister_nmi_console() in drivers/tty/serial/kgdb_nmi.c
> 
> They both expect to get "0" on success and a non-zero value on error.
> But the current behavior is confusing and buggy:
> 
>   + _braille_unregister_console() returns "1" on success
>   + unregister_console() returns "1" on error
> 
> Fix and clean up the behavior:
> 
>   + Return success when _braille_unregister_console() succeeded.
>   + Return a meaningful error code when the console was not
>     registered before.
> </end>

-- 
With Best Regards,
Andy Shevchenko


