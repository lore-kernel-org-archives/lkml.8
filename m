Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E00C3B188
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AAB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgBKMyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:54:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:39917 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBKMye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:54:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 04:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226494130"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2020 04:54:31 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1V3h-000kFh-9o; Tue, 11 Feb 2020 14:54:33 +0200
Date:   Tue, 11 Feb 2020 14:54:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 1/7] console: Don't perform test for CON_BRL flag
Message-ID: <20200211125433.GB10400@smile.fi.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
 <20200204013426.GB41358@google.com>
 <20200211113213.eaftwrq3tbt3rjwo@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211113213.eaftwrq3tbt3rjwo@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:32:13PM +0100, Petr Mladek wrote:
> On Tue 2020-02-04 10:34:26, Sergey Senozhatsky wrote:
> > On (20/02/03 15:31), Andy Shevchenko wrote:
> > > 
> > > We don't call braille_register_console() without CON_BRL flag set.
> > > And the _braille_unregister_console() already tests for console to have
> > > CON_BRL flag. No need to repeat this in braille_unregister_console().
> > > 
> > > Drop the repetitive checks from Braille console driver.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > Looks good to me overall
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The entire patchset has been commited into printk.git,
> branch for-5.7-console-exit

Thank you, Petr!

-- 
With Best Regards,
Andy Shevchenko


