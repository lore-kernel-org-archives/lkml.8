Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C29208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgFPQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:32:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:22596 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgFPQcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:32:53 -0400
IronPort-SDR: WOq2sdQ2x/P0CmEBDU7B6XQKw7kfmNpPBypUoQZ3tXOccacJ95edRNGo1Umf/nRJgFHmXscBii
 7tHvbdWF7aug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 09:32:52 -0700
IronPort-SDR: /ufzMPhmSvZHJPN0HXfB/setWDjkZcQFuZwxb2zVxNxOudFCcXKRN1XF9XqiYp7FCrc8lhdo1w
 fZ9FgJpRA1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="317270789"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2020 09:32:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlEW4-00DsCM-L6; Tue, 16 Jun 2020 19:32:52 +0300
Date:   Tue, 16 Jun 2020 19:32:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
Message-ID: <20200616163252.GX2428291@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
 <5551ac7d9c7ba7df2b44832af49b3744869b34ef.camel@suse.de>
 <20200616161346.GW2428291@smile.fi.intel.com>
 <cabeb88787e032d0b241369884720b410142f72b.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabeb88787e032d0b241369884720b410142f72b.camel@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:22:17PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2020-06-16 at 19:13 +0300, Andy Shevchenko wrote:
> > On Tue, Jun 16, 2020 at 05:53:23PM +0200, Nicolas Saenz Julienne wrote:
> > > On Wed, 2020-04-15 at 20:00 +0300, Andy Shevchenko wrote:
> > > > Use %ptT instead of open coded variant to print content of
> > > > time64_t type in human readable format.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > 
> > > as originally reported by Stefan Wahren, this patch is likely to be the
> > > cause
> > > for a regression on RPi3b+ 32bit mode (multi_v7_defconfig,
> > > 5.8.0-rc1-00019-ga5dc8300df75):
> > > 
> > > [    3.759892] raspberrypi-firmware soc:firmware: Attached to firmware from
> > > 18446744073709048425-02-19T15:52:16
> > > 
> > > Whereas the same doesn't seem to happen in 64bit mode:
> > > 
> > > [    1.584126] raspberrypi-firmware soc:firmware: Attached to firmware from
> > > 2020-02-12T12:39:27
> > 
> > Had you chance to run test_printf on that machine and see if it reports any
> > failure?
> > If no, can you provide a raw date which makes this happen?
> > 
> > Ah, I think I have an idea what is going on... stay tuned!
> > 
> > Does below fix it?
> 
> Yes :)

Patch has been just sent. I hope it can go via printk tree, because MAINTAINERS keeps silent for this file.

-- 
With Best Regards,
Andy Shevchenko


