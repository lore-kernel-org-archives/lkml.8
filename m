Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6DDC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3212063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgA3KBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:01:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:57775 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgA3KBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:01:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 02:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="262121220"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2020 02:01:02 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ix6dD-0004b9-Sn; Thu, 30 Jan 2020 12:01:03 +0200
Date:   Thu, 30 Jan 2020 12:01:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200130100103.GR32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200130090917.sg5vnwvlng4ox6ua@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130090917.sg5vnwvlng4ox6ua@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 10:09:17AM +0100, Petr Mladek wrote:
> On Mon 2020-01-27 13:47:19, Andy Shevchenko wrote:
> > Some consoles might require special operations on unregistering. For example,
> > serial console, when registered in the kernel, keeps power on for entire time,
> > until it gets unregistered. For such cases to have a balance we would provide
> > ->exit() callback.
> 
> Is there any plan to use this callback, please?
> 
> The console init, setup, registration code needs a clean up,
> definitely. If you plan some rework, I would like to understand
> the bigger picture before we start adding new callbacks.

Yes, as mentioned in the commit message I would like to use it for balancing
runtime PM reference counters in the UART code later on.

It will look like:

	->setup():
		pm_runtime_get(...);

	->exit():
		pm_runtime_put(...);

The current operations have no needs to be undone.

-- 
With Best Regards,
Andy Shevchenko


