Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AC52173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCBQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:37:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:59458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgCBQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:37:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 08:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="233422345"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2020 08:37:09 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8o46-006J9M-Vu; Mon, 02 Mar 2020 18:37:10 +0200
Date:   Mon, 2 Mar 2020 18:37:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/19] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200302163710.GI1224808@smile.fi.intel.com>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
 <20200302142621.GB3494@dell>
 <20200302143803.GI2667@lahna.fi.intel.com>
 <20200302151924.GC3494@dell>
 <20200302154205.GF1224808@smile.fi.intel.com>
 <20200302155716.GD3494@dell>
 <20200302160746.GF2540@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302160746.GF2540@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:07:46PM +0200, Mika Westerberg wrote:
> On Mon, Mar 02, 2020 at 03:57:16PM +0000, Lee Jones wrote:
> > > This series has dependencies to PDx86 (as mentioned in cover letter).
> > > 
> > > What do you prefer then, me to:
> > > a) prepare ib from what I have, then you take it followed by me taking your ib, or
> > > b) take everything and prepare ib for you?
> > 
> > Either would be fine by me.
> 
> I would prefer these to go through pdx86 because of the dependency.
> 
> > What kind of dependencies are they?  Are they protected by Kconfig
> > options?  Another way of asking that would be to say, would this set
> > throw build errors if I tried to apply and build it or would it just
> > refuse to compile?
> 
> They do not apply cleanly because linux-platform-drivers-x86.git/for-next
> re-organizes Kconfig and Makefile entries. I think they should still
> build fine, though.

So, then it's third possible way, to build this on top of MFD next followed by
importing an ib to PDx86 with conflict resolution.

-- 
With Best Regards,
Andy Shevchenko


