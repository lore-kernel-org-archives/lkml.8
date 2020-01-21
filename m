Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD651C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17E221569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAURAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:00:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:51940 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgAURA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:00:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 09:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="280112750"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 21 Jan 2020 09:00:23 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 21 Jan 2020 19:00:22 +0200
Date:   Tue, 21 Jan 2020 19:00:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/38] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200121170022.GA2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121162157.GD4656@sirena.org.uk>
 <20200121163312.GZ2665@lahna.fi.intel.com>
 <20200121164515.GG4656@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121164515.GG4656@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:45:15PM +0000, Mark Brown wrote:
> On Tue, Jan 21, 2020 at 06:33:12PM +0200, Mika Westerberg wrote:
> 
> > Sorry about that. I included you because there was suggestion from Lee
> > to convert the MFD driver in patch 37 to use regmap but the registers
> > are all 64-bit and it was not clear whether regmap supports that:
> 
> >   https://www.spinics.net/lists/platform-driver-x86/msg20652.html
> 
> > Looking at the regmap API it seems to deal mostly with "unsigned int"
> > which does not work well with the 64-bit MMIO registers but I may be
> > missing something.
> 
> It should work fine on architectures with 64 bit ints but otherwise it's
> not supported (and doing so would hurt the API pretty badly so I'm not
> sure it would make sense but patches welcome).

OK, thanks for the clarification. I guess in this case we can probably
just live without using it, if that's fine for Lee and others. The new
MFD driver itself is ~500 lines so not sure how much regmap would help
there, and we only expose two simple functions for the subdevices both
dealing with 64-bit registers.
