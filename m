Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C05222D9
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGTty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:49:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:38023 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGTty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:49:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 11:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="255511597"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2020 11:49:50 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j09dP-0003vS-8y; Fri, 07 Feb 2020 21:49:51 +0200
Date:   Fri, 7 Feb 2020 21:49:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        christopher.s.hall@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        jacob.e.keller@intel.com,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, sean.v.kelley@intel.com
Subject: Re: [Intel PMC TGPIO Driver 5/5] drivers/ptp: Add PMC Time-Aware
 GPIO Driver
Message-ID: <20200207194951.GM10400@smile.fi.intel.com>
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
 <20191211214852.26317-6-christopher.s.hall@intel.com>
 <CACRpkdbi7q5Vr2Lt12eirs3Z8GLL2AuLLrAARCHkYEYgKbYkHg@mail.gmail.com>
 <20200207172844.GC19213@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207172844.GC19213@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 06:28:44PM +0100, Andrew Lunn wrote:
> On Fri, Feb 07, 2020 at 06:10:46PM +0100, Linus Walleij wrote:
> > OK this looks like some GPIO registers...
> > 
> > Then there is a bunch of PTP stuff I don't understand I suppose
> > related to the precision time protocol.
> 
> Hi Linus
> 
> I understand your confusion. The first time this was posted to netdev,
> i asked it to be renamed because it has very little to do with GPIO
> 
> https://lore.kernel.org/netdev/20190719132021.GC24930@lunn.ch/

And besides that I didn't see it in internal review list, so, it needs to be
very carefully reviewed. I already saw some not good formatted and questionable
code.

-- 
With Best Regards,
Andy Shevchenko


